package content

// Spike issue. Template: templates/spike.md (starting text only).
// Limits follow the Fable review of 2026-11-22: opening sections near 40 words
// and a total below the sum of the sections.

#Hints: spike: {
	title:          "The title, at most 70 characters, no trailing period."
	outcome:        "The question this spike answers."
	checks:         "Checkboxes that prove it is done, one short line each."
	context:        "Why this matters and what to know first. Link, don't paste."
	"out-of-scope": "What this issue will not do."
}

#Variant: #Draft & {
	object:  "issue"
	variant: "spike"

	metadata: close({
		type: "Spike"
		// Only area and role labels exist: priority is a field, never a label.
		labels: [#AreaLabel, ...(#AreaLabel | #RoleLabel)]
		fields: close({
			"work-type": #WorkType
			priority?:   #Priority
		})
		assignees: [...string]
		parent?: string
	})

	metrics: visible: words: <=170

	blockOrder: ["title", "outcome", "checks", "context", "out-of-scope"]
	blocks: close({
		title: #DraftBlock & {
			kind:    "heading"
			level:   1
			visible: !~#"\.$"#
			metrics: visible: characters: >=1 & <=70
		}
		outcome: #DraftBlock & {
			kind:    "section"
			heading: "Outcome"
			metrics: {
				visible: words: >=10 & <=40
				codeLines: <=10
			}
		}
		checks: #DraftBlock & {
			kind:    "section"
			heading: "Checks"
			metrics: {
				visible: words: >=5 & <=60
				codeLines:  <=10
				paragraphs: 0
				lists:      1
				listItems:  >=1 & <=5
			}
			content: [#List & {items: [...{metrics: visible: words: <=20}]}]
		}
		context: #DraftBlock & {
			kind:    "section"
			heading: "Context"
			metrics: {
				visible: words: >=10 & <=80
				codeLines: <=10
			}
		}
		"out-of-scope": #DraftBlock & {
			kind:    "section"
			heading: "Out of scope"
			metrics: {
				visible: words: <=30
				codeLines: <=10
			}
		}
	})
}
