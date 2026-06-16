---
source: REPOC (oac-swe-master)
library: REPOC
package: oac-repoc
topic: estructura-completa-opencode
fetched: 2026-06-16
version: v0.7.1
official_docs: ""
---

# Estructura completa de `.opencode/`

**Propósito**: Mapa completo del directorio `.opencode/` del REPOC con
propósito de cada subdirectorio y archivo relevante. Sirve como referencia
para que OCA conozca sus propios recursos.

**Fecha**: 2026-06-16

---

## Índice

- [Árbol completo](#árbol-completo)
- [Directorio `agent/` — Definiciones de agentes](#directorio-agent--definiciones-de-agentes)
- [Directorio `command/` — Comandos slash](#directorio-command--comandos-slash)
- [Directorio `config/` — Configuración](#directorio-config--configuración)
- [Directorio `context/` — Sistema de contexto](#directorio-context--sistema-de-contexto)
- [Directorio `external-context/` — Contexto externo](#directorio-external-context--contexto-externo)
- [Directorio `mcp/` — Servidores MCP](#directorio-mcp--servidores-mcp)
- [Directorio `skills/` — Skills reutilizables](#directorio-skills--skills-reutilizables)
- [Directorio `tool/` — Herramientas personalizadas](#directorio-tool--herramientas-personalizadas)
- [Directorio `plugin/` — Plugins](#directorio-plugin--plugins)
- [Directorio `scripts/` — Scripts de utilidad](#directorio-scripts--scripts-de-utilidad)
- [Archivos raíz](#archivos-raíz)
- [Ver también](#ver-también)

---

## Árbol completo

```
.opencode/
├── agent/                    → Agentes y subagentes
│   ├── core/                 → Agentes primarios (OpenAgent, OpenCoder)
│   ├── content/              → Especialistas de contenido
│   ├── data/                 → Analista de datos
│   ├── meta/                 → Agentes meta (system-builder, repo-manager)
│   └── subagents/            → Subagentes delegables
│       ├── code/             → CoderAgent, BuildAgent, Reviewer, TestEngineer
│       ├── core/             → ContextScout, ExternalScout, TaskManager, DocWriter
│       ├── development/      → DevOpsSpecialist, FrontendSpecialist
│       ├── system-builder/   → AgentGenerator, CommandCreator, etc.
│       ├── test/             → SimpleResponder
│       └── utils/            → ImageSpecialist
├── command/                  → Comandos slash (/commit, /context, /hugo-deploy...)
│   ├── openagents/           → Comandos del ecosistema OAC
│   │   └── new-agents/       → Crear agentes y tests
│   └── prompt-engineering/   → Mejora y optimización de prompts
├── config/                   → Metadatos de agentes y registros
├── context/                  → Sistema de contexto MVI
│   ├── core/                 → Estándares, workflows, navegación
│   └── ...                   → Contextos por dominio
├── external-context/         → Conocimiento de herramientas externas
│   ├── hugo/                 → Documentación de Hugo y HugoMods
│   ├── oac/                  → Documentación del framework OAC
│   └── cloudflare-pages-tools/ → Investigación Cloudflare
├── mcp/                      → Servidores MCP instalados
│   ├── hugo-mcp-src/         → hugo-mcp (Python)
│   ├── hugo-memex-src/       → hugo-memex (Python)
│   └── hugo-docs-mcp-src/    → hugo-docs-mcp (Go)
├── skills/                   → Skills reutilizables
│   ├── hugo-*/               → 7 skills para Hugo
│   ├── context-manager/      → Gestión de contexto
│   ├── context7/             → Documentación externa vía Context7
│   └── task-management/      → CLI de tareas
├── tool/                     → Herramientas personalizadas
│   ├── env/                  → Cargar variables de entorno
│   └── gemini/               → Integración con Gemini AI
├── plugin/                   → Plugins de eventos
│   └── notify.ts             → Plugin de notificaciones
└── scripts/                  → Scripts de utilidad
    └── install-tools.sh      → Bootstrap para REPON
```

---

## Directorio `agent/` — Definiciones de agentes

| Ruta | Contenido |
|------|-----------|
| `agent/core/openagent.md` | **OpenAgent** (v1) — Agente universal primario. Responde preguntas, ejecuta tareas, coordina flujos de trabajo. `mode: primary`, `temperature: 0.2` |
| `agent/core/opencoder.md` | **OpenCoder** — Agente de orquestación para código complejo, arquitectura y refactorización multi-archivo. `mode: primary`, `temperature: 0.1` |
| `agent/content/copywriter.md` | **OpenCopywriter** — Redacción persuasiva, copy de marketing y mensajes de marca. `mode: primary`, `temperature: 0.3` |
| `agent/content/technical-writer.md` | **OpenTechnicalWriter** — Documentación técnica, API docs y comunicación técnica. `mode: primary`, `temperature: 0.2` |
| `agent/data/data-analyst.md` | **OpenDataAnalyst** — Análisis de datos, visualización y extracción de insights estadísticos. `mode: primary`, `temperature: 0.1` |
| `agent/meta/repo-manager.md` | **OpenRepoManager** — Gestión del repositorio OAC con carga lazy de contexto, delegación inteligente y documentación automática. `mode: primary`, `temperature: 0.2` |
| `agent/meta/system-builder.md` | **OpenSystemBuilder** — Orquestador para construir sistemas IA completos con contexto a partir de requisitos del usuario. `mode: primary`, `temperature: 0.2` |
| `agent/eval-runner.md` | **Eval Runner** — Test harness para el framework de evaluación. NO usar directamente. `mode: subagent`, `temperature: 0.2` |

### Subagentes

| Ruta | Nombre | Función |
|------|--------|---------|
| `subagents/code/coder-agent.md` | **CoderAgent** | Ejecuta subtareas de codificación en secuencia |
| `subagents/code/build-agent.md` | **BuildAgent** | Validación de type check y build |
| `subagents/code/reviewer.md` | **CodeReviewer** | Code review, seguridad y calidad |
| `subagents/code/test-engineer.md` | **TestEngineer** | Autoría de tests y TDD |
| `subagents/core/contextscout.md` | **ContextScout** | Descubre contextos relevantes en `.opencode/context/` |
| `subagents/core/externalscout.md` | **ExternalScout** | Fetch de documentación viva de librerías externas |
| `subagents/core/task-manager.md` | **TaskManager** | Desglose JSON de features complejas en subtareas |
| `subagents/core/documentation.md` | **DocWriter** | Redacción de documentación |
| `subagents/core/context-manager.md` | **ContextManager** | Ciclo de vida del contexto: descubrir, catalogar, validar |
| `subagents/core/context-retriever.md` | **Context Retriever** | Búsqueda genérica de contextos |
| `subagents/development/devops-specialist.md` | **OpenDevopsSpecialist** | CI/CD, infraestructura como código, automatización |
| `subagents/development/frontend-specialist.md` | **OpenFrontendSpecialist** | Diseño UI, sistemas de diseño, animaciones |
| `subagents/system-builder/agent-generator.md` | **AgentGenerator** | Genera archivos de agente XML optimizados |
| `subagents/system-builder/command-creator.md` | **CommandCreator** | Crea comandos slash personalizados |
| `subagents/system-builder/context-organizer.md` | **ContextOrganizer** | Organiza y genera archivos de contexto |
| `subagents/system-builder/domain-analyzer.md` | **DomainAnalyzer** | Analiza dominios de usuario |
| `subagents/system-builder/workflow-designer.md` | **WorkflowDesigner** | Diseña definiciones de workflow |
| `subagents/test/simple-responder.md` | **Simple Responder** | Test agent para evaluaciones |
| `subagents/utils/image-specialist.md` | **Image Specialist** | Edición y análisis de imágenes |

---

## Directorio `command/` — Comandos slash

| Comando | Archivo | Descripción |
|---------|---------|-------------|
| `/add-context` | `command/add-context.md` | Wizard interactivo para añadir patrones del proyecto |
| `/analyze-patterns` | `command/analyze-patterns.md` | Analizar codebase en busca de patrones |
| `/build-context-system` | `command/build-context-system.md` | Constructor de sistemas de contexto |
| `/clean` | `command/clean.md` | Limpiar codebase (Prettier, ESLint, TSC) |
| `/commit` | `command/commit.md` | Commits convencionales con emojis |
| `/commit-openagents` | `command/commit-openagents.md` | Commit para repo OAC con validación automática |
| `/context` | `command/context.md` | Gestor del sistema de contexto (harvest, organize) |
| `/hugo-deploy` | `command/hugo-deploy.md` | Build + deploy Hugo a Cloudflare Pages |
| `/optimize` | `command/optimize.md` | Analizar y optimizar código |
| `/test` | `command/test.md` | Pipeline de testing completo |
| `/test-new-command` | `command/test-new-command.md` | Test de auto-detección de comandos |
| `/validate-repo` | `command/validate-repo.md` | Validar consistencia de registro/componentes |
| `/worktrees` | `command/worktrees.md` | Gestionar git worktrees |
| `/create-agent` | `command/openagents/new-agents/create-agent.md` | Crear nuevos agentes OAC |
| `/create-tests` | `command/openagents/new-agents/create-tests.md` | Generar suites de test para agentes |
| `/check-context-deps` | `command/openagents/check-context-deps.md` | Validar dependencias de contexto |
| `prompt-enhancer` | `command/prompt-engineering/prompt-enhancer.md` | Mejorar prompts con patrones de investigación |
| `prompt-optimizer` | `command/prompt-engineering/prompt-optimizer.md` | Optimizar prompts (30-50% menos tokens) |

---

## Directorio `config/` — Configuración

| Archivo | Contenido |
|---------|-----------|
| `config/agent-metadata.json` | Metadatos de todos los agentes: id, nombre, categoría, tipo, versión, etiquetas, dependencias |

---

## Directorio `context/` — Sistema de contexto

Estructura MVI (Minimal Viable Information). Subdirectorios principales:

| Ruta | Contenido |
|------|-----------|
| `context/core/standards/` | Estándares transversales: code-quality, documentation, test-coverage, security-patterns, navigation |
| `context/core/workflows/` | Flujos de trabajo: code-review, task-delegation, session-management, design-iteration, external-context |
| `context/core/config/` | Config del sistema de contexto: navigation.md, paths.json |
| `context/core/context-system/` | Guías, ejemplos, operaciones (harvest, extract, organize, update, error, migrate) |
| `context/core/task-management/` | Gestión de tareas: guías, comandos, esquema, navegación |
| `context/openagents-repo/` | Documentación del framework OAC: core-concepts, guides, lookup, plugins, quality, templates, blueprints |
| `context/project-intelligence/` | Inteligencia del proyecto: business-domain, technical-domain, decisions-log, living-notes |
| `context/development/` | Contextos de desarrollo: principios, frameworks, frontend, backend, infraestructura, AI/mastra |
| `context/ui/` | Contextos de UI: web (animaciones, diseño, patrones React, sistemas de diseño), terminal |
| `context/content-creation/` | Formatos de contenido: audio, imagen, video, escrito + principios y workflows |
| `context/navigation.md` | Índice maestro de contexto |
| `context/learning/README.md` | Guía de aprendizaje del contexto |

---

## Directorio `external-context/` — Contexto externo

| Subdirectorio | Archivos | Propósito |
|---------------|----------|-----------|
| `oac/` | `01_estructura-completa-opencode.md`, `02_agents-catalogo.md`, `03_comandos-personalizados.md`, `04_skills-instalados.md`, `05_mcp-servers-configurados.md`, `06_plugins-y-herramientas.md`, `07_scripts-de-arranque.md` + 7 archivos de documentación genérica OAC | Auto-conocimiento del REPOC + documentación del framework OAC |
| `hugo/` | `hugo-install.md`, `hugomods-*.md` (6), `archetypes.md`, `configuration.md`, `templates.md`, etc. (19 archivos) | Documentación de Hugo, HugoMods y herramientas |
| `cloudflare-pages-tools/` | `investigacion-herramientas.md` | Documentación de Cloudflare Pages |

---

## Directorio `mcp/` — Servidores MCP

| Ruta | Tecnología | Propósito |
|------|-----------|-----------|
| `mcp/hugo-mcp-src/` | Python + venv | CRUD de contenido Hugo (jmrGrav) |
| `mcp/hugo-memex-src/` | Python + venv | Búsqueda semántica FTS5 (queelius) |
| `mcp/hugo-docs-mcp-src/` | Go (binario) | Auditoría de calidad de contenido (danfinn5) |
| `mcp/hugo-docs-mcp` | Go (compilado) | Binario compilado de hugo-docs-mcp |

---

## Directorio `skills/` — Skills reutilizables

| Skill | Ruta | Función |
|-------|------|---------|
| `hugo-mcp-adapter` | `skills/hugo-mcp-adapter/SKILL.md` | CRUD de páginas Hugo vía MCP |
| `hugo-query` | `skills/hugo-query/SKILL.md` | Búsqueda semántica con hugo-memex |
| `hugo-search-index` | `skills/hugo-search-index/SKILL.md` | Indexar búsqueda con Pagefind |
| `hugo-agentic-audit` | `skills/hugo-agentic-audit/SKILL.md` | Auditoría de visibilidad IA (AEO) |
| `hugo-seo-audit` | `skills/hugo-seo-audit/SKILL.md` | Auditoría SEO técnica |
| `hugo-audit-quality` | `skills/hugo-audit-quality/SKILL.md` | Auditoría de calidad del contenido |
| `hugo-cms-setup` | `skills/hugo-cms-setup/SKILL.md` | Configurar Decap CMS |
| `context-manager` | `skills/context-manager/SKILL.md` | Gestión del ciclo de vida del contexto |
| `context7` | `skills/context7/` | Documentación externa vía Context7 API |
| `task-management` | `skills/task-management/` | CLI de tareas con router.sh + task-cli.ts |

---

## Directorio `tool/` — Herramientas personalizadas

| Ruta | Propósito |
|------|-----------|
| `tool/env/index.ts` | Cargar variables de entorno desde `.env` y `env.example` |
| `tool/gemini/index.ts` | Integración con Gemini AI para edición/análisis de imágenes |

---

## Directorio `plugin/` — Plugins

| Ruta | Propósito |
|------|-----------|
| `plugin/notify.ts` | Plugin de notificaciones. Actualmente deshabilitado (`ENABLED = false`) |

---

## Directorio `scripts/` — Scripts de utilidad

| Ruta | Propósito |
|------|-----------|
| `scripts/install-tools.sh` | Bootstrap para REPON: instala hugo-extended, Pagefind, agentic-seo, seofor.dev, wrangler, venvs Python de MCPs, binario Go |

---

## Archivos raíz

| Archivo | Propósito |
|---------|-----------|
| `.opencode/.gitignore` | Ignorar venvs y node_modules en los subdirectorios |
| `.opencode/env.example` | Plantilla de variables de entorno |
| `.opencode/package.json` | Definición del paquete npm `@nextsystems/oac` |
| `.opencode/README.md` | Documentación del directorio `.opencode/` |

---

## Ver también

- [Agentes — catálogo completo](02_agents-catalogo.md)
- [Comandos personalizados](03_comandos-personalizados.md)
- [Skills instalados](04_skills-instalados.md)
- [MCP servers configurados](05_mcp-servers-configurados.md)
