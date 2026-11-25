# Preview freezes when the report opens

## Outcome

The preview stays responsive when the report opens.

## Context

The log showed null for the field.
The value found in the response was 3.
The audit log grows without bound.
The audit log drops the entry.
The error raised by the parser stops the preview.
Parser errors are surfaced in the preview pane.
The error reported by the parser blocks the preview.
The issue discovered in the cache still affects the preview.

## Actual

The preview stops responding.

## Reproduction

- S1: Open the monthly report.
- S2: Select the preview tab.

## Acceptance criteria

- AC1: The preview responds when the monthly report opens.

## Verification

- V1: Regression test: Check that the monthly report preview responds.
