package content

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

// Hint text shared by every variant. Item rules: Criterion and VerificationItem
// in tools' issue.cue. The writing rules: docs/issue-writing.md.
#DoneHint: " Each item names the exact check and the result it must show, in one sentence, such as 'Running `bazel test //pkg:foo_test` reports the new case passing.' Do not state that work exists or was done. The Definition of Done requires evidence on the issue before closing."

#ItemHint: " Use one outcome per item, as a full sentence of 2 to 20 words that ends with a period. State a result someone can observe, not that work was done. Keep CI gate references in Verification."

#ContextHint: "Write one or two plain sentences about the work or the system, then a bullet list of specifics. Never write message times, run names, reviewer notes, deferral reasons, process dates or sentences about the issue's own tracking. Name a file by its symbol, target or key, never as path:line. Write every issue or pull request reference as owner/repo#N, and any 'found in' as a fully qualified link. Link, don't paste."

#OutOfScopeHint: "What this work must not change or will not do. Leave the section out when there is nothing to say."

// Issue and pull request references in any section must be fully qualified.
// tools' parser leaves the inline index empty for now, so this refuses nothing
// until it fills the index. The kernel check in docs/issue-templates.md covers
// the gap.
#QualifiedRefs: {
	inline: {repositoryReferences: [...#QualifiedRepositoryReference], ...}
	...
}
