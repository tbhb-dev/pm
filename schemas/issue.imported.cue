package content

// Imported issue. The tracker import supplies the title and Context.
// Load with tools' core.cue, taxonomy.cue and issue.cue, plus issue-sections.cue.

#Hints: imported: {
	title:      "Keep the original issue title."
	relates_to: #RelatedIssueHint
	context:    "The import keeps the original text here. Refinement rewrites it into the destination variant."
}

#ImportedTitle: #DraftBlock & {
	kind:  "heading"
	level: 1
	metrics: visible: {
		characters: <=256
		words:      >=1
		...
	}
}

#Variant: #Draft & {
	object:  "issue"
	variant: "imported"

	metadata: close({
		type:  "Initiative" | "Epic" | "Feature" | "Defect" | "Chore" | "Task"
		area?: #AreaLabel
		role?: #RoleLabel
		fields: close({source: #Source})
		assignees: [...string]
		parent?: #IssueRef
		blocked_by?: [...#IssueRef]
		relates_to?: [...#IssueRef]
	})

	metrics: {
		visible: words:     <=460
		source: characters: <=2700
	}

	blockOrder: ["title", "context"]
	blocks: close({
		title: #ImportedTitle
		context: #IssueSection & {
			heading: "Context"
			metrics: {
				visible: words:     <=450
				source: characters: <=2600
				codeLines: <=40
			}
		}
	})
}
