---
source: REPOC (oac-swe-master)
library: REPOC
package: oac-repoc
topic: skills-instalados
fetched: 2026-06-16
version: v0.7.1
official_docs: ""
---

# Skills instalados

**Propósito**: Catálogo de todos los skills (comportamientos reutilizables)
disponibles en `.opencode/skills/`. Cada skill contiene un `SKILL.md` que OCA
carga para saber cómo usar una herramienta específica.

**Fecha**: 2026-06-16

---

## Índice

- [Skills Hugo](#skills-hugo)
- [Skills del framework OAC](#skills-del-framework-oac)
- [Ver también](#ver-también)

---

## Skills Hugo

| Skill | Ruta del SKILL.md | Herramienta | Capacidad OCA |
|-------|-------------------|-------------|---------------|
| **hugo-mcp-adapter** | `skills/hugo-mcp-adapter/SKILL.md` | hugo-mcp (MCP Python) | C2 — CRUD de páginas y assets |
| **hugo-query** | `skills/hugo-query/SKILL.md` | hugo-memex (MCP Python) | C3 — Búsqueda semántica FTS5 |
| **hugo-search-index** | `skills/hugo-search-index/SKILL.md` | Pagefind (npm CLI) | C4 — Indexar búsqueda post-build |
| **hugo-agentic-audit** | `skills/hugo-agentic-audit/SKILL.md` | agentic-seo (npm CLI) | C5 — Auditoría visibilidad IA |
| **hugo-seo-audit** | `skills/hugo-seo-audit/SKILL.md` | seofor.dev (binary CLI) | C5 — Auditoría SEO técnica |
| **hugo-audit-quality** | `skills/hugo-audit-quality/SKILL.md` | hugo-docs-mcp (MCP Go) | C10 — Auditoría calidad contenido |
| **hugo-cms-setup** | `skills/hugo-cms-setup/SKILL.md` | Decap CMS (HugoMods) | C7 — Configurar CMS visual |

### Detalle por skill

**hugo-mcp-adapter**
- Invoca `hugo-mcp` (MCP server de jmrGrav, Python)
- Tools MCP: `list_pages`, `get_page`, `create_page`, `update_page`, `delete_page`, `build_site`, `upload_asset`, `list_assets`, `generate_featured_image`, `check_sri_versions`
- Dependencia: Python 3.12+ con venv en `.opencode/mcp/hugo-mcp-src/venv/`
- Ubicación del source: `.opencode/mcp/hugo-mcp-src/`
- Capacidades adicionales: purga Cloudflare, SRI checking, plugins

**hugo-query**
- Invoca `hugo-memex` (MCP server de queelius, Python)
- Capacidades: búsqueda full-text, sugerencia de tags, validación de contenido, consultas SQL sobre índice FTS5
- Dependencia: Python 3.12+ con venv en `.opencode/mcp/hugo-memex-src/venv/`
- Instalación editable: `pip install -e .`

**hugo-search-index**
- Ejecuta `npx pagefind --source public` post-build
- Dependencia: `npm install -g pagefind`

**hugo-agentic-audit**
- Ejecuta `agentic-seo <url>`
- Audita: robots.txt, llms.txt, AGENTS.md, crawlers ChatGPT/Claude/Gemini/Perplexity
- Dependencia: `npm install -g agentic-seo`

**hugo-seo-audit**
- Ejecuta `seo audit run --port <port>` sobre servidor dev Hugo
- Audita: meta tags, rendimiento, HTML semántico, enlaces rotos, IndexNow
- Dependencia: binario Go `/usr/local/bin/seo`

**hugo-audit-quality**
- Invoca `hugo-docs-mcp` (MCP server Go, danfinn5) en modo stdio
- Auditorías: frontmatter, enlaces rotos, duplicados, antigüedad, scaffolding
- Dependencia: binario Go en `.opencode/mcp/hugo-docs-mcp`
- Source: `.opencode/mcp/hugo-docs-mcp-src/`

**hugo-cms-setup**
- Genera `static/admin/config.yml` para Decap CMS
- Configura colecciones, campos y backend GitHub
- Dependencia: módulo HugoMods Decap CMS en `hugo.toml`

---

## Skills del framework OAC

| Skill | Ruta del SKILL.md | Herramienta | Función |
|-------|-------------------|-------------|---------|
| **context-manager** | `skills/context-manager/SKILL.md` | `router.sh` + scripts | Gestión del ciclo de vida del contexto: descubrir, catalogar, validar. Incluye `/context` command. |
| **context7** | `skills/context7/SKILL.md` | Context7 API + `library-registry.md` + `navigation.md` | Fetch de documentación viva de librerías externas. Usa Context7 API para obtener docs actualizadas. |
| **task-management** | `skills/task-management/SKILL.md` | `router.sh` + `scripts/task-cli.ts` | CLI de tareas para desglose y seguimiento de subtasks de features. Comandos: `task init`, `task add`, `task status`, `task list`, `task complete`, `task next`, `task parallel`. |

---

## Resumen de herramientas por skill

| Skill | Tipo de herramienta | Dónde se instala |
|-------|---------------------|-------------------|
| hugo-mcp-adapter | MCP (Python) | `.opencode/mcp/hugo-mcp-src/venv/` |
| hugo-query | MCP (Python) | `.opencode/mcp/hugo-memex-src/venv/` |
| hugo-search-index | CLI (npm global) | `$(npm root -g)/pagefind` |
| hugo-agentic-audit | CLI (npm global) | `$(npm root -g)/agentic-seo` |
| hugo-seo-audit | CLI (binary Go) | `/usr/local/bin/seo` |
| hugo-audit-quality | MCP (Go stdio) | `.opencode/mcp/hugo-docs-mcp` |
| hugo-cms-setup | HugoMods | `hugo.toml` del proyecto |
| context-manager | Scripts bash | `.opencode/skills/context-manager/` |
| context7 | API + contextos | `.opencode/skills/context7/` |
| task-management | CLI TypeScript | `.opencode/skills/task-management/` |

---

## Ver también

- [MCP servers configurados](05_mcp-servers-configurados.md)
- [Estructura completa de `.opencode/`](01_estructura-completa-opencode.md)
- [Agentes — catálogo completo](02_agents-catalogo.md)
- [Guía de skills y comandos](../recursos/guias/05_skills-comandos.md)
