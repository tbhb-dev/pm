# Preview freezes when the report opens

## Outcome

The preview stays responsive when the report opens.

## Context

Copy the entries from the audit log into the report.
Errors from the audit job stop the release.
The exporter reads rows from the audit table every hour.
Remove the button from the review page.
Comments from the review thread vanish.
Remove the label from the review queue.
Export the rows from the audit table to CSV.

## Actual

The preview stops responding.

## Reproduction

1. Open the monthly report.
2. Select the preview tab.

## Acceptance criteria

- AC1: The preview responds when the monthly report opens.

## Verification

- V1: Regression test: Check that the monthly report preview responds.

## Out of scope

- Changing the report layout.
