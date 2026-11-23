package content

// Chore issue. Template: templates/chore.md (starting text only).
// Load with tools' core.cue, taxonomy.cue and issue.cue, plus issue-sections.cue.

#Hints: chore: {
	title:                 "Start with an imperative verb that names the upkeep."
	outcome:               "What upkeep is finished."
	"acceptance-criteria": "State 1 to 3 observable results of the upkeep. Use one outcome per item, in 2 to 20 words. Keep CI gate references in Verification."
	verification:          "Give 1 to 3 ways to prove the criteria, such as a configuration read or a command with its expected result." + #DoneHint
	context:               "Why this matters and what to know first. Link, don't paste."
	"out-of-scope":        "What this issue won't do. Leave the section out when there is nothing to say."
}

#KernelChecks: titleShape: {visible: =~#TaskShape, ...}

#Variant: #Draft & {
	object:  "issue"
	variant: "chore"

	metadata: close({
		type: "Chore"
		// One area label is required and one role label is optional. The
		// kernel turns these into labels. Priority is a field, never a label.
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
		visible: words:     <=150
		source: characters: <=1500
	}

	_order: ["title", "outcome", "acceptance-criteria", "verification", "context", "out-of-scope"]
	blockOrder: [for k in _order if blocks[k] != _|_ {k}]
	blocks: close({
		title: #ChoreTitle
		outcome: #IssueSection & {
			heading: "Outcome"
			metrics: {
				visible: words:     >=4 & <=40
				source: characters: <=320
				codeLines: <=0
			}
		}
		"acceptance-criteria": #AcceptanceCriteriaSection & {metrics: listItems: >=1 & <=3}
		verification: #VerificationSection
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
