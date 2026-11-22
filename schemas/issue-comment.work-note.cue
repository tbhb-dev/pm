package content

// Work note comment. Template: templates/work-note.txt (starting text only).
// Load with core.cue and taxonomy.cue, and one variant file per run.

#Hints: "work-note": note: "One short paragraph with evidence: a repository reference, a link, or a code span."

#Variant: #Draft & {
	object:  "issue-comment"
	variant: "work-note"

	metadata: close({})

	metrics: visible: words: >=3 & <=60

	blockOrder: ["note"]
	blocks: close({
		note: #DraftBlock & {
			kind:   "text"
			source: =~#"(`[^`]+`|https?://|[a-z0-9][a-z0-9-]*/[a-z0-9._-]+#[0-9]+|\b[0-9a-f]{7,40}\b)"#
			metrics: {
				visible: words:     >=3 & <=60
				source: characters: <=480
				paragraphs:     1
				lists:          0
				tables:         0
				blockQuotes:    0
				atxHeadings:    0
				setextHeadings: 0
				htmlBlocks:     0
				codeLines:      <=5
			}
		}
	})
}
