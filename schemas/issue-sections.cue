package content

import "strings"

// Mirrors the shared taxonomy's #Source. Identical definitions unify, so the shared copy can arrive later.
#Source: "Import"

#SentenceStart: #"(?:^|[.!?] |\n)"#

// Keep punctuation inside tokens without crossing a sentence boundary.
#SentenceText:          #"(?:[^.!?\r\n]|[.!?]+[^.!? \r\n])*"#
#AttributionRepository: #"[a-z0-9][a-z0-9-]*/[a-z0-9_.-]+"#
#AttributionReference: strings.Join([
	#AttributionRepository + #"#[0-9]+"#,
	#"PR #[0-9]+|run [0-9]+"#,
	#"https?://github\.com/"# + #AttributionRepository + #"/(?:pull|issues|actions/runs)/[0-9]+"#,
], "|")

#NoProvenance: "(?i)" + strings.Join([
	// A discovery verb and a preposition open the sentence.
	#SentenceStart + #"(?:found|noted|raised|reported|spotted|flagged|identified|discovered|surfaced|seen|uncovered) (?:in|during|by|while|at)\b"#,
	// An explicit attribution to an audit or review.
	#"\bfrom (?:the|an) audit\b|\bfrom (?:the|a) review\b"#,
	// An audit or review leads to a finding after a reference in the same sentence.
	#SentenceStart + #"(?:the review of|the audit of|a review of) "# + #SentenceText +
	#"\b(?:"# + #AttributionReference + #")\b"# + #SentenceText + #"\b(?:showed|shows|found|revealed|noted|raised)\b"#,
], "|")

// A slug can carry a label or anchor. A word character or backtick just
// before the opener lets bracket syntax used in code pass.
#NoWikilink: #"(?:^|[^\pL\pM\pN_`])\[\[[a-z][A-Za-z0-9_-]*(?:[|#][^\r\n]*?)?\]\]"#

#IssueBodySection: #IssueSection & {
	visible: !~#NoProvenance
	source:  !~#NoWikilink
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
	content: [...(#BlankLine | #List & {items: [...#Criterion]})]
}

#VerificationSection: #IssueEvidenceSection & {
	heading: "Verification"
	metrics: listItems: >=1 & <=3
	content: [...(#BlankLine | #List & {items: [...#VerificationItem]})]
}

#DoneHint: " The Definition of Done requires evidence on the issue before closing. Use ci_enforced with a reference to each gate CI already checks."
