---
type: Spike
max_words: 300
sections:
  - heading: Outcome
    required: true
    min_words: 10
    max_words: 60
  - heading: Checks
    required: true
    min_words: 5
    max_words: 120
    max_items: 8
  - heading: Context
    required: true
    min_words: 10
    max_words: 150
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

## Out of scope

{{out_of_scope}}
