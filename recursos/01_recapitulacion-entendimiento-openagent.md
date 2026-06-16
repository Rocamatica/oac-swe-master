# Recapitulación de entendimiento — OpenAgent

**Propósito**: Documento fundacional que captura el entendimiento completo de OpenAgent sobre el repositorio, su naturaleza, reglas, stack tecnológico, arquitectura de interacción y restricciones. Sirve como referencia única y punto de partida para toda toma de decisiones futura.

**Fecha**: 2026-06-16

**Repositorio**: `oac-swe-master` (base clonable OAC + Hugo)

---

## Índice

- [1. Quién soy (OpenAgent)](#1-quién-soy-openagent)
- [2. Stack tecnológico del repositorio](#2-stack-tecnológico-del-repositorio)
- [3. Arquitectura de interacción](#3-arquitectura-de-interacción)
- [4. Naturaleza del repositorio: base clonable](#4-naturaleza-del-repositorio-base-clonable)
- [5. Modelo REPOC → REPON (herencia)](#5-modelo-repoc--repon-herencia)
- [6. Estructura del repositorio (relevante)](#6-estructura-del-repositorio-relevante)
- [7. Contexto externo de OAC cargado (7 archivos)](#7-contexto-externo-de-oac-cargado-7-archivos)
- [8. Contenido del flujo Hugo](#8-contenido-del-flujo-hugo)
- [9. Artefactos: no todo son prompts (P)](#9-artefactos-no-todo-son-prompts-p)
- [10. Lo que NO debo hacer (restricciones)](#10-lo-que-no-debo-hacer-restricciones)
- [11. Lo que SÍ debo hacer (prioridades)](#11-lo-que-sí-debo-hacer-prioridades)
- [12. Estado actual de la conversación](#12-estado-actual-de-la-conversación)

---

## 1. Quién soy (OpenAgent)

Soy **OpenAgent**, el agente universal primario de **OpenAgents Control (OAC) v0.7.1**, un framework que extiende OpenCode. Mi función es ser el **único punto de interacción** con el usuario, orquestando todo el trabajo: analizar, descubrir contexto, proponer planes, ejecutar, validar y resumir. Puedo ejecutar directamente o delegar a subagentes especializados (ContextScout, ExternalScout, TaskManager, CoderAgent, etc.).

Mi workflow es de 6 etapas:

```
Analyze → Discover (ContextScout) → Approve → Execute → Validate → Summarize → Confirm
```

---

## 2. Stack tecnológico del repositorio

| Componente | Rol |
|------------|-----|
| **OAC** (OpenAgents Control) v0.7.1 | Framework de agentes que extiende OpenCode |
| **OpenCode** | CLI de IA subyacente |
| **Hugo** (extended) | Generador de sitios web estáticos (SSG) |
| **Cloudflare Pages** | Destino de despliegue (vía Wrangler + `npm`) |

---

## 3. Arquitectura de interacción

```
Usuario ←→ OpenAgent (OAC) ←→ OpenCoder (OCC) ←→ Hugo
```

Reglas:
- El usuario interactúa **exclusivamente con OpenAgent**
- OpenAgent gestiona **todo**: instalación, configuración, contenido, build, deploy
- **Nunca se ejecutan comandos Hugo directamente** — todo se canaliza a través de OAC
- **Preparar OAC primero** — antes de gestionar Hugo, verificar que el contexto está completo (`.opencode/external-context/hugo/`) y sin gaps
- Cualquier cambio en configuración o estructura de Hugo se canaliza por OAC para mantener coherencia de contexto

---

## 4. Naturaleza del repositorio: base clonable

Regla fundamental y transversal (incorporada del análisis inicial de reglas OAC+Hugo):

> **"Este repositorio es una base clonable. No contiene proyectos específicos (PYT). Todo el contenido que se cree aquí debe ser reutilizable al clonar el repositorio."**

### Implicaciones directas

| Principio | Implicación |
|-----------|-------------|
| **Es base clonable** | No es el proyecto final. Es una plantilla para iniciar proyectos |
| **No contiene proyectos específicos (PYT)** | Nada de contenido concreto de "PYT" o "SWE" |
| **Todo debe ser reutilizable** | Archetypes, layouts, configs genéricas, documentación de flujos |
| **Prohibido `/add-context`** | `project-intelligence/` pertenece al proyecto clonado, no aquí |
| **Prohibido `project-intelligence/`** | El stack concreto se registra en el proyecto clonado |

### Modelo REPOC → REPON

El ciclo de vida del repositorio sigue un modelo de dos etapas:

```
REPOC (este repositorio)                REPON (nuevo repositorio)
oac-swe-master                          nombre-del-proyecto
     │                                         │
     │  git clone                              │
     ├─────────────────────────────────────────┤
     │                                         │
     ├── .opencode/       ──hereda──→          ├── .opencode/    (base + ajustes)
     ├── recursos/        ──hereda──→          ├── recursos/     (base + ajustes)
     ├── en_des/          ──NO hereda──        ├── (proyecto Hugo)
     ├── reglas-abreviaciones.txt              ├── (propios del proyecto)
     └── (otros archivos base)                 └── (propios del proyecto)
```

| Concepto | Significado |
|----------|-------------|
| **REPOC** | Este repositorio. Base clonable. No contiene proyectos específicos. |
| **REPON** | Nuevo repositorio creado al clonar REPOC. Aquí vivirá el proyecto (PYT). |
| **Heredado** | `.opencode/` (configuración OAC + contextos) y `recursos/` (prompts, skills) |
| **No heredado** | `en_des/`, `reglas-abreviaciones.txt` y demás archivos raíz de preparación |

### Reglas generales del proyecto (de `reglas-abreviaciones.txt` + correcciones)

| # | Regla | Fuente |
|---|-------|--------|
| G1 | Usar **español de España (RAE)** — no presente continuo, no vocabulario hispanoamericano | `reglas-abreviaciones.txt` |
| G2 | **No inventar, no rellenar vacíos ni especular** — solo información veraz | `reglas-abreviaciones.txt` |
| G3 | **No usar abreviaciones en respuestas** — interpretar las del usuario pero responder con palabras completas | `reglas-abreviaciones.txt` |
| G4 | Reglas G1-G3 aplican a **todos los prompts y respuestas, siempre** | `reglas-abreviaciones.txt` |
| G5 | **Siempre la última versión estable** de los componentes requeridos. Confirmar/verificar que sean **funcionales y no betas** | Corrección del usuario (punto 4) |
| G6 | **No todo son prompts (P)** — usar artefactos y ventajas de OAC: skills, contextos, comandos, subagentes | Corrección del usuario (punto 3) |
| G7 | **Explicar como tutorial paso a paso**. No adelantarse a lo que el usuario pregunta. Responder solo a lo preguntado, sin información no solicitada | Extraída de reglas originales (archivo eliminado, contenido aquí) |
| G8 | **No ejecutar sin preguntar ni confirmar**. Antes de cualquier acción (instalar, modificar, crear archivos), preguntar primero y esperar confirmación explícita | Extraída de reglas originales |
| G9 | **Guardar el conocimiento obtenido** de Context7, ExternalScout o cualquier fuente externa en `.opencode/external-context/<tema>/` para que esté disponible en consultas futuras | Extraída de reglas originales |
| G10 | **OAC gestiona todo el trabajo con Hugo**. El usuario interactúa exclusivamente con OAC. OAC gestiona instalación, configuración, contenido, build y despliegue. Todo cambio se canaliza a través de OAC | Extraída de reglas originales |
| G11 | **No duplicar información**. Cada contenido una sola vez en un único archivo. Si un contenido es necesario desde otro lugar, usar referencias (enlaces, citas) sin copiar | Extraída de reglas originales |
| G12 | **Preparar OAC primero**. Antes de gestionar Hugo, verificar que el contexto está completo en `.opencode/external-context/hugo/` y que no hay gaps | Adaptada del análisis inicial |

### En una frase

> **No estoy construyendo un sitio Hugo. Estoy construyendo la FÁBRICA que construye sitios Hugo.**

---

## 6. Estructura del repositorio (relevante)

### Lo que se hereda en REPON (`.opencode/` + `recursos/`)

```
.opencode/                         ← SE HEREda EN REPON
├── external-context/
│   ├── oac/              → 7 archivos de contexto sobre OAC (v0.7.1)
│   └── hugo/             → Contexto externo de Hugo (pendiente de completar)
├── context/
│   └── core/             → Estándares, workflows, context-system (estándar OAC)
├── agent/                → Definiciones de agentes en markdown
├── command/              → Slash commands
├── skills/               → Skills reutilizables
└── ...                   → Resto de estructura OAC

recursos/                          ← SE HEREda EN REPON
├── recapitulacion-entendimiento-openagent.md  → Documento fundacional
├── seleccion-herramientas-hugo-oac.md         → Catálogo de herramientas
├── plan-implementacion-repoc.md               → Plan de implementación
├── flujos/                                     → Flujos y capacidades
│   └── capacidades-oca-hugo.md                → Catálogo de capacidades OCA
└── prompts/                                    → (vacío — el usuario expresa intención directamente)
```

### Lo que SOLO existe en REPOC (no se hereda)

```
en_des/                            ← NO SE HEREda
└── preparacion-inicial/           ← VACÍO (todo eliminado: notas, reglas, análisis previos)
    └── ...                        ← Contenido ya extraído a este documento
reglas-abreviaciones.txt           ← NO SE HEREda (permanece en REPOC como referencia)
```

---

## 7. Contexto externo de OAC cargado (7 archivos)

| # | Archivo | Temas clave |
|---|---------|-------------|
| 7.1 | `architecture-overview.md` | Pattern Control, Approval Gates, MVI, eventos, versionado (v0.7.1) |
| 7.2 | `context-system-architecture.md` | ContextScout + ExternalScout + `/add-context`, jerarquía, resolución local-first, MVI |
| 7.3 | `agent-workflows.md` | Workflows OpenAgent (6 etapas) y OpenCoder (6 etapas), parallel execution, TaskManager |
| 7.4 | `configuration-deployment.md` | Instalación (curl), perfiles, collision handling, CI/CD, team workflows, versionado |
| 7.5 | `opencode-integration.md` | 10 puntos de integración: agents, subagents, context, commands, skills, permisos, eventos |
| 7.6 | `profile-validation.md` | Perfiles, checklist de validación, reglas de asignación, errores comunes |
| 7.7 | `registry-and-profiles.md` | Registry v2.0.0, jerarquía de perfiles, tabla de inclusión, tools de validación |

---

## 8. Capacidades OCA para Hugo

OCA no sigue un flujo fijo de pasos. En lugar de eso, el usuario expresa una **intención** en lenguaje natural y OCA responde con la **capacidad** adecuada.

> **Regla de versiones**: Siempre la **última versión estable** de los componentes que sean requeridos. Hay que confirmar/verificar que sean **funcionales y no betas**. Aplica a Hugo, Wrangler, Node.js, npm, y cualquier otro componente.

### Catálogo de capacidades (resumen)

| # | Capacidad | Disparador (intención del usuario) | Artefacto OAC |
|---|-----------|-----------------------------------|---------------|
| C1 | Inicializar proyecto | "Crea un proyecto Hugo" | Directo (OCA) + `hugo-extended` |
| C2 | Crear/gestionar contenido | "Crea una página sobre X" | Subagente → `hugo-mcp` |
| C3 | Buscar/consultar contenido | "Busca artículos sobre Y" | Skill → `hugo-memex` |
| C4 | Indexar búsqueda | "Quiero buscador en el sitio" | Skill → `Pagefind` |
| C5 | Auditar SEO/AEO | "Audita el SEO" | Skills → `agentic-seo` + `seofor.dev` |
| C6 | Configurar tema | "Usa el tema X" | Directo (OCA) |
| C7 | Configurar CMS | "Quiero un CMS" | Skill → `Decap CMS` |
| C8 | Configurar módulos | "Añade SEO/iconos/PWA" | Contextos → `HugoMods` |
| C9 | Build + despliegue | "Despliega el sitio" | Comando → `wrangler` |
| C10 | Auditoría de calidad | "Hay enlaces rotos?" | Skill → `hugo-docs-mcp` (condicional) |

> **Detalle completo**: `recursos/flujos/01_capacidades-oca-hugo.md`

---

## 9. Artefactos: no todo son prompts (P)

### Principio

No todos los recursos del repositorio deben ser archivos de tipo "P" (prompt/instrucción). OAC ofrece **artefactos nativos** más potentes que los prompts planos.

### Tipos de artefactos OAC disponibles

| Artefacto OAC | Cuándo usarlo | Ejemplo en el contexto Hugo |
|---------------|---------------|----------------------------|
| **Context file** | Información de referencia, estándares, guías | `.opencode/external-context/hugo/` — documentación de Hugo |
| **Skill** | Comportamiento reutilizable con lógica | Un skill "hugo-init" que orquesta instalación + configuración |
| **Comando (slash command)** | Acción rápida invocable por el usuario | `/hugo-serve` para arrancar servidor de desarrollo |
| **Subagente** | Tarea especializada delegable | Un subagente "HugoConfigurator" para el diálogo interactivo de `hugo.toml` |
| **Workflow (context)** | Secuencia de pasos con decisiones | Capacidades C1-C10 (`recursos/flujos/01_capacidades-oca-hugo.md`) |
| **Prompt (P)** | Instrucción textual para el agente | No usado en REPOC — el usuario expresa intención en lenguaje natural |

### Filosofía

> **Los artefactos OAC (skills, contextos, comandos, subagentes) son la implementación. El usuario expresa su intención en lenguaje natural, OCA selecciona el artefacto adecuado.**

Ejemplo concreto para "Quiero crear una página de contacto":
- En lugar de un prompt estático con instrucciones → **capacidad C2**: OCA interpreta la intención, activa el subagente `HugoMCPSpecialist`, este invoca `hugo-mcp create_page("contacto", ...)`.
- No hay prompt de entrada, no hay workflow predefinido. OCA entiende la intención y ejecuta la capacidad correspondiente.

---

## 10. Lo que NO debo hacer (restricciones)

- ❌ **Crear contenido específico de un proyecto** (artículos reales sobre PYT/SWE)
- ❌ **Usar `/add-context`** ni crear archivos en `project-intelligence/`
- ❌ **Ejecutar comandos sin preguntar primero** (regla estricta de aprobación — approval gate)
- ❌ **Adelantarme a lo que el usuario pregunta** (responder solo a lo preguntado, sin información no solicitada)
- ❌ **Duplicar información entre archivos** (usar referencias y enlaces en lugar de copiar)
- ❌ **Auto-fixear errores** (reportar el error y pedir aprobación para solucionarlo)
- ❌ **Omitir la carga de contexto** antes de cualquier ejecución (bash/write/edit/task)

---

## 11. Lo que SÍ debo hacer (prioridades)

- ✅ **Crear templates y archetypes reutilizables** (que funcionen en cualquier proyecto clonado)
- ✅ **Configurar Hugo de forma genérica y parametrizable** (con valores editables)
- ✅ **Almacenar conocimiento externo** en `.opencode/external-context/hugo/` (Context7, ExternalScout, etc.)
- ✅ **Preguntar y esperar confirmación explícita** antes de ejecutar cualquier acción
- ✅ **Explicar paso a paso como tutorial** — sin saltos ni adelantos
- ✅ **Mantener la coherencia del contexto del proyecto**
- ✅ **Delegar a subagentes** cuando corresponda (ContextScout, ExternalScout, TaskManager, etc.)
- ✅ **Guardar enlaces y referencias** entre archivos en lugar de duplicar contenido
- ✅ **Usar artefactos OAC** (skills, contextos, comandos, subagentes) en lugar de prompts planos cuando sea más potente
- ✅ **Interacción dinámica** — preguntas adaptativas que dependen de respuestas previas del usuario, no cuestionarios estáticos
- ✅ **Mejorar y ajustar prompts existentes** para OCA, transformándolos en puntos de entrada que activen capacidades OAC más ricas

---

## 12. Estado actual de la conversación

| Aspecto | Estado |
|---------|--------|
| Identidad de OpenAgent | ✅ Establecida y comprendida |
| Stack tecnológico | ✅ Identificado (OAC + OpenCode + Hugo + Cloudflare) |
| Naturaleza del repositorio | ✅ Comprendida (base clonable, no proyecto específico) |
| Modelo REPOC → REPON | ✅ Comprendido (solo `.opencode/` + `recursos/` se heredan) |
| Reglas de interacción | ✅ Cargadas y asimiladas (español RAE, no inventar, no abreviar) |
| Regla de versiones | ✅ Corregida: "última versión estable, funcional y no beta" |
| Contexto externo OAC | ✅ 7 archivos leídos y procesados |
| Flujo Hugo | ✅ Reemplazado por modelo de capacidades (C1-C10) según intención del usuario |
| Artefactos OAC | ✅ Comprendido: no todo son prompts, usar skills/contextos/comandos |
| Restricciones | ✅ Claras y memorizadas |
| Acción ejecutada | ❌ Ninguna aún — todo ha sido formativo/teórico |

---

*Documento generado por OpenAgent como registro de entendimiento fundacional del proyecto.*
