package content

// Initiative issue. Template: templates/initiative.md (starting text only).
// Load with tools' core.cue, taxonomy.cue and issue.cue, plus issue-sections.cue.

#Hints: initiative: {
	title:                 "State one measurable outcome as a condition that holds once the work is done."
	outcome:               "State in one sentence the measurable result that will show the initiative worked."
	context:               "Why this matters and what to know first. Link, don't paste."
	"acceptance-criteria": "State 1 to 6 observable results or measures that indicate the outcome was reached." + #CriteriaItemHint
	verification:          "Give 1 to 3 ways to prove the criteria, such as a measured result or a decision record." + #VerificationItemHint
	"out-of-scope":        #OutOfScopeHint
	relates_to:            #RelatedIssueHint
	related:               #RelatedHint
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
		relates_to?: [...#IssueRef]
	})

	metrics: {
		visible: words:     <=180
		source: characters: <=1800
	}

	_order: ["title", "outcome", "context", "acceptance-criteria", "verification", "out-of-scope", "related"]
	blockOrder: [for k in _order if blocks[k] != _|_ {k}]
	blocks: close({
		title: #InitiativeTitle
		outcome: #IssueBodySection & {
			heading: "Outcome"
			metrics: {
				visible: words:     >=4 & <=50
				source: characters: <=400
				codeLines: <=0
			}
		}
		"acceptance-criteria": #AcceptanceCriteriaSection & {metrics: listItems: >=1 & <=6}
		verification: #VerificationSection
		context: #IssueBodySection & {
			heading: "Context"
			metrics: {
				visible: words:     >=4 & <=60
				source: characters: <=480
				codeLines: <=10
			}
		}
		"out-of-scope"?: #OutOfScopeSection
		related?:        #RelatedSection
	})
}
