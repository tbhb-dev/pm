---
base: main
draft: true
---

# feat: add Feature, Chore, and Task issue templates

## Why

A generic checklist leaves readers guessing what counts as success. Feature and Chore need observable outcomes and evidence. Contributors also need a Task template for small steps under a Feature. See [the original template proposal](https://github.com/tbhb-dev/pm/pull/3).

## Behavior change

Feature requires two to five acceptance criteria. Chore requires one to three. Both require one to three verification items, and Task requires Verification and a parent reference. All three use shared title rules. The kernel can warn about title phrasing without refusing the draft. The hints require evidence before closure and use `ci_enforced` to reference existing gates.

## Needs human judgment

The kernel must look up the Task parent and confirm that its type is Feature.

## Verification

Running `cue vet` with version 0.17.1 accepted the three schemas. All 78 cases passed for rendered templates, list bounds, title warnings, CI restatements, and the Task parent reference.
