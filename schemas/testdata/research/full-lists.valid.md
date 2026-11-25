---
type: Research
area: area:reports
fields: {}
assignees: []
---

# Which cache improves reports?

## Question

Which cache plan keeps report views fast when ten users set date filters at the same time while keeping RAM use below the set cap on each live node in the main web pool at peak load on work days?

## Decision

Pick the cache tool and drop rule for the next report view roll out across each live web node in the main pool at the start of the new term.

## Scope

Check RAM use, read time, and drop rate across three cache tools with real report filter logs from the past six weeks on the main web nodes today.

## Deliverable location

reports/cache.md

## Verification

- V1: The report exists at the stated deliverable location

## Out of scope

- Changing the report view layout to add new sum rows for users who save data from the main web panel.
- Adding a timer job that reloads open report views when a user does not press the retry button in view.
- Saving old report view data in local web store so users can open old views across new sign in runs.
