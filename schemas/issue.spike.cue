package content

// Spike issue. Template: templates/spike.md (starting text only).
// Load with tools' core.cue, taxonomy.cue and issue.cue, plus issue-sections.cue.

#Hints: spike: {
	title:                 "Ask the research question and end with a question mark."
	parent:                "Optional, as owner/repo#N. Name the Feature or Epic this spike informs."
	question:              "The one question this spike answers. End it with a question mark."
	context:               #ContextHint
	decision:              "The decision the answer unblocks."
	"acceptance-criteria": "State 1 to 3 observable conditions for answering the question and informing the decision." + #ItemHint
	verification:          "Give 1 to 3 ways to prove the criteria, such as a findings record or a decision link." + #DoneHint
	"out-of-scope":        #OutOfScopeHint
}

#KernelChecks: parentType: "Feature" | "Epic"

#Variant: #Draft & #QualifiedRefs & {
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

	_order: ["title", "question", "context", "decision", "acceptance-criteria", "verification", "out-of-scope"]
	blockOrder: [for k in _order if blocks[k] != _|_ {k}]
	blocks: close({
		title: #SpikeTitle
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
