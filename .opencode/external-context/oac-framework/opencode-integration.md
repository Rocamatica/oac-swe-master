---
source: GitHub Repository (darrenhinde/OpenAgentsControl)
library: OpenAgentsControl (OAC)
package: @nextsystems/oac
topic: opencode-integration
fetched: 2026-06-16T10:00:00Z
official_docs: https://github.com/darrenhinde/OpenAgentsControl
version: v0.7.1
---

# OpenCode Integration

## How OAC Extends OpenCode

OpenAgents Control builds on top of OpenCode (an open-source AI coding framework) by adding:

### 1. Agent System
OAC provides markdown-based agent definitions that OpenCode loads as prompts:
- **OpenAgent** (v1) — Universal agent for questions, tasks, and coordination
- **OpenCoder** — Production development with complex feature orchestration
- **SystemBuilder** — Generate custom AI systems
- **Specialists** — Content, data, devops, frontend specialists

Agents are defined in `.opencode/agent/` as markdown files with YAML frontmatter:
```yaml
---
name: OpenAgent
description: "Universal agent for answering queries..."
mode: primary
temperature: 0.2
permission:
  bash:
    "*": "ask"
    "sudo *": "deny"
  edit:
    "**/*.env*": "deny"
    ".git/**": "deny"
---
```

### 2. Subagent Delegation
OAC uses OpenCode's `task()` tool for subagent delegation:
```javascript
task(
  subagent_type="ContextScout",
  description="Find context files",
  prompt="Search for context files related to..."
)
```

### 3. Context System
OAC's context system integrates with OpenCode's file reading capabilities:
- Context files stored as markdown in `.opencode/context/`
- Agents use OpenCode's `Read` tool to load context
- Context is loaded lazily — only when needed
- Project intelligence in `project-intelligence/` overrides core defaults

### 4. Slash Commands
OAC defines custom slash commands that work within OpenCode:
| Command | Purpose |
|---------|---------|
| `/add-context` | Interactive wizard for project patterns |
| `/commit` | Smart git commits with conventional format |
| `/test` | Run testing pipeline |
| `/context` | Context management (harvest, organize, validate) |
| `/optimize` | Code optimization |
| `/clean` | Clean build artifacts |
| `/analyze-patterns` | Pattern analysis |
| `/validate-repo` | Validate registry/component consistency |

### 5. Skills System
OAC provides reusable skills that OpenCode can load:
- **context7** — External library documentation fetching
- **task-management** — Task CLI for feature subtask tracking
- **context-manager** — Context lifecycle operations (discover, fetch, harvest, organize)
- **smart-router** — Personality/mission-based routing

### 6. Model Agnosticism
OAC agents can use any OpenCode-compatible model:
- Default: OpenCode default model
- Per-agent override via frontmatter `model:` field
- Supports Claude, GPT, Gemini, Grok, local models

### 7. Permission System
OAC uses OpenCode's permission system with granular controls:
```yaml
permission:
  bash:
    "rm -rf *": "ask"       # Dangerous commands require approval
    "sudo *": "deny"         # Sudo is always denied
  edit:
    "**/*.env*": "deny"      # Never edit env files
    ".git/**": "deny"         # Never edit git internals
```

### 8. OpenCode Config Files
- `.opencode/config.json` — `{"agent": "eval-runner"}` (default agent for eval mode)
- `.opencode/opencode.json` — `{"$schema": "https://opencode.ai/config.json"}` (OpenCode schema)
- `package.json` — npm package definition with `bin` entry `oac` pointing to `./bin/oac.js`

### 9. Event System Integration
OAC uses OpenCode plugin events:
- `agent:start` / `agent:end` — Agent lifecycle
- `task:start` / `task:end` — Subagent task lifecycle
- `command:execute` — Slash command execution
- `skill:load` / `skill:unload` — Skill management
- `tool:execute` — Custom tool execution

### 10. Plugin System
OAC has an experimental Claude Code plugin integration at `plugins/claude-code/`:
- 6-stage workflow with approval gates
- 7 specialized subagents
- 9 workflow skills + 6 user commands
- Flexible context discovery (.oac, .claude/context, .opencode/context)
