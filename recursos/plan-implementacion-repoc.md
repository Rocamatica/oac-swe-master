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

- [x] **2.1** — Actualizar `recursos/recapitulacion-entendimiento-openagent.md` (reglas 1-5 extraídas, G7-G12 añadidas, "preparar OAC primero" añadido a arquitectura)
- [x] **2.2** — Actualizar `recursos/seleccion-herramientas-hugo-oac.md` (eliminado GH CI/CD, sección 8 reescrita, referencias actualizadas)
- [x] **2.3** — Crear `recursos/flujos/capacidades-oca-hugo.md` (10 capacidades: C1-C10, mapeo intención→capacidad)
- [x] **2.4** — Revisar qué otros documentos requieren actualización (actualizada sección 8→capacidades, sección 9→nuevo modelo intención, tabla estado→flujo Hugo) 

## Fase 3: Instalación de herramientas

**Basado en**: `recursos/seleccion-herramientas-hugo-oac-validado.md`
**No instalados**: `recursos/seleccion-herramientas-hugo-oac-no-validado.md`

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

**Basado en**: `recursos/seleccion-herramientas-hugo-oac-validado.md` y `recursos/flujos/capacidades-oca-hugo.md`

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

---

## Notas

- Skills en inglés, formato `.md` estándar de OAC
- MCP servers en entorno virtual Python (no global)
- No se usa CI/CD de GitHub. Solo Wrangler + Cloudflare Pages
- El usuario no sigue pasos fijos. OCA interpreta cada petición y usa el artefacto adecuado
