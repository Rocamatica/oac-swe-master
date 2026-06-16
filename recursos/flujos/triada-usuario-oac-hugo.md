# Tríada Usuario — OAC — Hugo

**Propósito**: Documento de flujo de trabajo que define cómo interactúan los tres actores del sistema para la creación y gestión de sitios web estáticos con Hugo, mediado enteramente por OpenAgents Control (OAC).

**Fecha**: 2026-06-16

**Versión**: 1.0

**Aplica a**: REPON (repositorio clonado donde vive el proyecto)

---

## Arquitectura de la tríada

```
┌──────────────┐    Instrucciones    ┌────────────────┐    Comandos      ┌──────────────┐
│              │   en lenguaje       │                │   y acciones     │              │
│   Usuario    │ ──────────────────► │  OpenAgent     │ ──────────────► │    Hugo      │
│              │                     │   (OAC / OCC)  │                  │   (SSG)      │
│              │ ◄────────────────── │                │ ◄────────────── │              │
│              │   Resultados,       │                │   Output,       │              │
│              │   preguntas,        │                │   errores       │              │
│              │   confirmaciones    │                │                 │              │
└──────────────┘                     └────────────────┘                 └──────────────┘
       ▲                                    │                                  │
       │                                    │                                  │
       │                           ┌────────▼─────────┐                       │
       │                           │   Artefactos OAC  │                       │
       │                           │  (skills, comandos,│                      │
       │                           │   subagentes,      │                      │
       │                           │   contextos)       │                      │
       │                           └───────────────────┘                      │
       │                                                                      │
       └────────────────────── Contexto del proyecto ─────────────────────────┘
```

---

## Roles

### Usuario

| Atributo | Descripción |
|----------|-------------|
| **Lenguaje** | Natural (español de España, RAE) |
| **Acción principal** | Indicar qué quiere hacer |
| **Forma de trabajo** | Responde preguntas, confirma planes, aprueba ejecución |
| **No hace** | No ejecuta comandos directamente. No toca archivos de configuración manualmente |
| **Interacción** | Exclusivamente con OpenAgent |

### OpenAgent (OAC / OCC)

| Atributo | Descripción |
|----------|-------------|
| **Rol** | Orquestador y ejecutor delegado |
| **Tipo** | Agente universal primario de OAC v0.7.1 |
| **Acción principal** | Recibir instrucciones, planificar, preguntar, ejecutar, validar, resumir |
| **Herramientas** | Subagentes (ContextScout, ExternalScout, TaskManager, CoderAgent, etc.), skills, comandos, contextos |
| **No hace** | Actuar sin aprobación. Auto-fixear errores. Saltarse pasos |
| **Destino** | REPON (repositorio del proyecto) |

### Hugo (SSG)

| Atributo | Descripción |
|----------|-------------|
| **Rol** | Generador de sitio web estático |
| **Acción principal** | Ejecutar comandos: `hugo new site`, `hugo server`, `hugo --minify --gc` |
| **Interacción** | Solo recibe comandos de OAC (nunca del usuario directamente) |
| **Dependencia** | Binario "extended", última versión estable y funcional |

---

## Ciclo de vida del flujo

### Inicio de sesión

```
Usuario abre OCA en REPON
    │
    ▼
Usuario lanza 01-P-iniciar-sitio-hugo.md  ← PRIMERA ACCIÓN
    │
    ▼
Comienza el flujo de trabajo
```

### Flujo general (macro-ciclo)

```
1. Usuario indica objetivo (lenguaje natural)
    │
    ▼
2. OpenAgent analiza y descubre contexto
    │   ├── ContextScout → .opencode/context/
    │   └── ExternalScout → .opencode/external-context/
    │
    ▼
3. OpenAgent propone plan y pregunta
    │
    ▼
4. Usuario confirma o ajusta
    │
    ▼
5. OpenAgent ejecuta (directo o delegando)
    │   ├── Bash para comandos Hugo
    │   ├── Edit/Write para archivos
    │   └── Task/CoderAgent para tareas complejas
    │
    ▼
6. OpenAgent valida resultado
    │
    ▼
7. OpenAgent resume y confirma con usuario
    │
    ▼
8. ¿Siguiente objetivo? → volver a 1
    │
    ▼
   FIN
```

### Flujo específico — Inicializar Hugo (pasos 1-3)

```
INICIO: Usuario lanza 01-P-iniciar-sitio-hugo.md
    │
    ▼
┌───────────────────────────────────────────────────┐
│ FASE 1: Verificar/Instalar Hugo                    │
│                                                    │
│ 1. OpenAgent comprueba si Hugo está instalado      │
│ 2. Si no → instala última versión estable          │
│ 3. Si sí → verifica que sea la última estable      │
│ 4. Confirma al usuario                             │
└───────────────────────────────────────────────────┘
    │
    ▼
┌───────────────────────────────────────────────────┐
│ FASE 2: Interacción dinámica (recopilar datos)     │
│                                                    │
│ OpenAgent pregunta (una a una, de forma adaptativa):│
│                                                    │
│ 1. "¿Nombre del proyecto?"                         │
│    → Define el nombre para hugo new site           │
│                                                    │
│ 2. "¿Título del sitio?"                            │
│    → Título que aparecerá en el navegador          │
│                                                    │
│ 3. "¿Base URL?"                                    │
│    → URL donde se publicará el sitio               │
│    (si el usuario duda, se explica o se deja       │
│     valor por defecto)                             │
│                                                    │
│ 4. "¿Idioma principal?"                            │
│    → locale (es-es, en, etc.)                      │
│                                                    │
│ 5. "¿Descripción para SEO?"                        │
│    → meta description global                       │
│                                                    │
│ [Cada respuesta puede generar                     │
│  preguntas dependientes adicionales]               │
│                                                    │
│ Cuando todo está completo:                         │
└───────────────────────────────────────────────────┘
    │
    ▼
┌───────────────────────────────────────────────────┐
│ FASE 3: Crear proyecto + hugo.toml                 │
│                                                    │
│ 1. OpenAgent ejecuta: hugo new site <nombre>       │
│ 2. OpenAgent escribe hugo.toml con datos           │
│ 3. OpenAgent verifica estructura creada            │
│ 4. OpenAgent confirma al usuario                   │
└───────────────────────────────────────────────────┘
    │
    ▼
SIGUIENTE: Continuar con paso 4 (layouts) del flujo Hugo
```

---

## Principios de la tríada

| Principio | Descripción |
|-----------|-------------|
| **Mediación total** | Toda interacción con Hugo pasa por OAC. El usuario no toca Hugo directamente |
| **Aprobación explícita** | OpenAgent no ejecuta nada sin confirmación del usuario |
| **Paso a paso** | Una cosa a la vez, sin adelantarse. El usuario guía el ritmo |
| **Preguntas adaptativas** | Las preguntas de OpenAgent dependen de las respuestas del usuario, no son un cuestionario fijo |
| **Contexto primero** | Antes de ejecutar, OpenAgent carga contexto relevante (ContextScout + ExternalScout) |
| **Validación continua** | Cada paso se valida antes de pasar al siguiente |
| **No duplicación** | Cada contenido existe una sola vez. Se usan referencias entre archivos |
| **REPOC → REPON** | El repositorio clonable aporta la fábrica (`.opencode/` + `recursos/`). El clonado es el proyecto |

---

## Artefactos OAC en la tríada

| Artefacto | Función en la tríada |
|-----------|---------------------|
| **Prompt (P)** | Punto de entrada que el usuario lanza para iniciar un flujo |
| **Context file** | Información de referencia que OpenAgent carga para tomar decisiones |
| **Skill** | Comportamiento reutilizable que OpenAgent ejecuta (ej: `hugo-search-index`, `hugo-seo-audit`) |
| **Comando (slash)** | Acción rápida invocable por el usuario dentro de la sesión (ej: `/hugo-install`, `/hugo-serve`) |
| **Subagente** | Especialista al que OpenAgent delega una tarea concreta (ej: `HugoMCPSpecialist` que invoca hugo-mcp) |
| **Workflow** | Secuencia de pasos con lógica condicional que OpenAgent sigue |
| **MCP Server** | Servidor externo (hugo-mcp, hugo-memex) al que OCA delega vía subagente para CRUD de contenido y búsqueda semántica |
| **Módulo Hugo** | Módulo del ecosistema HugoMods que OCA configura en `hugo.toml` para SEO, imágenes, PWA, etc. |
| **Herramienta CLI** | Ejecutable externo (Pagefind, agentic-seo, seofor.dev) que OCA invoca como parte del workflow |

### Mapa de delegación

```
OCA recibe instrucción del usuario
    │
    ├── ¿Es instalar/configurar? → Comando / Contexto
    ├── ¿Es crear/editar contenido? → Subagente → hugo-mcp (MCP)
    ├── ¿Es buscar/consultar contenido? → Skill → hugo-memex (MCP)
    ├── ¿Es auditar calidad? → Skill → agentic-seo / seofor.dev
    ├── ¿Es indexar búsqueda? → Skill → Pagefind
    ├── ¿Es configurar CMS? → Skill → Decap CMS
    └── ¿Es configurar módulo? → Context file → HugoMods
```

**Principio**: OCA nunca ejecuta comandos Hugo crudos si existe una skill/herramienta que lo haga mejor. El usuario siempre habla con OCA, y OCA decide qué artefacto o subagente invocar.

---

## Ejemplo de interacción real (diálogo)

```
Usuario:   "Voy a iniciar un sitio Hugo nuevo"
OpenAgent: "Perfecto. Voy a preparar el entorno.
            Primero, ¿qué nombre quieres para el proyecto?"
Usuario:   "mi-blog"
OpenAgent: "Vale. ¿Y el título del sitio?"
Usuario:   "Mi Blog Personal"
OpenAgent: "¿Tienes ya un dominio donde publicarlo? (base URL)"
Usuario:   "Todavía no"
OpenAgent: "De acuerdo, lo dejamos en blanco y lo configuramos después.
            ¿Idioma principal del sitio?"
... (continúa)
```

---

## Referencias

- `recursos/prompts/01-P-iniciar-sitio-hugo.md` — Prompt de entrada
- `en_des/preparacion-inicial/notas/01-flujo-trabajo-hugo.md` — Flujo técnico Hugo
- `en_des/preparacion-inicial/reglas-oac-hugo.md` — Reglas de interacción
- `recursos/recapitulacion-entendimiento-openagent.md` — Documento fundacional
- `recursos/seleccion-herramientas-hugo-oac.md` — Catálogo de herramientas seleccionadas para delegación OAC
- `recursos/flujos/interaccion-dinamica-inicializar-hugo.md` — Árbol de preguntas adaptativas
- `.opencode/external-context/hugo/` — Contexto externo de Hugo

---

*Documento generado por OpenAgent como parte del marco de trabajo de la tríada Usuario-OAC-Hugo*
