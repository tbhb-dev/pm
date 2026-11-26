---
type: Defect
area: area:reports
fields:
  work-type: Planned
  severity: SEV3
assignees: []
---

# Preview freezes when the report opens

## Outcome

The preview stays responsive when the monthly report opens after readers apply a previous month filter in the dashboard without refreshing the report preview first.

## Actual

The preview stops responding.

## Reproduction

1. Open the monthly report from the dashboard after signing in and wait until the report finishes loading saved data.
2. Select the preview tab beside the report summary and wait until the loading indicator disappears from the preview panel.
3. Expand the date filter near the report and choose the previous month while keeping the report preview tab open.
4. Apply the selected date filter and wait for report totals to update before clicking anywhere inside the preview panel.
5. Scroll to the bottom of the preview panel and select the final report row while the filter remains active.
6. Return to the top of the preview panel and try opening the report menu while watching the frozen interface.

## Acceptance criteria

- AC1: The preview panel responds to menu clicks after readers filter the monthly report by the previous month.
- AC2: Selecting the final report row keeps the preview header controls active while the date filter stays applied.
- AC3: Switching between the summary tab and the preview tab preserves the selected month without freezing the browser.

## Verification

- V1: Regression test: Filter the monthly report in the preview panel and confirm the report menu opens after scrolling.
- V2: Select the final row in a filtered monthly report preview and confirm the header controls remain interactive.
- V3: Switch tabs after filtering the monthly report preview and confirm the selected month stays active without delay.

## Out of scope

- Changing report layout.
- Changing export formats.
- Rewriting cache policy.
