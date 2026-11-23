# Issue templates and the Definition of Done

“The Definition of Done is a formal description of the state of the Increment when it meets the quality measures required for the product.” [Scrum Guide 2020](https://scrumguides.org/scrum-guide.html#commitment-definition-of-done)

Mike Cohn uses *conditions of satisfaction* for acceptance criteria. He writes that they “are specific to a given product backlog item and define what must be true for that particular product backlog item to be considered done.” [Relationship Between Definition of Done and Conditions of Satisfaction](https://www.mountaingoatsoftware.com/agile/clarifying-the-relationship-between-definition-of-done-and-conditions-of-sa)

## Issue criteria and evidence

Write one observable outcome per acceptance criterion. Verification names the evidence for the criteria. An evidence item can cover multiple criteria if the reader can tell which ones it proves.

| Issue type | Acceptance criteria | Verification |
| --- | --- | --- |
| Feature | 2 to 5 | 1 to 3 |
| Chore | 1 to 3 | 1 to 3 |
| Defect | 1 to 3 | 1 to 3, including a `Regression test:` entry |
| Task | — | 1 to 3 |
| Spike | 1 to 3 | 1 to 3 |
| Epic | 1 to 6 | 1 to 3 |
| Initiative | 1 to 6 | 1 to 3 |

Use a Feature as the Task's parent. A Spike's criteria describe what the findings must establish for the decision. Epic criteria describe observable parts of a capability, and Initiative criteria describe measurable results.

For this repository, close completed work with evidence on the issue, such as a work note that links to a merged pull request, a result, or a decision. In Verification, use `ci_enforced` with a reference to the continuous integration (CI) workflow or check that covers the outcome. At closure, link to the run that supplies the evidence.

## Schema and rendering

The issue variants load the tools schemas alongside the local definitions in `schemas/issue-sections.cue`. The shared item rules require 2 to 20 visible words and reject standalone restatements such as “Tests pass.” [Shared schemas](https://github.com/tbhb-dev/tools/tree/5192863b/schemas)

The templates render required sections from supplied keys. Append optional sections only when there is text for them, since the renderer raises `KeyError` for an absent key.

The shared title rules cap length and reject ticket prefixes. A Spike title must end with a question mark. Use an outcome for Initiative and a capability noun phrase for Epic. Feature uses `<Role> can <action>`, Task and Chore start with an imperative verb, and Defect uses `<Thing> <does wrong> when <condition>`. The kernel can evaluate `#KernelChecks.titleShape` separately to warn about phrasing.

## Unverified by the schema

The schema checks the format of the Task's parent reference. The kernel needs to fetch the parent to confirm its type. A reviewer still needs to check whether each criterion states one observable outcome, whether evidence covers the criteria, and whether closure meets the Definition of Done.
