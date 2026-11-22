---
type: Defect
max_words: 230
max_code_lines: 10
sections:
  - heading: Outcome
    required: true
    min_words: 10
    max_words: 40
    hint: The behavior that is correct once this is fixed.
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
  - heading: Reproduction
    required: false
    max_words: 60
    max_items: 6
    max_item_words: 20
    list_only: true
    hint: Numbered steps to see the fault.
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

## Reproduction

{{reproduction}}

## Out of scope

{{out_of_scope}}
