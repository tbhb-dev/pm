# Issue templates and the Definition of Done

“The Definition of Done is a formal description of the state of the Increment when it meets the quality measures required for the product.” [Scrum Guide 2020](https://scrumguides.org/scrum-guide.html#commitment-definition-of-done)

Mike Cohn uses *conditions of satisfaction* for acceptance criteria. He writes that they “are specific to a given product backlog item and define what must be true for that particular product backlog item to be considered done.” [Relationship Between Definition of Done and Conditions of Satisfaction](https://www.mountaingoatsoftware.com/agile/clarifying-the-relationship-between-definition-of-done-and-conditions-of-sa)

## Issue criteria and evidence

After the title, start with Outcome, one sentence stating what will be true when the work is done. Follow with Context, Acceptance criteria, Verification, and Out of scope. For a Defect, put Actual and Reproduction after Context. For a Spike, start with Question and put Decision after Context. A Task has only a title and Verification.

Every other template lists each of its sections, including Context and Out of scope. Feature, Epic, and Initiative require Context. Context is optional for Chore, Defect, and Spike, and Out of scope is optional for every type. [The issue writing guide](issue-writing.md) covers the prose of each section.

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

A Spike's criteria describe what the findings must establish for the decision. Epic criteria describe observable parts of a capability, and Initiative criteria describe measurable results.

## Hierarchy and ownership

| Issue type | Parent |
| --- | --- |
| Initiative | None |
| Epic | Required, an Initiative |
| Feature | Required, an Epic |
| Task | Required, any issue type except Task |
| Defect | Optional, a Feature, an Epic, or a Problem |
| Chore | Optional, a Feature, an Epic, or a Problem |
| Spike | Optional, either a Feature or an Epic |

The schema and the templates refuse a Task, Feature, or Epic without a parent. A Problem is a planned issue type that parents the Defects and Chores that fix it. Incidents link to a Problem. The Problem rows in the table go no further than that, pending the Problem design.

Write every parent and `blocked_by` reference as `owner/repo#N`. A bare `#N` fails validation in both fields and sections.

An issue has no owner field. The repository implies which role works on it, and a role label marks an exception.

For this repository, close completed work with evidence on the issue, such as a work note that links to a merged pull request, a result, or a decision. In Verification, give the exact check and the result it shows, such as the continuous integration (CI) workflow or test target that covers the outcome. At closure, link to the run that supplies the evidence.

## Schema and rendering

The issue variants load the tools schemas alongside the local definitions in `schemas/issue-sections.cue`. The shared item rules require 2 to 20 visible words and reject standalone restatements such as “Tests pass.” [Shared schemas](https://github.com/tbhb-dev/tools/tree/5192863b/schemas)

The renderer drops a section, heading included, when the key for its placeholder is absent. This lets a caller omit an optional section. The renderer in the tools repository still raises `KeyError` for an absent key, and a separate change fixes that.

The first line of a template, `# {{title}}`, is the title block that the schemas check. The tools library sends the body unchanged. The caller splits the title from the body before posting. The heading text becomes the issue title, and the remaining sections become the body.

The shared title rules cap length and reject ticket prefixes. A Spike title must end with a question mark. Use an outcome for Initiative and a capability noun phrase for Epic. Feature uses `<Role> can <action>`, Task and Chore start with an imperative verb, and Defect uses `<Thing> <does wrong> when <condition>`. The kernel can evaluate `#KernelChecks.titleShape` separately to warn about phrasing.

## Checks the kernel runs

The kernel in the tools repository runs these content checks in a separate change. This section is their specification, because the schemas can't express them. Each line gives the rule and an example that fails. A check is a warning when its phrase can be legitimate and a refusal otherwise, per the check design in that repository.

- Bare reference (refusal): a reference that omits the owner and repository, such as `Blocked by #12.`, anywhere in a section, in the parent field, or in `blocked_by`.
- Bare location (refusal): a `path:NN` pattern outside a permalink pinned to a commit hash, such as `Found in lib/cache.sh:42.`
- Existence-only item (warning or refusal): an Acceptance criteria or Verification item that matches `(is|are) (written|merged|updated|done|added|created|documented|implemented|complete)` or that says `exists`, such as `The spike is written.`
- Missing final period (refusal): a list item without a period at the end, task-list items included, such as `- The dashboard lists each failed job`. An item made only of a link or a code span is exempt.
- Semicolon (warning): a semicolon in prose outside code spans and fenced code, such as `The stub covers the runner checks; no test uses a real JVM.`
- Meta exposition (warning): a phrase that matches `tracked in|tracked under|this issue (covers|tracks|is)|see the sub-issues|split from|parent issue|child issue|umbrella|this epic`, such as `Its parts are tracked in the gateway epic.`
- Context bookkeeping (warning): message times, run names, reviewer notes, deferral reasons, and process dates in Context, such as `Deferred in review on 2026-11-20.`
- Parent type (refusal): a parent whose type breaks the hierarchy table, such as a Feature whose parent is a Defect. The kernel fetches the parent and checks it against `#KernelChecks.parentType` from the variant.

The same checks run on imported bodies, Context sections included. A body from an old tracker keeps none of its bare locations, bare references, or meta sentences.

## Unverified by the schema

The schema checks the format of each parent reference. The kernel needs to fetch the parent to confirm its type. A reviewer still needs to check whether each criterion states one observable outcome, whether evidence covers the criteria, and whether closure meets the Definition of Done.
