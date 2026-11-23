package content

// Mirrors the shared taxonomy's #Source. Identical definitions unify, so the shared copy can arrive later.
#Source: "Import"

// Shared section layout for issue variants. Item constraints come from tools.
#IssueEvidenceSection: #IssueSection & {
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
