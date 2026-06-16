# P-crear-guia — Crear guía técnica de una parte del proyecto

> **Propósito:** Generar 3 documentos de guía técnica (ficha rápida, arquitectura, referencia operativa) sobre una parte/función/área del proyecto, para que un agente IA pueda entenderla, usarla y modificarla sin contexto previo.
> **Cuándo usarlo:** Al finalizar el desarrollo de una nueva función en el proyecto.
> **Última actualización:** 2026-06-12
> **Destino:** `stage-management-system/conocimiento-guias-ia/[area-descriptiva]/`
> **Subagentes:** explore, ContextScout, ExternalScout (si aplica), ContextRetriever, CodeReviewer, TechnicalWriter, ContextOrganizer, TaskManager (opcional), BuildAgent (opcional)

---

## INSTRUCCIONES PARA EL USUARIO — Cómo usar este prompt

### ¿Qué hace este prompt?

Este prompt genera **desde cero** los 3 documentos de una guía técnica (`01-ficha-rapida.md`, `02-arquitectura.md`, `03-referencia-operativa.md`) para un área nueva del proyecto. El agente IA:

1. Investiga el código, el contexto y las dependencias del área
2. Decide el perfil de la guía (énfasis en arquitectura o en operativa)
3. Redacta los 3 documentos con referencias cruzadas entre ellos
4. Revisa la calidad, la precisión técnica y la coherencia global

### ¿Cómo se ejecuta?

**Paso 1 — Copia todo el contenido del bloque «PROMPT»** (desde la línea `--- INICIO DEL PROMPT ---` hasta `--- FIN DEL PROMPT ---`).

**Paso 2 — Pégalo como primer mensaje** en el chat del agente IA (OpenAgent, OpenCode, etc.).

**Paso 3 — Completa el campo obligatorio** en la sección de entrada del usuario:

```
Área a documentar: [descripción libre del área, incluyendo clases, archivos, funcionalidades]
```

**Paso 4 (opcional) — Añade campos opcionales** si necesitas control adicional:

```
Writer override: [DocWriter | TechnicalWriter]     ← fuerza el escritor (por defecto se elige automáticamente según perfil)
Complejidad: [normal | alta]                       ← normal=flujo estándar, alta=activa TaskManager para descomponer
```

**Paso 5 — El agente ejecutará las fases y te pedirá confirmación** al final.

### ¿Qué obtienes como resultado?

- El subdirectorio `stage-management-system/conocimiento-guias-ia/[area]/` creado
- Los 3 documentos generados: `01-ficha-rapida.md`, `02-arquitectura.md`, `03-referencia-operativa.md`
- El perfil aplicado (doc2, doc3 o equilibrado) según la naturaleza del código
- Revisión de calidad (CodeReviewer)
- Verificación de coherencia global (ContextOrganizer)
- Validación opcional de ejemplos de código (BuildAgent)

### Consideraciones

- **Los nombres de archivo son fijos:** `01-ficha-rapida.md`, `02-arquitectura.md`, `03-referencia-operativa.md`.
- **El nombre del subdirectorio** lo elige el agente basándose en el área descrita. Si quieres forzarlo, menciónalo en la descripción.
- **Cada documento referencia explícitamente a los otros 2.** No se duplica información entre docs.
- **Si el área es muy extensa** (múltiples subsistemas, 5+ archivos), usa `Complejidad: alta` para activar TaskManager.
- **Si el contenido es muy técnico** (protocolos, APIs de bajo nivel), el agente usará TechnicalWriter automáticamente. Puedes forzarlo con `Writer override: TechnicalWriter`.

---

--- INICIO DEL PROMPT ---

# P-crear-guia — Crear guía técnica de una parte del proyecto

> **Propósito:** Generar 3 documentos de guía técnica (ficha rápida, arquitectura, referencia operativa) sobre una parte/función/área del proyecto, para que un agente IA pueda entenderla, usarla y modificarla sin contexto previo.
> **Cuándo usarlo:** Al finalizar el desarrollo de una nueva función en el proyecto.
> **Destino:** `stage-management-system/conocimiento-guias-ia/[area-descriptiva]/`
> **Subagentes:** explore, ContextScout, ExternalScout (si aplica), ContextRetriever, CodeReviewer, TechnicalWriter, ContextOrganizer, TaskManager (opcional), BuildAgent (opcional)

---

## Instrucciones para el agente

Lee este prompt COMPLETO antes de actuar. Sigue todas las fases en orden. No asumas conocimiento previo — verifica todo contra el código y los archivos.

### Reglas estrictas

1. **No ejecutes nada** hasta completar todas las lecturas y definiciones del plan.
2. **No asumas** conocimiento previo. Verifica contra el código real.
3. **Toda la información debe estar respaldada** por el código, la configuración o la documentación existente. No inventes.
4. **Los 3 documentos deben tener referencias cruzadas explícitas** entre sí. No duplicar información.
5. **Reporta** al final qué se ha creado, qué contiene cada doc, y qué necesita confirmación del usuario.

### Flujo general

```
F1: explore + ContextScout + ExternalScout + CodeReviewer + ContextRetriever investigan
  ↓
F2: OpenAgent sintetiza + decide perfil (doc2/doc3) [+ TaskManager si complejidad alta]
  ↓
F3: TechnicalWriter crea los 3 documentos desde cero
  ↓
F4: CodeReviewer revisa + ContextOrganizer verifica coherencia [+ BuildAgent opcional]
  ↓
Usuario confirma → Guía publicada
```

---

## Entrada del usuario

El usuario indicará los siguientes campos. El **obligatorio** es imprescindible. Los **opcionales** se pueden omitir.

```
Área a documentar: [descripción libre del área, incluyendo clases, archivos,
funcionalidades, dependencias y cualquier detalle relevante]
   Ej: Módulo de autenticación — ServicioAutenticacion, ControladorAuth,
   DriverAutenticacionCookies, middleware de autenticación y rutas de inicio
   de sesión/registro/recuperación. Incluye la integración con la librería
   delight-im/auth y WordPress como plataforma base.

--- CAMPOS OPCIONALES ---

Writer override: [DocWriter | TechnicalWriter]
   Por defecto se elige automáticamente según el perfil del área:
   - TechnicalWriter para contenido técnico (APIs, protocolos, configuraciones)
   - DocWriter para contenido más narrativo o general
   Usa este campo para forzar un escritor concreto.

Complejidad: [normal | alta]
   normal → flujo estándar (por defecto)
   alta   → activa TaskManager para descomponer la creación si el área es extensa
```

Usa esta información para guiar todas las fases.

---

## Fase 1 — Investigación y Análisis

### 1.0 Exploración estructural (explore)

Delegar en el agente explore para mapear la estructura completa del área:

```
task(
  subagent_type="explore",
  description="Mapear estructura de [área]",
  prompt="Explora el área [descripción] del proyecto con nivel de profundidad 'very thorough'.

  Identifica:
  1. DIRECTORIOS: estructura de carpetas del área
  2. ARCHIVOS: todos los archivos que componen el área (clases, interfaces, traits,
     tests, configuraciones, templates, assets, scripts)
  3. NOMBRES DE SUBDIRECTORIO SUGERIDOS: propón 2-3 nombres para el subdirectorio
     de la guía (formato kebab-case, ej: auth-system, workflow-stages)
  4. CAMBIOS RECIENTES: git log --oneline -10 en los archivos del área
  5. ESTRUCTURA GENERAL: cómo se organiza el área (capas, módulos, subcomponentes)

  Devuelve un listado estructurado con rutas completas y propósito de cada archivo,
  y una recomendación de nombre para el subdirectorio de la guía."
)
```

### 1.1 ContextScout

Delegar en ContextScout para descubrir todo el contexto disponible sobre el área:

```
task(
  subagent_type="ContextScout",
  description="Descubrir contexto sobre [área]",
  prompt="Busca archivos de contexto en .opencode/context/, stage-management-system/,
  documentacion-desarrollo/ y cualquier otra ubicación del proyecto relacionados con:
  [descripción del usuario].

  Incluye:
  - Guías existentes sobre áreas relacionadas (para referencias cruzadas)
  - Estándares aplicables (code-quality, security-patterns, test-coverage)
  - Reglas de seguridad relevantes
  - Reglas del proyecto (RG en AGENTS.md) que apliquen al área
  - Fichas rápidas del proyecto que mencionen el área
  - Cualquier otro archivo de contexto relevante
  - Referencias en .gobernanza/inventario_recursos.yaml que mencionen el área

  Devuelve lista de archivos de contexto con ruta completa y un resumen de 1-2 líneas
  de lo que contiene cada uno."
)
```

### 1.2 ExternalScout (si aplica)

Si el área usa librerías externas (detectar en composer.json, package.json, imports en código), delegar en ExternalScout:

```
task(
  subagent_type="ExternalScout",
  description="Docs externas para [librería]",
  prompt="Busca documentación actualizada sobre [librería/API] en relación con su uso
  en: [descripción del área].

  Enfócate en:
  - Instalación y configuración
  - API específica usada en el proyecto
  - Breaking changes relevantes
  - Buenas prácticas documentadas
  - Versión concreta usada en el proyecto (según composer.json / package.json)"
)
```

Si el área **no usa** librerías externas, omitir esta sección.

### 1.3a CodeReviewer — Análisis completo del código

Delegar en CodeReviewer para analizar exhaustivamente el código fuente del área:

```
task(
  subagent_type="CodeReviewer",
  description="Analizar código de [área]",
  prompt="Analiza el código fuente del proyecto relacionado con: [descripción del área].
  Identifica y extrae:

  1. ARCHIVOS: lista completa de archivos que componen el área (clases, interfaces,
     traits, tests, configuraciones, templates, assets, scripts, rutas)
  2. CLASES Y FUNCIONES: cada clase/interface/trait/función con su propósito y firma
  3. FLUJOS PRINCIPALES: cómo se conectan entre sí los componentes (entradas,
     procesos, salidas)
  4. DEPENDENCIAS INTERNAS: qué archivos del proyecto importa/usa cada componente
  5. DEPENDENCIAS EXTERNAS: librerías de terceros, APIs, servicios externos con versión
  6. CONFIGURACIÓN: qué variables de .env, archivos de configuración del proyecto
     (config-wa.json, ui.json, .env) afectan al área, con valores esperados
  7. COMPORTAMIENTO: describe brevemente qué hace cada función (no solo su firma)
  8. ERRORES CONOCIDOS: busca comentarios TODO, FIXME, HACK, XXX, SECURITY,
     bugs documentados en el código
  9. SEGURIDAD: puntos que requieren autenticación, validación, autorización,
     CORS, sanitización — y cómo se implementan realmente
  10. TESTS: archivos de test existentes, qué cubren y qué no
  11. CAMBIOS RECIENTES: git log de los últimos commits que tocaron estos archivos
  12. CONTRATOS: endpoints que expone o consume, formatos de request/response,
      códigos de estado HTTP
  13. NOMBRE SUGERIDO: propón un nombre para el subdirectorio de la guía
      (kebab-case, inglés descriptivo, ej: forms-api, workflow-stages, auth-system)

  Para cada hallazgo, indica el archivo y línea exacta.
  Para clases y funciones, indica la firma completa."
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
  6. Si el área es un workflow → busca en workflow-stages-library.md

  Para CADA fragmento relevante encontrado, indica:
  - Archivo de origen y líneas
  - El fragmento de contenido (cita textual)
  - Por qué es relevante para la creación de la guía"
)
```

---

## Fase 2 — Procesamiento y síntesis (OpenAgent)

Sintetiza todos los materiales recopilados en la Fase 1 en un outline estructurado para los 3 documentos. Sigue estos pasos:

### 2.1 Clasificar el contenido

Para cada hallazgo de la Fase 1, decide si pertenece a:

| Doc | Contenido |
|-----|-----------|
| **01-ficha-rapida.md** | Visión general, propósito, archivos clave, dependencias principales, casos de uso |
| **02-arquitectura.md** | Relaciones entre componentes, flujos, ciclos de vida, árboles de dependencia, diagramas Mermaid, decisiones técnicas |
| **03-referencia-operativa.md** | Configuración, comandos, ejemplos de código, troubleshooting, errores conocidos, guía de uso paso a paso |

### 2.2 Decidir perfil (doc2 vs doc3)

Analiza la naturaleza del código para decidir el énfasis de la guía:

- **Si predominan relaciones entre componentes** (muchas clases conectadas, herencia, interfaces, eventos, inyección de dependencias): dar más peso y profundidad al **doc2 (arquitectura)**
- **Si predominan configuraciones y comandos** (muchas variables de entorno, endpoints, parámetros, ejemplos de uso, comandos CLI): dar más peso y profundidad al **doc3 (operativa)**
- **Equilibrado**: dar el mismo nivel de detalle a ambos

Esta decisión es automática. No preguntes al usuario.

### 2.3 Decidir perfil del writer

- **Perfil técnico** (APIs, endpoints, protocolos, seguridad, configuraciones técnicas): **TechnicalWriter**
- **Perfil narrativo/general** (flujos de negocio, fichas rápidas, descripciones de alto nivel): **DocWriter**

Si el usuario especificó `Writer override`, usar ese valor. Por defecto, decidir según el perfil del área.

### 2.4 Si complejidad es «alta»: activar TaskManager

```
task(
  subagent_type="TaskManager",
  description="Descomponer creación de guía de [área]",
  prompt="El área [área] tiene complejidad alta y requiere crear 3 documentos
  de guía técnica desde cero. El análisis de Fase 1 ha identificado:

  [RESUMEN DE HALLAZGOS DE FASE 1]

  Descompón esta creación en subtareas atómicas con dependencias.
  Cada subtarea debe ser una sección específica de un documento concreto.
  Las subtareas de los 3 docs pueden ejecutarse en paralelo si no comparten
  dependencias de contenido.

  Considera:
  - Doc1 (ficha rápida): independiente, puede crearse en paralelo
  - Doc2 (arquitectura): depende del análisis estructural
  - Doc3 (operativa): depende del análisis de configuraciones y ejemplos"
)
```

Usar la salida de TaskManager para organizar la ejecución de Fase 3.

### 2.5 Preparar material para el writer

El outline que entregues al writer debe contener:

```
Área: [nombre del subdirectorio, ej: auth-system]
Descripción: [una línea]
Perfil de la guía: [doc2 | doc3 | equilibrado]
Writer: [TechnicalWriter | DocWriter]

## Doc 1 — 01-ficha-rapida.md
Debe incluir:
- Qué es [2-3 líneas]
- Para qué sirve
- Arquitectura general del proyecto donde encaja
- Archivos clave (lista con rutas)
- Dependencias principales (internas y externas)

## Doc 2 — 02-arquitectura.md
Debe incluir:
- [lista de elementos a incluir con su descripción]
- [relaciones entre elementos]
- [diagramas Mermaid a incluir: flujos, ciclos de vida, árboles de componentes]
- [dependencias externas e internas detalladas]
- [decisiones técnicas documentadas]
- Referencias a doc1 y doc3

## Doc 3 — 03-referencia-operativa.md
Debe incluir:
- [configuración necesaria: .env, archivos de configuración del proyecto]
- [comandos de ejemplo]
- [ejemplos de código reales, verificables]
- [troubleshooting con errores conocidos y cómo evitarlos]
- [guía de uso paso a paso]
- [tests: cómo ejecutarlos, qué cubren]
- Referencias a doc1 y doc2
```

---

## Fase 3 — Creación de documentos (TechnicalWriter / DocWriter)

Seleccionar el writer según el perfil decidido en Fase 2.3:

### Opción por defecto: TechnicalWriter

```
task(
  subagent_type="DocWriter",
  description="Crear guía de [área]",
  prompt="[MODO: TechnicalWriter — redacción técnica, precisa, para consumo IA]

  Crea 3 documentos de guía técnica desde cero para el área [área] del proyecto.

  --- PERFIL TÉCNICO ---
  - Redacción en español de España (es-ES)
  - Enfoque en precisión técnica, no narrativa
  - Prioriza: datos exactos, firmas de funciones, tipos, configuraciones literales
  - Usa tablas, viñetas, árboles, diagramas Mermaid cuando sea necesario
  - Explica términos específicos cuando aparezcan
  - El público principal es IA (80%) y humano en segundo término (20%)
  - Incluye lo necesario para EVITAR errores conocidos, no solo corregirlos

  MATERIAL PARA ESCRIBIR:
  [OUTLINE DE LA FASE 2.5]

  Requisitos de formato:

  ### Doc 1 — 01-ficha-rapida.md
  - Máximo 100 líneas
  - Visión general para que el lector decida si necesita leer los otros docs
  - Debe incluir: qué es, para qué sirve, archivos clave, dependencias principales
  - Referencias explícitas a 02-arquitectura.md y 03-referencia-operativa.md

  ### Doc 2 — 02-arquitectura.md
  - Explica CÓMO FUNCIONA, no cómo se usa
  - Diagramas Mermaid de flujos, ciclos de vida, árboles de componentes
  - Tablas de relaciones entre componentes
  - Dependencias internas y externas detalladas
  - Decisiones técnicas y su justificación
  - Referencias explícitas a 01-ficha-rapida.md y 03-referencia-operativa.md

  ### Doc 3 — 03-referencia-operativa.md
  - Explica CÓMO SE USA, no cómo funciona
  - Ejemplos de código reales (verificados contra el código, no inventados)
  - Comandos de ejemplo
  - Sección de troubleshooting con errores conocidos y cómo evitarlos
  - Configuración necesaria (.env, archivos de configuración del proyecto)
  - Cómo ejecutar tests
  - Referencias explícitas a 01-ficha-rapida.md y 02-arquitectura.md

  Crea el subdirectorio:
  stage-management-system/conocimiento-guias-ia/[area-descriptiva]/

  Los nombres de archivo son FIJOS:
  - 01-ficha-rapida.md
  - 02-arquitectura.md
  - 03-referencia-operativa.md

  El nombre del subdirectorio [area-descriptiva] debe estar en kebab-case,
  en inglés, descriptivo del área.
  Usa el nombre sugerido por el análisis de Fase 1.
  Si hay múltiples sugerencias, elige la más representativa.

  Devuelve confirmación de los 3 archivos creados con:
  - Ruta completa de cada archivo
  - Número de líneas de cada uno
  - Resumen del contenido de cada doc (2-3 líneas)
  - Fecha y hora de creación
  - Perfil aplicado (doc2 / doc3 / equilibrado)"
)
```

### Opción alternativa: DocWriter

Si el perfil es narrativo/general o el usuario especificó `Writer override: DocWriter`:

```
task(
  subagent_type="DocWriter",
  description="Crear guía de [área]",
  prompt="[MODO: DocWriter — narrativa general, para audiencia mixta]

  Crea 3 documentos de guía técnica desde cero para el área [área] del proyecto.

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
  description="Revisar guía de [área]",
  prompt="Revisa los 3 documentos de guía ubicados en:
  stage-management-system/conocimiento-guias-ia/[area-descriptiva]/
   - 01-ficha-rapida.md
   - 02-arquitectura.md
   - 03-referencia-operativa.md

  Verifica estos 10 puntos:

  1. PRECISIÓN: ¿La guía describe correctamente lo que hace el código?
     No debe inventar nada.
  2. COMPLETITUD: ¿Falta algún componente importante, dependencia o flujo
     que esté en el código pero no en la guía?
  3. REFERENCIAS CRUZADAS: ¿Las referencias entre los 3 docs son correctas
     y existen?
  4. EJEMPLOS: ¿Los ejemplos de código son sintácticamente válidos y
     reflejan el código real?
  5. ERRORES CONOCIDOS: ¿Se mencionan los errores conocidos y cómo evitarlos?
  6. SEGURIDAD: ¿Se documentan los requisitos de autenticación, autorización,
     validación y CORS?
  7. INVENTARIO: ¿Los componentes, variables y endpoints mencionados son
     coherentes con el inventario (.gobernanza/inventario_recursos.yaml)?
  8. ESTÁNDARES: ¿La guía cumple con los estándares del proyecto
     (code-quality.md, security-patterns.md)?
  9. PERFIL: ¿El perfil aplicado (doc2/doc3/equilibrado) es coherente
     con la naturaleza del código?
  10. NOMBRES: ¿El nombre del subdirectorio y los nombres de archivo
      siguen las convenciones del proyecto?

  Por cada problema encontrado, indica:
   - Archivo y línea (aproximada)
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
  prompt="Verifica que la guía creada en:
  stage-management-system/conocimiento-guias-ia/[area-descriptiva]/
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
     (navigation.md, índices de contexto), ¿debería añadirse?
  4. CONSISTENCIA TERMINOLÓGICA: ¿Usa la misma terminología que el resto
     del sistema de contextos?
  5. FRESCURA: ¿La fecha de creación está presente y es correcta?

  Devuelve:
  - ✅ COHERENTE: si no hay problemas
  - ⚠️ REQUIERE AJUSTES: si hay problemas menores (lista)
  - ❌ INCOHERENTE: si hay problemas graves que requieren corrección (lista)
  - RECOMENDACIONES: qué acciones tomar"
)
```

### 4.3 BuildAgent — Validación técnica de ejemplos (opcional)

Si la guía contiene ejemplos de código:

```
task(
  subagent_type="BuildAgent",
  description="Validar ejemplos de código en guía de [área]",
  prompt="Revisa los ejemplos de código PHP y otros lenguajes en los documentos
  de guía ubicados en:
  stage-management-system/conocimiento-guias-ia/[area-descriptiva]/
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
## Guía creada

**Área:** [descripción]
**Ubicación:** stage-management-system/conocimiento-guias-ia/[area-descriptiva]/
**Fecha y hora de creación:** [YYYY-MM-DD HH:MM]

### Archivos creados

| Archivo | Líneas | Propósito |
|---------|:------:|-----------|
| 01-ficha-rapida.md | [n] | [resumen 1 línea] |
| 02-arquitectura.md | [n] | [resumen 1 línea] |
| 03-referencia-operativa.md | [n] | [resumen 1 línea] |

### Perfil aplicado
[doc2 | doc3 | equilibrado] — [justificación 1 línea]

### Writer utilizado
[TechnicalWriter | DocWriter]

### Revisiones

| Fase | Resultado |
|------|-----------|
| CodeReviewer (F4.1) | [superada / con errores → corregidos] |
| ContextOrganizer (F4.2) | [coherente / ajustes menores] |
| BuildAgent (F4.3) | [superada / no aplica] |

### Resumen de contenido
- **Doc 1:** [2-3 líneas]
- **Doc 2:** [2-3 líneas]
- **Doc 3:** [2-3 líneas]

### Referencias cruzadas
- [Otras guías en conocimiento-guias-ia/ que referencian esta área]
- [Contextos en .opencode/context/ relacionados]

¿Confirmas la publicación de esta guía?
```

--- FIN DEL PROMPT ---
