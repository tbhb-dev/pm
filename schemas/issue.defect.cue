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
	reproduction:          "Give 1 to 6 bullet steps starting with 'S1: ' and count up by one. Use up to 20 words per step including the ID. A fault whose steps are unknown belongs in a Task to find a reproduction, not in a Defect."
	"acceptance-criteria": "State 1 to 3 corrected behaviors under the conditions that triggered the failure." + #CriteriaItemHint
	verification:          "Give 1 to 3 ways to prove the criteria. After the ID, start one item with 'Regression test:' and name a test that reproduces the failure and proves the fix." + #VerificationItemHint
	"out-of-scope":        "What this issue won't do. Leave the section out when there is nothing to say."
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
	})

	metrics: {
		visible: words:     <=220
		source: characters: <=2200
	}

	_order: ["title", "outcome", "context", "actual", "reproduction", "acceptance-criteria", "verification", "out-of-scope"]
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
		reproduction: #IssueBodySection & {
			heading: "Reproduction"
			metrics: {
				visible: words:     >=3 & <=60
				source: characters: <=480
				codeLines: <=10
				lists:     1
				listItems: >=1 & <=6
			}
			content: [...(#BlankLine | #_PrefixedList & {
				_prefix: "S"
				items: [...#IssueItem & {metrics: visible: words: <=20}]
			})]
		}
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
		"out-of-scope"?: #IssueBodySection & {
			heading: "Out of scope"
			metrics: {
				visible: words:     >=3 & <=30
				source: characters: <=240
				codeLines: <=0
			}
		}
	})
}
