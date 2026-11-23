---
base: feat/feature-chore-templates
draft: true
---

# feat: add Defect and Spike issue templates

## Why

Defects need regression tests. Spike drafts need a way to show that the research answered the question and can inform a decision. [Original template proposal](https://github.com/tbhb-dev/pm/pull/3)

## Behavior change

Each type requires one to three criteria and one to three verification items. Defect requires a regression test. Spike titles end with a question mark, and the kernel can warn when a Defect title omits the trigger for the failure. To close the issue, record the evidence. Reference gates with `ci_enforced`.

## Verification

Running `cue vet` with version 0.17.1 accepted all five schemas in the stack. All 138 normalized cases passed, including a rendered Defect, a rendered Spike, and missing or empty regression entries.
