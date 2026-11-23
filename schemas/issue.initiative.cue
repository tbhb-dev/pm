package content

// Initiative issue. Template: templates/initiative.md (starting text only).
// Load with tools' core.cue, taxonomy.cue and issue.cue, plus issue-sections.cue.

#Hints: initiative: {
	title:          "State one measurable outcome as a condition that holds once the work is done."
	outcome:        "State in one sentence the measurable result that will show the initiative worked."
	context:        "Why this matters and what to know first. Link, don't paste."
	checks:         "State 1 to 6 observable results or measures that indicate the outcome was reached. Use one outcome per item, in 2 to 20 words. Keep CI gate references in Verification."
	verification:   "Give 1 to 3 ways to show the checks pass, such as a measured result or a decision record." + #DoneHint
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
			source?:      #Source
		})
		assignees: [...string]
		parent?: _|_
	})

	metrics: {
		visible: words:     <=180
		source: characters: <=1800
	}

	_order: ["title", "outcome", "context", "checks", "verification", "out-of-scope"]
	blockOrder: [for k in _order if blocks[k] != _|_ {k}]
	blocks: close({
		title: #InitiativeTitle
		outcome: #IssueSection & {
			heading: "Outcome"
			metrics: {
				visible: words:     >=4 & <=50
				source: characters: <=400
				codeLines: <=0
			}
		}
		checks: #ChecksSection & {metrics: listItems: >=1 & <=6}
		verification: #VerificationSection
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
