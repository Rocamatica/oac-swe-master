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
- [ ] **2.2** — Actualizar `recursos/seleccion-herramientas-hugo-oac.md` (quitar GH CI/CD + ajustes)
- [ ] **2.3** — Crear `recursos/flujos/capacidades-oca-hugo.md` (sustituye a la triada obsoleta)
- [ ] **2.4** — Revisar qué otros documentos requieren actualización (ContextScout)

## Fase 3: Instalación de herramientas (fase 0 técnica)

- [ ] **3.1** — Instalar `hugo-extended` vía npm (última versión estable, funcional y no beta)
- [ ] **3.2** — Instalar `hugo-mcp` (Python, entorno virtual)
- [ ] **3.3** — Instalar `hugo-memex` (Python, entorno virtual)
- [ ] **3.4** — Instalar `Pagefind` (npm)
- [ ] **3.5** — Instalar `agentic-seo` y `seofor.dev`
- [ ] **3.6** — Verificar que todas las herramientas responden correctamente

## Fase 4: Habilidades OAC (skills + subagentes + contextos)

- [ ] **4.1** — Crear skill `hugo-mcp-adapter` (subagente que invoca hugo-mcp)
- [ ] **4.2** — Crear skill `hugo-query` (envuelve hugo-memex)
- [ ] **4.3** — Crear skill `hugo-search-index` (envuelve Pagefind)
- [ ] **4.4** — Crear skill `hugo-agentic-audit` (envuelve agentic-seo)
- [ ] **4.5** — Crear skill `hugo-seo-audit` (envuelve seofor.dev)
- [ ] **4.6** — Crear contextos para HugoMods (SEO, Images, PWA, Icons)
- [ ] **4.7** — Crear skill `hugo-cms-setup` (Decap CMS)

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
