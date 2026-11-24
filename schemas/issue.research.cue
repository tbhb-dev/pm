package content

// Research issue. Template: templates/research.md (starting text only).
// Research is an investigation whose deliverable is a written report, with no build or experiment, while a Spike is a time-boxed experiment.
// Load with tools' core.cue, taxonomy.cue and issue.cue, plus issue-sections.cue.

#Hints: research: {
	title:                  "Ask the research question and end with a question mark."
	question:               "The one question this research answers. End it with a question mark."
	decision:               "The decision or work the report informs."
	scope:                  "What the investigation covers."
	"deliverable-location": "Where the report will exist. Give one path or link."
	verification:           "Keep exactly one item that reads: The report exists at the stated deliverable location. Link the report on the issue before closing."
}

#Variant: #Draft & {
	object:  "issue"
	variant: "research"

	metadata: close({
		type: "Research"
		// One area label is required and one role label is optional. The
		// kernel turns these into labels. Priority is a field, never a label.
		area:  #AreaLabel
		role?: #RoleLabel
		// Time box is a field, never a section.
		fields: close({
			priority?: #Priority
			source?:   #Source
			timebox:   #Timebox
		})
		assignees: [...string]
		// An Epic, an Initiative, or none. The schema checks the reference format only.
		parent?: #IssueRef
	})

	metrics: {
		visible: words:     <=150
		source: characters: <=1200
	}

	blockOrder: ["title", "question", "decision", "scope", "deliverable-location", "verification"]
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
		scope: #IssueSection & {
			heading: "Scope"
			metrics: {
				visible: words:     >=3 & <=40
				source: characters: <=320
				codeLines: <=0
			}
		}
		// One path or link on one line. The section key follows the heading.
		"deliverable-location": #IssueSection & {
			heading: "Deliverable location"
			metrics: {
				visible: words:     >=1 & <=20
				source: characters: <=240
				paragraphs: 1
				lists:      0
				codeLines:  <=0
			}
			visible: !~#"\n"#
		}
		verification: #VerificationSection & {
			metrics: listItems: 1
			visible: "The report exists at the stated deliverable location"
		}
	})
}
