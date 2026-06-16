---
source: REPOC (oac-swe-master)
topic: agents-catalogo
fetched: 2026-06-16
version: v0.7.1
---

# Agentes — catálogo completo

**Propósito**: Catálogo de todos los agentes y subagentes definidos en
`.opencode/agent/`, con su modo, temperatura y función. OCA usa este
catálogo para saber qué subagentes tiene disponibles para delegar.

**Fecha**: 2026-06-16

---

## Índice

- [Agentes primarios (core)](#agentes-primarios-core)
- [Agentes de contenido](#agentes-de-contenido)
- [Agentes de datos](#agentes-de-datos)
- [Agentes meta](#agentes-meta)
- [Agente de evaluación](#agente-de-evaluación)
- [Subagentes de código](#subagentes-de-código)
- [Subagentes core](#subagentes-core)
- [Subagentes de desarrollo](#subagentes-de-desarrollo)
- [Subagentes system-builder](#subagentes-system-builder)
- [Subagentes de test](#subagentes-de-test)
- [Subagentes de utilidades](#subagentes-de-utilidades)
- [Ver también](#ver-también)

---

## Agentes primarios (core)

| Nombre | Archivo | Modo | Temp. | Función |
|--------|---------|------|-------|---------|
| **OpenAgent** | `agent/core/openagent.md` | `primary` | 0.2 | Agente universal. Responde preguntas, ejecuta tareas, coordina flujos de trabajo. Es el agente por defecto para interacción con el usuario. |
| **OpenCoder** | `agent/core/opencoder.md` | `primary` | 0.1 | Orquestación para código complejo, arquitectura y refactorización multi-archivo. Temperatura baja para precisión. |

---

## Agentes de contenido

| Nombre | Archivo | Modo | Temp. | Función |
|--------|---------|------|-------|---------|
| **OpenCopywriter** | `agent/content/copywriter.md` | `primary` | 0.3 | Redacción persuasiva, copy de marketing y mensajes de marca. Temperatura más alta para creatividad. |
| **OpenTechnicalWriter** | `agent/content/technical-writer.md` | `primary` | 0.2 | Documentación técnica, API docs y comunicación técnica. |

---

## Agentes de datos

| Nombre | Archivo | Modo | Temp. | Función |
|--------|---------|------|-------|---------|
| **OpenDataAnalyst** | `agent/data/data-analyst.md` | `primary` | 0.1 | Análisis de datos, visualización y extracción de insights estadísticos. |

---

## Agentes meta

| Nombre | Archivo | Modo | Temp. | Función |
|--------|---------|------|-------|---------|
| **OpenRepoManager** | `agent/meta/repo-manager.md` | `primary` | 0.2 | Gestión del repositorio OAC con carga lazy de contexto, delegación inteligente y documentación automática. |
| **OpenSystemBuilder** | `agent/meta/system-builder.md` | `primary` | 0.2 | Orquestador para construir sistemas IA completos con contexto a partir de requisitos del usuario. |

---

## Agente de evaluación

| Nombre | Archivo | Modo | Temp. | Función |
|--------|---------|------|-------|---------|
| **Eval Runner** | `agent/eval-runner.md` | `subagent` | 0.2 | Test harness para el framework de evaluación. NO usar directamente en producción. |

---

## Subagentes de código

| Nombre | Archivo | Categoría | Función |
|--------|---------|-----------|---------|
| **CoderAgent** | `subagents/code/coder-agent.md` | code | Ejecuta subtareas de codificación en secuencia. Delega OCA para implementar features. |
| **BuildAgent** | `subagents/code/build-agent.md` | code | Valida type check y build del proyecto. |
| **CodeReviewer** | `subagents/code/reviewer.md` | code | Code review, análisis de seguridad y aseguramiento de calidad. |
| **TestEngineer** | `subagents/code/test-engineer.md` | code | Autoría de tests y TDD. Escribe tests antes del código. |

---

## Subagentes core

| Nombre | Archivo | Categoría | Función |
|--------|---------|-----------|---------|
| **ContextScout** | `subagents/core/contextscout.md` | core | Descubre y recomienda archivos de contexto de `.opencode/context/` por prioridad. Sugiere ExternalScout cuando se menciona una librería externa. |
| **ExternalScout** | `subagents/core/externalscout.md` | core | Fetch de documentación viva de librerías externas vía Context7. Filtra, ordena y devuelve docs relevantes. |
| **TaskManager** | `subagents/core/task-manager.md` | core | Desglose JSON de features complejas en subtareas atómicas verificables con seguimiento de dependencias. |
| **DocWriter** | `subagents/core/documentation.md` | core | Redacción de documentación técnica. |
| **ContextManager** | `subagents/core/context-manager.md` | core | Ciclo de vida del contexto: descubre, cataloga, valida y mantiene la estructura de contexto con dependencias. |
| **Context Retriever** | `subagents/core/context-retriever.md` | core | Búsqueda genérica de contextos, estándares y guías en cualquier repositorio. |

---

## Subagentes de desarrollo

| Nombre | Archivo | Categoría | Función |
|--------|---------|-----------|---------|
| **OpenDevopsSpecialist** | `subagents/development/devops-specialist.md` | development | CI/CD, infraestructura como código, automatización de despliegue. |
| **OpenFrontendSpecialist** | `subagents/development/frontend-specialist.md` | development | Diseño UI, sistemas de diseño, temas, animaciones. |

---

## Subagentes system-builder

| Nombre | Archivo | Categoría | Función |
|--------|---------|-----------|---------|
| **AgentGenerator** | `subagents/system-builder/agent-generator.md` | system-builder | Genera archivos de agente XML optimizados siguiendo patrones de investigación. |
| **CommandCreator** | `subagents/system-builder/command-creator.md` | system-builder | Crea comandos slash personalizados con sintaxis clara. |
| **ContextOrganizer** | `subagents/system-builder/context-organizer.md` | system-builder | Organiza y genera archivos de contexto (dominio, procesos, estándares, plantillas). |
| **DomainAnalyzer** | `subagents/system-builder/domain-analyzer.md` | system-builder | Analiza dominios de usuario para identificar conceptos clave y estructura de contexto. |
| **WorkflowDesigner** | `subagents/system-builder/workflow-designer.md` | system-builder | Diseña definiciones completas de workflow con dependencias de contexto y criterios de éxito. |

---

## Subagentes de test

| Nombre | Archivo | Categoría | Función |
|--------|---------|-----------|---------|
| **Simple Responder** | `subagents/test/simple-responder.md` | test | Test agent que responde "AWESOME TESTING". Usado en evaluaciones del framework. |

---

## Subagentes de utilidades

| Nombre | Archivo | Categoría | Función |
|--------|---------|-----------|---------|
| **Image Specialist** | `subagents/utils/image-specialist.md` | utils | Edición y análisis de imágenes usando herramientas Gemini AI. |

---

## Ver también

- [Estructura completa de `.opencode/`](01_estructura-completa-opencode.md)
- [Comandos personalizados](03_comandos-personalizados.md)
- [Skills instalados](04_skills-instalados.md)
