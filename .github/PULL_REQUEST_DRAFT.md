---
base: feat/epic-initiative-templates
draft: true
---

# feat: check work notes and document issue evidence

## Why

A work note gives reviewers a place to find evidence when an issue closes. The earlier work note schema expected a different block name from the one the Markdown normalizer produces. [Original template proposal](https://github.com/tbhb-dev/pm/pull/3)

## Behavior change

The schema validates work notes against the block the normalizer produces. Record evidence and links to applicable CI runs at closure. The design note explains acceptance criteria, Verification, and the Definition of Done. It cites two sources, including the 2020 Scrum Guide.

## Verification

Running `cue vet` with version 0.17.1 accepted all eight schemas. All 196 checks passed. The work note cases covered valid evidence and rejection of a note without evidence. Both quotations match the cited pages.
