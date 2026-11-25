---
type: Task
area: area:reports
fields:
  work-type: Planned
assignees: []
parent: owner/repo#53
---

# Add a report preview retry button

## Description

Add a retry button to the monthly report preview panel so readers can recover from a temporary loading error without leaving the current report view. Keep the active date filter and selected summary row intact across each retry request today.

## Verification

- V1: Trigger a temporary report loading failure in the preview panel and confirm the retry button reloads the selected month.
- V2: Retry a failed monthly report preview with an active date filter and confirm the chosen filter stays in place.
- V3: Retry a failed monthly report preview after selecting a summary row and confirm the row selection remains visible afterward.

## Out of scope

- Changing the monthly report layout to display extra summary columns for readers who export totals from the dashboard preview panel.
- Adding background polling that refreshes open monthly report previews without a reader selecting the retry button in the dashboard panel.
- Storing previous monthly report responses in browser storage so offline readers can reopen cached previews across separate dashboard browser sessions.
