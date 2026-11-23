package content

// Chore issue. Template: templates/chore.md (starting text only).
// Load with tools' core.cue, taxonomy.cue and issue.cue, plus issue-sections.cue.

#Hints: chore: {
	title:                 "Start with an imperative verb that names the upkeep."
	parent:                "Optional, as owner/repo#N. Name the Feature, Epic or Problem this chore belongs to."
	outcome:               "State in one sentence what will be true when the upkeep is finished."
	context:               #ContextHint
	"acceptance-criteria": "State 1 to 3 observable results of the upkeep." + #ItemHint
	verification:          "Give 1 to 3 ways to prove the criteria, such as a configuration read or a command with its expected result." + #DoneHint
	"out-of-scope":        #OutOfScopeHint
}

#KernelChecks: {
	titleShape: {visible: =~#TaskShape, ...}
	parentType: "Feature" | "Epic" | "Problem"
}

#Variant: #Draft & #QualifiedRefs & {
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
		parent?: #IssueRef
	})

	metrics: {
		visible: words:     <=150
		source: characters: <=1500
	}

	_order: ["title", "outcome", "context", "acceptance-criteria", "verification", "out-of-scope"]
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
