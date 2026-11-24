package content

// Task issue. Template: templates/task.md (starting text only).
// Load with tools' core.cue, taxonomy.cue and issue.cue, plus issue-sections.cue.

#Hints: task: {
	title:        "Start with an imperative verb that names the work."
	parent:       "Use the reference for the issue this work subdivides. The parent can be any issue type except Task."
	description:  "Explain what the work is and why it matters in a few sentences."
	verification: "Give 1 to 3 ways to prove the task is complete." + #DoneHint
}

#KernelChecks: {
	titleShape: {visible: =~#TaskShape, ...}
	parentType: string & !="Task"
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
			source?:     #Source
		})
		assignees: [...string]
		parent: #IssueRef
	})

	metrics: {
		visible: words:     <=140
		source: characters: <=1300
	}

	blockOrder: ["title", "description", "verification"]
	blocks: close({
		title: #TaskTitle
		description: #IssueBodySection & {
			heading: "Description"
			metrics: {
				visible: words:     >=8 & <=60
				source: characters: <=480
				codeLines: <=0
			}
		}
		verification: #VerificationSection
	})
}
