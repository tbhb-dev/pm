package content

import "strings"

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

#IssueBodySection: #IssueSection & {
	visible: !~#NoProvenance
	source:  !~#NoWikilink
	metrics: orderedLists: 0
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
		visible: words:     >=1 & <=30
		source: characters: <=240
		lists:            1
		listItems:        >=1 & <=3
		codeLines:        0
		fencedCodeBlocks: 0
	}
	content: [...(#BlankLine | #List & {
		style: "unordered"
		items: [...#IssueItem & {metrics: visible: words: >=1 & <=20}]
	})]
}

#OutOfScopeHint: "Name what this issue deliberately does not cover, one bullet each. If nothing is out of scope, write 'None.' after deciding that on purpose."
