---
type: Initiative
max_words: 600
sections:
  - heading: Outcome
    required: true
    min_words: 10
    max_words: 80
  - heading: Checks
    required: true
    min_words: 5
    max_words: 120
    max_items: 8
  - heading: Context
    required: true
    min_words: 10
    max_words: 200
  - heading: Children
    required: false
    max_words: 100
    max_items: 12
  - heading: Out of scope
    required: true
    max_words: 60
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
