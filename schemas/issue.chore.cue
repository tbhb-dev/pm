package content

// Chore issue. Template: templates/chore.md (starting text only).
// Load with tools' core.cue, taxonomy.cue and issue.cue, plus issue-sections.cue.

#Hints: chore: {
	title:          "Start with an imperative verb that names the upkeep."
	outcome:        "State in one sentence what will be true when the upkeep is finished."
	context:        "Why this matters and what to know first. Link, don't paste."
	verification:   "State 1 to 3 observable results of the upkeep, such as a configuration read or a command with its expected result." + #VerificationItemHint
	"out-of-scope": #OutOfScopeHint
	relates_to:     #RelatedIssueHint
	related:        #RelatedHint
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
			source?:     #Source
		})
		assignees: [...string]
		parent?: #IssueRef
		relates_to?: [...#IssueRef]
	})

	metrics: {
		visible: words:     <=150
		source: characters: <=1500
	}

	_order: ["title", "outcome", "context", "verification", "out-of-scope", "related"]
	blockOrder: [for k in _order if blocks[k] != _|_ {k}]
	blocks: close({
		title: #ChoreTitle & #RelationText
		outcome: #IssueBodySection & {
			heading: "Outcome"
			metrics: {
				visible: words:     >=4 & <=40
				source: characters: <=320
				codeLines: <=0
			}
		}
		verification: #VerificationSection
		context?: #IssueBodySection & {
			heading: "Context"
			metrics: {
				visible: words:     <=60
				source: characters: <=480
				codeLines: <=10
			}
		}
		"out-of-scope"?: #OutOfScopeSection
		related?:        #RelatedSection
	})
}
