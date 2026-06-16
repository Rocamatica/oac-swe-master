---
name: hugo-audit-quality
description: Skill que envuelve hugo-docs-mcp (danfinn5) para auditoría de calidad del contenido Hugo. Validación de frontmatter, verificación de enlaces, detección de duplicados y contenido obsoleto.
---

# Hugo Audit Quality

## Overview

Wraps [hugo-docs-mcp](https://github.com/danfinn5/hugo-docs-mcp) — an MCP server for documentation quality auditing. Use this skill when the user wants to check content health, find broken links, or audit content freshness.

## Location

Binary: `.opencode/mcp/hugo-docs-mcp`
Source: `.opencode/mcp/hugo-docs-mcp-src/`

## How to Invoke

The binary is a Go MCP server. Run it in stdio mode:

```bash
.opencode/mcp/hugo-docs-mcp
```

## Available Audits

| Audit | Description |
|-------|-------------|
| Frontmatter validation | Check all pages have required frontmatter fields |
| Link checking | Detect broken internal and external links |
| Duplicate detection | Find duplicate or near-duplicate content |
| Content freshness | Flag pages not updated in >N days |
| Scaffolding | Generate skeleton for missing sections |

## Usage

### Full content audit

When user says "audita la calidad del contenido":
1. Start hugo-docs-mcp in stdio
2. Run frontmatter validation
3. Run link checking
4. Run duplicate detection
5. Present results to the user with actionable fixes

### Periodic health check

Recommended: run `hugo-audit-quality` monthly to maintain site health.

## Dependencies

- Go 1.21+ (to rebuild if needed)
- Binary at `.opencode/mcp/hugo-docs-mcp`
- Must run from the Hugo project root directory
