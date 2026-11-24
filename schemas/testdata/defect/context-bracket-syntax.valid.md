# Preview freezes when the report opens

## Outcome

The preview stays responsive when the report opens.

## Context

The script uses `[[ -n $x ]]` to test the variable. Use `a[[0]]` to read the first cell.

The parser reads a[[0]] and [[1, 2], [3, 4]]. The report shows [[1]](https://example.com).

## Actual

The preview stops responding.

```bash
if [[ -n $x ]]; then echo ok; fi
```

## Reproduction

1. Open the monthly report.
2. Select the preview tab.

## Acceptance criteria

- The preview responds when the monthly report opens.

## Verification

- Regression test: Check that the monthly report preview responds.
