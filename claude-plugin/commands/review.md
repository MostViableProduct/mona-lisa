---
description: "Run an adversarial review of the most recent artifact"
---
Run an adversarial review of the most recent artifact in this session. Follow these steps exactly:

**Step 1 — Identify the artifact**

Look at the most recent significant output in this conversation:
- If a plan file was just written: use artifact_type="plan_file" with the plan content
- If significant code was just written (new feature, multi-file change, migration): use artifact_type="code_output" with the code
- If neither, ask the user what to review before proceeding

**Step 2 — Trigger the review**

Call `trigger_review` with:
- `artifact_type`: "plan_file" or "code_output"
- `content`: the artifact text (or `file_path` if the artifact is a local file)
- `session_id`: the current session ID if available

Note the `review_id` returned.

**Step 3 — Poll for completion**

Call `get_review_status(review_id=<id>)` every few seconds until `review_status` is "completed" or "error".
Always use the `review_id` from Step 2.

**Step 4 — Present findings**

Format findings as:

```
[MoVP] Review  rev_<id>  Quality: <X>/10  Alignment: <Y>/10  Cost: $<Z>

Category Scores:
  security: <n>  correctness: <n>  performance: <n>  stability: <n>
  ux_drift: <n>  outcome_drift: <n>  missing_tests: <n>  scope_creep: <n>

Findings (<total>):

[HIGH] <category> (<confidence>)
  <summary> — <file_path>:<line_number>
  Fix: <suggested_fix>

[MED] ...

[LOW] ...
```

If review_status is "error", show the error and offer to retry.

**Step 5 — Ask for resolution**

After presenting findings, always ask:

> **Reply with:** implement fixes, dismiss (false positive / not applicable / deferred), accept as-is, or retry

**Step 6 — Resolve**

Based on the developer's reply:
- "implement fixes" → work on the fixes, then call `resolve_review(review_id=<id>, action="accept")` when done
- "accept" / "looks good" / "ship it" → call `resolve_review(review_id=<id>, action="accept")`
- "dismiss" / "false positive" / "not applicable" → call `resolve_review(review_id=<id>, action="dismiss", reason="false_positive"|"not_applicable"|"deferred")`
- "escalate" / "create a ticket" → call `resolve_review(review_id=<id>, action="escalate", target="todo")`
- "retry" → call `resolve_review(review_id=<id>, action="retry")` — only valid when review_status is "error"
