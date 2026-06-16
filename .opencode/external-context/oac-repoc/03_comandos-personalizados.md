---
source: REPOC (oac-swe-master)
library: REPOC
package: oac-repoc
topic: comandos-personalizados
fetched: 2026-06-16
version: v0.7.1
official_docs: ""
---

# Comandos personalizados

**Propósito**: Catálogo de todos los comandos slash definidos en
`.opencode/command/`. Cada comando es un atajo que OCA o el usuario pueden
invocar escribiendo `/nombre` en el chat.

**Fecha**: 2026-06-16

---

## Índice

- [Comandos de utilidad general](#comandos-de-utilidad-general)
- [Comandos de código y testing](#comandos-de-código-y-testing)
- [Comandos de contexto](#comandos-de-contexto)
- [Comandos Hugo](#comandos-hugo)
- [Comandos del ecosistema OAC](#comandos-del-ecosistema-oac)
- [Comandos de prompt engineering](#comandos-de-prompt-engineering)
- [Ver también](#ver-también)

---

## Comandos de utilidad general

| Comando | Archivo | Descripción |
|---------|---------|-------------|
| `/commit` | `command/commit.md` | Crea commits con formato convencional y emoji. Analiza `git diff`, propone mensaje, ejecuta y pushea. |
| `/commit-openagents` | `command/commit-openagents.md` | Commit específico para el repo OAC con validación automática. |
| `/worktrees` | `command/worktrees.md` | Gestiona git worktrees para flujos de desarrollo en paralelo. |
| `/clean` | `command/clean.md` | Limpia el codebase: Prettier, Import Sorter, ESLint y TypeScript Compiler. |
| `/optimize` | `command/optimize.md` | Analiza y optimiza código en busca de problemas de rendimiento, seguridad y calidad. |
| `/analyze-patterns` | `command/analyze-patterns.md` | Analiza el codebase en busca de patrones e implementaciones similares. |
| `/validate-repo` | `command/validate-repo.md` | Valida la consistencia del registro y componentes del repositorio. |

---

## Comandos de código y testing

| Comando | Archivo | Descripción |
|---------|---------|-------------|
| `/test` | `command/test.md` | Ejecuta el pipeline de testing completo. |
| `/test-new-command` | `command/test-new-command.md` | Test para verificar auto-detección de nuevos comandos y actualizaciones del registro. |
| `/build-context-system` | `command/build-context-system.md` | Constructor interactivo de sistemas de contexto para dominios específicos. |

---

## Comandos de contexto

| Comando | Archivo | Descripción |
|---------|---------|-------------|
| `/context` | `command/context.md` | Gestor del sistema de contexto. Operaciones: harvest (extraer conocimiento de sesiones), extract (desde docs/code/URLs), organize (reestructurar), validate (verificar integridad). |
| `/add-context` | `command/add-context.md` | Wizard interactivo para añadir patrones del proyecto usando el estándar Project Intelligence. |

---

## Comandos Hugo

| Comando | Archivo | Descripción |
|---------|---------|-------------|
| `/hugo-deploy` | `command/hugo-deploy.md` | Build del sitio Hugo (`hugo --minify --gc`) + indexación Pagefind + deploy a Cloudflare Pages via Wrangler. Flags: `--project`, `--dry-run`, `--skip-audit`. |

---

## Comandos del ecosistema OAC

| Comando | Archivo | Descripción |
|---------|---------|-------------|
| `/create-agent` | `command/openagents/new-agents/create-agent.md` | Crea nuevos agentes OAC siguiendo mejores practices (Anthropic 2025). |
| `/create-tests` | `command/openagents/new-agents/create-tests.md` | Genera suites de test completas para agentes OAC con 8 tipos de test esenciales. |
| `/check-context-deps` | `command/openagents/check-context-deps.md` | Valida dependencias de contexto entre agentes y el registro. |

---

## Comandos de prompt engineering

| Comando | Archivo | Descripción |
|---------|---------|-------------|
| `prompt-enhancer` | `command/prompt-engineering/prompt-enhancer.md` | Mejora prompts aplicando patrones de investigación Stanford/Anthropic con mejoras específicas por modelo y tarea. |
| `prompt-optimizer` | `command/prompt-engineering/prompt-optimizer.md` | Optimiza prompts reduciendo 30-50% tokens preservando significado al 100%. Usa patrones de eficiencia semántica. |

---

## Ver también

- [Estructura completa de `.opencode/`](01_estructura-completa-opencode.md)
- [Agentes — catálogo completo](02_agents-catalogo.md)
- [Skills instalados](04_skills-instalados.md)
- [Guía de comandos Hugo](../recursos/guias/05_skills-comandos.md)
