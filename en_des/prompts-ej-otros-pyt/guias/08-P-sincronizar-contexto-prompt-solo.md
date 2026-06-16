# P-sincronizar-contexto — Sincronizar .opencode/context/ tras nueva guía

> **Propósito:** Sincronizar el sistema de contextos en `.opencode/context/` con la información generada por `03-P-crear-guia` o `04-P-actualizar-guia`, usando los comandos nativos de OpenAgentControl para extraer, organizar y validar el conocimiento.
> **Cuándo usarlo:** Inmediatamente después de ejecutar `03-P-crear-guia` (guía creada) o `04-P-actualizar-guia` (guía actualizada).
> **Última actualización:** 2026-06-12
> **Subagentes:** CodeReviewer, ContextScout, ContextOrganizer (vía comandos `/context`)
> **Destino de la actualización:** `.opencode/context/`

---

## INSTRUCCIONES PARA EL USUARIO — Cómo usar este prompt

### ¿Qué hace este prompt?

Toma una guía técnica recién creada o actualizada (por `03-P-crear-guia` o `04-P-actualizar-guia`) y sincroniza automáticamente el sistema de contextos del proyecto (`.opencode/context/`) para que refleje ese conocimiento.

El agente IA:

1. Lee la guía fuente y extrae los conceptos clave (términos, componentes, dependencias, configuraciones)
2. Descubre el estado actual de `.opencode/context/` para saber qué contextos ya existen
3. Usa los comandos OAC `/context extract`, `/context organize` y `/context validate` para sincronizar
4. Reporta qué se ha actualizado, creado o validado

### ¿Cuándo ejecutarlo?

| Si acabas de ejecutar... | Ejecuta esto... |
|--------------------------|-----------------|
| `03-P-crear-guia.md` → guía creada | ✅ `08-P-sincronizar-contexto.md` |
| `04-P-actualizar-guia.md` → guía actualizada | ✅ `08-P-sincronizar-contexto.md` |
| Ambos | ✅ Una vez por cada guía |

### ¿Cómo se ejecuta?

**Paso 1 — Copia todo el contenido del bloque «PROMPT»** (desde `--- INICIO DEL PROMPT ---` hasta `--- FIN DEL PROMPT ---`).

**Paso 2 — Pégalo como primer mensaje** en el chat del agente IA (OpenAgent, OpenCode, etc.).

**Paso 3 — Completa el campo obligatorio:**

```
Guía de referencia: [ruta al subdirectorio de la guía, ej: stage-management-system/conocimiento-guias-ia/workflow-engine/]
```

**Paso 4 (opcional) — Añade campos opcionales** si necesitas control adicional:

```
Tipo de guía: [creada | actualizada]     ← ayuda al agente a saber el alcance (creada=todo nuevo, actualizada=solo cambios)
Skip validate: [true | false]            ← true=omite la validación final (por defecto false)
```

**Paso 5 — El agente ejecutará las fases y te pedirá confirmación.**

### ¿Qué obtienes como resultado?

- Los conceptos de la guía extraídos e integrados en `.opencode/context/`
- Los archivos de contexto reorganizados si es necesario
- Validación de integridad del sistema de contextos
- Reporte detallado con fecha/hora de las acciones realizadas

### Requisitos

- **La guía debe existir** en `stage-management-system/conocimiento-guias-ia/` antes de ejecutar este prompt.
- **Los comandos `/context`** deben estar disponibles en el agente (son nativos de OpenAgentControl).

---

--- INICIO DEL PROMPT ---

# P-sincronizar-contexto — Sincronizar .opencode/context/ tras nueva guía

> **Propósito:** Sincronizar el sistema de contextos en `.opencode/context/` con la información generada por `03-P-crear-guia` o `04-P-actualizar-guia`, usando los comandos nativos de OpenAgentControl para extraer, organizar y validar el conocimiento.
> **Cuándo usarlo:** Inmediatamente después de ejecutar `03-P-crear-guia` (guía creada) o `04-P-actualizar-guia` (guía actualizada).
> **Subagentes:** CodeReviewer, ContextScout, ContextOrganizer (vía comandos `/context`)
> **Destino de la actualización:** `.opencode/context/`

---

## Instrucciones para el agente

Lee este prompt COMPLETO antes de actuar. Sigue todas las fases en orden. No asumas conocimiento previo — verifica todo contra los archivos reales.

### Reglas estrictas

1. **No ejecutes nada** hasta completar todas las lecturas y definiciones del plan.
2. **No modifiques archivos de contexto manualmente.** Usa los comandos `/context` para todas las operaciones sobre `.opencode/context/`.
3. **No asumas** conocimiento previo. Verifica contra la guía real y los contextos reales.
4. **Toda la información extraída debe estar respaldada** por el contenido de la guía. No inventes conceptos.
5. **Reporta** al final qué se ha extraído, organizado y validado, y qué necesita confirmación del usuario.

### Flujo general

```
Guía de referencia (03 o 04)
     ↓
F1: CodeReviewer extrae conceptos clave de la guía (términos, componentes, dependencias, configuraciones)
     ↓
F2: ContextScout descubre estado actual de .opencode/context/ (qué contextos existen, cuáles faltan)
     ↓
F3: Sincronización vía comandos OAC:
    3.1 /context extract  → extraer nuevo conocimiento al sistema de contextos
    3.2 /context organize → reorganizar contextos si es necesario
    3.3 /context validate → validar integridad del sistema
     ↓
F4: Reporte final con acciones realizadas + confirmación del usuario
```

---

## Entrada del usuario

El usuario indicará los siguientes campos. El **obligatorio** es imprescindible. Los **opcionales** se pueden omitir.

```
--- CAMPO OBLIGATORIO ---

Guía de referencia: [ruta al subdirectorio de la guía, ej: stage-management-system/conocimiento-guias-ia/workflow-engine/]

--- CAMPOS OPCIONALES ---

Tipo de guía: [creada | actualizada]
   creada     → la guía es nueva, todo su contenido es nuevo (por defecto)
   actualizada → la guía ya existía y se ha modificado, solo los cambios son nuevos

Skip validate: [true | false]
   true  → omite la validación final con /context validate
   false → ejecuta la validación (por defecto)
```

Usa esta información para guiar todas las fases.

---

## Fase 1 — Extracción de conceptos de la guía (CodeReviewer)

Delegar en CodeReviewer para analizar la guía fuente y extraer los conceptos clave que deben reflejarse en el sistema de contextos:

```
task(
  subagent_type="CodeReviewer",
  description="Extraer conceptos de guía [RUTA]",
  prompt="Lee los 3 documentos de la guía técnica ubicada en:
  [Guía de referencia]

   - 01-ficha-rapida.md
   - 02-arquitectura.md
   - 03-referencia-operativa.md

  Lee cada documento COMPLETAMENTE.

  Extrae y clasifica los siguientes conceptos clave que deberían reflejarse
  en el sistema de contextos del proyecto (.opencode/context/):

  1. TÉRMINOS Y DEFINICIONES: vocabulario específico del área que un agente IA
     debería conocer para trabajar con ella. Para cada término: nombre, definición breve.

  2. COMPONENTES: clases, servicios, módulos, interfaces, traits identificados.
     Para cada uno: nombre, propósito, ruta en el proyecto.

  3. FLUJOS PRINCIPALES: secuencias de operación, pipelines, procesos.
     Para cada flujo: nombre, descripción, actores involucrados.

  4. DEPENDENCIAS EXTERNAS: librerías, APIs, servicios de terceros.
     Para cada una: nombre, versión, propósito en el proyecto.

  5. CONFIGURACIÓN RELEVANTE: variables de entorno, entradas en config-wa.json,
     ui.json, .env, etc. que cualquier agente debería conocer.

  6. REGLAS DE SEGURIDAD: autenticación, autorización, validación específicas
     del área documentada.

  7. ERRORES CONOCIDOS: los fallos típicos y cómo evitarlos (para prevenirlos,
     no solo corregirlos).

  Para CADA concepto extraído, indica:
  - El concepto
  - El documento de origen (01, 02, o 03)
  - La sección dentro del documento
  - Una breve descripción (máximo 2 líneas)

  Si el Tipo de guía es 'actualizada', indica qué conceptos son NUEVOS
  respecto a los que ya existían antes de la actualización."
)
```

**Salida de Fase 1:** Lista estructurada de conceptos clasificados, con origen (documento + sección).

---

## Fase 2 — Estado actual de .opencode/context/ (ContextScout)

Delegar en ContextScout para descubrir el estado actual del sistema de contextos y determinar qué necesita cambios:

```
task(
  subagent_type="ContextScout",
  description="Descubrir estado de .opencode/context/",
  prompt="Analiza el estado actual del sistema de contextos en .opencode/context/.

  Identifica:

  1. ESTRUCTURA ACTUAL: lista de archivos de contexto existentes, organizados
     por subdirectorio (core/, project-intelligence/, development/, etc.)

  2. ÁREAS CUBIERTAS: qué áreas del proyecto tienen contexto actualmente

  3. ÁREAS NO CUBIERTAS: qué áreas del proyecto NO tienen contexto asociado

  4. CONTEXTO RELACIONADO CON LA GUÍA: busca específicamente archivos de contexto
     que mencionen o estén relacionados con el área descrita en la guía:
     [Guía de referencia]

  5. DUPLICACIONES: si el contenido de la guía ya existe parcial o totalmente
     en algún archivo de contexto existente

  6. UBICACIÓN RECOMENDADA: basado en la estructura actual, ¿dónde debería
     ubicarse el nuevo contexto? (sugerir subdirectorio y nombre de archivo)

  Devuelve:
  - Lista de contextos existentes relacionados con el área
  - Áreas sin cubrir que la guía podría llenar
  - Sugerencia de ubicación para el nuevo contexto
  - Si hay duplicación parcial con contexto existente, indicarlo"
)
```

**Salida de Fase 2:** Diagnóstico del estado actual de `.opencode/context/` vs la guía.

---

## Fase 3 — Sincronización vía comandos OAC

Con los conceptos extraídos (Fase 1) y el diagnóstico de estado actual (Fase 2), ejecutar los comandos OAC para sincronizar el sistema de contextos.

### 3.1 /context extract

Extraer el nuevo conocimiento de la guía al sistema de contextos:

```
/context extract from="[Guía de referencia]" target=".opencode/context/[ubicación recomendada]"
```

Este comando toma los conceptos identificados en Fase 1 y los convierte en archivos de contexto dentro de `.opencode/context/`. Se enruta automáticamente a ContextOrganizer.

**Si Tipo de guía = 'actualizada':** el comando debe aplicarse solo sobre los conceptos nuevos, no regenerar todo el contexto desde cero.

### 3.2 /context organize

Una vez extraídos los nuevos contextos, reorganizar la estructura si es necesario para mantener la coherencia:

```
/context organize [path=".opencode/context/" if-needed]
```

Este comando revisa la estructura de `.opencode/context/` y reorganiza los archivos si detecta que algún contexto nuevo debería estar en un subdirectorio diferente, si hay duplicaciones, o si la estructura general puede mejorarse.

**Nota:** solo reorganiza si es necesario. Si la estructura ya es correcta, el comando lo indicará sin hacer cambios.

### 3.3 /context validate (si Skip validate != true)

Validar la integridad del sistema de contextos tras los cambios:

```
/context validate [path=".opencode/context/"]
```

Este comando verifica:
- Que todos los archivos de contexto tengan metadatos válidos (fecha, versión, prioridad)
- Que no haya referencias rotas entre contextos
- Que la estructura sea coherente
- Que no haya duplicaciones de contenido

**Si la validación encuentra errores:** reportarlos al usuario con sugerencias de corrección. No corregir automáticamente sin aprobación.

---

## Fase 4 — Resumen y confirmación

Presentar al usuario un resumen con el siguiente formato:

```
## Sincronización de contexto completada

**Guía de referencia:** [ruta]
**Tipo:** [creada | actualizada]
**Fecha y hora:** [YYYY-MM-DD HH:MM]

### Conceptos extraídos

| Categoría | Cantidad | Documento origen |
|-----------|:--------:|------------------|
| Términos y definiciones | [n] | [01/02/03] |
| Componentes | [n] | [01/02/03] |
| Flujos principales | [n] | [02] |
| Dependencias externas | [n] | [02/03] |
| Configuración relevante | [n] | [03] |
| Reglas de seguridad | [n] | [02/03] |
| Errores conocidos | [n] | [03] |

### Acciones realizadas

| Acción | Comando | Resultado |
|--------|---------|-----------|
| Extraer contexto | /context extract | [archivos creados/actualizados] |
| Organizar contexto | /context organize | [cambios realizados / sin cambios] |
| Validar contexto | /context validate | [superada / errores encontrados] |

### Contextos afectados

- [ruta al archivo de contexto creado/actualizado]
- [ruta al archivo de contexto creado/actualizado]
- ...

### Observaciones

[Si hay duplicaciones, advertencias, o notas importantes]

¿Confirmas la publicación de estos cambios en el sistema de contextos?
```

--- FIN DEL PROMPT ---
