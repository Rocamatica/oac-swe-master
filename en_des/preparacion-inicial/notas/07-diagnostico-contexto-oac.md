# Informe ContextScout — Repositorio OAC

**Contexto**: Proyecto PYT-SWE (OAC+Hugo)
**Herramienta**: ContextScout (subagente de OAC)
**Fecha**: 2026-06-16

---

## Resumen

El repositorio `oac-swe-master` tiene **208 archivos de contexto** (188 internos + 20 externos).

| Área | Archivos | Estado |
|------|:--------:|--------|
| Core (estándares, workflows, task mgmt, ctx system) | 61 | ✅ Completo |
| OpenAgents Repo (guías del framework OAC) | 54 | ⚠️ Faltan ~20 referenciados |
| Development (principios, frontend, Mastra AI) | 24 | ⚠️ 4/8 subdirectorios vacíos |
| UI (web, animación, React, diseño) | 17 | ✅ Completo |
| Content Creation (formatos, copywriting) | 12 | ✅ Completo |
| Project Intelligence (negocio, stack, decisiones) | 6 | ✅ Completo |
| System Builder (plantillas) | 3 | ✅ Completo |
| Data / Learning / Product | 3 | ❌ Solo README placeholder |
| Hugo (externo) | 13 | ✅ Fichas técnicas completas |
| Astro (externo) | 7 | — |

---

## Archivos existentes por sección

### 1. Core (`core/`) — 61 archivos
Cubre: estándares de código, testing, documentación, seguridad, project intelligence, flujos de trabajo (code review, delegación, diseño, librerías externas, contexto externo), configuración, sistema de contexto (MVI, estructura, plantillas, frontmatter, operaciones harvest/extract/organize), y task management (esquema JSON, descomposición, ciclo de vida).

### 2. OpenAgents Repo (`openagents-repo/`) — 54 archivos
Cubre: conceptos (agents, evals, registry, categories, metadata, subagent testing), guías (añadir agentes/skills, testing, debugging, npm publishing, GitHub issues, subagent invocation), lookup (comandos, subagent testing, file locations), ejemplos, errores, plugins, calidad, plantillas, blueprints.

### 3. Development (`development/`) — 24 archivos
Cubre: principios (clean code, API design), Mastra AI (core concepts, agents, workflows, evaluations, storage, guías, ejemplos, errores, configuración), frontend, y placeholders para backend, data, integration, infrastructure.

### 4. UI (`ui/`) — 17 archivos
Cubre: web (CSS/Tailwind, React patterns, design systems, animación completa: basics, components, chat, loading, forms, advanced), diseño (scroll-linked animations, scrollytelling), y placeholder terminal.

### 5. Content Creation (`content-creation/`) — 12 archivos
Cubre: formatos (written, video, image, audio), principios (copywriting frameworks, tone/voice, audience, hooks), workflows (ideas, matrix, review, remix).

### 6. Project Intelligence (`project-intelligence/`) — 6 archivos
Cubre: navigation, business domain, technical domain, business-tech bridge, decisions log, living notes.

### 7. External Context (`external-context/`) — 20 archivos
- **Hugo** (13): archetypes, cascade, configuration, content-formats, directory-structure, menus-frontmatter, page-bundles, pagination, shortcodes, summaries, taxonomies, templates, manifest
- **Astro** (7): blog, content-creation, i18n, markdown-content, performance-build, seo, manifest

---

## Gaps críticos (36 archivos referenciados pero no existentes)

| Archivo faltante | Referenciado en |
|-----------------|-----------------|
| `openagents-repo/standards/agent-frontmatter.md` | navigation |
| `openagents-repo/standards/subagent-structure.md` | navigation |
| `openagents-repo/lookup/tool-feature-parity.md` | navigation |
| `openagents-repo/lookup/compatibility-layer-structure.md` | navigation |
| `openagents-repo/lookup/builtin-subagents.md` | navigation |
| `openagents-repo/lookup/subagent-frontmatter.md` | navigation |
| `openagents-repo/lookup/hook-events.md` | navigation |
| `openagents-repo/lookup/skill-metadata.md` | navigation |
| `openagents-repo/lookup/skills-comparison.md` | navigation |
| `openagents-repo/concepts/compatibility-layer.md` | navigation |
| `openagents-repo/concepts/hooks-system.md` | navigation |
| `openagents-repo/concepts/agent-skills.md` | navigation |
| `openagents-repo/concepts/subagents-system.md` | navigation |
| `openagents-repo/examples/baseadapter-pattern.md` | navigation |
| `openagents-repo/examples/zod-schema-migration.md` | navigation |
| `openagents-repo/errors/skills-errors.md` | navigation |
| `openagents-repo/guides/compatibility-layer-workflow.md` | navigation |
| `openagents-repo/guides/creating-skills.md` | navigation |
| `openagents-repo/guides/creating-subagents.md` | navigation |
| `core/standards/typescript.md` | core/standards/navigation |
| `core/standards/csharp.md` | core/standards/navigation |
| `core/standards/csharp-project-structure.md` | core/standards/navigation |
| `core/guides/resuming-sessions.md` | core/navigation |
| `core/workflows/multi-stage-orchestration.md` | task-management/navigation |
| `core/task-management/standards/enhanced-task-schema.md` | task-management/navigation |
| `ui/web/images-guide.md` | ui/web/navigation |
| `ui/web/icons-guide.md` | ui/web/navigation |
| `ui/web/fonts-guide.md` | ui/web/navigation |
| `ui/web/cdn-resources.md` | ui/web/navigation |
| `ui/web/design/guides/premium-dark-ui-visual-reference.md` | ui/web/design/navigation |
| `openagents-repo/examples/hooks/` (directorio) | examples/navigation |
| `openagents-repo/examples/skills/` (directorio) | examples/navigation |
| `openagents-repo/examples/subagents/` (directorio) | examples/navigation |
| `openagents-repo/features/` (directorio) | navigation |
| `development/frameworks/tanstack-start/` (directorio) | frameworks/navigation |
| `development/frontend/react/` (directorio) | frontend/navigation |

---

## Recomendaciones ExternalScout

| Framework/Librería | Motivo |
|--------------------|--------|
| **Next.js** | Mencionado en ejemplo scrollytelling |
| **TanStack Start** | Directorio vacío en frameworks/ |
| **Framer Motion** | Referenciado en animación UI |
| **Auth.js / Better Auth** | Potencial para autenticación |
| **Prisma / Drizzle** | Planeado en data/ |

---

## Pendiente

- [ ] Rellenar gaps de archivos referenciados pero no existentes
- [ ] ExternalScout para frameworks pendientes (Next.js, TanStack, Framer Motion, Auth, ORMs)
- [ ] Decidir si los placeholders (data/, learning/, product/) necesitan contenido
