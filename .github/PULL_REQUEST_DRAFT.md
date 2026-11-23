---
base: feat/defect-spike-templates
draft: true
---

# feat: add Epic and Initiative issue templates

## Why

The template proposal used a checklist for both capability work and wider outcomes. Epic and Initiative readers need to see what success looks like and how to confirm it. [Original template proposal](https://github.com/tbhb-dev/pm/pull/3)

## Behavior change

Epic and Initiative require one to six acceptance criteria and one to three verification items. The Epic title describes a capability. Use a measurable outcome for the Initiative title. The kernel can warn when an Epic title uses the Feature format. The hints point to evidence for closure and use `ci_enforced` to reference existing gates.

## Verification

Running `cue vet` with version 0.17.1 accepted all seven schemas in the stack. All 191 normalized cases passed, including criterion counts at both limits and the Epic title warning.
