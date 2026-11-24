# Preview freezes when the report opens

## Outcome

The preview stays responsive when the report opens.

## Context

The log showed null for the field. The value found in the response was 3. The audit log grows without bound. The error raised by the parser stops the preview. Parser errors are surfaced in the preview pane. The review of a pull request never loads.

This builds on the parser from owner/repo#88. Port the retry logic from PR #41. Depends on owner/repo#53.

## Actual

The preview stops responding.

## Reproduction

1. Open the monthly report.
2. Select the preview tab.

## Acceptance criteria

- The preview responds when the monthly report opens.

## Verification

- Regression test: Check that the monthly report preview responds.
- The merged change from PR #12 is on the default branch.
