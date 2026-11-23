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
	context:               #ContextHint
	parent:                "Optional, as owner/repo#N. Name the Feature, Epic or Problem this defect belongs to."
	actual:                "What happens now, with the error text if there is one, and where it was observed, as a version or commit."
	reproduction:          "Numbered steps to see the fault. Write each step as a full sentence that ends with a period."
	"acceptance-criteria": "State 1 to 3 corrected behaviors under the conditions that triggered the failure." + #ItemHint
	verification:          "Give 1 to 3 ways to prove the criteria. Include a 'Regression test:' item naming a test that reproduces the failure and proves the fix." + #DoneHint
	"out-of-scope":        #OutOfScopeHint
}

// A Problem may parent the Defects that fix it. The Problem type design may narrow this.
#KernelChecks: {
	titleShape: {visible: =~#DefectShape, ...}
	parentType: "Feature" | "Epic" | "Problem"
}

#RegressionTest: {
	visible:      =~#"^Regression test: \S"#
	_description: strings.TrimPrefix(visible, "Regression test: ") & !~#CIRestatement
	...
}

#Variant: #Draft & #QualifiedRefs & {
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
		})
		assignees: [...string]
		parent?: #IssueRef
	})

	metrics: {
		visible: words:     <=220
		source: characters: <=2200
	}

	_order: ["title", "outcome", "context", "actual", "reproduction", "acceptance-criteria", "verification", "out-of-scope"]
	blockOrder: [for k in _order if blocks[k] != _|_ {k}]
	blocks: close({
		title: #DefectTitle
		outcome: #IssueSection & {
			heading: "Outcome"
			metrics: {
				visible: words:     >=4 & <=40
				source: characters: <=320
				codeLines: <=0
			}
		}
		actual: #IssueSection & {
			heading: "Actual"
			metrics: {
				visible: words:     >=3 & <=40
				source: characters: <=320
				codeLines: <=10
			}
		}
		reproduction: #IssueSection & {
			heading: "Reproduction"
			metrics: {
				visible: words:     >=3 & <=60
				source: characters: <=480
				codeLines:      <=10
				lists:          1
				listItems:      >=1 & <=6
				orderedLists:   1
				unorderedLists: 0
			}
			content: [...(#BlankLine | #List & {items: [...#IssueItem & {metrics: visible: words: <=20}]})]
		}
		"acceptance-criteria": #AcceptanceCriteriaSection & {metrics: listItems: >=1 & <=3}
		verification: #VerificationSection & {
			content: [...(#BlankLine | #List & {
				items: list.MatchN(>=1, #RegressionTest)
			})]
		}
		context?: #IssueSection & {
			heading: "Context"
			metrics: {
				visible: words:     <=80
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
