---
type: Feature
max_words: 200
max_code_lines: 10
sections:
  - heading: Outcome
    required: true
    min_words: 10
    max_words: 40
    hint: What users or agents can do after this ships.
  - heading: Checks
    required: true
    min_words: 5
    max_words: 80
    max_items: 6
    max_item_words: 20
    list_only: true
    hint: Checkboxes that prove it is done, one short line each.
  - heading: Context
    required: true
    min_words: 10
    max_words: 80
    hint: Why this matters and what to know first. Link, don't paste.
  - heading: Out of scope
    required: true
    max_words: 30
    hint: What this issue will not do.
---

# {{title}}

## Outcome

{{outcome}}

## Checks

- [ ] {{first_check}}

## Context

{{context}}

## Out of scope

{{out_of_scope}}
