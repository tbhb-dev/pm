package content

// Initiative issue. Template: templates/initiative.md (starting text only).
// Load with core.cue, taxonomy.cue and issue.cue, and one variant file per run.

#Hints: initiative: {
	title:          "The title: 15 to 70 characters, at least three words, no trailing period or colon."
	outcome:        "A measurable result that proves the initiative worked."
	checks:         "Task list boxes that prove it is done, one short line each."
	context:        "Why this matters and what to know first. Link, don't paste."
	"out-of-scope": "What this issue won't do. Leave the section out when there is nothing to say."
}

#Variant: #Draft & {
	object:  "issue"
	variant: "initiative"

	metadata: close({
		type: "Initiative"
		// One area label is required and one role label is optional. The
		// kernel turns these into labels. Priority is a field, never a label.
		area:  #AreaLabel
		role?: #RoleLabel
		fields: close({
			"work-type"?: #WorkType
			priority?:    #Priority
		})
		assignees: [...string]
		parent?: _|_
	})

	metrics: {
		visible: words:     <=180
		source: characters: <=1800
	}

	_order: ["title", "outcome", "checks", "context", "out-of-scope"]
	blockOrder: [for k in _order if blocks[k] != _|_ {k}]
	blocks: close({
		title: #IssueTitle & {visible: !~#"\?$"#}
		outcome: #IssueSection & {
			heading: "Outcome"
			metrics: {
				visible: words:     >=4 & <=50
				source: characters: <=400
				codeLines: <=0
			}
		}
		checks: #IssueSection & {
			heading: "Checks"
			metrics: {
				visible: words:     >=4 & <=80
				source: characters: <=640
				codeLines: <=0
				lists:     1
				listItems: >=1 & <=6
				taskLists: 1
				taskItems: listItems
			}
			content: [...(#BlankLine | #List & {items: [...#IssueItem & {metrics: visible: words: <=15}]})]
		}
		context: #IssueSection & {
			heading: "Context"
			metrics: {
				visible: words:     >=4 & <=60
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
