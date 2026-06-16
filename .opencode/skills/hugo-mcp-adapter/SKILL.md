---
name: hugo-mcp-adapter
description: Subagente que invoca hugo-mcp (jmrGrav) para gestionar contenido Hugo (CRUD páginas, assets, build). MCP server con 10 herramientas para operaciones de contenido.
---

# Hugo MCP Adapter

## Overview

Wraps [hugo-mcp](https://github.com/jmrGrav/hugo-mcp) — an MCP server with 10 tools for Hugo static site management. Use this skill when the user wants to create, read, update, or delete pages/assets, or trigger a build.

## Location

Source code: `.opencode/mcp/hugo-mcp-src/`
Virtual env: `.opencode/mcp/hugo-mcp-src/venv/`

## How to Invoke

Start the MCP server in stdio mode (for direct MCP integration):

```bash
cd .opencode/mcp/hugo-mcp-src && venv/bin/python main.py
```

For HTTP mode (local dev server):
```bash
cd .opencode/mcp/hugo-mcp-src && venv/bin/uvicorn main:app --port 8000
```

## Available Tools

| Tool | Description |
|------|-------------|
| `list_pages` | List all Hugo pages (filter by lang/section) |
| `get_page` | Read frontmatter + Markdown content of a page |
| `create_page` | Create page + rebuild + Cloudflare purge |
| `update_page` | Update page + rebuild + Cloudflare purge |
| `delete_page` | Delete page + rebuild + full CF purge |
| `build_site` | Rebuild Hugo + full CF purge |
| `upload_asset` | Upload an image to `static/` |
| `list_assets` | List static assets and page bundles |
| `generate_featured_image` | Generate Tokyo Night featured image |
| `check_sri_versions` | Audit SRI hashes + npm versions of CDN libs |

## Usage

### Create a new page

When user says "crea una página de contacto":
1. Ask the user for: title, section/route, optional content
2. Invoke the MCP: `create_page(route="/contact", title="Contacto", content="...")`
3. Confirm the page was created successfully

### List existing pages

When user says "qué páginas tengo":
1. Invoke: `list_pages()`
2. Present the list to the user in a readable format

### Update a page

When user says "cambia el título de X":
1. Invoke: `update_page(route="/ruta", title="Nuevo título", frontmatter={"title": "Nuevo título"})`
2. Confirm changes

## Dependencies

- Python 3.12+
- Virtual env with dependencies installed (`pip install -r requirements.txt`)
- Requires `.env` file with `MCP_TOKEN`, `CF_TOKEN`, `CF_ZONE_ID` for Cloudflare purge
