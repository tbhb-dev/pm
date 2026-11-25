# Preview freezes when the report opens

## Outcome

The preview stays responsive when the report opens.

## Context

This builds on the parser from owner/repo#88.
Port the retry logic from PR #41.
Depends on owner/repo#53.
The review of a pull request never loads.

## Actual

The preview stops responding.

## Reproduction

- S1: Open the monthly report.
- S2: Select the preview tab.

## Acceptance criteria

- AC1: The preview responds when the monthly report opens.

## Verification

- V1: Regression test: Check that the monthly report preview responds.
- V2: The merged change from PR #12 is on the default branch.
