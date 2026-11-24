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
	reproduction:          "Give numbered steps to see the fault, or describe the observed conditions in one paragraph if the steps are unknown."
	"acceptance-criteria": "State 1 to 3 corrected behaviors under the conditions that triggered the failure. Use one outcome per item, in 2 to 20 words. Keep CI gate references in Verification."
	verification:          "Give 1 to 3 ways to prove the criteria. Include a 'Regression test:' item naming a test that reproduces the failure and proves the fix." + #DoneHint
	"out-of-scope":        "What this issue won't do. Leave the section out when there is nothing to say."
}

#KernelChecks: titleShape: {visible: =~#DefectShape, ...}

#RegressionTest: {
	visible:      =~#"^Regression test: \S"#
	_description: strings.TrimPrefix(visible, "Regression test: ") & !~#CIRestatement
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
				codeLines: <=10
			}
		} & ({
			metrics: {
				lists:          1
				listItems:      >=1 & <=6
				orderedLists:   1
				unorderedLists: 0
			}
			content: [...(#BlankLine | #List & {items: [...#IssueItem & {metrics: visible: words: <=20}]})]
		} | {
			metrics: {
				paragraphs: 1
				lists:      0
			}
			content: [...(#BlankLine | #Paragraph)]
		})
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
