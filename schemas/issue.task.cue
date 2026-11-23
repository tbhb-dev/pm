package content

// Task issue. Template: templates/task.md (starting text only).
// Load with tools' core.cue, taxonomy.cue and issue.cue, plus issue-sections.cue.

#Hints: task: {
	title:        "Start with an imperative verb that names the work."
	parent:       "Use the parent Feature's issue reference."
	verification: "Give 1 to 3 ways to prove the task is complete." + #DoneHint
}

#KernelChecks: {
	titleShape: {visible: =~#TaskShape, ...}
	parentType: "Feature"
}

#Variant: #Draft & {
	object:  "issue"
	variant: "task"

	metadata: close({
		type:  "Task"
		area:  #AreaLabel
		role?: #RoleLabel
		fields: close({
			"work-type": #WorkType
			priority?:   #Priority
		})
		assignees: [...string]
		parent: #IssueRef
	})

	metrics: {
		visible: words:     <=80
		source: characters: <=800
	}

	blockOrder: ["title", "verification"]
	blocks: close({
		title:        #TaskTitle
		verification: #VerificationSection
	})
}
