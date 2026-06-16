---
source: GitHub Repository (darrenhinde/OpenAgentsControl)
library: OpenAgentsControl (OAC)
package: @nextsystems/oac
topic: context-system-architecture
fetched: 2026-06-16T10:00:00Z
official_docs: https://github.com/darrenhinde/OpenAgentsControl/blob/main/CONTEXT_SYSTEM_GUIDE.md
version: v0.7.1
---

# Context System Architecture

## How ContextScout, ExternalScout, and `/add-context` Interact

### The Flow

```
User Request
    │
    ▼
┌──────────────────────────────────────────────────────┐
│ Stage 0: Agent receives request                       │
│   → ContextScout discovers RELEVANT context files     │
│   → ExternalScout fetches LIVE docs for external libs │
└──────────────────────────────────────────────────────┘
    │
    ▼
┌──────────────────────────────────────────────────────┐
│ Stage 1: Agent loads context files                    │
│   → Code standards (code-quality.md)                  │
│   → Project patterns (technical-domain.md)            │
│   → External library docs (from ExternalScout)        │
└──────────────────────────────────────────────────────┘
    │
    ▼
┌──────────────────────────────────────────────────────┐
│ Stage 2: Agent creates code following YOUR patterns   │
│   → Uses YOUR API pattern                             │
│   → Uses YOUR component pattern                       │
│   → Uses YOUR security requirements                   │
└──────────────────────────────────────────────────────┘
    │
    ▼
  Ships without refactoring ✅
```

### ContextScout (Subagent — v5.1.0)
**Role**: Internal context discovery — "How we do things in THIS project"
- Discovers context files from `.opencode/context/`
- Ranks by priority (Critical → High → Medium)
- Resolves context location (local vs global)
- Returns precise file paths + line ranges
- 20% token reduction via optimization
- **Exempt from approval gates** for discovery
- Used before ANY code generation

### ExternalScout (Subagent — v2.0.0)
**Role**: External library documentation — "How to use THIS library (current version)"
- Fetches live docs via Context7 API (primary) or webfetch (fallback)
- Checks cache first in `.tmp/external-context/` (7-day TTL)
- Filters to relevant sections only
- Persists to `.tmp/external-context/{package-name}/{topic}.md`
- 42% token reduction via optimization
- Supports 18+ libraries (Drizzle, Prisma, Next.js, TanStack, etc.)

### `/add-context` Command
**Role**: Interactive wizard to create project intelligence
- 6-question wizard (~5 min): Tech Stack, API pattern, Component pattern, Naming conventions, Code standards, Security requirements
- Creates/updates: `.opencode/context/project-intelligence/technical-domain.md`
- Follows MVI (Minimal Viable Information) — files <200 lines
- Uses HTML frontmatter for metadata
- Option flags: `--update`, `--tech-stack`, `--patterns`, `--global`
- Detects external context files in `.tmp/` and offers to harvest

### How They Combine

| Scenario | ContextScout | ExternalScout | Both |
|----------|--------------|---------------|------|
| Project coding standards | ✅ | ❌ | ❌ |
| External library setup | ❌ | ✅ MANDATORY | ❌ |
| Project-specific patterns | ✅ | ❌ | ❌ |
| External API usage | ❌ | ✅ MANDATORY | ❌ |
| Feature w/ external lib | ✅ standards | ✅ lib docs | ✅ |
| Package installation | ❌ | ✅ MANDATORY | ❌ |
| Security patterns | ✅ | ❌ | ❌ |
| External lib integration | ✅ project | ✅ lib docs | ✅ |

**Key Principle**: ContextScout + ExternalScout = Complete Context
- ContextScout: "How we do things in THIS project"
- ExternalScout: "How to use THIS library (current version)"
- Combined: "How to use THIS library following OUR standards"

## MVI Principle (Minimal Viable Information)

Only load what's needed, when it's needed:
- Files <200 lines (scannable in 30s)
- Lazy loading — agents load only what they need
- ~80% token reduction vs loading entire codebase
- Concepts: <100 lines | Guides: <150 lines | Examples: <80 lines

## Context Directory Structure

```
.opencode/context/
├── core/                           # Universal standards
│   ├── standards/                  # Code quality, security, testing, docs
│   ├── workflows/                  # Design iteration, task delegation, code review
│   ├── context-system/             # System docs (standards, guides, operations)
│   └── task-management/            # Task JSON schema
├── ui/web/                         # Design patterns (React, styling, animations)
├── development/                    # Language-specific (backend, frontend navigation)
├── content-creation/               # Content guidelines (written, video, image, audio)
└── project-intelligence/           # YOUR custom patterns (created by /add-context)
    ├── technical-domain.md         # Tech stack & code patterns
    ├── business-domain.md          # Business context
    └── navigation.md               # Quick overview
```

## Context Hierarchy (Loading Order)

1. **Core Standards** — universal patterns (code-quality, security)
2. **Workflows** — how to do things (design iteration, external libs)
3. **Domain-Specific** — language/framework patterns
4. **Project-Specific (YOUR patterns)** — ALWAYS overrides everything else!

## Context Resolution (Local-First)

```
1. Check local: .opencode/context/core/navigation.md
   ↓ Found? → Use local. Done.
   ↓ Not found?
2. Check global: ~/.config/opencode/context/core/navigation.md
   ↓ Found? → Use global for core/ files only.
   ↓ Not found? → Proceed without core context.
```

Key rules:
- **Local always wins** — project-specific patterns never loaded from global
- **Global fallback is only for `core/`** (universal files)
- **Project intelligence is always local** — in `.opencode/context/project-intelligence/`
