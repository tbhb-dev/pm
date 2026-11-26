package content

// Task issue. Template: templates/task.md (starting text only).
// Load with tools' core.cue, taxonomy.cue and issue.cue, plus issue-sections.cue.

#Hints: task: {
	title:          "Start with an imperative verb that names the work."
	parent:         "Use the reference for the issue this work subdivides. The parent can be any issue type except Task."
	description:    "Explain what the work is and why it matters in a few sentences."
	verification:   "Give 1 to 3 ways to prove the task is complete." + #VerificationItemHint
	"out-of-scope": #OutOfScopeHint
	relates_to:     #RelatedIssueHint
	related:        #RelatedHint
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
		relates_to?: [...#IssueRef]
	})

	metrics: {
		visible: words:     <=160
		source: characters: <=1300
	}

	_order: ["title", "description", "verification", "out-of-scope", "related"]
	blockOrder: [for k in _order if blocks[k] != _|_ {k}]
	blocks: close({
		title: #TaskTitle & #RelationText
		description: #IssueBodySection & {
			heading: "Description"
			metrics: {
				visible: words:     >=8 & <=60
				source: characters: <=480
				codeLines: <=0
			}
		}
		verification:    #VerificationSection
		"out-of-scope"?: #OutOfScopeSection
		related?:        #RelatedSection
	})
}
