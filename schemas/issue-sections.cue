package content

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
