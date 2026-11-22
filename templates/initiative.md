---
type: Initiative
max_words: 260
max_code_lines: 10
sections:
  - heading: Outcome
    required: true
    min_words: 10
    max_words: 50
    hint: What is true when every child is done.
  - heading: Checks
    required: true
    min_words: 5
    max_words: 80
    max_items: 6
    max_item_words: 20
    list_only: true
    hint: Checkboxes that prove the epic is done.
  - heading: Context
    required: true
    min_words: 10
    max_words: 100
    hint: Why this exists and how the children fit.
  - heading: Children
    required: false
    max_words: 60
    max_items: 12
    max_item_words: 15
    list_only: true
    hint: One line per child issue.
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

## Children

- {{first_child}}

## Out of scope

{{out_of_scope}}
