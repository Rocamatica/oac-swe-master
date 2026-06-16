# P-tematicas-guia — Detectar áreas del proyecto candidatas a documentar

> **Propósito:** Analizar el código fuente del proyecto para identificar áreas, componentes, módulos y funcionalidades que deberían tener guía técnica en `conocimiento-guias-ia/`.
> **Cuándo usarlo:** Para generar o actualizar el inventario de áreas (ej: al inicio del proyecto, al añadir funcionalidades grandes, o periódicamente).
> **Última actualización:** 2026-06-12
> **Destino del informe:** `stage-management-system/conocimiento-guias-ia/inventario-areas.md`
> **Subagentes:** explore (rápido), ContextScout, CodeReviewer (paralelo por área), ContextRetriever

---

## INSTRUCCIONES PARA EL USUARIO — Cómo usar este prompt

### ¿Qué hace este prompt?

Escanea todo el proyecto y genera un **inventario de áreas candidatas a documentar**, clasificadas por prioridad. Cada entrada incluye la descripción precisa para usarla directamente como input del prompt `P-crear-guia`.

El agente IA:

1. Mapea la estructura completa del proyecto (rápido, con explore)
2. Descubre contextos y guías existentes
3. Analiza cada módulo/área (en paralelo cuando es posible)
4. Clasifica por prioridad (Alta / Media / Baja / Ya tiene guía)
5. Genera el inventario con descripciones listas para `P-crear-guia`

### ¿Cómo se ejecuta?

**Paso 1 — Copia todo el contenido del bloque «PROMPT»** (desde `--- INICIO DEL PROMPT ---` hasta `--- FIN DEL PROMPT ---`).

**Paso 2 — Pégalo como primer mensaje** en el chat del agente IA (OpenAgent, OpenCode, etc.).

**Paso 3 (opcional) — Añade el campo opcional** si necesitas control adicional:

```
Scope: [full | incremental]     ← full=escanea todo (por defecto), incremental=solo áreas nuevas o modificadas desde el último inventario
```

**Paso 4 — El agente ejecutará el escaneo y te presentará el inventario generado.**

### ¿Qué obtienes como resultado?

- `stage-management-system/conocimiento-guias-ia/inventario-areas.md` actualizado
- Áreas clasificadas por prioridad con tablas
- Para cada área sin guía: el texto exacto para copiar y pegar como entrada de `P-crear-guia`
- Recomendaciones priorizadas de qué documentar primero

### Consideraciones

- **La primera ejecución (full)** puede tomar tiempo porque escanea todo el proyecto.
- **Ejecuciones incrementales** son más rápidas: solo analizan áreas nuevas o modificadas.
- **El informe generado sobreescribe el anterior.** Si quieres conservar un histórico, usa git.
- **Las descripciones generadas** son deliberadamente detalladas para que `P-crear-guia` pueda trabajar sin ambigüedad.

---

--- INICIO DEL PROMPT ---

# P-tematicas-guia — Detectar áreas del proyecto candidatas a documentar

> **Propósito:** Analizar el código fuente del proyecto para identificar áreas, componentes, módulos y funcionalidades que deberían tener guía técnica en `conocimiento-guias-ia/`.
> **Cuándo usarlo:** Para generar o actualizar el inventario de áreas.
> **Destino del informe:** `stage-management-system/conocimiento-guias-ia/inventario-areas.md`
> **Subagentes:** explore (rápido), ContextScout, CodeReviewer (paralelo por área), ContextRetriever

---

## Instrucciones para el agente

Lee este prompt COMPLETO antes de actuar. Sigue todas las fases en orden. No asumas conocimiento previo — verifica todo contra el código y los archivos.

### Reglas estrictas

1. **No ejecutes nada** hasta completar todas las lecturas y definiciones del plan.
2. **No asumas** conocimiento previo. Verifica contra el código real.
3. **Toda la información debe estar respaldada** por el código, la configuración o la documentación existente. No inventes.
4. **Optimiza el uso de subagentes:** usa explore para el barrido estructural (rápido) y CodeReviewer solo para el análisis profundo de cada área.
5. **Paraleliza** los análisis de CodeReviewer cuando las áreas sean independientes.
6. **Reporta** al final el número de áreas detectadas, clasificadas y el tiempo estimado de ejecución.

### Flujo general

```
F1.0: explore → mapea estructura completa del proyecto (rápido)
  ↓
F1.1: ContextScout → descubre contextos y guías ya existentes
  ↓
F1.2: CodeReviewer (PARALELO, un task por área) → analiza cada módulo
  ↓
F1.3: ContextRetriever → recupera fragmentos de contexto específicos
  ↓
F2: OpenAgent → sintetiza, clasifica por prioridad, genera inventario
  ↓
F3: Guarda inventario-areas.md + muestra resumen al usuario
```

---

## Entrada del usuario

El usuario puede proporcionar un campo opcional. Si no se proporciona, se usa el valor por defecto.

```
--- CAMPO OPCIONAL ---

Scope: [full | incremental]
   full        → escanea todo el proyecto (por defecto). Usar en la primera
                 ejecución o cuando se quiera regenerar el inventario completo.
   incremental → solo analiza áreas nuevas o modificadas desde el último
                 inventario registrado en inventario-areas.md.
                 Requiere que el archivo exista para comparar.
```

Usa esta información para guiar todas las fases.

---

## Fase 1 — Investigación y Análisis

### 1.0 Exploración estructural (explore)

Delegar en el agente explore para mapear la estructura completa del proyecto. Este paso es rápido y da la visión general necesaria para las fases siguientes:

```
task(
  subagent_type="explore",
  description="Mapear estructura del proyecto",
  prompt="Explora el proyecto completo con nivel de profundidad 'very thorough'.

  Identifica y devuelve una estructura organizada con:

  1. CAPA DE APLICACIÓN (src/):
     - Lista de directorios principales (cada uno es un módulo/área candidata)
     - Para cada directorio: número de archivos, tipos (clases, interfaces, traits)
     - Archivos principales con ruta completa

  2. SCRIPTS EJECUTABLES (bin/):
     - Lista de scripts con ruta y propósito

  3. PUNTOS DE ENTRADA WEB (public/):
     - Scripts PHP, formularios, assets
     - Excluir directorios estándar (css/, js/, img/, libs/, vendor/)

  4. TEMPLATES/VISTAS (templates/):
     - Lista de directorios de templates

  5. TESTS (tests/):
     - Estructura de tests, qué módulos cubren

  6. CONFIGURACIÓN:
     - Archivos de configuración principales (config-wa.json, ui.json, .env.example)

  7. CAMBIOS RECIENTES:
     - git log --oneline -5 (para contexto general)

  Devuelve la información estructurada para que pueda ser usada como índice
  de las áreas a analizar en profundidad. No incluyas el contenido de los
  archivos, solo su ubicación y propósito."
)
```

### 1.1 ContextScout — Contextos y guías existentes

Antes de analizar el código, descubrir qué contextos y guías ya existen para evitar recomendar documentar áreas ya cubiertas:

```
task(
  subagent_type="ContextScout",
  description="Contextos y guías existentes",
  prompt="Lista todos los archivos de contexto y guías disponibles en el proyecto.

  Busca en estas ubicaciones:
  1. .opencode/context/ — todo el árbol de contexto
  2. stage-management-system/conocimiento-guias-ia/ — guías técnicas existentes
  3. stage-management-system/conocimiento-guias-ia/inventario-areas.md — inventario previo (si existe)

  Para cada archivo encontrado, indica:
  - Ruta completa
  - Área del sistema que cubre
  - Propósito (1 línea)

  Si el inventario previo (inventario-areas.md) existe y el usuario seleccionó
  Scope: incremental, léelo y extrae la lista de áreas YA documentadas para
  evitar recomendar duplicados.

  Identifica áreas del sistema que NO tienen contexto ni guía asociados.

  Devuelve:
  1. Lista de guías existentes con ruta y área
  2. Lista de contextos existentes en .opencode/context/ con ruta y área
  3. Lista de áreas detectadas que NO tienen guía (basado en el inventario previo si existe)
  4. Si Scope=incremental: lista de áreas nuevas o modificadas respecto al inventario previo
     (basado en cambios en git log y estructura de directorios)"
)
```

### 1.2 CodeReviewer — Análisis por áreas (paralelo)

A partir de la estructura descubierta en 1.0 y las áreas sin guía de 1.1, lanzar **un task de CodeReviewer por cada área independiente** en paralelo.

Para cada área, usar este template:

```
task(
  subagent_type="CodeReviewer",
  description="Analizar módulo [NOMBRE_MODULO]",
  prompt="Analiza el módulo [NOMBRE_MODULO] del proyecto en la ruta [RUTA].

  Identifica y extrae:

  1. NOMBRE DEL MÓDULO: nombre descriptivo en inglés (kebab-case)
  2. PROPÓSITO: qué hace, 1-2 líneas
  3. ARCHIVOS: lista de archivos que componen el módulo (clases, interfaces, traits,
     tests, configuraciones, templates, assets) con ruta completa
  4. CLASES PRINCIPALES: cada clase/interface con su propósito y línea de definición
  5. DEPENDENCIAS EXTERNAS: librerías de terceros con versión (de composer.json)
  6. DEPENDENCIAS INTERNAS: otros módulos del proyecto que importa
  7. COMPLEJIDAD: baja (1 clase, autónomo) / media (2-4 clases) / alta (5+ clases)
     / muy alta (10+ clases con dependencias cruzadas)
  8. CONFIGURACIÓN: variables de .env, entradas en config-wa.json/ui.json que afectan al módulo
  9. SEGURIDAD: requisitos de autenticación, autorización, validación
  10. SI YA TIENE GUÍA: buscar en stage-management-system/conocimiento-guias-ia/
  11. PRIORIDAD SUGERIDA: qué tan útil sería tener una guía para este módulo
      (alta / media / baja) según: número de clases, dependencias, complejidad,
      uso por otros módulos, criticidad para el sistema

  Para cada clase/interface, indica archivo y línea de la definición.
  Para las dependencias externas, indica la versión exacta."
)
```

**Reglas de paralelización:**
- Los análisis de áreas independientes (sin dependencias entre sí) se lanzan **simultáneamente**.
- Ejemplo de lotes paralelizables:
  - `Auth/` + `Middleware/` + `I18n/` + `WooCommerce/` → todos independientes
  - `Workflow/Stages/` + `Workflow/Services/` → dependientes, ejecutar secuencial
- Usa el criterio: si el módulo A importa del módulo B, analizar B primero.

### 1.3 ContextRetriever — Contextos específicos de áreas detectadas

Para las áreas de prioridad alta y media detectadas, recuperar fragmentos de contexto específicos que ayuden a clasificar mejor:

```
task(
  subagent_type="Context Retriever",
  description="Recuperar contextos para áreas detectadas",
  prompt="Para las siguientes áreas del proyecto que han sido identificadas como
  candidatas a documentar, busca fragmentos de contexto relevantes:

  [LISTA DE ÁREAS DE PRIORIDAD ALTA Y MEDIA]

  Para cada área, busca en .opencode/context/ y stage-management-system/:
  1. ¿Hay estándares específicos que apliquen? (security-patterns, code-quality)
  2. ¿Hay reglas del proyecto (AGENTS.md RG) que afecten al área?
  3. ¿Hay entradas en .gobernanza/inventario_recursos.yaml relacionadas?
  4. ¿Hay decisiones de arquitectura documentadas sobre esta área?

  Para cada fragmento encontrado, indica:
  - Área a la que aplica
  - Archivo de origen y líneas
  - Relevancia para la documentación futura"
)
```

---

## Fase 2 — Clasificación y priorización (OpenAgent)

Sintetiza toda la información recopilada de las fases 1.0 a 1.3. Sigue estos pasos:

### 2.1 Consolidar el listado de áreas

Para cada área detectada, combina:
- Información estructural de explore (1.0)
- Estado de guías existentes de ContextScout (1.1)
- Análisis detallado de CodeReviewer (1.2)
- Fragmentos de contexto de ContextRetriever (1.3)

### 2.2 Aplicar criterios de prioridad

| Prioridad | Criterio |
|-----------|----------|
| **Alta** | Módulo con 5+ clases, dependencias externas, usado por otros módulos, sin guía actual, crítico para el sistema |
| **Media** | Módulo con 2-4 clases, dependencias internas, funcionalidad específica, útil pero no crítico |
| **Baja** | Módulo pequeño (1 clase), autónomo, bien documentado en comentarios o código autoexplicativo |
| **Ya tiene guía** | Ya existe guía en `stage-management-system/conocimiento-guias-ia/` |
| **No aplica** | Directorio de soporte (vendor, assets, libs externas) o código legacy no relevante |

### 2.3 Si Scope=incremental: detectar cambios

Comparar el inventario generado con el anterior (si existe) para detectar:
- **Áreas nuevas**: no estaban en el inventario previo
- **Áreas modificadas**: han cambiado (nuevos archivos, commits recientes, cambios de estructura)
- **Áreas eliminadas**: ya no existen en el código
- **Áreas sin cambios**: idénticas al inventario previo

Solo incluir en el informe las áreas nuevas y modificadas. Las áreas sin cambios se mencionan en un apartado "Sin cambios desde el último inventario".

---

## Fase 3 — Generación del informe

### 3.1 Guardar inventario-areas.md

Generar y guardar el archivo en:

```
Ruta: stage-management-system/conocimiento-guias-ia/inventario-areas.md
```

### Formato de salida

```
# Inventario de áreas del PYT para documentar

> **Generado por:** P-tematicas-guia
> **Fecha y hora:** [YYYY-MM-DD HH:MM]
> **Scope:** [full | incremental]
> **Total áreas detectadas:** [n]

---

## Prioridad ALTA

| Área | Ruta | Archivos | Complejidad | Dependencias externas |
|------|------|:--------:|:-----------:|-----------------------|
| [nombre] | [ruta] | [n] | [alta/muy alta] | [librerías] |

## Prioridad MEDIA

| Área | Ruta | Archivos | Complejidad | Dependencias externas |
|------|------|:--------:|:-----------:|-----------------------|
| [nombre] | [ruta] | [n] | [media] | [librerías] |

## Prioridad BAJA

| Área | Ruta | Archivos | Complejidad | Dependencias externas |
|------|------|:--------:|:-----------:|-----------------------|
| [nombre] | [ruta] | [n] | [baja] | [librerías] |

## Ya tienen guía

| Área | Ubicación de la guía |
|------|---------------------|
| [nombre] | stage-management-system/conocimiento-guias-ia/[area]/ |

## Áreas sin cambios desde el último inventario (solo en modo incremental)

| Área | Última modificación |
|------|---------------------|
| [nombre] | [fecha] |

---

## Secciones para ejecutar P-crear-guia

Para cada área SIN guía (prioridad alta y media, más baja si aplica), generar el texto exacto que el usuario debe copiar y pegar como entrada del prompt `P-crear-guia`. Cada entrada debe ser descriptiva e incluir las clases, archivos y dependencias identificadas en el análisis.

Formato de cada entrada:

### [Área]

**Área a documentar:** [descripción del área, clases principales, archivos clave,
dependencias internas y externas. Suficiente contexto para que P-crear-guia
pueda investigar sin ambigüedad. Máximo 15 líneas.]

---

## Recomendaciones

- **[Área X]**: crear guía (prioridad [alta/media/baja], justificación)
- **[Área Y]**: actualizar guía (existe pero incompleta o desactualizada)
- ...

## Resumen

- **Total áreas detectadas:** [n]
- **Sin guía:** [n] (alta: [n], media: [n], baja: [n])
- **Con guía:** [n]
- **Próximo paso recomendado:** [sugerencia de qué área documentar primero y por qué]
```

--- FIN DEL PROMPT ---
