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

The preview froze on the monthly report after a period of inactivity.

## Acceptance criteria

- The preview responds when the monthly report opens.

## Verification

- Regression test: Check that the monthly report preview responds.
- The merged change from PR #12 is on the default branch.
