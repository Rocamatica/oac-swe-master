---
source: GitHub Repository (darrenhinde/OpenAgentsControl)
library: OpenAgentsControl (OAC)
package: @nextsystems/oac
topic: registry-and-profiles
fetched: 2026-06-16T10:00:00Z
official_docs: https://github.com/darrenhinde/OpenAgentsControl/blob/main/registry.json
version: v0.7.1 (registry v2.0.0)
---

# Registry & Profile System

## registry.json — Central Component Catalog

**Location**: `/registry.json` (repo root)

**Purpose**: Tracks ALL components — agents, subagents, commands, tools, contexts, skills, plugins

### Top-Level Schema

```json
{
  "version": "2.0.0",
  "schema_version": "2.0.0",
  "repository": "https://github.com/darrenhinde/OpenAgentsControl",
  "categories": {
    "essential": "Minimal components for basic functionality",
    "standard": "Standard components for typical use",
    "extended": "Extended components for advanced features",
    "specialized": "Specialized components for specific domains",
    "meta": "Meta-level components for system generation"
  },
  "components": {
    "agents": [...],
    "subagents": [...],
    "commands": [...],
    "tools": [...],
    "plugins": [...],
    "skills": [...],
    "contexts": [...]
  },
  "profiles": {
    "essential": {...},
    "developer": {...},
    "business": {...},
    "full": {...},
    "advanced": {...}
  }
}
```

### Component Entry Schema

```json
{
  "id": "unique-kebab-id",
  "name": "Display Name",
  "type": "agent|subagent|command|tool|plugin|skill|context",
  "path": ".opencode/relative/path.md",
  "description": "Brief description",
  "category": "essential|standard|extended|specialized|meta",
  "tags": ["tag1", "tag2"],
  "dependencies": ["subagent:x", "context:y", "skill:z"],
  "version": "1.0.0"
}
```

### Component Types Registered

| Type | Count (approx.) | Description |
|------|-----------------|-------------|
| Agents | ~9 | Primary + specialized agents |
| Subagents | ~20 | Delegated specialists |
| Commands | ~18 | Slash commands |
| Tools | 2 | Env, Gemini |
| Plugins | 1 | Notify |
| Skills | 4 | task-management, smart-router, context7, context-manager |
| Contexts | ~50+ | Standards, workflows, guides |

## Profile System

Profiles are pre-configured component bundles installed via `install.sh {profile}`.

### Profile Hierarchy

| Profile | Description | Best For | Agents Included |
|---------|-------------|----------|-----------------|
| **essential** | Minimal setup | Learning, lightweight tasks | openagent only |
| **developer** | Full dev environment **★ RECOMMENDED** | Software development | openagent, opencoder |
| **business** | Content/product focus | Content creation, business | openagent, copywriter, technical-writer, data-analyst |
| **full** | Everything except meta | Maximum functionality | All except meta agents |
| **advanced** | Full + meta-level | Power users, contributors | Everything including system-builder |

### Profile Inclusion Rules

| Agent Category | essential | developer | business | full | advanced |
|---------------|-----------|-----------|----------|------|----------|
| core | ✅ | ✅ | ✅ | ✅ | ✅ |
| development | ❌ | ✅ | ❌ | ✅ | ✅ |
| content/data | ❌ | ❌ | ✅ | ✅ | ✅ |
| meta | ❌ | ❌ | ❌ | ❌ | ✅ |

### Developer Profile Contents (Recommended)

**Agents**: openagent, opencoder
**Subagents**: task-manager, frontend-specialist, devops-specialist, documentation, coder-agent, reviewer, tester, build-agent, contextscout, image-specialist
**Skills**: task-management, context-manager
**Commands**: commit, test, context, clean, optimize, validate-repo, analyze-patterns
**Tools**: env, gemini
**Context**: root-navigation, context-paths-config, essential-patterns, core/*, project-intelligence/*, + UI animation contexts

### Profile Validation (MANDATORY when adding components)

**Checklist**:
1. Agent added to `components.agents[]` in registry
2. Agent added to appropriate profiles (see inclusion rules above)
3. Profile component lists are consistent across essential/developer/business/full/advanced
4. Dependencies resolved correctly
5. Paths validated (files exist)

**Validation tools**:
```bash
./scripts/registry/validate-registry.sh       # Check schema, paths, IDs, categories
./scripts/registry/validate-registry.ts       # TypeScript validator (used in CI)
./scripts/registry/auto-detect-components.sh  # Auto-scan + update
```

**CI Integration**: GitHub Actions workflow validates registry on every PR to main/dev branch.
