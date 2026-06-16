---
source: GitHub Repository (darrenhinde/OpenAgentsControl)
library: OpenAgentsControl (OAC)
package: @nextsystems/oac
topic: profile-validation
fetched: 2026-06-16T10:00:00Z
official_docs: https://github.com/darrenhinde/OpenAgentsControl/blob/main/.opencode/context/openagents-repo/guides/profile-validation.md
version: v1.0
---

# Profile Validation Guide

## What Are Profiles?

Profiles are pre-configured component bundles in `registry.json` that users install:
- **essential** — Minimal setup (openagent + core subagents + basic context files)
- **developer** — Full dev environment (all dev agents + tools + contexts)
- **business** — Content/product focus (content agents + tools + contexts)
- **full** — Everything (all agents, subagents, tools, contexts)
- **advanced** — Full + meta-level (system-builder, repo-manager)

## The Problem

**Issue**: New agents added to `components.agents[]` but NOT added to profiles.

**Result**: Users install a profile but don't get the new agents.

## Validation Checklist (When Adding Components)

### 1. Agent Added to Components
```bash
cat registry.json | jq '.components.agents[] | select(.id == "your-agent")'
```

### 2. Agent Added to Appropriate Profiles

| If agent category is... | Add to profiles... |
|------------------------|-------------------|
| **development** | developer, full, advanced |
| **content** | business, full, advanced |
| **data** | business (if business), full, advanced |
| **meta** | advanced only |
| **core** / **essential** / **standard** | essential AND all others |

### 3. Verify Profile Includes Agent
```bash
cat registry.json | jq '.profiles.developer.components[] | select(. == "agent:your-agent")'
```

## Profile Assignment Rules (Detailed)

### Developer Profile
**Include**: Core agents, development specialists, code subagents, dev commands, dev context
**Exclude**: Content agents, data agents, meta agents

### Business Profile
**Include**: Core agent, content specialists, data specialists, image tools, notifications
**Exclude**: Development specialists, code subagents, meta agents

### Full Profile
**Include**: Everything from developer + business profiles
**Exclude**: Meta agents only

### Advanced Profile
**Include**: Everything from full + meta agents + meta subagents + meta commands
**Exclude**: Nothing (all inclusive)

## Profile JSON Structure

Each profile is a separate file in `.opencode/profiles/{name}/profile.json`:

```json
{
  "name": "Developer",
  "description": "Complete software development environment...",
  "badge": "RECOMMENDED",
  "components": [
    "agent:openagent",
    "agent:opencoder",
    "subagent:task-manager",
    "context:core/*",
    "command:test",
    "tool:env",
    "skill:task-management",
    "config:env-example"
  ]
}
```

Component references use `type:id` syntax:
- `agent:openagent` — Agent components
- `subagent:contextscout` — Subagent components
- `command:test` — Command components
- `context:core/*` — Context files (wildcard supported)
- `tool:env` — Tool components
- `skill:task-management` — Skill components
- `config:env-example` — Configuration files

## Common Mistakes

1. **Only adding to components, forgetting profiles** — Most common error
2. **Wrong profile assignment** — e.g., dev agent in business profile only
3. **Inconsistent coverage** — e.g., in full but not advanced
4. **Missing dependency resolution** — Dependencies not installed

## Automated Validation

CI validates on every PR:
1. `validate-registry.ts` — Schema, paths, IDs, categories, dependencies
2. `validate-markdown-links.ts` — Context link validation
3. `validate-pr.sh` — Prompt library structure
4. Profile coverage should be validated separately (script in profile-validation.md)
