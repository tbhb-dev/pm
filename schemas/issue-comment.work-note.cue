package content

// Work note comment. Template: templates/work-note.txt (starting text only).

#Hints: "work-note": note: "One or two sentences, with evidence."

#Variant: #Draft & {
	object:  "issue-comment"
	variant: "work-note"

	metadata: close({})

	metrics: visible: words: >=1 & <=60

	blockOrder: ["note"]
	blocks: close({
		note: #DraftBlock & {
			kind: "text"
			metrics: {
				visible: words: >=1 & <=60
				codeLines:      <=10
				atxHeadings:    0
				setextHeadings: 0
			}
		}
	})
}
