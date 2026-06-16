---
name: hugo-query
description: Skill que envuelve hugo-memex (queelius) para búsqueda semántica y consulta de contenido Hugo mediante FTS5 en SQLite. Permite a OCA buscar, analizar y sugerir tags sobre el contenido del sitio.
---

# Hugo Query

## Overview

Wraps [hugo-memex](https://github.com/queelius/hugo-memex) — an MCP server that indexes Hugo content in SQLite with FTS5 (Full-Text Search). Use this skill when the user wants to search, find, or query existing content.

## Location

Source code: `.opencode/mcp/hugo-memex-src/`
Virtual env: `.opencode/mcp/hugo-memex-src/venv/`

## How to Invoke

Start the MCP server in stdio:

```bash
cd .opencode/mcp/hugo-memex-src && venv/bin/python -m hugo_memex
```

## Available Capabilities

| Capability | Description |
|------------|-------------|
| Full-text search | Search all content using FTS5 queries |
| Semantic suggestions | Tag suggestions based on content index |
| Content validation | Cross-reference checking, completeness |
| SQL queries | Direct SQL access to the index |

## Usage

### Search content

When user says "busca artículos sobre Node.js":
1. Start hugo-memex MCP in stdio
2. Send a search query via MCP
3. Return results to the user

### Check for related content before creating

Before creating new content with hugo-mcp-adapter:
1. Query hugo-memex for existing content on the same topic
2. Inform the user of related pages to avoid duplication

### Suggest tags

When user asks "qué tags debería usar para esta página":
1. Send the page content to hugo-memex
2. Return FTS5-based tag suggestions

## Dependencies

- Python 3.12+
- Virtual env with package installed (`pip install -e .`)
