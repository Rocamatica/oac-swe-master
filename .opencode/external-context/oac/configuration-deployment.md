---
source: GitHub Repository (darrenhinde/OpenAgentsControl)
library: OpenAgentsControl (OAC)
package: @nextsystems/oac
topic: configuration-deployment
fetched: 2026-06-16T10:00:00Z
official_docs: https://github.com/darrenhinde/OpenAgentsControl
version: v0.7.1
---

# Configuration, Deployment & Team Workflows

## Installation Options

### One-Command Install
```bash
curl -fsSL https://raw.githubusercontent.com/darrenhinde/OpenAgentsControl/main/install.sh | bash -s developer
```
Installs OpenCode CLI if needed, then OAC with the Developer profile.

### Update
```bash
curl -fsSL https://raw.githubusercontent.com/darrenhinde/OpenAgentsControl/main/update.sh | bash
```

### Profile Selection
Choose a profile during installation:
```bash
bash install.sh essential    # Minimal
bash install.sh developer   # Full dev (recommended)
bash install.sh business    # Content focus
bash install.sh full        # Everything
bash install.sh advanced    # Full + meta-level
```

## Installation Types

### Local Install (Recommended)
- `.opencode/` in project root
- Context files committed to git
- Team members inherit patterns automatically
- Project intelligence is ALWAYS local

### Global Install
- `~/.config/opencode/`
- Personal defaults across all projects
- Local overrides global when both exist

## Collision Handling

When installing over existing files:
```bash
# Options
--skip-existing    # Keep existing files
--force           # Overwrite all
--backup          # Backup then install
```

Interactive: `[S]kip, [O]verwrite, [B]ackup, [A]ll skip, [F]orce all?`

## Environment Configuration

### `.opencode/config.json`
```json
{"agent": "eval-runner"}
```
Sets the default agent. Used for eval framework testing.

### `.opencode/opencode.json`
```json
{"$schema": "https://opencode.ai/config.json"}
```
OpenCode config schema reference.

### `env.example`
Template for environment variables (git-committed, no secrets).

## Team Workflows

### Sharing Context
```bash
# Lead adds team patterns
/add-context

# Commit to repo
git add .opencode/context/
git commit -m "Add team coding standards"
git push

# All team members now use same patterns
# New developers inherit standards on day 1
```

### Local-First Context Resolution
1. Check `.opencode/context/core/navigation.md` (local project)
2. If not found → Check `~/.config/opencode/context/core/navigation.md` (global)
3. Core files can come from global, but project intelligence is ALWAYS local

### CI/CD Pipeline

```yaml
# PR Validation (runs on every PR to main/dev)
.github/workflows/validate-registry.yml
  - Install dependencies (jq, bun)
  - auto-detect-components.sh --dry-run
  - validate-registry.ts (TypeScript)
  - validate-markdown-links.ts
  - validate-pr.sh (prompt library)
  - Auto-commit registry updates (internal PRs only)
  - Post validation summary to PR
```

### Version Management

Versions must be consistent across:
- `VERSION` — Plain text file
- `package.json` — `"version": "x.y.z"`
- `registry.json` — `"version": "x.y.z"`

Bump commands:
```bash
npm run version:bump:patch
npm run version:bump:minor
npm run version:bump:major
```

### Testing & Eval Framework

```bash
npm run test:openagent           # Test OpenAgent
npm run test:opencoder           # Test OpenCoder
npm run test:openagent:claude    # Test with specific model
npm run test:ci                  # CI smoke tests
npm run dashboard                # View eval results
```

Eval framework at `evals/framework/` with results in `evals/results/`.

### Plugin Distribution

npm package: `@nextsystems/oac`
Published files (via `files` in `package.json`):
- `.opencode/agent/`, `.opencode/command/`, `.opencode/context/`
- `.opencode/plugin/`, `.opencode/profiles/`, `.opencode/prompts/`
- `.opencode/scripts/`, `.opencode/skills/`, `.opencode/tool/`
- `.opencode/config.json`, `.opencode/opencode.json`
- `registry.json`, `install.sh`, `scripts/`, `bin/`

## Key Configuration Files

| File | Purpose |
|------|---------|
| `registry.json` | Central component catalog (v2.0.0 schema) |
| `.opencode/config.json` | Default agent config |
| `.opencode/opencode.json` | OpenCode schema ref |
| `.opencode/profiles/*/profile.json` | Installation profiles |
| `package.json` | npm package (`@nextsystems/oac`) |
| `install.sh` | Install script |
| `update.sh` | Update script |

## Development Commands

```bash
npm run dev:setup          # Install eval framework deps
npm run dev:build          # Build eval framework
npm run validate:registry  # Validate registry
npm run validate:context-links  # Validate markdown links
```
