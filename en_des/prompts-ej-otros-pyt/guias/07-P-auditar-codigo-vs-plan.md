# P-auditar-codigo-vs-plan — Auditoría de código contra plan o definición del proyecto

> **Propósito:** Comparar el código existente de un área/función del proyecto contra su plan de diseño (documento de especificación) o contra la definición general del proyecto (arquitectura, estándares, convenciones), detectando inconsistencias de todo tipo. No modifica nada, solo informa.
> **Cuándo usarlo:** Antes de desplegar, al finalizar una implementación, al detectar bugs recurrentes, o antes de una refactorización.
> **Última actualización:** 2026-06-12
> **Destino del informe:** `stage-development-system/auditoria/auditoria-[area-descriptiva].md`
> **Subagentes:** explore, ContextScout, ExternalScout (si aplica), ContextRetriever, CodeReviewer, TechnicalWriter, BuildAgent (opcional)
> **Modos de auditoría:**
>   - **Modo A (contra plan concreto):** El usuario proporciona la ruta al documento de diseño/implementación. El prompt compara el código contra ese plan.
>   - **Modo B (contra definición del proyecto):** El prompt descubre automáticamente planes, diseños y documentación existente del área y compara el código contra todo ello.

---

## INSTRUCCIONES PARA EL USUARIO — Cómo usar este prompt

### ¿Qué hace este prompt?

Compara el código real de un área contra su especificación (plan de diseño) o contra la definición general del proyecto, y genera un **informe de auditoría** con todos los hallazgos clasificados por tipo y gravedad. No modifica ningún archivo.

El agente IA:

1. Investiga el área: código, contexto, plan (si se proporciona)
2. Compara sistemáticamente cada elemento del plan contra la implementación real
3. Clasifica cada hallazgo por **tipo** (omisión, exceso, discrepancia, etc.) y **gravedad** (crítico, alto, medio, informativo)
4. Genera un informe detallado con evidencia, impacto y corrección sugerida

### ¿Cómo se ejecuta?

**Paso 1 — Copia todo el contenido del bloque «PROMPT»** (desde `--- INICIO DEL PROMPT ---` hasta `--- FIN DEL PROMPT ---`).

**Paso 2 — Pégalo como primer mensaje** en el chat del agente IA (OpenAgent, OpenCode, etc.).

**Paso 3 — Completa los campos según el modo elegido:**

**Modo A — Contra un plan concreto** (tienes el documento de diseño):

```
## Modo A — Auditoría contra plan concreto

Área a auditar: [descripción del área/función/componente]
Plan de referencia: [ruta al documento de diseño, ej: documentacion-desarrollo/area/especificacion.md]
```

**Modo B — Contra la definición del proyecto** (sin plan concreto):

```
## Modo B — Auditoría contra definición del proyecto

Área a auditar: [descripción del área/función/componente]
```

**Paso 4 (opcional) — Añade campos opcionales** si necesitas control adicional:

```
Writer override: [DocWriter | TechnicalWriter]     ← fuerza el escritor (por defecto TechnicalWriter para auditorías)
```

**Paso 5 — El agente ejecutará las fases y te pedirá confirmación** al final.

### ¿Qué obtienes como resultado?

- `stage-development-system/auditoria/auditoria-[area].md` con el informe completo
- Resumen ejecutivo con número de hallazgos por gravedad
- Cada hallazgo detallado con: tipo, archivo, evidencia (plan vs código), impacto y corrección sugerida
- Top 3 hallazgos más importantes
- Recomendaciones priorizadas

### Consideraciones

- **No se modifica ningún archivo.** Es solo diagnóstico.
- **Modo A** es más preciso porque compara contra un plan concreto.
- **Modo B** es más exploratorio: descubre automáticamente los estándares y definiciones aplicables.
- **El informe se guarda en `stage-development-system/auditoria/`.** Si ya existe uno previo, se sobreescribe.

---

--- INICIO DEL PROMPT ---

# P-auditar-codigo-vs-plan — Auditoría de código contra plan o definición del proyecto

> **Propósito:** Comparar el código existente de un área/función del proyecto contra su plan de diseño (documento de especificación) o contra la definición general del proyecto (arquitectura, estándares, convenciones), detectando inconsistencias de todo tipo. No modifica nada, solo informa.
> **Cuándo usarlo:** Antes de desplegar, al finalizar una implementación, al detectar bugs recurrentes, o antes de una refactorización.
> **Destino del informe:** `stage-development-system/auditoria/auditoria-[area-descriptiva].md`
> **Subagentes:** explore, ContextScout, ExternalScout (si aplica), ContextRetriever, CodeReviewer, TechnicalWriter, BuildAgent (opcional)
> **Modos de auditoría:**
>   - **Modo A (contra plan concreto):** El usuario proporciona la ruta al documento de diseño/implementación. El prompt compara el código contra ese plan.
>   - **Modo B (contra definición del proyecto):** El prompt descubre automáticamente planes, diseños y documentación existente del área y compara el código contra todo ello.

---

## Instrucciones para el agente

Lee este prompt COMPLETO antes de actuar. Sigue todas las fases en orden. No asumas conocimiento previo — verifica todo contra el código y los archivos.

### Reglas estrictas

1. **No ejecutes nada** hasta completar todas las lecturas y definiciones del plan.
2. **No modifiques ningún archivo.** Solo analiza, compara e informa.
3. **No asumas** conocimiento previo. Verifica contra el código real.
4. **Toda la información debe estar respaldada** por el código, la configuración o la documentación existente. No inventes discrepancias.
5. **Cada hallazgo debe incluir** evidencia concreta (archivo, línea, fragmento de código o texto del plan).
6. **Reporta** al final qué se ha auditado, qué se ha encontrado, y qué necesita confirmación del usuario.

### Flujo general

```
Modo A: Usuario da área + plan concreto
Modo B: Usuario da área, se descubre el plan automáticamente

F1.0: explore → mapea estructura del área
F1.1: ContextScout → descubre contextos
F1.2: ExternalScout → (si aplica) docs de librerías externas
F1.3a: CodeReviewer → análisis completo del código
F1.3b: ContextRetriever → fragmentos de contexto relevantes
F1.4: CodeReviewer → extrae especificaciones del plan (Modo A) o descubre (Modo B)
  ↓
F2: OpenAgent → compara plan vs código, clasifica hallazgos por tipo y gravedad
  ↓
F3: TechnicalWriter → redacta informe de auditoría
  ↓
F4: CodeReviewer → revisa el informe (precisión, evidencia, gravedad)
  ↓
Usuario confirma → Auditoría publicada
```

---

## Entrada del usuario

El usuario indicará el modo y los campos correspondientes. Los **obligatorios** son imprescindibles. Los **opcionales** se pueden omitir.

```
## Modo A — Auditoría contra plan concreto

Área a auditar: [descripción del área/función/componente]
Plan de referencia: [ruta al documento de diseño, ej: documentacion-desarrollo/area-modulo/especificacion-diseno-final.md]
```

```
## Modo B — Auditoría contra definición del proyecto

Área a auditar: [descripción del área/función/componente]
```

--- CAMPO OPCIONAL (aplica a ambos modos) ---

```
Writer override: [DocWriter | TechnicalWriter]  ← fuerza el escritor (por defecto se usa TechnicalWriter para auditorías)
```

Usa esta entrada para guiar todas las fases. Si no se especifica un plan de referencia, opera en **Modo B**.

---

## Fase 1 — Investigación y Análisis

### 1.0 Exploración estructural (explore)

Delegar en el agente explore para mapear la estructura del área a auditar:

```
task(
  subagent_type="explore",
  description="Mapear estructura de [área]",
  prompt="Explora el área [descripción] del proyecto con nivel de profundidad 'medium'.

  Identifica:
  1. DIRECTORIOS: estructura de carpetas del área
  2. ARCHIVOS: todos los archivos que componen el área (clases, interfaces, traits,
     tests, configuraciones, templates, assets, scripts)
  3. DEPENDENCIAS: qué archivos del proyecto importa/usa cada componente
  4. CONFIGURACIÓN: archivos de configuración del proyecto que afectan al área
     (.env variables, config-wa.json, ui.json)
  5. CAMBIOS RECIENTES: git log --oneline -10 en los archivos del área

  Devuelve un listado estructurado con rutas completas y propósito de cada archivo."
)
```

### 1.1 ContextScout

Delegar en ContextScout para descubrir todo el contexto disponible sobre el área y los planes/documentos de diseño asociados:

```
task(
  subagent_type="ContextScout",
  description="Descubrir contexto y plan de [área]",
  prompt="Busca archivos de contexto en .opencode/context/, stage-management-system/,
  documentacion-desarrollo/ y cualquier otra ubicación del proyecto relacionados con:
  [descripción del área].

  En Modo A (plan concreto), además busca referencias cruzadas y contexto adicional
  sobre el plan proporcionado: [plan de referencia si existe].

  En Modo B (definición del proyecto), busca:
  - Documentos de diseño, especificaciones o planes del área (en documentacion-desarrollo/
    y stage-management-system/)
  - Guías existentes en stage-management-system/conocimiento-guias-ia/
  - Estándares aplicables en .opencode/context/core/standards/
  - Reglas de seguridad relevantes
  - Fichas rápidas del proyecto que mencionen el área
  - Decisiones de arquitectura registradas
  - Entradas en .gobernanza/inventario_recursos.yaml que mencionen el área
  - Cualquier otro archivo de contexto relevante

  Devuelve: lista completa de archivos de contexto con su ruta y un breve resumen
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
  - Cambios de versión que puedan explicar discrepancias entre el plan y la implementación"
)
```

Si el área **no usa** librerías externas, omitir esta sección.

### 1.3a CodeReviewer — Análisis completo del código

Delegar en CodeReviewer para analizar exhaustivamente el código del área:

```
task(
  subagent_type="CodeReviewer",
  description="Analizar código de [área]",
  prompt="Analiza el código fuente del proyecto relacionado con: [descripción del área].
  Identifica y extrae:

  1. ARCHIVOS: lista completa de archivos que componen el área (clases, interfaces, traits,
     tests, configuraciones, templates, assets, scripts)
  2. CLASES Y FUNCIONES: cada clase/interfaz/función/método con su propósito y firma
  3. FLUJOS PRINCIPALES: cómo se conectan entre sí los componentes (entradas, procesos, salidas)
  4. DEPENDENCIAS INTERNAS: qué archivos del proyecto importa/usa cada componente
  5. DEPENDENCIAS EXTERNAS: librerías de terceros, APIs, servicios externos con versión
  6. CONFIGURACIÓN: qué variables de .env, archivos de configuración del proyecto afectan
     al área, con valores esperados
  7. COMPORTAMIENTO: describe brevemente qué hace cada función (no solo su firma)
  8. ERRORES CONOCIDOS: busca comentarios TODO, FIXME, HACK, XXX, SECURITY,
     bugs documentados en el código
  9. SEGURIDAD: puntos que requieren autenticación, validación, autorización —
     y cómo se implementan realmente
  10. TESTS: archivos de test existentes, qué cubren y qué no
  11. CAMBIOS RECIENTES: git log de los últimos commits que tocaron estos archivos

  Para cada hallazgo, indica el archivo y línea exacta."
)
```

### 1.3b ContextRetriever — Fragmentos de contexto específicos

Delegar en ContextRetriever para recuperar fragmentos de contexto que enriquezcan la comparación:

```
task(
  subagent_type="Context Retriever",
  description="Recuperar contextos específicos para [área]",
  prompt="Para el área [descripción], busca en .opencode/context/ y stage-management-system/
  fragmentos de contexto específicamente relevantes para la auditoría.

  Enfócate en recuperar contenido CONCRETO:
  1. Si el área usa autenticación → fragmentos de security-patterns.md y middleware/
  2. Si el área tiene endpoints → fragmentos de api-design.md y el inventario de recursos
  3. Si el área involucra IA → fragmentos de stages de IA y config-wa.json
  4. Si el área tiene configuraciones → fragmentos del inventario de variables de entorno
  5. Si el área maneja archivos → fragmentos de reglas de seguridad de subida de archivos

  Para CADA fragmento relevante encontrado, indica:
  - Archivo de origen y líneas
  - El fragmento de contenido (cita textual)
  - Por qué es relevante para la auditoría (qué tipo de discrepancia podría detectar)"
)
```

### 1.4 Extracción del plan de referencia (CodeReviewer)

**En Modo A** (plan concreto proporcionado): delegar en CodeReviewer para extraer las especificaciones del plan de forma estructurada:

```
task(
  subagent_type="CodeReviewer",
  description="Extraer especificaciones del plan de [área]",
  prompt="Lee el archivo del plan en la siguiente ruta y extrae sus especificaciones
  de forma estructurada:

  Ruta del plan: [plan de referencia]

  Extrae y clasifica:

  1. COMPONENTES ESPECIFICADOS: qué se dijo que debía crearse (clases, funciones,
     archivos, endpoints, configuraciones). Para cada uno: nombre, tipo, propósito.
  2. COMPORTAMIENTO ESPECIFICADO: cómo debía funcionar cada componente (reglas de
     negocio, algoritmos, flujos de decisión).
  3. INTERFACES Y CONTRATOS: firmas esperadas, tipos de datos, formatos de
     request/response, códigos de estado.
  4. FLUJOS ESPECIFICADOS: secuencias, estados, transiciones descritas en el plan.
  5. CONFIGURACIÓN ESPECIFICADA: variables de entorno, parámetros, endpoints,
     archivos de configuración del proyecto requeridos.
  6. SEGURIDAD ESPECIFICADA: requisitos de autenticación, autorización, validación,
     CORS, sanitización según el plan.
  7. LIMITACIONES Y RESTRICCIONES: lo que el plan dice explícitamente que NO debe
     hacerse o que debe evitarse.
  8. DEPENDENCIAS DECLARADAS: lo que el plan dice que el área debe usar (librerías,
     servicios, APIs externas).

  Para cada elemento, indica:
  - La sección del plan (título o línea aproximada)
  - El texto exacto relevante (cita textual entre comillas)
  - Una breve interpretación de lo que implica para la implementación"
)
```

**En Modo B** (sin plan concreto): no hay plan que extraer. La "referencia" será la definición del proyecto descubierta por ContextScout (guías existentes, estándares, convenciones de arquitectura, decisiones registradas, inventario de recursos). El paso anterior de ContextScout ya recopiló estos materiales; úsalos como referencia en Fase 2.

---

## Fase 2 — Comparación y Clasificación (OpenAgent)

Sintetiza todo el material recopilado en la Fase 1. Sigue estos pasos:

### 2.1 Mapeo plan → código

Crea una tabla de correspondencia entre lo especificado en el plan (o definición del proyecto) y lo implementado en el código. Para cada elemento del plan, determina:

| Estado | Significado |
|--------|-------------|
| **✅ Implementado** | El código implementa lo especificado sin desviaciones significativas |
| **⚠️ Implementado con diferencias** | Existe pero con cambios respecto al plan |
| **❌ No implementado** | Especificado en el plan pero ausente en el código |
| **➕ No especificado** | Presente en el código pero no mencionado en el plan |

### 2.2 Clasificar hallazgos por tipo y gravedad

#### Por tipo de inconsistencia

| Tipo | Código | Descripción | Ejemplo |
|------|--------|-------------|---------|
| **Omisión** | `OMIT` | Especificado en el plan pero no implementado | "El plan dice que debe haber un endpoint PUT /update pero no existe" |
| **Exceso** | `EXC` | Implementado pero no especificado en el plan | "El código tiene un validador extra que el plan no menciona" |
| **Discrepancia de comportamiento** | `DISC-B` | Implementado de forma diferente a lo especificado | "El plan dice timeout 30s, el código usa 120s" |
| **Discrepancia de estructura** | `DISC-E` | Naming, organización de archivos diferente al plan | "El plan dice `src/Auth/`, el código tiene `src/authentication/`" |
| **Discrepancia de configuración** | `DISC-C` | Variables, endpoints, parámetros que no coinciden | "El plan requiere DB_HOST, el código usa DATABASE_HOST" |
| **Discrepancia de seguridad** | `DISC-S` | Requisitos de auth/validación del plan no implementados | "El plan dice validar token en todas las rutas, falta en una" |
| **Inconsistencia interna** | `INT` | El código se contradice a sí mismo | "Una función espera string, otra que la llama le pasa int" |
| **Código muerto** | `DEAD` | Código presente pero no usado ni referenciado | "Función exportada que no se llama desde ningún sitio" |
| **Desviación de estándares** | `STD` | El código no sigue los estándares del proyecto | "No usa declare(strict_types=1) cuando el estándar lo exige" |
| **Discrepancia con inventario** | `DISC-I` | El código usa recursos no registrados en el inventario | "Endpoint en código que no existe en inventario_recursos.yaml" |

#### Por gravedad

| Gravedad | Significado | Acción recomendada |
|----------|-------------|-------------------|
| **🔴 Crítico** | Impide el funcionamiento o crea un riesgo de seguridad | Corregir antes de desplegar |
| **🟡 Alto** | Cambia el comportamiento esperado o introduce deuda técnica significativa | Corregir en el próximo ciclo |
| **🔵 Medio** | Desviación del plan sin impacto funcional inmediato | Documentar y planificar corrección |
| **⚪ Informativo** | Código extra, mejoras no planificadas, observaciones | Revisar si merece actualizar el plan |

### 2.3 Seleccionar writer

- **Por defecto: TechnicalWriter** — el informe de auditoría es 100% técnico
- Si los hallazgos son pocos y sencillos, o el usuario especificó `Writer override: DocWriter`, usar DocWriter

### 2.4 Preparar material para el writer

```
Área auditada: [nombre]
Plan de referencia: [ruta o "definición del proyecto" en Modo B]
Modo: [A — plan concreto | B — definición del proyecto]
Writer: [TechnicalWriter]

## Resumen ejecutivo
- Total de hallazgos: [n]
- Críticos: [n]
- Altos: [n]
- Medios: [n]
- Informativos: [n]
- Correctos (✅): [n]

## Tabla consolidada de hallazgos
[Lista completa con: ID, tipo, gravedad, archivo, descripción, referencia del plan]

## Detalle por hallazgo crítico
[Para cada 🔴: descripción detallada, evidencia (cita del plan + cita del código),
 impacto, corrección sugerida]

## Detalle por hallazgo alto
[Para cada 🟡: mismo formato]

## Detalle por hallazgo medio
[Para cada 🔵: mismo formato]

## Detalle por hallazgo informativo
[Para cada ⚪: mismo formato]

## Correcto (✅)
[Lo que el código implementa fielmente según el plan]

## Recomendaciones
[Qué acciones tomar, en qué orden, qué documentos actualizar]

## Referencias
- Plan analizado: [ruta]
- Archivos auditados: [lista]
- Documentos relacionados: [guías, estándares, etc.]
```

---

## Fase 3 — Generación del informe (TechnicalWriter / DocWriter)

### Opción por defecto: TechnicalWriter

```
task(
  subagent_type="DocWriter",
  description="Redactar informe de auditoría de [área]",
  prompt="[MODO: TechnicalWriter — redacción técnica, precisa, para consumo IA]

  Redacta un informe de auditoría técnica en español de España (es-ES).
  Redacción explícita, clara y detallada. Usa tablas, viñetas, diagramas cuando sea necesario.

  --- PERFIL TÉCNICO ---
  - Enfoque en precisión y evidencia, no narrativa
  - Cada afirmación debe estar respaldada por citas textuales
  - Prioriza: datos exactos, líneas de código, fragmentos del plan
  - El público principal es IA y desarrolladores

  Información de entrada:

  [MATERIAL DE LA FASE 2.4]

  Requisitos de formato:

  ### Estructura del informe
  - Portada con título, área, fecha y hora, modo de auditoría
  - Resumen ejecutivo (máximo 10 líneas)
  - Tabla consolidada de hallazgos (TODOS los hallazgos en una sola tabla)
  - Sección por cada hallazgo (ordenados por gravedad: críticos → altos → medios → informativos)
  - Sección de "Correcto (✅)" — lo que sí está bien
  - Recomendaciones priorizadas
  - Referencias

  ### Formato de cada hallazgo
  ```
  ### 🔴 [ID-HALLAZGO]: [Título descriptivo]

  **Tipo:** [OMIT | EXC | DISC-B | DISC-E | DISC-C | DISC-S | DISC-I | INT | DEAD | STD]
  **Gravedad:** [Crítico | Alto | Medio | Informativo]
  **Archivo:** [ruta al archivo, línea si aplica]
  **Plan dice:** [cita textual del plan o definición]
  **Código hace:** [descripción de lo que realmente hace el código]
  **Discrepancia:** [explicación de la diferencia]
  **Impacto:** [qué consecuencias tiene]
  **Corrección sugerida:** [qué habría que hacer para alinearlo]
  ```

  Guarda el informe en: stage-development-system/auditoria/auditoria-[area-descriptiva].md

  Devuelve confirmación con la ruta completa, número de hallazgos y fecha/hora de generación."
)
```

### Opción alternativa: DocWriter

Si el usuario especificó `Writer override: DocWriter` o los hallazgos son pocos y sencillos:

```
task(
  subagent_type="DocWriter",
  description="Redactar informe de auditoría de [área]",
  prompt="[MODO: DocWriter — narrativa general, para audiencia mixta]

  Redacta un informe de auditoría técnica en español de España (es-ES).
  Redacción clara y detallada. Usa tablas, viñetas cuando sea necesario.

  --- PERFIL GENERAL ---
  - Enfoque en claridad y legibilidad
  - Explica los hallazgos de forma accesible
  - El público principal incluye stakeholders no técnicos

  ... (mismas instrucciones que TechnicalWriter para el resto)
  [MATERIAL DE LA FASE 2.4]
  ..."
)
```

---

## Fase 4 — Revisión (CodeReviewer)

```
task(
  subagent_type="CodeReviewer",
  description="Revisar informe de auditoría de [área]",
  prompt="Revisa el informe de auditoría ubicado en:
  stage-development-system/auditoria/auditoria-[area-descriptiva].md

  Verifica estos 10 puntos:

  1. PRECISIÓN: Cada hallazgo, ¿está respaldado por evidencia real del código y del
     plan? No debe inventar nada.
  2. EVIDENCIA: ¿Las citas del plan y del código son textuales y verificables?
  3. GRAVEDAD: ¿La clasificación de gravedad es adecuada? (un hallazgo etiquetado
     como crítico debe ser realmente crítico)
  4. TIPO: ¿El tipo de inconsistencia (OMIT, EXC, DISC-B, etc.) es correcto?
  5. IMPACTO: ¿La descripción del impacto es realista y está justificada?
  6. CORRECCIÓN: ¿Las correcciones sugeridas son viables y resuelven el problema?
  7. COMPLETITUD: ¿Falta algún hallazgo importante que se haya pasado por alto
     en la comparación?
  8. CORRECTO: ¿Lo marcado como ✅ realmente coincide entre plan y código?
  9. REFERENCIAS: ¿Las referencias a archivos, líneas y documentos son correctas?
  10. INVENTARIO: ¿Los hallazgos son coherentes con el inventario de recursos
      (.gobernanza/inventario_recursos.yaml)? Si hay discrepancias con el inventario,
      ¿están documentadas como DISC-I?

  Si un hallazgo no tiene evidencia suficiente, márcalo como:
  'SIN EVIDENCIA SUFICIENTE — requiere verificación manual'.
  Si un hallazgo es incorrecto (el código SÍ coincide con el plan), márcalo como:
  'FALSO POSITIVO — eliminar del informe'.
  Si la gravedad está mal asignada, indica la corrección.

  Por cada problema encontrado, indica:
  - Sección del informe
  - El problema
  - La corrección sugerida

  Si NO hay errores, indica: 'REVISIÓN SUPERADA'
  Si HAY errores, indica: 'REVISIÓN CON ERRORES — requiere corrección'"
)
```

### Si hay errores

- Leer el output de CodeReviewer
- Delegar nuevamente en TechnicalWriter/DocWriter con las correcciones indicadas
- Volver a pasar por Fase 4

### Si la revisión es superada

Presentar al usuario un resumen con:

```
## Auditoría completada

**Área auditada:** [nombre]
**Modo:** [A — plan concreto | B — definición del proyecto]
**Plan de referencia:** [ruta o "definición del proyecto"]
**Informe:** stage-development-system/auditoria/auditoria-[area-descriptiva].md
**Fecha y hora:** [YYYY-MM-DD HH:MM]

### Resumen de hallazgos

| Gravedad | Cantidad |
|----------|:--------:|
| 🔴 Críticos | [n] |
| 🟡 Altos | [n] |
| 🔵 Medios | [n] |
| ⚪ Informativos | [n] |
| ✅ Correctos | [n] |
| **Total** | **[n]** |

### Top 3 hallazgos más importantes
1. [ID] [descripción breve]
2. [ID] [descripción breve]
3. [ID] [descripción breve]

### Writer utilizado
[TechnicalWriter | DocWriter]

### Revisión
[CodeReviewer: superada]

¿Confirmas la publicación de esta auditoría?
```

--- FIN DEL PROMPT ---
