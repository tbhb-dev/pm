package content

// Feature issue. Template: templates/feature.md (starting text only).
// Load with tools' core.cue, taxonomy.cue and issue.cue, plus issue-sections.cue.

#Hints: feature: {
	title:                 "Use a role and what it can do, in the form '<Role> can <action>'."
	outcome:               "State in one sentence what users or agents will be able to do after this ships."
	context:               "Why this matters and what to know first. Link, don't paste."
	"acceptance-criteria": "State 2 to 5 observable behaviors the role can use." + #CriteriaItemHint
	verification:          "Give 1 to 3 ways to prove the criteria, such as a demo or a behavior test." + #VerificationItemHint
	"out-of-scope":        #OutOfScopeHint
	relates_to:            #RelatedIssueHint
	related:               #RelatedHint
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
			source?:     #Source
		})
		assignees: [...string]
		parent: #IssueRef
		relates_to?: [...#IssueRef]
	})

	metrics: {
		visible: words:     <=200
		source: characters: <=2000
	}

	_order: ["title", "outcome", "context", "acceptance-criteria", "verification", "out-of-scope", "related"]
	blockOrder: [for k in _order if blocks[k] != _|_ {k}]
	blocks: close({
		title: #FeatureTitle & {visible: !~#ProseRelation}
		outcome: #IssueBodySection & {
			heading: "Outcome"
			metrics: {
				visible: words:     >=4 & <=40
				source: characters: <=320
				codeLines: <=0
			}
		}
		"acceptance-criteria": #AcceptanceCriteriaSection & {metrics: listItems: >=2 & <=5}
		verification: #VerificationSection
		context: #IssueBodySection & {
			heading: "Context"
			metrics: {
				visible: words:     >=4 & <=80
				source: characters: <=640
				codeLines: <=10
			}
		}
		"out-of-scope": #OutOfScopeSection
		related?:       #RelatedSection
	})
}
