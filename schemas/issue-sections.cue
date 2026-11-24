package content

import "strings"

// Mirrors the shared taxonomy's #Source. Identical definitions unify, so the shared copy can arrive later.
#Source: "Import"

#_ProvenanceReference: "(?:" + strings.Join([
	#"(?:(?:pr|issue|run)\s+)?(?:[a-z0-9-]+/[a-z0-9._-]+)?#[1-9][0-9]*\b"#,
	#"(?:pr|issue|run)\s+#?[1-9][0-9]*\b"#,
	#"https?://[^\s/]+/[a-z0-9-]+/[a-z0-9._-]+/(?:pull|issues|actions/runs)/[1-9][0-9]*\b"#,
], "|") + ")"

// Match attribution in visible text while allowing references to related work.
#NoProvenance: "(?i)" + strings.Join([
	#"\bthe\s+review\s+of\b"#,
	#"\bthe\s+audit\b"#,
	#"\bfound\s+(?:in|during)\b"#,
	#"\bnoted\s+during\b"#,
	#"\braised\s+by\b"#,
	#"\bshowed\b"#,
	#"\breported\s+by\b"#,
	#"\bsurfaced\s+in\b"#,
	#"\bdiscovered\s+in\b"#,
	#"\bfrom\s+(?:the\s+)?"# + #_ProvenanceReference,
], "|")

// cspell:words wikilink
#NoWikilink: #"\[\["#

#IssueBodySection: #IssueSection & {
	visible: !~#NoProvenance
	source:  !~#NoWikilink
}

// Shared layout for list-only sections. Item constraints come from tools.
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
