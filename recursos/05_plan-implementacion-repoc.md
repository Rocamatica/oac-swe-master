# Plan de implementación — REPOC

**Propósito**: Checklist maestro del trabajo necesario para equipar REPOC (repositorio clonable) con todas las capacidades OAC para gestionar Hugo mediante delegación a skills, MCPs y módulos.

**Fecha**: 2026-06-16

**Principio**: El usuario dice lo que quiere en lenguaje natural. OCA interpreta la intención y delega en el artefacto adecuado.

---

## Fase 1: Limpieza de obsoletos ✅

- [x] **1.1** — ContextScout para identificar archivos obsoletos → propuesta aprobada
- [x] **1.2** — Eliminar `en_des/desarrollando-oac-hugo/` (completo)
- [x] **1.3** — Eliminar `recursos/flujos/triada-usuario-oac-hugo.md`
- [x] **1.4** — Eliminar `recursos/prompts/01-P-iniciar-sitio-hugo.md`
- [x] **1.5** — Eliminar otros archivos identificados:
  - `recursos/flujos/interaccion-dinamica-inicializar-hugo.md`
  - `.opencode/external-context/astro/` (7 archivos)
  - `en_des/preparacion-inicial/legado/` (2 archivos)
  - `en_des/preparacion-inicial/notas/` (10 archivos)
  - `en_des/preparacion-inicial/analisis-hugo.md`
  - `en_des/preparacion-inicial/definiciones-pyt-swe-oac-cf.md`
  - `en_des/preparacion-inicial/reglas-oac-hugo.md` (reglas 1-5 extraídas a recapitulación)
  - `en_des/prompts-ej-otros-pyt/` (15 archivos)
  - `.opencode/skills/smart-router-skill/`

## Fase 2: Actualizar documentos

- [x] **2.1** — Actualizar `recursos/01_recapitulacion-entendimiento-openagent.md` (reglas 1-5 extraídas, G7-G12 añadidas, "preparar OAC primero" añadido a arquitectura)
- [x] **2.2** — Actualizar `recursos/02_seleccion-herramientas-hugo-oac.md` (eliminado GH CI/CD, sección 8 reescrita, referencias actualizadas)
- [x] **2.3** — Crear `recursos/flujos/01_capacidades-oca-hugo.md` (10 capacidades: C1-C10, mapeo intención→capacidad)
- [x] **2.4** — Revisar qué otros documentos requieren actualización (actualizada sección 8→capacidades, sección 9→nuevo modelo intención, tabla estado→flujo Hugo) 

## Fase 3: Instalación de herramientas

**Basado en**: `recursos/03_seleccion-herramientas-hugo-oac-validado.md`
**No instalados**: `recursos/04_seleccion-herramientas-hugo-oac-no-validado.md`

### Lote 1 — npm global

- [x] **3.1** — `hugo-extended` (npm -g) → v0.163.2+extended
- [x] **3.2** — `Pagefind` (npm -g) → v1.5.2
- [x] **3.3** — `agentic-seo` (npm -g) → v1.0.0
- [x] **3.4** — `seofor.dev` (npm -g → instalado como binario `seo`) → v3.0.1
- [x] **3.5** — `wrangler` (npm -g) → v4.101.0

### Lote 2 — Python / Go

- [x] **3.6** — `hugo-mcp` (clonado + venv + dependencias) → `.opencode/mcp/hugo-mcp-src/`
- [x] **3.7** — `hugo-memex` (clonado + venv + pip install) → `.opencode/mcp/hugo-memex-src/`
- [x] **3.8** — `hugo-docs-mcp` (clonado + Go build) → binario en `.opencode/mcp/hugo-docs-mcp`

### Lote 3 — Verificación

- [x] **3.9** — Verificar que todas las herramientas responden correctamente

| Herramienta | Estado | Versión |
|-------------|--------|---------|
| `hugo` | ✅ | v0.163.2+extended |
| `pagefind` | ✅ | v1.5.2 |
| `agentic-seo` | ✅ | v1.0.0 |
| `seo` (seofor.dev) | ✅ | v3.0.1 |
| `wrangler` | ✅ | v4.101.0 |
| `hugo-mcp` (venv) | ✅ | deps OK (FastAPI) |
| `hugo-memex` (venv) | ✅ | v0.1.0 |
| `hugo-docs-mcp` (binary) | ✅ | Go binary 8.4MB |

### Bootstrapping REPON

Lo instalado en Fase 3 NO viaja al clonar REPOC → REPON (npm global, venvs con rutas absolutas). El REPOC debe contener el **conocimiento** para reinstalar las herramientas en el clon.

- [x] **3.10** — Crear `.opencode/scripts/install-tools.sh` (script de bootstrap para REPON)

## Fase 4: Habilidades OAC (skills + subagentes + contextos)

**Basado en**: `recursos/03_seleccion-herramientas-hugo-oac-validado.md` y `recursos/flujos/01_capacidades-oca-hugo.md`

### Skills (`.opencode/skills/`)

- [x] **4.1** — Skill `hugo-mcp-adapter` — Subagente que invoca hugo-mcp (CRUD contenido)
- [x] **4.2** — Skill `hugo-query` — Envuelve hugo-memex (búsqueda semántica FTS5)
- [x] **4.3** — Skill `hugo-search-index` — Envuelve Pagefind (indexado post-build)
- [x] **4.4** — Skill `hugo-agentic-audit` — Envuelve agentic-seo (visibilidad IA)
- [x] **4.5** — Skill `hugo-seo-audit` — Envuelve seofor.dev (SEO técnico)
- [x] **4.6** — Skill `hugo-audit-quality` — Envuelve hugo-docs-mcp (calidad contenido)
- [x] **4.7** — Skill `hugo-cms-setup` — Configura Decap CMS

### Comandos (`.opencode/command/`)

- [x] **4.8** — Comando `/hugo-deploy` — Build + deploy a Cloudflare Pages via Wrangler

### Context files (`.opencode/external-context/hugo/`)

- [x] **4.9** — Contexto `hugo-install.md` — Versión, instalación y verificación de Hugo
- [x] **4.10** — Contextos HugoMods:
  - `hugomods-seo.md`
  - `hugomods-images.md`
  - `hugomods-pwa.md`
  - `hugomods-icons.md`
  - `hugomods-analytics.md`
  - `hugomods-bootstrap.md`

## Fase 5: Validación

- [ ] **5.1** — Verificar que REPOC se puede clonar y OCA tiene todas las capacidades
- [ ] **5.2** — Probar flujo completo: "crea proyecto" → "configura" → "crea contenido" → "build" → "deploy"
- [ ] **5.3** — Documentar estado final

## Fase 6: Guías de usuario

Documentación para el usuario final del REPOC. Instrucciones paso a paso sobre qué hacer después de clonar, cómo usar cada capacidad, ejemplos prácticos.

| # | Guía | Archivo | Propósito |
|---|------|---------|-----------|
| 6.1 | Inicio rápido | `recursos/guias/01_inicio-rapido.md` | Clonar, instalar herramientas, primer proyecto |
| 6.2 | Crear y configurar proyecto | `recursos/guias/02_crear-proyecto.md` | Usar OCA para `hugo new site`, configurar `hugo.toml`, temas |
| 6.3 | Gestión de contenido | `recursos/guias/04_gestion-contenido.md` | Páginas, artículos, assets con hugo-mcp |
| 6.4 | SEO, búsqueda y calidad | `recursos/guias/06_calidad-seo-busqueda.md` | Pagefind, agentic-seo, seofor.dev, hugo-docs-mcp |
| 6.5 | Skills y comandos OCA | `recursos/guias/05_skills-comandos.md` | Catálogo de skills, `/hugo-deploy`, subagentes |
| 6.6 | Módulos HugoMods | `recursos/guias/03_modulos-hugomods.md` | SEO, Images, PWA, Icons, Analytics, Bootstrap |
| 6.7 | CMS y Decap | `recursos/guias/07_cms-decap.md` | Configurar CMS visual, OAuth, edición vía web |

- [x] **6.1** — `01_inicio-rapido.md` (229 líneas)
- [x] **6.2** — `02_crear-proyecto.md` (243 líneas)
- [x] **6.3** — `04_gestion-contenido.md` (320 líneas)
- [x] **6.4** — `06_calidad-seo-busqueda.md` (324 líneas)
- [x] **6.5** — `05_skills-comandos.md` (254 líneas)
- [x] **6.6** — `03_modulos-hugomods.md` (277 líneas)
- [x] **6.7** — `07_cms-decap.md` (293 líneas)

## Fase 7: Auto-conocimiento del REPOC (`.opencode/external-context/oac/`)

Documentar la propia estructura `.opencode/` del REPOC para que OCA conozca
sus propios recursos: qué agentes, comandos, skills, MCPs, herramientas,
plugins y scripts tiene disponibles. Esto es el "auto-conocimiento" del
repositorio.

**Motivación**: Los 7 archivos actuales en `.opencode/external-context/oac/`
son documentación genérica del framework OAC. Falta documentar la
**configuración concreta** de este REPOC.

| # | Archivo | Ruta | Finalidad |
|---|---------|------|-----------|
| 7.1 | `estructura-completa-opencode.md` | `.opencode/external-context/oac/01_estructura-completa-opencode.md` | Mapa completo del árbol `.opencode/` con propósito de cada directorio y archivo |
| 7.2 | `agents-catalogo.md` | `.opencode/external-context/oac/02_agents-catalogo.md` | Catálogo de los 3 agentes primarios + 16 subagentes |
| 7.3 | `comandos-personalizados.md` | `.opencode/external-context/oac/03_comandos-personalizados.md` | Catálogo de los 18 comandos slash personalizados |
| 7.4 | `skills-instalados.md` | `.opencode/external-context/oac/04_skills-instalados.md` | Los 8 skills instalados y sus capacidades |
| 7.5 | `mcp-servers-configurados.md` | `.opencode/external-context/oac/05_mcp-servers-configurados.md` | Los 3 MCP servers integrados (hugo-mcp, hugo-memex, hugo-docs-mcp) |
| 7.6 | `plugins-y-herramientas.md` | `.opencode/external-context/oac/06_plugins-y-herramientas.md` | Plugin notify.ts + herramientas env/gemini |
| 7.7 | `scripts-de-arranque.md` | `.opencode/external-context/oac/07_scripts-de-arranque.md` | Script install-tools.sh y rutas de bootstrap |

- [x] **7.1** — `01_estructura-completa-opencode.md` (256 líneas)
- [x] **7.2** — `02_agents-catalogo.md` (143 líneas)
- [x] **7.3** — `03_comandos-personalizados.md` (95 líneas)
- [x] **7.4** — `04_skills-instalados.md` (112 líneas)
- [x] **7.5** — `05_mcp-servers-configurados.md` (137 líneas)
- [x] **7.6** — `06_plugins-y-herramientas.md` (133 líneas)
- [x] **7.7** — `07_scripts-de-arranque.md` (132 líneas)

---

## Notas

- Skills en inglés, formato `.md` estándar de OAC
- MCP servers en entorno virtual Python (no global)
- No se usa CI/CD de GitHub. Solo Wrangler + Cloudflare Pages
- El usuario no sigue pasos fijos. OCA interpreta cada petición y usa el artefacto adecuado
