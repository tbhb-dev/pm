package content

// Epic issue. Template: templates/epic.md (starting text only).
// Load with tools' core.cue, taxonomy.cue and issue.cue, plus issue-sections.cue.

#Hints: epic: {
	title:                 "Name the capability as a noun phrase."
	parent:                "Required, as owner/repo#N. Name the Initiative this epic delivers."
	outcome:               "State in one sentence what will be true when every sub-issue is done."
	context:               #ContextHint
	"acceptance-criteria": "State 1 to 6 observable parts of the capability that must be present." + #ItemHint
	verification:          "Give 1 to 3 ways to prove the criteria, such as an integrated demo or a capability read." + #DoneHint
	"out-of-scope":        #OutOfScopeHint
}

#KernelChecks: {
	titleShape: {visible: !~#EpicShapeBan, ...}
	parentType: "Initiative"
}

#Variant: #Draft & #QualifiedRefs & {
	object:  "issue"
	variant: "epic"

	metadata: close({
		type: "Epic"
		// One area label is required and one role label is optional. The
		// kernel turns these into labels. Priority is a field, never a label.
		area:  #AreaLabel
		role?: #RoleLabel
		fields: close({
			"work-type"?: #WorkType
			priority?:    #Priority
		})
		assignees: [...string]
		parent: #IssueRef
	})

	metrics: {
		visible: words:     <=180
		source: characters: <=1800
	}

	_order: ["title", "outcome", "context", "acceptance-criteria", "verification", "out-of-scope"]
	blockOrder: [for k in _order if blocks[k] != _|_ {k}]
	blocks: close({
		title: #EpicTitle
		outcome: #IssueSection & {
			heading: "Outcome"
			metrics: {
				visible: words:     >=4 & <=50
				source: characters: <=400
				codeLines: <=0
			}
		}
		"acceptance-criteria": #AcceptanceCriteriaSection & {metrics: listItems: >=1 & <=6}
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
