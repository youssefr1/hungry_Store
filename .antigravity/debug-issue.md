# /debug-issue Workflow

## Trigger
Use this workflow when asked to fix a bug or unexpected behavior.

## Step 1 — Gather Info (no code yet)
Confirm: error message / stack trace, repro steps,
expected vs actual, feature/screen affected.

## Step 2 — Diagnose by Type

### UI_WRONG
- Widget file → hardcoded values?
- Parent section → correct data passed?
- Compare with Figma if UI mismatch

### STATE_ISSUE
- Trace all emit() in cubit
- Check buildWhen in every BlocBuilder
- Check BlocSelector field names
- Check copyWith calls

### API_FAILURE
- DataSource method → fromJson null safety?
- ApiEndpoints constant correct?
- fold() in cubit — onFailure emitting?

### CRASH
- Parse stack trace top-down
- Find exact file + line
- Null access? Type cast? Context after dispose?

### PERF_ISSUE
- BlocBuilder without buildWhen at high level?
- ListView without .builder?
- Missing const? Opacity widget? ClipRRect in list?
- Images without cacheWidth/cacheHeight?

## Step 3 — Root Cause Report
  ROOT CAUSE:   [file, line, reason]
  FIX PLAN:     [list of changes]
  NOT TOUCHING: [out-of-scope files]
→ Wait for approval before writing code.

## Step 4 — Minimum Fix
- Change ONLY identified files
- Add: // Fix: [brief explanation]
- Do NOT refactor unrelated code

## Step 5 — Verify
- Repro steps no longer trigger bug
- dart analyze → zero errors