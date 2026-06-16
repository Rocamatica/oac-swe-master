---
source: GitHub Repository (darrenhinde/OpenAgentsControl)
library: OpenAgentsControl (OAC)
package: @nextsystems/oac
topic: architecture-overview
fetched: 2026-06-16T10:00:00Z
official_docs: https://github.com/darrenhinde/OpenAgentsControl
version: v0.7.1
---

# OAC Architecture Overview

## What is OpenAgents Control?

OpenAgents Control (OAC) is an AI agent framework that extends OpenCode with:
- **Pattern Control** — Teach agents YOUR coding patterns once, they use them forever
- **Approval Gates** — Agents propose plans → you approve → they execute
- **Context System** — MVI (Minimal Viable Information) principle for token efficiency
- **Team Workflows** — Commit contexts to repo, everyone uses same patterns

## Core Principle

**Traditional AI tools**: Generic code → You refactor
**OAC**: Your patterns → AI generates matching code

## High-Level Architecture

```
opencode CLI (host)
    │
    ├── .opencode/config.json        → {"agent": "eval-runner"} (default agent)
    ├── .opencode/opencode.json      → {"$schema": "..."} (OpenCode config)
    ├── registry.json                 → Central component catalog (v2.0.0 schema)
    ├── .opencode/
    │   ├── agent/                    → AI agent prompt definitions (markdown)
    │   │   ├── core/                 → Primary agents (OpenAgent, OpenCoder)
    │   │   ├── content/              → Content specialists (copywriter, technical-writer)
    │   │   ├── data/                 → Data specialists (data-analyst)
    │   │   ├── meta/                 → Meta agents (system-builder, repo-manager)
    │   │   └── subagents/            → Delegated specialists (ContextScout, ExternalScout, etc.)
    │   ├── command/                  → Slash command definitions
    │   ├── context/                  → Context files (standards, patterns, guides)
    │   ├── profiles/                 → Pre-configured component bundles
    │   ├── skills/                   → Reusable skills (context7, task-management, context-manager)
    │   ├── tool/                     → Custom tools (env, gemini)
    │   ├── plugin/                   → Plugin definitions (notify)
    │   ├── prompts/                  → Prompt variants per model
    │   └── scripts/                  → Utility scripts
    └── packages/                     → npm packages (cli, compatibility-layer)
```

## Key Events & Lifecycle

The system uses OpenCode's event system:
1. `agent:start` — Agent begins execution
2. `agent:end` — Agent completes execution  
3. `task:start/end` — Subagent task lifecycle
4. `command:execute` — Slash command invocation
5. `skill:load` — Skill initialization
6. `tool:execute` — Custom tool execution

## Versioning

- Current: v0.7.1 (January 30, 2026)
- Version stored in: `VERSION`, `package.json`, and `registry.json` (must all match)
- npm package: `@nextsystems/oac`
