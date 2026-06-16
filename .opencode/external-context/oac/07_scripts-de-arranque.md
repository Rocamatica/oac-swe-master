---
source: REPOC (oac-swe-master)
topic: scripts-de-arranque
fetched: 2026-06-16
version: v0.7.1
---

# Scripts de arranque

**Propósito**: Documentación del script de bootstrap `install-tools.sh` que
reinstala todas las herramientas del REPOC en un REPON recién clonado. Las
herramientas npm globales y entornos virtuales Python no viajan en el clon
de git, pero el script las reinstala automáticamente.

**Fecha**: 2026-06-16

---

## Índice

- [Script principal: install-tools.sh](#script-principal-install-toolssh)
- [Qué instala](#qué-instala)
- [Ubicaciones de instalación](#ubicaciones-de-instalación)
- [Verificación post-instalación](#verificación-post-instalación)
- [Solución de problemas](#solución-de-problemas)
- [Ver también](#ver-también)

---

## Script principal: install-tools.sh

| Campo | Valor |
|-------|-------|
| **Ruta** | `.opencode/scripts/install-tools.sh` |
| **Lenguaje** | Bash |
| **Uso** | `bash .opencode/scripts/install-tools.sh` |
| **Log** | `.opencode/scripts/install-tools.log` |

### Descripción

Script de bootstrap que reinstala todas las herramientas del ecosistema Hugo
en un REPON recién clonado. Ejecuta instalaciones npm globales, crea
entornos virtuales Python para MCPs, compila binarios Go y verifica cada
instalación.

### Flujo de ejecución

1. **Determinar directorio raíz** del proyecto (usando `dirname $0`)
2. **Instalar herramientas npm globales**: `hugo-extended`, `pagefind`,
   `agentic-seo`, `wrangler`
3. **Instalar binario Go**: `seofor.dev` → `/usr/local/bin/seo`
4. **Crear venv Python** para `hugo-mcp` en
   `.opencode/mcp/hugo-mcp-src/venv/` e instalar dependencias
5. **Crear venv Python** para `hugo-memex` en
   `.opencode/mcp/hugo-memex-src/venv/` e instalar en modo editable
6. **Compilar binario Go** `hugo-docs-mcp` en `.opencode/mcp/`
7. **Verificar** cada herramienta con su comando de versión
8. **Escribir log** con resultado de cada paso

### Flags de configuración

| Variable | Efecto |
|----------|--------|
| `HUGO_VERSION` | Versión específica de Hugo a instalar (default: latest) |
| `SKIP_NPM` | Skip npm global installs |
| `SKIP_MCP_PYTHON` | Skip Python venv creation |
| `SKIP_MCP_GO` | Skip Go build |
| `VERBOSE` | Log detallado de cada paso |

---

## Qué instala

| Categoría | Herramienta | Método | Versión actual |
|-----------|-------------|--------|----------------|
| SSG | hugo-extended | npm global | v0.163.2+extended |
| Búsqueda | Pagefind | npm global | v1.5.2 |
| Auditoría AEO | agentic-seo | npm global | v1.0.0 |
| Auditoría SEO | seofor.dev | Go binary | v3.0.1 |
| Despliegue | Wrangler (Cloudflare) | npm global | v4.101.0 |
| MCP contenido | hugo-mcp | Python venv | v2.1.0 |
| MCP búsqueda | hugo-memex | Python venv | (source) |
| MCP auditoría | hugo-docs-mcp | Go build | (source) |

---

## Ubicaciones de instalación

| Herramienta | Ubicación post-instalación |
|-------------|---------------------------|
| hugo-extended | `$(npm root -g)/hugo-extended/` |
| Pagefind | `$(npm root -g)/pagefind/` |
| agentic-seo | `$(npm root -g)/agentic-seo/` |
| seofor.dev | `/usr/local/bin/seo` |
| Wrangler | `$(npm root -g)/wrangler/` |
| hugo-mcp venv | `.opencode/mcp/hugo-mcp-src/venv/` |
| hugo-memex venv | `.opencode/mcp/hugo-memex-src/venv/` |
| hugo-docs-mcp binary | `.opencode/mcp/hugo-docs-mcp` |

---

## Verificación post-instalación

| Herramienta | Comando | Salida esperada |
|-------------|---------|-----------------|
| Hugo | `hugo version` | `hugo v0.163.2+extended ...` |
| Pagefind | `pagefind --version` | `pagefind 1.5.2` |
| agentic-seo | `agentic-seo --version` | `1.0.0` |
| seofor.dev | `seo --version` | `3.0.1` |
| wrangler | `wrangler --version` | `4.101.0` |
| hugo-mcp | `ls .opencode/mcp/hugo-mcp-src/venv/bin/python` | File exists |
| hugo-memex | `ls .opencode/mcp/hugo-memex-src/venv/bin/python` | File exists |
| hugo-docs-mcp | `ls .opencode/mcp/hugo-docs-mcp` | File exists |

---

## Solución de problemas

| Síntoma | Causa | Solución |
|---------|-------|----------|
| `command not found: hugo` | npm global no en PATH | `npm config set prefix ~/.npm-global && echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc` |
| MCP venv no encontrado | Directorio source del MCP no existe | `git clone <url-mcp> .opencode/mcp/<mcp-src>/` |
| `seo: command not found` | Go binary no en PATH | Verificar `/usr/local/bin` en PATH |
| `wrangler: not logged in` | Wrangler no autenticado | `wrangler login` (o `wrangler login --browser=false`) |

---

## Ver también

- [Guía de inicio rápido](../recursos/guias/01_inicio-rapido.md) — Pasos tras clonar REPOC
- [MCP servers configurados](05_mcp-servers-configurados.md) — Detalle de cada MCP
- [Estructura completa de `.opencode/`](01_estructura-completa-opencode.md)
