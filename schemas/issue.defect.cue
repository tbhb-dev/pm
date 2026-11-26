package content

import (
	"list"
	"strings"
)

// Defect issue. Template: templates/defect.md (starting text only).
// Load with tools' core.cue, taxonomy.cue and issue.cue, plus issue-sections.cue.

#Hints: defect: {
	title:                 "Use '<Thing> <does wrong> when <condition>' to name the failure and its trigger."
	outcome:               "State the expected behavior after the fix in one sentence."
	context:               "Why this matters and what to know first. Link, don't paste."
	actual:                "What happens now, with the error text if there is one."
	reproduction:          "Give 1 to 6 steps in an ordered Markdown list. Start with '1. ', count up by one, and use up to 20 words per step. Use the list numbers alone. File a Task to find a reproduction if the steps are unknown."
	"acceptance-criteria": "State 1 to 3 corrected behaviors under the conditions that triggered the failure." + #CriteriaItemHint
	verification:          "Give 1 to 3 ways to prove the criteria. After the ID, start one item with 'Regression test:' and name a test that reproduces the failure and proves the fix." + #VerificationItemHint
	"out-of-scope":        #OutOfScopeHint
	relates_to:            #RelatedIssueHint
	related:               #RelatedHint
}

#KernelChecks: titleShape: {visible: =~#DefectShape, ...}

#RegressionTest: {
	visible: =~#"^V[1-9][0-9]*: Regression test: \S"#
	_test:   strings.SplitN(visible, ": ", 3)[2] & !~#CIRestatement
	...
}

#Variant: #Draft & {
	object:  "issue"
	variant: "defect"

	metadata: close({
		type: "Defect"
		// One area label is required and one role label is optional. The
		// kernel turns these into labels. Priority is a field, never a label.
		area:  #AreaLabel
		role?: #RoleLabel
		fields: close({
			"work-type": #WorkType
			priority?:   #Priority
			severity:    #Severity
			source?:     #Source
		})
		assignees: [...string]
		parent?: #IssueRef
		relates_to?: [...#IssueRef]
	})

	metrics: {
		visible: words:     <=260
		source: characters: <=2200
	}

	_order: ["title", "outcome", "context", "actual", "reproduction", "acceptance-criteria", "verification", "out-of-scope", "related"]
	blockOrder: [for k in _order if blocks[k] != _|_ {k}]
	blocks: close({
		title: #DefectTitle
		outcome: #IssueBodySection & {
			heading: "Outcome"
			metrics: {
				visible: words:     >=4 & <=40
				source: characters: <=320
				codeLines: <=0
			}
		}
		actual: #IssueBodySection & {
			heading: "Actual"
			metrics: {
				visible: words:     >=3 & <=40
				source: characters: <=320
				codeLines: <=10
			}
		}
		reproduction: #ReproductionSection
		"acceptance-criteria": #AcceptanceCriteriaSection & {metrics: listItems: >=1 & <=3}
		verification: #VerificationSection & {
			content: [...(#BlankLine | #List & {
				items: list.MatchN(>=1, #RegressionTest)
			})]
		}
		context?: #IssueBodySection & {
			heading: "Context"
			metrics: {
				visible: words:     <=80
				source: characters: <=640
				codeLines: <=10
			}
		}
		"out-of-scope"?: #OutOfScopeSection
		related?:        #RelatedSection
	})
}
