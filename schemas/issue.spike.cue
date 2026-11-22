package content

// Spike issue. Template: templates/spike.md (starting text only).
// Load with core.cue, taxonomy.cue and issue.cue, and one variant file per run.

#Hints: spike: {
	title:          "The title: 15 to 70 characters, at least three words, no trailing period or colon."
	question:       "The one question this spike answers. End it with a question mark."
	decision:       "The decision the answer unblocks."
	checks:         "Deliverables as task boxes, at most three."
	context:        "Why this matters and what to know first. Link, don't paste."
	"out-of-scope": "What this issue won't do. Leave the section out when there is nothing to say."
}

#Variant: #Draft & {
	object:  "issue"
	variant: "spike"

	metadata: close({
		type: "Spike"
		// One area label is required and one role label is optional. The
		// kernel turns these into labels. Priority is a field, never a label.
		area:  #AreaLabel
		role?: #RoleLabel
		fields: close({
			"work-type": #WorkType
			priority?:   #Priority
			timebox:     #Timebox
		})
		assignees: [...string]
		parent?: #IssueRef
	})

	metrics: {
		visible: words:     <=130
		source: characters: <=1300
	}

	_order: ["title", "question", "decision", "checks", "context", "out-of-scope"]
	blockOrder: [for k in _order if blocks[k] != _|_ {k}]
	blocks: close({
		title: #IssueTitle
		question: #IssueSection & {
			heading: "Question"
			metrics: {
				visible: words:     >=3 & <=40
				source: characters: <=320
				codeLines: <=0
			}
			visible: =~#"\?$"#
		}
		decision: #IssueSection & {
			heading: "Decision"
			metrics: {
				visible: words:     >=3 & <=30
				source: characters: <=240
				codeLines: <=0
			}
		}
		checks: #IssueSection & {
			heading: "Checks"
			metrics: {
				visible: words:     >=3 & <=60
				source: characters: <=480
				codeLines:  <=0
				paragraphs: 0
				lists:      1
				listItems:  >=1 & <=3
				taskLists:  1
				taskItems:  listItems
			}
			content: [...(#BlankLine | #List & {items: [...#IssueItem & {metrics: visible: words: <=15}]})]
		}
		context?: #IssueSection & {
			heading: "Context"
			metrics: {
				visible: words:     <=60
				source: characters: <=480
				codeLines: <=10
			}
		}
		"out-of-scope"?: #IssueSection & {
			heading: "Out of scope"
			metrics: {
				visible: words:     >=3 & <=30
				source: characters: <=240
				codeLines: <=0
			}
		}
	})
}
