package content

// Epic issue. Template: templates/epic.md (starting text only).
// Limits follow the Fable review of 2026-11-22: opening sections near 40 words
// and a total below the sum of the sections.

#Hints: epic: {
	title:          "The title, at most 70 characters, no trailing period."
	outcome:        "What is true when every child is done."
	checks:         "Checkboxes that prove the epic is done."
	context:        "Why this exists and how the children fit."
	children:       "One line per child issue."
	"out-of-scope": "What this issue will not do."
}

#Variant: #Draft & {
	object:  "issue"
	variant: "epic"

	metadata: close({
		type: "Epic"
		// Only area and role labels exist: priority is a field, never a label.
		labels: [#AreaLabel, ...(#AreaLabel | #RoleLabel)]
		fields: close({
			"work-type": #WorkType
			priority?:   #Priority
		})
		assignees: [...string]
		parent?: _|_
	})

	metrics: visible: words: <=260

	blockOrder: ["title", "outcome", "checks", "context", "out-of-scope"] | ["title", "outcome", "checks", "context", "children", "out-of-scope"]
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
				visible: words: >=10 & <=50
				codeLines: <=10
			}
		}
		checks: #DraftBlock & {
			kind:    "section"
			heading: "Checks"
			metrics: {
				visible: words: >=5 & <=80
				codeLines:  <=10
				paragraphs: 0
				lists:      1
				listItems:  >=1 & <=6
			}
			content: [#List & {items: [...{metrics: visible: words: <=20}]}]
		}
		context: #DraftBlock & {
			kind:    "section"
			heading: "Context"
			metrics: {
				visible: words: >=10 & <=100
				codeLines: <=10
			}
		}
		children?: #DraftBlock & {
			kind:    "section"
			heading: "Children"
			metrics: {
				visible: words: <=60
				codeLines:  <=10
				paragraphs: 0
				lists:      1
				listItems:  >=1 & <=12
			}
			content: [#List & {items: [...{metrics: visible: words: <=15}]}]
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
