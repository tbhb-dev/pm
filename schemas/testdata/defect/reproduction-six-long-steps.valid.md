# Preview freezes when the report opens

## Outcome

The preview stays responsive when the report opens.

## Actual

The preview stops responding.

## Reproduction

1. Open the monthly report from the dashboard after signing in and wait until the report finishes loading previously saved data.
2. Select the preview tab beside the report summary and wait until the blue loading indicator disappears from the preview panel.
3. Expand the date filter above the report title and choose the previous month while keeping the report preview tab open.
4. Apply the selected date filter and wait for all report totals to update before clicking anywhere inside the preview panel.
5. Scroll to the bottom of the preview panel and select the final open report row while the filter remains active.
6. Return to the top of the preview panel and try opening the report menu again while watching the frozen interface.

## Acceptance criteria

- AC1: The preview responds when the monthly report opens.

## Verification

- V1: Regression test: Check that the monthly report preview responds.

## Out of scope

- Changing the report layout.
