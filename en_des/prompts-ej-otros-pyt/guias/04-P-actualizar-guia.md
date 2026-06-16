# P-actualizar-guia — Actualizar guía técnica existente

> **Propósito:** Actualizar los 3 documentos de guía técnica (ficha rápida, arquitectura, referencia operativa) de una parte del proyecto tras modificaciones en la funcionalidad.
> **Cuándo usarlo:** Al modificar o mejorar una función existente del proyecto cuya guía ya fue creada.
> **Última actualización:** 2026-06-12
> **Destino:** `stage-management-system/conocimiento-guias-ia/[area-descriptiva]/` (mismo directorio de la guía original)
> **Subagentes:** explore, ContextScout, ExternalScout (si aplica), ContextRetriever, CodeReviewer, TechnicalWriter, ContextOrganizer, TaskManager (opcional), BuildAgent (opcional)

---

## INSTRUCCIONES PARA EL USUARIO — Cómo usar este prompt

### ¿Qué hace este prompt?

Este prompt actualiza los 3 documentos de una guía técnica existente (`01-ficha-rapida.md`, `02-arquitectura.md`, `03-referencia-operativa.md`) tras cambios en la funcionalidad. El agente IA:

1. Lee la guía actual y diagnostica qué ha cambiado
2. Investiga el código y el contexto del proyecto
3. Sintetiza solo los cambios necesarios
4. Actualiza los documentos preservando las secciones no afectadas
5. Revisa la calidad y la coherencia global

### ¿Cómo se ejecuta?

**Paso 1 — Copia todo el contenido del bloque «PROMPT»** (desde la línea `--- INICIO DEL PROMPT ---` hasta `--- FIN DEL PROMPT ---`).

**Paso 2 — Pégalo como primer mensaje** en el chat del agente IA (OpenAgent, OpenCode, etc.).

**Paso 3 — Completa los campos obligatorios** en la sección de entrada del usuario:

```
Área a actualizar: [nombre exacto del subdirectorio en conocimiento-guias-ia/]
Cambios realizados: [descripción detallada de lo que cambió en el código]
```

**Paso 4 (opcional) — Añade campos opcionales** si necesitas control adicional:

```
Complejidad: [normal | alta]                      ← normal=flujo estándar, alta=activa TaskManager para descomponer
Writer override: [DocWriter | TechnicalWriter]     ← fuerza el escritor (por defecto se elige automáticamente según perfil)
Skip BuildAgent: [true | false]                    ← true=omite validación de ejemplos de código (por defecto false)

NOTA: Sigue leyendo, especialmente "Consideraciones".
```

**Paso 5 — El agente ejecutará las fases y te pedirá confirmación** al final.

### ¿Qué obtienes como resultado?

- Los 3 documentos actualizados en `stage-management-system/conocimiento-guias-ia/[area]/`
- Un resumen de cambios aplicados por documento
- Una revisión de calidad (CodeReviewer)
- Una verificación de coherencia global (ContextOrganizer)
- Validación opcional de ejemplos de código (BuildAgent)

### Consideraciones

- **No modifiques los nombres de archivo** (`01-ficha-rapida.md`, `02-arquitectura.md`, `03-referencia-operativa.md`) — son fijos.
- **El agente solo actualiza lo que ha cambiado.** Las secciones no afectadas se preservan intactas.
- **Si el área es muy extensa** (múltiples subsistemas, 5+ archivos), usa `Complejidad: alta` para activar TaskManager.
- **Si el contenido es muy técnico** (protocolos, APIs de bajo nivel), el agente usará TechnicalWriter automáticamente. Puedes forzarlo con `Writer override: TechnicalWriter`.

---

--- INICIO DEL PROMPT ---

# P-actualizar-guia — Actualizar guía técnica existente

> **Propósito:** Actualizar los 3 documentos de guía técnica (ficha rápida, arquitectura, referencia operativa) de una parte del proyecto tras modificaciones en la funcionalidad.
> **Cuándo usarlo:** Al modificar o mejorar una función existente del proyecto cuya guía ya fue creada.
> **Destino:** `stage-management-system/conocimiento-guias-ia/[area-descriptiva]/` (mismo directorio de la guía original)
> **Subagentes:** explore, ContextScout, ExternalScout (si aplica), ContextRetriever, CodeReviewer, TechnicalWriter, ContextOrganizer, TaskManager (opcional), BuildAgent (opcional)

---

## Instrucciones para el agente

Lee este prompt COMPLETO antes de actuar. Sigue todas las fases en orden. No asumas conocimiento previo — verifica todo contra el código y los archivos.

### Reglas estrictas

1. **No ejecutes nada** hasta completar todas las lecturas y definiciones del plan.
2. **No asumas** conocimiento previo. Verifica contra el código real y la guía existente.
3. **Toda la información debe estar respaldada** por el código, la configuración o la documentación existente. No inventes.
4. **Preserva las secciones no afectadas** de la guía. Solo actualiza lo que ha cambiado.
5. **Reporta** al final qué se ha actualizado, qué no ha cambiado, y qué necesita confirmación del usuario.

### Flujo general

```
F0: CodeReviewer diagnostica guía actual vs código
  ↓
F1: explore + ContextScout + ExternalScout + CodeReviewer + ContextRetriever investigan
  ↓
F2: OpenAgent sintetiza cambios [+ TaskManager si complejidad alta]
  ↓
F3: TechnicalWriter actualiza los 3 documentos
  ↓
F4: CodeReviewer revisa + ContextOrganizer verifica coherencia [+ BuildAgent opcional]
  ↓
Usuario confirma → Guía actualizada
```

---

## Entrada del usuario

El usuario indicará los siguientes campos. Los **obligatorios** son imprescindibles. Los **opcionales** se pueden omitir.

```
Área a actualizar: [nombre exacto del subdirectorio en conocimiento-guias-ia/]
   Ej: workflow-engine, auth-system, forms-api, fex-cfle

Cambios realizados: [descripción detallada de lo que cambió en el código]
   Ej: Se añadió un nuevo método validarSesion en AuthService, se eliminó
   el driver antiguo WpCookieAuth, se añadieron 2 nuevas rutas de perfil,
   y se modificó el middleware de idioma para extraer locale de cookie.

--- CAMPOS OPCIONALES ---

Complejidad: [normal | alta]
   normal → flujo estándar (por defecto)
   alta   → activa TaskManager para descomponer la actualización

Writer override: [DocWriter | TechnicalWriter]
   Por defecto se usa TechnicalWriter. Usa DocWriter si prefieres
   un enfoque menos técnico o más narrativo.

Skip BuildAgent: [true | false]
   Por defecto false (se ejecuta si hay ejemplos de código en la guía).
   true → omite la validación de ejemplos de código.
```

Usa esta información para guiar todas las fases.

---

## Fase 0 — Diagnóstico de la guía existente (CodeReviewer)

Antes de investigar el código, delegar en CodeReviewer para analizar la guía actual y producir un diagnóstico estructurado de lo que necesita cambio:

```
task(
  subagent_type="CodeReviewer",
  description="Diagnosticar guía actual de [área]",
  prompt="Analiza los 3 documentos de guía existentes en:
  stage-management-system/conocimiento-guias-ia/[area]/
   - 01-ficha-rapida.md
   - 02-arquitectura.md
   - 03-referencia-operativa.md

  Lee cada documento COMPLETAMENTE.

  Para cada documento, identifica y genera una tabla con:

  | Sección | Estado | Acción requerida |
  |---------|--------|------------------|
  | [nombre sección] | ✅ Vigente / ⚠️ Obsoleta / ❌ Ausente | [preservar / actualizar / eliminar / crear] |

  Criterios para determinar el estado:
  - ✅ VIGENTE: La información coincide con el código actual. No tocar.
  - ⚠️ OBSOLETA: Menciona funcionalidades, archivos, variables, endpoints o configuraciones
    que ya no existen o han cambiado. Marcar para actualizar.
  - ❌ AUSENTE: Funcionalidades, componentes o configuraciones nuevas que no están
    documentadas en la guía. Marcar para crear.

  Además, identifica:
  - REFERENCIAS CRUZADAS ROTAS: menciones a archivos, rutas o conceptos que ya no existen
  - INFORMACIÓN CONTRADICTORIA: secciones que se contradicen entre los 3 docs
  - ERRORES CONOCIDOS NO DOCUMENTADOS: TODO, FIXME, HACK en el código que no aparecen
    en la sección de troubleshooting de la guía

  Devuelve:
  1. Tabla de diagnóstico por documento (sección + estado + acción)
  2. Lista de referencias rotas encontradas (si las hay)
  3. Lista de contradicciones entre docs (si las hay)
  4. Lista de errores conocidos en código no documentados en la guía (si los hay)
  5. Resumen: cuántas secciones preservar / actualizar / eliminar / crear"
)
```

**Salida de Fase 0:** Diagnóstico estructurado de la guía actual con acciones concretas por sección.

---

## Fase 1 — Investigación y Análisis

### 1.0 Exploración estructural (explore)

Delegar en el agente explore para mapear rápidamente la estructura actual de archivos del área:

```
task(
  subagent_type="explore",
  description="Mapear estructura de [área]",
  prompt="Explora el área [descripción] del proyecto con nivel de profundidad 'medium'.

  Identifica:
  1. DIRECTORIOS: estructura de carpetas del área
  2. ARCHIVOS: todos los archivos que componen el área (clases, interfaces, traits,
     tests, configuraciones, templates, assets, scripts)
  3. CAMBIOS RECIENTES: git log --oneline -10 en los archivos del área
  4. DEPENDENCIAS: qué archivos del proyecto importa/usa cada componente
  5. CONFIGURACIÓN: archivos de configuración del proyecto que afectan al área
     (.env variables, config-wa.json, ui.json)

  Devuelve un listado estructurado con rutas completas y propósito de cada archivo."
)
```

### 1.1 ContextScout

Delegar en ContextScout para descubrir contextos actualizados sobre el área:

```
task(
  subagent_type="ContextScout",
  description="Descubrir contexto actualizado sobre [área]",
  prompt="Busca archivos de contexto en .opencode/context/, stage-management-system/,
  documentacion-desarrollo/ y cualquier otra ubicación del proyecto relacionados con:
  [descripción del usuario].

  La funcionalidad ha cambiado, busca información actualizada.
  Incluye:
  - Nuevas guías o actualizaciones de contexto sobre el área
  - Estándares aplicables (code-quality, security-patterns, test-coverage)
  - Reglas de seguridad relevantes
  - Reglas del proyecto (RG en AGENTS.md) que apliquen al área
  - Cualquier archivo de contexto nuevo que no existiera cuando se creó la guía original
  - Referencias en .gobernanza/inventario_recursos.yaml que mencionen el área

  Devuelve lista de archivos de contexto con ruta completa y un resumen de 1-2 líneas
  de lo que contiene cada uno."
)
```

### 1.2 ExternalScout (si aplica)

Si los cambios involucran librerías externas nuevas o actualizaciones de versión (detectar en composer.json, package.json, imports en el código), delegar en ExternalScout:

```
task(
  subagent_type="ExternalScout",
  description="Docs externas actualizadas para [librería]",
  prompt="Busca documentación actualizada sobre [librería/API] en relación con los
  cambios en: [descripción del usuario].

  Enfócate en:
  - Breaking changes entre versiones anteriores y la actual
  - Nuevas APIs añadidas que el proyecto pueda estar usando
  - APIs deprecadas que el proyecto debería dejar de usar
  - Cambios en configuración o requisitos del sistema
  - Buenas prácticas documentadas para el caso de uso del proyecto"
)
```

Si los cambios **no involucran** librerías externas nuevas o actualizadas, omitir esta sección.

### 1.3a CodeReviewer — Análisis de cambios en código

Delegar en CodeReviewer para analizar los cambios en el código del área:

```
task(
  subagent_type="CodeReviewer",
  description="Analizar cambios en [área]",
  prompt="Analiza los cambios recientes en el código del proyecto relacionados con:
  [descripción del usuario].

  IMPORTANTE: Parte del diagnóstico de la Fase 0 ya realizado. Este análisis se
  centra en detectar y documentar los cambios reales en el código.

  Identifica y extrae:

  1. ARCHIVOS NUEVOS: lista de archivos añadidos (ruta completa)
  2. ARCHIVOS MODIFICADOS: cambios significativos en archivos existentes
  3. ARCHIVOS ELIMINADOS: archivos que ya no existen
  4. CLASES/FUNCIONES NUEVAS: cada clase/interface/trait/función nueva con su propósito
  5. CLASES/FUNCIONES MODIFICADAS: cambios en interfaz, firma o comportamiento
  6. CLASES/FUNCIONES ELIMINADAS: obsoletas o reemplazadas
  7. NUEVAS DEPENDENCIAS: internas (otros módulos del proyecto) y externas (librerías)
  8. DEPENDENCIAS ELIMINADAS
  9. CAMBIOS EN CONFIGURACIÓN: nuevas variables de entorno, cambios en archivos
     de configuración del proyecto (config-wa.json, ui.json, .env)
  10. NUEVOS ERRORES CONOCIDOS: busca comentarios TODO, FIXME, HACK, XXX,
      SECURITY añadidos en los cambios
  11. CAMBIOS DE SEGURIDAD: nuevos requisitos de autenticación, autorización,
      validación, CORS, sanitización
  12. CAMBIOS EN CONTRATOS: modificaciones en endpoints, formatos de request/response,
      códigos de estado HTTP
  13. GIT DIFF: resumen de los cambios (git diff de los archivos afectados)

  Para cada hallazgo, indica:
  - Archivo y línea exacta
  - Si la guía existente se vería afectada (SÍ / NO / PARCIALMENTE)
  - Qué documento(s) de la guía necesitarían actualización (01 / 02 / 03)"
)
```

### 1.3b ContextRetriever — Contextos específicos del área

Delegar en ContextRetriever para recuperar fragmentos específicos de contexto relevantes:

```
task(
  subagent_type="Context Retriever",
  description="Recuperar contextos específicos para [área]",
  prompt="Busca en .opencode/context/ y stage-management-system/ los archivos de
  contexto, estándares y reglas específicamente relevantes para el área:
  [descripción del usuario].

  Enfócate en recuperar contenido CONCRETO (no solo listar archivos):

  1. Si el área usa autenticación → busca en security-patterns.md y middleware/
  2. Si el área tiene endpoints → busca en api-design.md y el inventario de recursos
  3. Si el área involucra IA → busca en los stages de IA y config-wa.json
  4. Si el área tiene configuraciones → busca en el inventario de variables de entorno
  5. Si el área maneja archivos → busca en file-upload stages y reglas de seguridad

  Para CADA fragmento relevante encontrado, indica:
  - Archivo de origen y líneas
  - El fragmento de contenido (cita textual)
  - Por qué es relevante para la actualización de la guía"
)
```

---

## Fase 2 — Procesamiento y síntesis (OpenAgent)

Sintetiza todos los materiales recopilados:

1. **Diagnóstico de Fase 0** (CodeReviewer) — qué preservar, actualizar, eliminar, crear
2. **Exploración de Fase 1.0** (explore) — estructura del área
3. **Contextos de Fase 1.1** (ContextScout) — estándares y reglas aplicables
4. **Docs externas de Fase 1.2** (ExternalScout) — si aplica
5. **Cambios de Fase 1.3a** (CodeReviewer) — cambios en el código
6. **Contextos específicos de Fase 1.3b** (ContextRetriever) — fragmentos relevantes

### 2.1 Clasificar cambios vs guía existente

Combina el diagnóstico de Fase 0 con los hallazgos de Fase 1. Para cada cambio detectado:

| Tipo | Acción sobre la guía | Docs afectados |
|------|---------------------|----------------|
| **Funcionalidad nueva** | Añadir sección nueva | Según naturaleza |
| **Funcionalidad modificada** | Actualizar sección existente | Los que referencien esa funcionalidad |
| **Funcionalidad eliminada** | Eliminar sección o marcar como obsoleta | 01, 02, 03 |
| **Dependencia nueva** | Añadir a doc2 (arquitectura) y doc3 (operativa) | 02, 03 |
| **Dependencia eliminada** | Eliminar de doc2 y doc3 | 02, 03 |
| **Error conocido nuevo** | Añadir a doc3 (troubleshooting) | 03 |
| **Error conocido resuelto** | Eliminar de doc3 o marcar como resuelto | 03 |
| **Configuración nueva** | Añadir a doc3 (referencia operativa) | 03 |
| **Cambio de seguridad** | Actualizar en doc2 (si afecta arquitectura) y doc3 | 02, 03 |
| **Cambio de contrato** | Actualizar en doc2 (diagramas) y doc3 (ejemplos) | 02, 03 |

### 2.2 Decidir qué docs necesitan actualización

No todos los docs necesitan actualizarse siempre:

- Si solo cambió la configuración → solo doc3
- Si solo cambiaron las relaciones entre componentes → solo doc2
- Si cambió el propósito general → doc1 + doc2 + doc3
- Si se añadió funcionalidad nueva → doc1 (mención) + doc2 (arquitectura) + doc3 (operativa)
- Si solo se corrigieron errores → solo doc3 (troubleshooting)

### 2.3 Decidir perfil del writer

Analiza la naturaleza del contenido a actualizar para decidir el writer:

- **Técnico** (por defecto): protocolos, APIs, endpoints, configuraciones técnicas, seguridad → **TechnicalWriter**
- **Narrativo/General**: descripciones de alto nivel, flujos de negocio, fichas rápidas → **DocWriter**

Si el usuario especificó `Writer override`, usar ese valor.

### 2.4 Si complejidad es «alta»: activar TaskManager

```
task(
  subagent_type="TaskManager",
  description="Descomponer actualización de [área]",
  prompt="El área [área] tiene complejidad alta y requiere actualizar múltiples
  secciones de la guía. Los cambios a documentar son:

  [RESUMEN DE CAMBIOS DE FASE 1]

  Descompón esta actualización en subtareas atómicas con dependencias.
  Cada subtarea debe ser una sección específica de un documento concreto.
  Marca con parallel: true las subtareas que puedan ejecutarse en paralelo
  (ej: actualizar doc2 y doc3 simultáneamente si no comparten dependencias)."
)
```

Usar la salida de TaskManager para organizar la ejecución de Fase 3.

### 2.5 Preparar material para el writer

```
Área: [nombre]
Cambios a documentar: [resumen]
Writer: [TechnicalWriter | DocWriter]

Actualizaciones pendientes:

## Doc 1 — 01-ficha-rapida.md
- [secciones a actualizar: descripción del cambio]
- [secciones nuevas a añadir: contenido a incluir]
- [secciones a eliminar: justificación]

## Doc 2 — 02-arquitectura.md
- [secciones a actualizar: descripción del cambio]
- [secciones nuevas a añadir: diagramas Mermaid a incluir, relaciones nuevas]
- [secciones a eliminar: componentes/dependencias obsoletas]

## Doc 3 — 03-referencia-operativa.md
- [secciones a actualizar: descripción del cambio]
- [secciones nuevas a añadir: configuración, comandos, ejemplos]
- [secciones a eliminar: configuraciones/endpoints obsoletos]

## Errores conocidos a documentar (nuevos)
- [lista de errores conocidos detectados en Fase 1.3a]

## Errores conocidos a eliminar (resueltos)
- [lista de errores que ya no aplican]
```

---

## Fase 3 — Actualización de documentos (TechnicalWriter / DocWriter)

Seleccionar el writer según el perfil decidido en Fase 2.3:

### Opción por defecto: TechnicalWriter

```
task(
  subagent_type="DocWriter",
  description="Actualizar guía de [área]",
  prompt="[MODO: TechnicalWriter — redacción técnica, precisa, para consumo IA]

  Actualiza los documentos de guía técnica para el área [área] del proyecto.
  Los documentos actuales están en:
  stage-management-system/conocimiento-guias-ia/[area]/

  --- PERFIL TÉCNICO ---
  - Redacción en español de España (es-ES)
  - Enfoque en precisión técnica, no narrativa
  - Prioriza: datos exactos, firmas de funciones, tipos, configuraciones literales
  - Usa tablas, viñetas, árboles, diagramas Mermaid cuando sea necesario
  - Explica términos específicos cuando aparezcan
  - El público principal es IA (80%) y humano en segundo término (20%)
  - Incluye lo necesario para EVITAR errores conocidos, no solo corregirlos

  CAMBIOS A APLICAR:
  [MATERIAL DE LA FASE 2.5]

  INSTRUCCIONES:
  1. Lee cada doc existente antes de modificarlo
  2. Solo modifica las secciones indicadas en CAMBIOS A APLICAR
  3. No alteres secciones que no estén en la lista de cambios
  4. Actualiza las referencias cruzadas entre los 3 docs si es necesario
  5. Si añades contenido nuevo, verifica que los otros docs lo referencien si aplica
  6. Preserva el formato y estilo de los documentos originales
  7. Incrementa la versión de la guía y actualiza la fecha

  Los nombres de archivo son FIJOS:
  - 01-ficha-rapida.md
  - 02-arquitectura.md
  - 03-referencia-operativa.md

  Devuelve confirmación de los archivos actualizados con:
  - Ruta completa de cada archivo
  - Número de líneas antes y después
  - Resumen de cambios aplicados por archivo
  - Fecha y hora de la actualización"
)
```

### Opción alternativa: DocWriter

Si el perfil es narrativo/general o el usuario especificó `Writer override: DocWriter`:

```
task(
  subagent_type="DocWriter",
  description="Actualizar guía de [área]",
  prompt="[MODO: DocWriter — narrativa general, para audiencia mixta]

  Actualiza los documentos de guía técnica para el área [área] del proyecto.
  Los documentos actuales están en:
  stage-management-system/conocimiento-guias-ia/[area]/

  --- PERFIL GENERAL ---
  - Redacción en español de España (es-ES)
  - Enfoque en claridad y legibilidad
  - Explica conceptos, no solo datos técnicos
  - Usa viñetas, tablas, árboles, diagramas Mermaid cuando sea necesario
  - El público principal es humano (60%) y IA (40%)

  ... (mismas instrucciones que TechnicalWriter para el resto)
  [MATERIAL DE LA FASE 2.5]
  ..."
)
```

---

## Fase 4 — Revisión y validación

### 4.1 CodeReviewer — Revisión de calidad

```
task(
  subagent_type="CodeReviewer",
  description="Revisar actualización de guía de [área]",
  prompt="Revisa los documentos actualizados de la guía en:
  stage-management-system/conocimiento-guias-ia/[area]/
   - 01-ficha-rapida.md
   - 02-arquitectura.md
   - 03-referencia-operativa.md

  Los documentos fueron actualizados para reflejar cambios en el código.
  La guía original es la línea base.

  Verifica estos 10 puntos:

  1. CONSISTENCIA: ¿Las secciones actualizadas son coherentes con las secciones
     no modificadas?
  2. NO REGRESIÓN: ¿Las secciones no modificadas siguen siendo correctas?
  3. PRECISIÓN: ¿Los cambios documentados coinciden con los cambios reales
     en el código?
  4. COMPLETITUD: ¿Hay algo que cambió en el código y no se documentó?
  5. REFERENCIAS CRUZADAS: ¿Las referencias entre los 3 docs siguen siendo
     válidas y existen?
  6. CONTRADICCIONES: ¿Hay contradicciones entre el contenido nuevo y el existente?
  7. VERSIÓN Y FECHA: ¿Se actualizó la versión, fecha y hora de la guía?
  8. INVENTARIO: ¿Los cambios son coherentes con el inventario de recursos
     (.gobernanza/inventario_recursos.yaml)? Verifica que las variables,
     endpoints y componentes mencionados existan en el YAML.
  9. ESTÁNDARES: ¿La guía actualizada cumple con los estándares del proyecto
     (code-quality.md, security-patterns.md)?
  10. REFERENCIAS EXTERNAS: ¿Las referencias a otras guías en
      conocimiento-guias-ia/ son válidas y no se rompen?

  Por cada problema encontrado, indica:
   - Archivo y sección
   - El problema
   - La corrección sugerida

  Si NO hay errores, indica: 'REVISIÓN SUPERADA'
  Si HAY errores, indica: 'REVISIÓN CON ERRORES — requiere corrección'"
)
```

**Si hay errores:**
- Leer el output de CodeReviewer
- Delegar nuevamente en el writer (TechnicalWriter o DocWriter) con las correcciones indicadas
- Volver a pasar por Fase 4.1

### 4.2 ContextOrganizer — Verificación de coherencia global

Una vez superada la revisión de CodeReviewer, delegar en ContextOrganizer:

```
task(
  subagent_type="ContextOrganizer",
  description="Verificar coherencia global de guía de [área]",
  prompt="Verifica que la guía actualizada en:
  stage-management-system/conocimiento-guias-ia/[area]/
   - 01-ficha-rapida.md
   - 02-arquitectura.md
   - 03-referencia-operativa.md

  sea coherente con el sistema de contextos global del proyecto.

  Verifica:

  1. DUPLICACIÓN: ¿El contenido de esta guía duplica información que ya existe
     en .opencode/context/ o en otras guías de conocimiento-guias-ia/?
  2. REFERENCIAS CRUZADAS GLOBALES: ¿Las referencias a otros contextos
     o guías existen y son correctas?
  3. INTEGRACIÓN: Si esta guía debería estar registrada en algún índice
     (navigation.md, índices de contexto), ¿lo está?
  4. CONSISTENCIA TERMINOLÓGICA: ¿Usa la misma terminología que el resto
     del sistema de contextos?
  5. FRESCURA: ¿La fecha de actualización está presente y es correcta?

  Devuelve:
  - ✅ COHERENTE: si no hay problemas
  - ⚠️ REQUIERE AJUSTES: si hay problemas menores (lista)
  - ❌ INCOHERENTE: si hay problemas graves que requieren corrección (lista)
  - RECOMENDACIONES: qué acciones tomar"
)
```

### 4.3 BuildAgent — Validación técnica de ejemplos (opcional)

Si la guía contiene ejemplos de código Y el usuario no especificó `Skip BuildAgent: true`:

```
task(
  subagent_type="BuildAgent",
  description="Validar ejemplos de código en guía de [área]",
  prompt="Revisa los ejemplos de código PHP y otros lenguajes en los documentos
  de guía ubicados en:
  stage-management-system/conocimiento-guias-ia/[area]/
   - 02-arquitectura.md
   - 03-referencia-operativa.md

  Para cada ejemplo de código:

  1. SINTÁXIS: ¿Es sintácticamente válido? (PHP: <?php ... ?>, etc.)
  2. COHERENCIA: ¿Las funciones/clases/métodos mencionados existen realmente
     en el código del proyecto?
  3. FIRMAS: ¿Las firmas de funciones (parámetros, tipos, retorno) coinciden
     con el código real?
  4. CONFIGURACIÓN: ¿Las variables de entorno y rutas mencionadas existen
     en el proyecto?

  No ejecutes el código, solo haz validación estática por comparación
  con el código real del proyecto.

  Por cada problema encontrado, indica:
  - Archivo y sección
  - El problema concreto
  - La corrección sugerida

  Si NO hay errores, indica: 'VALIDACIÓN SUPERADA'
  Si HAY errores, indica: 'VALIDACIÓN CON ERRORES — requiere corrección'"
)
```

---

## Cierre — Resumen y confirmación

Una vez superadas todas las fases, presentar al usuario un resumen con el siguiente formato:

```
## Guía actualizada

**Área:** [descripción]
**Ubicación:** stage-management-system/conocimiento-guias-ia/[area]/
**Fecha y hora de actualización:** [YYYY-MM-DD HH:MM]

### Cambios aplicados

| Archivo | Acción | Detalle |
|---------|--------|---------|
| 01-ficha-rapida.md | [actualizada / sin cambios] | [n] secciones: [actualizadas / añadidas / eliminadas] |
| 02-arquitectura.md | [actualizada / sin cambios] | [n] secciones: [actualizadas / añadidas / eliminadas] |
| 03-referencia-operativa.md | [actualizada / sin cambios] | [n] secciones: [actualizadas / añadidas / eliminadas] |

### Errores conocidos documentados
- [nuevos: n] [resueltos: n]

### Writer utilizado
[TechnicalWriter | DocWriter]

### Revisiones

| Fase | Resultado |
|------|-----------|
| CodeReviewer (F4.1) | [superada / con errores → corregidos] |
| ContextOrganizer (F4.2) | [coherente / ajustes menores] |
| BuildAgent (F4.3) | [superada / no aplica / omitida] |

### Resumen de cambios
[2-3 líneas describiendo qué se actualizó y por qué]

¿Confirmas la publicación de esta actualización?
```

--- FIN DEL PROMPT ---
