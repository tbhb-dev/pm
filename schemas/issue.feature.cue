package content

// Feature issue. Template: templates/feature.md (starting text only).
// Load with tools' core.cue, taxonomy.cue and issue.cue, plus issue-sections.cue.

#Hints: feature: {
	title:                 "Use a role and what it can do, in the form '<Role> can <action>'."
	outcome:               "State in one sentence what users or agents will be able to do after this ships."
	context:               "Why this matters and what to know first. Link, don't paste."
	"acceptance-criteria": "State 2 to 5 observable behaviors the role can use. Use one outcome per item, in 2 to 20 words. Keep CI gate references in Verification."
	verification:          "Give 1 to 3 ways to prove the criteria, such as a demo or a behavior test." + #DoneHint
	"out-of-scope":        "What this issue won't do. Leave the section out when there is nothing to say."
}

#KernelChecks: titleShape: {visible: =~#FeatureShape, ...}

#Variant: #Draft & {
	object:  "issue"
	variant: "feature"

	metadata: close({
		type: "Feature"
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
		visible: words:     <=200
		source: characters: <=2000
	}

	_order: ["title", "outcome", "context", "acceptance-criteria", "verification", "out-of-scope"]
	blockOrder: [for k in _order if blocks[k] != _|_ {k}]
	blocks: close({
		title: #FeatureTitle
		outcome: #IssueSection & {
			heading: "Outcome"
			metrics: {
				visible: words:     >=4 & <=40
				source: characters: <=320
				codeLines: <=0
			}
		}
		"acceptance-criteria": #AcceptanceCriteriaSection & {metrics: listItems: >=2 & <=5}
		verification: #VerificationSection
		context: #IssueSection & {
			heading: "Context"
			metrics: {
				visible: words:     >=4 & <=80
				source: characters: <=640
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
