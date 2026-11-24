# Issue templates and the Definition of Done

“The Definition of Done is a formal description of the state of the Increment when it meets the quality measures required for the product.” [Scrum Guide 2020](https://scrumguides.org/scrum-guide.html#commitment-definition-of-done)

Mike Cohn uses *conditions of satisfaction* for acceptance criteria. He writes that they “are specific to a given product backlog item and define what must be true for that particular product backlog item to be considered done.” [Relationship Between Definition of Done and Conditions of Satisfaction](https://www.mountaingoatsoftware.com/agile/clarifying-the-relationship-between-definition-of-done-and-conditions-of-sa)

## Issue criteria and evidence

For most issue types, start with Outcome, one sentence stating what will be true when the work is done. Follow with Context, Acceptance criteria, Verification, and Out of scope, as applicable. For a Defect, put Actual and Reproduction after Context. For a Spike, start with Question and put Decision after Context. Chores list their results in Verification. A Task starts with Description and ends with Verification.

Write Reproduction steps as bullets, or describe the observed conditions in one paragraph if the steps are unknown.

Start each list item with its ID, a colon, and a space, as in `- AC1: The preview opens`. Use `AC` for acceptance criteria, `V` for verification, and `S` for reproduction steps. Reserve `O` for a decision options list if a template adds one. Prefixes apply within each template. Start each list at 1 and count up by one, without leading zeros.

For issues with acceptance criteria, write one observable outcome per criterion and name the evidence in Verification. An evidence item can cover multiple criteria if the reader can tell which ones it proves.

| Issue type | Acceptance criteria | Verification |
| --- | --- | --- |
| Feature | 2 to 5 | 1 to 3 |
| Chore | — | 1 to 3 |
| Defect | 1 to 3 | 1 to 3, including a `Regression test:` entry |
| Task | — | 1 to 3 |
| Spike | 1 to 3 | 1 to 3 |
| Research | — | 1 |
| Epic | 1 to 6 | 1 to 3 |
| Initiative | 1 to 6 | 1 to 3 |

Each criterion and verification item has 2 to 20 visible words, including its ID. The ID leaves room for 1 to 19 words of text. The Defect label `Regression test:` takes two of those words. Write 1 to 6 Reproduction steps with up to 20 visible words per step, including the ID.

A Spike's criteria describe what the findings must establish for the decision. Epic criteria describe observable parts of a capability, and Initiative criteria describe measurable results.

An Initiative has no parent. An Epic requires an Initiative parent, and a Feature requires an Epic parent. A Defect, Chore, or Spike may stand alone or have a parent. A Task requires a parent of any issue type except Task.

Research is an investigation that delivers a written report, with no build or experiment. A Spike is an experiment. After a title that ends with a question mark, a Research issue requires Question, Decision, Scope, Deliverable location, and Verification in that order. The one Verification item states that the report exists at the stated deliverable location. A Research issue may stand alone or have an Epic or Initiative parent. The draft allows up to 150 visible words and 1,200 source characters.

For this repository, close completed work with evidence on the issue, such as a work note that links to a merged pull request, a result, or a decision. In Verification, use `ci_enforced` with a reference to the continuous integration (CI) workflow or check that covers the outcome. At closure, link to the run that supplies the evidence.

## Schema and rendering

The issue variants load the tools schemas alongside the local definitions in `schemas/issue-sections.cue`. The shared item rules require 2 to 20 visible words and reject standalone restatements such as “Tests pass.” [Shared schemas](https://github.com/tbhb-dev/tools/tree/5192863b/schemas)

Use `source` for provenance because issue body sections outside the imported variant refuse provenance sentences and can refuse hyphenated wikilinks even in code, while slugs without hyphens pass.

The templates render required sections from supplied keys. Insert optional sections in the order above when there is text for them, since the renderer raises `KeyError` for an absent key.

The shared title rules cap length and reject ticket prefixes. A Spike title must end with a question mark. Use an outcome for Initiative and a capability noun phrase for Epic. Feature uses `<Role> can <action>`, Task and Chore start with an imperative verb, and Defect uses `<Thing> <does wrong> when <condition>`. The kernel can evaluate `#KernelChecks.titleShape` separately to warn about phrasing.

Use the imported variant only for the tracker import. It takes an assignee list and accepts Initiative, Epic, Feature, Defect, Chore, and Task as issue types. The area and role labels, parent, and `blocked_by` references are optional. The import sets Source to `Import`. Refinement keeps that value and assigns Work type and Priority as needed. The title needs at least one word and allows up to 256 visible characters. The required Context section allows up to 450 visible words, 2,600 source characters, and 40 lines of code. The draft allows up to 460 visible words and 2,700 source characters.

## Unverified by the schema

The schema checks the format of each parent reference. The kernel needs to fetch the parent to confirm its type. A reviewer still needs to check whether each criterion states one observable outcome, whether evidence covers the criteria, and whether closure meets the Definition of Done.
