# Preview freezes when the report opens

## Outcome

The preview stays responsive when the report opens.

## Context

The parser reads these table arrays.

```toml
[[package]]
[[rules]]
[[annotations]]
```

## Actual

The preview stops responding.

## Reproduction

The preview froze on the monthly report after a period of inactivity.

## Acceptance criteria

- The preview responds when the monthly report opens.

## Verification

- Regression test: Check that the monthly report preview responds.
