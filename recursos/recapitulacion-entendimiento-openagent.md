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

Regla fundamental y transversal (extraída de `en_des/preparacion-inicial/reglas-oac-hugo.md`):

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
| G7 | **Explicar como tutorial paso a paso**. No adelantarse a lo que el usuario pregunta. Responder solo a lo preguntado, sin información no solicitada | `reglas-oac-hugo.md` |
| G8 | **No ejecutar sin preguntar ni confirmar**. Antes de cualquier acción (instalar, modificar, crear archivos), preguntar primero y esperar confirmación explícita | `reglas-oac-hugo.md` |
| G9 | **Guardar el conocimiento obtenido** de Context7, ExternalScout o cualquier fuente externa en `.opencode/external-context/<tema>/` para que esté disponible en consultas futuras | `reglas-oac-hugo.md` |
| G10 | **OAC gestiona todo el trabajo con Hugo**. El usuario interactúa exclusivamente con OAC. OAC gestiona instalación, configuración, contenido, build y despliegue. Todo cambio se canaliza a través de OAC | `reglas-oac-hugo.md` |
| G11 | **No duplicar información**. Cada contenido una sola vez en un único archivo. Si un contenido es necesario desde otro lugar, usar referencias (enlaces, citas) sin copiar | `reglas-oac-hugo.md` |
| G12 | **Preparar OAC primero**. Antes de gestionar Hugo, verificar que el contexto está completo en `.opencode/external-context/hugo/` y que no hay gaps | `reglas-oac-hugo.md` |

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
├── prompts/              → Directorio para prompts reutilizables
└── ...                   → Otros recursos (skills, templates, etc.)
```

### Lo que SOLO existe en REPOC (no se hereda)

```
en_des/                            ← NO SE HEREda
└── preparacion-inicial/
    ├── notas/             → Investigación, análisis, flujos de trabajo
    ├── reglas-oac-hugo.md → Reglas de interacción OAC+Hugo
    ├── legado/            → Análisis previos descartados
    └── ...
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

## 8. Contenido del flujo Hugo

Workflow completo de 10 pasos (extraído de `01-flujo-trabajo-hugo.md`) para levantar un sitio Hugo desde cero en REPON:

> **Regla de versiones**: Siempre la **última versión estable** de los componentes que sean requeridos. Hay que confirmar/verificar que sean **funcionales y no betas**. Aplica a Hugo, Wrangler, Node.js, npm, y cualquier otro componente.

1. **Instalar Hugo** — Última versión estable (no betas, no RCs). Verificar antes si está instalado y si es la versión correcta.
2. **Crear proyecto** — `hugo new site <nombre>`. El usuario proporciona el nombre.
3. **Configurar `hugo.toml`** — No es un cuestionario estático. Debe ser una **interacción dinámica**: a medida que el usuario responde y proporciona información, se generan preguntas dependientes de las respuestas dadas, siempre dentro del marco de lo que va en `hugo.toml` (`baseURL`, `locale`, `title`, `params`, etc.).
4. **Crear layouts** — `baseof.html`, `partials/` (head, header, footer), `home.html`, `single.html`, `list.html`
5. **Configurar Hugo Pipes** — CSS (`assets/css/main.css`) y JS (`assets/js/main.js`) con minificación + fingerprint en producción
6. **Crear archetypes** — `default.md` y `posts.md` con frontmatter reutilizable
7. **Crear contenido de prueba** — `_index.md`, `posts/_index.md`, `posts/mi-primer-articulo.md`
8. **Servidor de desarrollo** — `hugo server -D` con LiveReload en `localhost:1313`
9. **Build de producción** — `hugo --minify --gc` (minifica + garbage collection)
10. **Despliegue Cloudflare** — `wrangler pages project create` (primera vez) → `hugo --minify --gc && wrangler pages deploy public/`

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
| **Workflow (context)** | Secuencia de pasos con decisiones | Workflow de 10 pasos definido en contexto que yo sigo como OpenAgent |
| **Prompt (P)** | Instrucción textual para el agente | `01-P-iniciar-sitio-hugo.md` como punto de entrada |

### Filosofía

> **Los prompts (P) son el punto de entrada. Los artefactos OAC (skills, contextos, comandos, subagentes) son la implementación.**

Ejemplo concreto para los pasos 2-3 (configurar `hugo.toml`):
- En lugar de un prompt estático con preguntas fijas → **interacción dinámica**: el usuario responde, y según sus respuestas, se generan preguntas dependientes, siempre dentro del marco de `hugo.toml`.
- Esto puede implementarse como un workflow que yo (OpenAgent) ejecuto interactivamente, apoyado por contextos y subagentes si es necesario.

### El rol del prompt `01-P-iniciar-sitio-hugo.md`

- Es el **punto de entrada** que activa el inicio del trabajo en una sesión de OCA
- Marca el inicio del **framework de configuración de Hugo en REPON**
- Debe ser **mejorado y ajustado para OCA**: no es una instrucción plana, sino el disparador de una secuencia interactiva que usa artefactos OAC
- El usuario lo activa como **primera acción** en una sesión de OCA

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
| Flujo Hugo | ✅ 10 pasos conocidos con correcciones |
| Artefactos OAC | ✅ Comprendido: no todo son prompts, usar skills/contextos/comandos |
| Restricciones | ✅ Claras y memorizadas |
| Acción ejecutada | ❌ Ninguna aún — todo ha sido formativo/teórico |

---

*Documento generado por OpenAgent como registro de entendimiento fundacional del proyecto.*
