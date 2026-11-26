package content

import (
	"regexp"
	"strings"
)

// Mirrors the shared taxonomy's #Source. Identical definitions unify, so the shared copy can arrive later.
#Source: "Import"

// A discovery verb and preposition must start a sentence.
#DiscoveryAttribution: #"(?:Found|Noted|Raised|Reported|Spotted|Flagged|Identified|Discovered|Surfaced|Seen|Uncovered)\s+(?:in|during|by|while|at)\b"#

// An audit or review must end the phrase, so nouns like audit log pass.
#AuditAttribution: #"\bfrom\s+(?:the\s+(?:audit|review)|an\s+audit|a\s+review)\s*(?:$|[.,;:!?)])"#

// A review or audit must name a reference and a finding in the same sentence.
#SentenceStart:     #"(?:^|[.!?] |\n)"#
#WithinSentence:    #"(?:[^.!?\r\n]|\.[^\s.!?])*"#
#ReviewReference:   #"\b(?:[a-z0-9][a-z0-9-]*/[a-z0-9._-]+#[0-9]+|PR[ \t]+#[0-9]+|run[ \t]+[0-9]+|https?://github\.com/[a-z0-9][a-z0-9-]*/[a-z0-9._-]+/(?:pull|issues|actions/runs)/[0-9]+)\b"#
#ReviewAttribution: #"(?:The (?:review|audit)|A review) of "# + #WithinSentence + #ReviewReference + #WithinSentence + #"\b(?:showed|shows|found|revealed|noted|raised)\b"#

#NoProvenance: "(?i)" + #SentenceStart + "(?:" + #DiscoveryAttribution + "|" + #ReviewAttribution + ")|" + #AuditAttribution

// Source preserves backticks. Require a hyphen to allow TOML array headers.
#NoWikilink: #"(?:^|[^\pL\pM\pN_`])\[\[[a-z][a-z0-9]*(?:-[a-z0-9]+)+(?:[|#][^\]\r\n]+)?\]\]"#

#ProseRelation: #"(?i)(?:^|[\r\n]|[.!?]["'”’)\]]*[ \t]+)[ \t]*(?:(?:AC|V)[1-9][0-9]*: )?Related(?:[ \t]+work)?:"#

// The normalized text flattens inline code. Use the paragraph source when
// a code span could account for a relation label in the visible text.
#RelationText: {
	source:  string
	visible: string
	if visible =~ #ProseRelation {
		_parts: [for fragment in regexp.FindAll(#"[^\x60]*(?:\x60+|$)"#, source, -1) {
			let Text = strings.TrimRight(fragment, "`")
			{text: Text, ticks: strings.TrimPrefix(fragment, Text)}
		}]
		// Pair backtick runs of equal length, then skip through the closing run.
		_scan: [{end: -1, text: "", code: false}, for index, part in _parts {
			let PreviousEnd = _scan[index].end
			if index <= PreviousEnd {
				{end: PreviousEnd, text: "", code: false}
			}
			if index > PreviousEnd {
				// An odd number of backslashes escapes the first opening backtick.
				let Escaped = part.text =~ #"(?:^|[^\\])(?:\\\\)*\\$"#
				_open: string
				if Escaped {
					_open: strings.TrimPrefix(part.ticks, "`")
				}
				if !Escaped {
					_open: part.ticks
				}
				_ends: [for end, candidate in _parts if end > index && _open != "" && candidate.ticks == _open {end}]
				if len(_ends) == 0 {
					{end: index, text: part.text + part.ticks, code: false}
				}
				if len(_ends) > 0 {
					{end: _ends[0], text: part.text + "`", code: true}
				}
			}
		}]
		_code: [for segment in _scan if segment.code {segment}]
		if len(_code) == 0 {
			visible: !~#ProseRelation
		}
		if len(_code) > 0 {
			_text: strings.Join([for segment in _scan {segment.text}], "")
			// Paragraph source can include the title or list marker.
			_prose: regexp.ReplaceAll(#"^ {0,3}(?:#|[-+*]|[0-9]{1,9}[.)])[ \t]+(?:\[[ xX]\][ \t]+)?"#, _text, "") & !~#ProseRelation
		}
	}
	...
}

#IssueTextSection: #IssueSection & {
	visible: !~#NoProvenance
	source:  !~#NoWikilink
	content: [...]
	_relationText: [
		for block in content if block.kind == "paragraph" {
			#RelationText & {source: block.source, visible: block.visible}
		},
		for block in content if block.kind == "list" for item in block.items for paragraph in item.blocks if paragraph.kind == "paragraph" {
			#RelationText & {source: paragraph.source, visible: paragraph.visible}
		},
	]
}

#IssueBodySection: #IssueTextSection & {
	metrics: orderedLists: 0
}

// The parser retains the start of an ordered list but drops subsequent markers
// from its visible text. Check each marker in the item source.
#ReproductionSection: #IssueTextSection & {
	heading: "Reproduction"
	metrics: {
		visible: words:     <=140
		source: characters: <=1100
		codeLines: <=10
		lists:     1
		listItems: >=1 & <=6
	}
	content: [...(#BlankLine | #List & {
		style: "ordered"
		start: 1
		items: [...#IssueItem & {
			visible: !~#"(?i)^S[0-9]+:"#
			metrics: visible: words: >=1 & <=20
		}]
		items: [for index, _ in items {
			{source: =~"^ {0,3}\(index+1)\\.[ \\t]+", ...}
		}]
	})]
}

// Match each item's visible ID against its one-based position in the list.
#_PrefixedList: #List & {
	_prefix: string
	style:   "unordered"
	items: [...#ListItem]
	items: [for index, _ in items {
		{visible: =~"^\(_prefix)\(index+1): \\S", ...}
	}]
}

// Apply the CI gate rule to the words after the ID.
#_EvidenceText: {
	visible:      string
	_description: strings.SplitN(visible, ": ", 2)[1] & !~#CIRestatement
	...
}

// Shared section layout for issue variants. Item constraints come from tools.
#IssueEvidenceSection: #IssueBodySection & {
	metrics: {
		lists:            1
		codeLines:        0
		fencedCodeBlocks: 0
	}
}

#AcceptanceCriteriaSection: #IssueEvidenceSection & {
	heading: "Acceptance criteria"
	content: [...(#BlankLine | #_PrefixedList & {
		_prefix: "AC"
		items: [...(#Criterion & #_EvidenceText)]
	})]
}

#VerificationSection: #IssueEvidenceSection & {
	heading: "Verification"
	metrics: listItems: >=1 & <=3
	content: [...(#BlankLine | #_PrefixedList & {
		_prefix: "V"
		items: [...(#VerificationItem & #_EvidenceText)]
	})]
}

#CriteriaItemHint:     " Use bullets starting with 'AC1: ' and count up by one. Write one outcome per item in 2 to 20 words including the ID. Keep CI gate references in Verification."
#VerificationItemHint: " Use bullets starting with 'V1: ' and count up by one. Use 2 to 20 words per item including the ID. The Definition of Done requires evidence on the issue before closing. Use ci_enforced with a reference to each gate CI already checks."

// Scope boundaries use ordinary bullets, independent of criteria and evidence IDs.
#OutOfScopeSection: #IssueBodySection & {
	heading: "Out of scope"
	metrics: {
		visible: words:     <=60
		source: characters: <=480
		codeLines:        0
		fencedCodeBlocks: 0
		lists:            1
		listItems:        >=1 & <=3
	}
	content: [...(#BlankLine | #List & {
		style: "unordered"
		items: [...#IssueItem & {metrics: visible: words: >=3 & <=20}]
	})]
}

#OutOfScopeHint: "If the issue has exclusions, list them in 1 to 3 bullets of 3 to 20 words each. Omit Out of scope when there are no exclusions."

#RelatedIssueHint: "Use the optional relates_to front matter list for GitHub issues, with one owner/repo#N reference per entry."
#RelatedHint:      "When there are related pull requests, commits, discussions, or web pages, add Related after Out of scope if present or after Verification otherwise. Use 1 to 8 dash bullets, each with an HTTPS URL, owner/repo#N pull request, or owner/repo@sha commit. Optionally append ': ' and a description of 1 to 12 words. Keep 'Related work:' and 'Related:' labels out of prose in other sections."

#GitHubRef:  #"(?i:[a-z0-9][a-z0-9-]*/[a-z0-9._-]+(?:#[1-9][0-9]*|@[a-f0-9]{4,40}))"#
#HTTPSRef:   #"https://(?:[A-Za-z0-9](?:[A-Za-z0-9.-]*[A-Za-z0-9])?|\[[A-Fa-f0-9:.]+\])(?::[0-9]+)?(?:[/?#][^\s<>"`]*)?"#
#RelatedRef: "(?:" + #GitHubRef + "|" + #HTTPSRef + ")"

#RelatedItem: #IssueItem & {
	source:  string
	visible: string
	_line:   strings.TrimSpace(source)
	_line:   =~("^- " + #RelatedRef + #"(?:: \S[^\r\n]*)?$"#)
	// A full issue URL identifies an issue. A bare owner/repo#N is ambiguous.
	_line: !~#"(?i)^- https://github\.com/[^/\s]+/[^/\s]+/issues/[1-9][0-9]*(?:[/?#:\s]|$)"#
	if strings.Contains(_line, ": ") {
		_description: strings.SplitN(visible, ": ", 2)[1]
		_words:       len(regexp.FindAll(#"[\pL\pN_]+"#, _description, -1)) & >=1 & <=12
	}
}

#RelatedSection: #IssueSection & {
	heading: "Related"
	metrics: {
		lists:     1
		listItems: >=1 & <=8
	}
	content: [...(#BlankLine | #List & {
		style: "unordered"
		items: [...#RelatedItem]
	})]
}
