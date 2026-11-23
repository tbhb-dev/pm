# Issue writing guide

An issue says what the work changes and how to check it. Write for a stranger who reads each sentence once. The templates and schemas in this repository set the form, and [Issue templates and the Definition of Done](issue-templates.md) lists the checks. This guide covers the prose. In each pair below, the first block fails. The second block passes.

## Context

Context is one or two plain sentences, then a bullet list of specifics. Leave out message times, run names, reviewer bookkeeping, deferral reasons, and process dates. Write any "found in" as a fully qualified link.

```text
Bad
Deferred in review on 2026-11-20 after run nightly-4 failed, see the thread.
Found in lib/cache.sh:42.

Good
The nightly job fails silently when the cache is cold.
- The failure shows only in the runner log for tbhb-dev/pm#12.
- The cache check is the `warm_cache` function in `lib/cache.sh`.
```

## Locations

Refer to a file by its symbol, target, or key. A line number goes stale at the next edit. When exact lines matter, use a GitHub permalink pinned to a commit hash. A `path:NN` pattern outside a permalink fails the content check.

```text
Bad
The guard is in scripts/guard.sh:88.

Good
The guard is the `check_token` function in `scripts/guard.sh`.
The loop is at https://github.com/tbhb-dev/pm/blob/1282ff04cb4b33d34cbbf86eb051d75853e3d553/size-check.sh#L1-L3
```

## References

Write every issue and pull request reference as `owner/repo#N`, in sections and in fields such as the parent and `blocked_by`. A bare `#N` fails validation, because it points at a different issue from each repository.

```text
Bad
Blocked by #12.

Good
Blocked by tbhb-dev/pm#12.
```

## Observable results

An acceptance criterion or a verification item states a result someone can check. It never claims that the work exists or that someone finished it. A verification item states the exact check and the result it shows, in one sentence.

```text
Bad
- The spike is written.
- The PR is merged.
- The doc is updated.

Good
- Pushing a 2 GB image and pulling it back gives an identical digest.
- The results table lists push, referrers, sync and GC each as pass or fail with the command used.
- Running `bazel test //pkg:foo_test` reports the new case passing.
```

## One fact per sentence

Write plain subject-verb sentences. Don't join clauses with a semicolon or a comma. Give each separate fact its own sentence or bullet.

```text
Bad
font_usage_test.sh stubs Java, so no test shows the font checks reject bad fonts with a real JVM; the stub covers the runner checks.

Good
The font checks are only tested with a stubbed Java, so no test proves they reject a bad font on a real JVM.
- The stub covers the runner checks.
```

## List items

Every list item is a full sentence that ends with a period. The rule covers bullets, numbered steps, and task-list items. The value you supply for a list placeholder in a template includes its period.

```text
Bad
- The dashboard lists each failed job

Good
- The dashboard lists each failed job.
```

## No sentences about the issue itself

GitHub sub-issue and dependency links record the structure, tracking, and relationships of an issue. Every sentence says something about the work or the system. Rewrite a sentence about the issue as one about the work, or delete it.

```text
Bad
Its parts are tracked in the epic to build and roll out the event gateway.
This issue covers the retry logic. See the sub-issues.

Good
The gateway accepts events from every producer and delivers each one to its subscribers at least once.
```

## Readiness checklist

This checklist is the Definition of Ready. Refinement checks each item before an issue is ready for work. A reviewer fixes a failed item or sends the issue back.

1. The type and parent follow the hierarchy in the templates doc, and the parent uses the form `owner/repo#N`.
2. The title matches the pattern for its type.
3. The Outcome is one sentence.
4. Context is one or two plain sentences and a bullet list, with no bookkeeping, and any "found in" is a fully qualified link.
5. Each acceptance criterion states one observable result, not the existence of the work.
6. Each verification item gives the exact check and its expected result in one sentence.
7. Each sentence states one fact, and no semicolon or comma joins clauses.
8. Every list item is a full sentence that ends with a period.
9. No sentence describes the issue's structure, tracking, relationships, or process.
10. No location is a bare `file:line`, and every reference is fully qualified.
11. The issue has no owner field. The repository implies which role works on it, and a role label marks an exception.
12. Refinement files an issue about internal security in a private repository. Internal security covers a certificate authority, credentials, keys, access control, and host exposure.

## Refinement agent duties

The refinement agent runs the preceding checklist on each public issue. For item 12, it checks the issue first. When the issue is about internal security, the agent files its content in a private repository through the content library. It then deletes the public issue. An edit would leave the old text in the issue's edit history. If it can't delete the issue, it asks a repository administrator to delete it. No trace of the sensitive text remains in the title, body, or comments of the public issue.
