package content

// Spike issue. Template: templates/spike.md (starting text only).
// Load with tools' core.cue, taxonomy.cue and issue.cue, plus issue-sections.cue.

#Hints: spike: {
	title:                 "Ask the research question and end with a question mark."
	question:              "The one question this spike answers. End it with a question mark."
	context:               "Why this matters and what to know first. Link, don't paste."
	decision:              "The decision the answer unblocks."
	"acceptance-criteria": "State 1 to 3 observable conditions for answering the question and informing the decision. Use one outcome per item, in 2 to 20 words. Keep CI gate references in Verification."
	verification:          "Give 1 to 3 ways to prove the criteria, such as a findings record or a decision link." + #DoneHint
	"out-of-scope":        "What this issue won't do. Leave the section out when there is nothing to say."
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
			source?:     #Source
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
