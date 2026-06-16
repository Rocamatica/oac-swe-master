---
source: REPOC (oac-swe-master)
library: REPOC
package: oac-repoc
topic: mcp-servers-configurados
fetched: 2026-06-16
version: v0.7.1
official_docs: ""
---

# MCP servers configurados

**Propósito**: Documentación de los 3 servidores MCP (Model Context Protocol)
instalados en el REPOC. Cada MCP extiende a OCA con capacidades específicas
para operar sobre sitios Hugo.

**Fecha**: 2026-06-16

---

## Índice

- [hugo-mcp (jmrGrav) — CRUD de contenido](#hugo-mcp-jmrgrav--crud-de-contenido)
- [hugo-memex (queelius) — Búsqueda semántica](#hugo-memex-queelius--búsqueda-semántica)
- [hugo-docs-mcp (danfinn5) — Auditoría de calidad](#hugo-docs-mcp-danfinn5--auditoría-de-calidad)
- [Tabla comparativa](#tabla-comparativa)
- [Ver también](#ver-también)

---

## hugo-mcp (jmrGrav) — CRUD de contenido

| Campo | Valor |
|-------|-------|
| **Autor** | jmrGrav |
| **Lenguaje** | Python |
| **Source** | `.opencode/mcp/hugo-mcp-src/` |
| **Venv** | `.opencode/mcp/hugo-mcp-src/venv/` |
| **Instalación** | `python -m venv venv && venv/bin/pip install -r requirements.txt` |
| **Skill que lo usa** | `hugo-mcp-adapter` |
| **Capacidad OCA** | C2 (gestionar contenido) |
| **Estado** | ✅ Instalado y verificado |
| **Plugins incluidos** | Cloudflare purge, Google Indexing, IndexNow, SRI check |

### Tools MCP disponibles

| Tool | Descripción |
|------|-------------|
| `list_pages` | Lista todas las páginas del sitio |
| `get_page` | Obtiene el contenido de una página específica |
| `create_page` | Crea una nueva página con título, sección y contenido |
| `update_page` | Actualiza el frontmatter o contenido de una página |
| `delete_page` | Elimina una página existente |
| `build_site` | Reconstruye el sitio Hugo |
| `upload_asset` | Sube una imagen/asset al directorio `static/` |
| `list_assets` | Lista los assets en `static/` |
| `generate_featured_image` | Genera imagen destacada para una página |
| `check_sri_versions` | Verifica integridad SRI de recursos externos |

---

## hugo-memex (queelius) — Búsqueda semántica

| Campo | Valor |
|-------|-------|
| **Autor** | queelius |
| **Lenguaje** | Python |
| **Source** | `.opencode/mcp/hugo-memex-src/` |
| **Venv** | `.opencode/mcp/hugo-memex-src/venv/` |
| **Instalación** | `pip install -e .` (editable) |
| **Skill que lo usa** | `hugo-query` |
| **Capacidad OCA** | C3 (buscar/consultar contenido) |
| **Estado** | ✅ Instalado y verificado |

### Capacidades

- Búsqueda full-text sobre el índice SQLite FTS5
- Sugerencia de tags basada en el contenido indexado
- Validación de contenido (completitud, referencias cruzadas)
- Listado de páginas por sección, tag o fecha
- Consultas SQL directas sobre el índice

### Dependencias

- Python 3.12+
- Tipos de contenido soportados: markdown, frontmatter YAML/TOML
- Indexa automáticamente el contenido de `content/`

---

## hugo-docs-mcp (danfinn5) — Auditoría de calidad

| Campo | Valor |
|-------|-------|
| **Autor** | danfinn5 |
| **Lenguaje** | Go |
| **Source** | `.opencode/mcp/hugo-docs-mcp-src/` |
| **Binario** | `.opencode/mcp/hugo-docs-mcp` (8.4 MB) |
| **Instalación** | `go build -o ../hugo-docs-mcp .` |
| **Skill que lo usa** | `hugo-audit-quality` |
| **Capacidad OCA** | C10 (auditar calidad) |
| **Estado** | ✅ Instalado y verificado |

### Auditorías disponibles

| Auditoría | Descripción |
|-----------|-------------|
| **Frontmatter** | Valida campos obligatorios en todas las páginas (title, date, description) |
| **Links** | Detecta enlaces internos y externos rotos (HTTP 404) |
| **Duplicates** | Detecta contenido duplicado o casi duplicado |
| **Freshness** | Identifica páginas no actualizadas en más de N días |
| **Scaffolding** | Genera esqueleto para secciones faltantes |
| **SEO** | Análisis de meta tags, headings, alt text |
| **Sections** | Lista secciones del sitio |
| **Taxonomies** | Analiza taxonomías (tags, categorías) |
| **Translations** | Verifica consistencia entre traducciones |

---

## Tabla comparativa

| Aspecto | hugo-mcp | hugo-memex | hugo-docs-mcp |
|---------|----------|------------|---------------|
| Lenguaje | Python | Python | Go |
| Modo de comunicación | MCP stdio | MCP stdio | MCP stdio |
| Skill asociado | hugo-mcp-adapter | hugo-query | hugo-audit-quality |
| Operación principal | CRUD de contenido | Búsqueda semántica | Auditoría de calidad |
| Capacidad OCA | C2 | C3 | C10 |
| Tamaño | ~500 KB (sin venv) | ~200 KB (sin venv) | 8.4 MB (binario) |
| Instalación | `requirements.txt` | `pip install -e .` | `go build` |
| Único en su tipo | Sí (único CRUD MCP) | Sí (único FTS5 MCP) | Sí (único calidad MCP) |

---

## Ver también

- [Skills instalados](04_skills-instalados.md)
- [Estructura completa de `.opencode/`](01_estructura-completa-opencode.md)
- [Guía de gestión de contenido](../recursos/guias/04_gestion-contenido.md)
- [Guía de calidad, SEO y búsqueda](../recursos/guias/06_calidad-seo-busqueda.md)
