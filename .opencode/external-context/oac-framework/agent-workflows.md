---
source: GitHub Repository (darrenhinde/OpenAgentsControl)
library: OpenAgentsControl (OAC)
package: @nextsystems/oac
topic: agent-workflows
fetched: 2026-06-16T10:00:00Z
official_docs: https://github.com/darrenhinde/OpenAgentsControl
version: v0.7.1
---

# Agent Workflows

## OpenAgent Workflow (Universal Agent)

```
Stage 1:  Analyze      → Assess request type (conversational vs task path)
Stage 1.5: Discover    → Use ContextScout to find relevant context files
Stage 1.5b: External   → If external packages detected, use ExternalScout
Stage 2:  Approve      → Present plan based on context → Request approval
Stage 3:  Execute      → Load context → Route to subagent or execute directly
Stage 4:  Validate     → Check quality, verify completion, test
Stage 5:  Summarize    → Brief or formal summary based on complexity
Stage 6:  Confirm      → Ask user if satisfactory → Cleanup session files
```

**Key rules**:
- ContextScout is EXEMPT from approval gates
- ExternalScout is MANDATORY for external library usage
- ALWAYS load context before execution
- NEVER auto-fix errors — always report + request approval
- STOP on test failures

## OpenCoder Workflow (Development Specialist)

```
Stage 1:  Discover       → ContextScout + ExternalScout (read-only)
Stage 2:  Propose        → Lightweight summary → Request approval
Stage 3:  InitSession    → Create .tmp/sessions/{id}/context.md
Stage 4:  Plan           → TaskManager breaks into subtasks (if complex)
Stage 5:  Execute        → Parallel batch execution via CoderAgents
Stage 6:  ValidateAndHandoff → Integration tests, review, summarize
```

**Key features**:
- Parallel batch execution (tasks with no dependencies run simultaneously)
- Session-based context sharing (context.md written once, read by all)
- BatchExecutor for 5+ parallel tasks
- Incremental execution — one step at a time with validation

## TaskManager Breakdown Flow

```
Complex Feature
    ↓
TaskManager
    ↓
Creates .tmp/tasks/{feature}/task.json + subtask_NN.json files
    ↓
Each subtask has: description, context_files, reference_files, depends_on, parallel flag
    ↓
OpenCoder reads task structure
    ↓
Groups into dependency-ordered batches
    ↓
Batch 1: [01, 02, 03] → Execute in PARALLEL (delegate to CoderAgents)
Batch 2: [04]          → Execute after Batch 1 completes
Batch 3: [05]          → Execute after Batch 2 completes
```

## Parallel Execution Strategy

| Batch Size | Strategy | Method |
|-----------|----------|--------|
| 1-4 parallel tasks | Direct delegation | OpenCoder → CoderAgents (simultaneous) |
| 5+ parallel tasks | BatchExecutor | OpenCoder → BatchExecutor → CoderAgents |
| Sequential tasks | Direct | OpenCoder → CoderAgent (one at a time) |
