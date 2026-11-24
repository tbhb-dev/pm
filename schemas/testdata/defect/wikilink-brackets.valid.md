# Preview freezes when the report opens

## Outcome

The preview stays responsive when the report opens.

## Context

The script uses `[[ -n $x ]]` to test the variable.
Use `a[[0]]` to read the first cell.
The parser accepts [[ -n $x ]] and [[1, 2], [3, 4]].
The preview shows [[1]](https://example.com).
The tokens a[[epic-slug]] and `[[epic-slug]]` stay literal.

```bash
if [[ -n $x ]]; then echo ok; fi
```

## Actual

The preview stops responding.

## Reproduction

The preview froze on the monthly report after a period of inactivity.

## Acceptance criteria

- The preview responds when the monthly report opens.

## Verification

- Regression test: Check that the monthly report preview responds.
