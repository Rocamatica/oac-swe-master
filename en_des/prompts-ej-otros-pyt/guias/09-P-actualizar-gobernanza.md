# P-actualizar-gobernanza — Sincronizar .gobernanza/ tras nueva guía

> **Propósito:** Sincronizar el sistema de gobernanza (`.gobernanza/inventario_recursos.yaml`, `.gobernanza/navigation.md`) con la información generada por `03-P-crear-guia` o `04-P-actualizar-guia`, respetando estrictamente las reglas vinculantes del inventario de recursos (R1-R8).
> **Cuándo usarlo:** Inmediatamente después de ejecutar `03-P-crear-guia` (guía creada) o `04-P-actualizar-guia` (guía actualizada).
> **Última actualización:** 2026-06-12
> **Destino de la actualización:** `.gobernanza/`
> **Subagentes:** CodeReviewer, ContextScout

---

## INSTRUCCIONES PARA EL USUARIO — Cómo usar este prompt

### ¿Qué hace este prompt?

Toma una guía técnica recién creada o actualizada (por `03-P-crear-guia` o `04-P-actualizar-guia`) y sincroniza el sistema de gobernanza del proyecto (`.gobernanza/`) para que refleje ese conocimiento:

- Detecta **nuevos recursos, variables de entorno, endpoints, componentes** que la guía menciona y que aún no están registrados en el inventario
- Te **propone los cambios** para que los apruebes (obligatorio por reglas del proyecto)
- Aplica los cambios solo tras tu aprobación
- Valida contra el schema automáticamente

### ¿Cuándo ejecutarlo?

| Si acabas de ejecutar... | Ejecuta esto... |
|--------------------------|-----------------|
| `03-P-crear-guia.md` → guía creada | ✅ `09-P-actualizar-gobernanza.md` |
| `04-P-actualizar-guia.md` → guía actualizada | ✅ `09-P-actualizar-gobernanza.md` |

### ¿Cómo se ejecuta?

**Paso 1 — Copia todo el contenido del bloque «PROMPT»** (desde `--- INICIO DEL PROMPT ---` hasta `--- FIN DEL PROMPT ---`).

**Paso 2 — Pégalo como primer mensaje** en el chat del agente IA (OpenAgent, OpenCode, etc.).

**Paso 3 — Completa el campo obligatorio:**

```
Guía de referencia: [ruta al subdirectorio de la guía, ej: stage-management-system/conocimiento-guias-ia/workflow-engine/]
```

**Paso 4 (opcional) — Añade campos opcionales** si necesitas control adicional:

```
Tipo de guía: [creada | actualizada]     ← ayuda al agente a saber el alcance
```

**Paso 5 — El agente ejecutará las fases y te presentará una propuesta de cambios.** Deberás aprobarla antes de que se aplique nada.

### ¿Qué obtienes como resultado?

- Propuesta detallada de nuevos recursos a registrar en `.gobernanza/inventario_recursos.yaml`
- Propuesta de actualización de `.gobernanza/navigation.md` si procede
- Validación contra schema tras cada cambio
- Respeto estricto de las reglas R1-R8 del inventario

### Reglas del proyecto que aplican

Este prompt opera bajo la autoridad de `.gobernanza/inventario-recursos-reglas.md`:

| Regla | Aplica |
|-------|:------:|
| **R1** — SSOT: el inventario es la fuente de verdad única | ✅ |
| **R2** — No inventar recursos no documentados | ✅ |
| **R3** — Aprobación previa del usuario para nombres nuevos | **🚨 OBLIGATORIO** |
| **R4** — Validación contra schema tras cada modificación | ✅ |
| **R5** — Integridad de referencias cruzadas | ✅ |
| **R6** — Sin histórico ni bitácora en el YAML | ✅ |
| **R7** — Actualización obligatoria antes de integrar | ✅ |
| **R8** — Extensiones controladas con aprobación + schema | ✅ |

**Importante:** El agente **no modificará nada sin tu aprobación explícita** (R3). Se detendrá y te presentará una propuesta para que confirmes antes de aplicar.

---

--- INICIO DEL PROMPT ---

# P-actualizar-gobernanza — Sincronizar .gobernanza/ tras nueva guía

> **Propósito:** Sincronizar el sistema de gobernanza (`.gobernanza/inventario_recursos.yaml`, `.gobernanza/navigation.md`) con la información generada por `03-P-crear-guia` o `04-P-actualizar-guia`, respetando estrictamente las reglas vinculantes del inventario de recursos (R1-R8).
> **Cuándo usarlo:** Inmediatamente después de ejecutar `03-P-crear-guia` (guía creada) o `04-P-actualizar-guia` (guía actualizada).
> **Destino de la actualización:** `.gobernanza/`
> **Subagentes:** CodeReviewer, ContextScout

---

## Instrucciones para el agente

### Archivos que debes leer antes de actuar

Antes de comenzar, lee COMPLETAMENTE estos archivos. Son vinculantes y están por encima de cualquier otra instrucción:

1. `.gobernanza/inventario-recursos-reglas.md` — reglas R1 a R8 (obligatorio)
2. `.gobernanza/inventario_recursos.yaml` — el inventario actual (para conocer el estado)
3. `.gobernanza/navigation.md` — el mapa de configuración actual
4. `.gobernanza/schemas/inventario_recursos.schema.json` — schema de validación

Si no los has leído: DETENTE. Lee ahora. Luego confirma explícitamente:
> *"He leído las reglas vinculantes en inventario-recursos-reglas.md. Procedo bajo su autoridad."*

Sin esta confirmación, ninguna edición al inventario es válida.

### Reglas estrictas

1. **No ejecutes nada** hasta completar todas las lecturas y definiciones del plan.
2. **No modifiques nada sin aprobación explícita del usuario** (exigido por R3).
3. **No asumas** conocimiento previo. Verifica contra la guía real y el inventario real.
4. **Toda la información propuesta debe estar respaldada** por el contenido de la guía. No inventes recursos.
5. **Cada nueva entrada propuesta debe seguir las convenciones de nombrado:**
   - Variables de entorno: `MAYUSCULAS_CON_GUIONES_BAJOS`
   - Endpoints y componentes: kebab-case o snake_case, en inglés
   - Prefijos de ámbito: `PUBLIC_`, `INTERNAL_`, `SECRET_` cuando aplique
6. **Valida contra el schema después de cada modificación** (exigido por R4).
7. **Verifica integridad de referencias cruzadas** (exigido por R5).

### Flujo general

```
Guía de referencia (03 o 04)
     ↓
F1: CodeReviewer extrae recursos de la guía (variables, endpoints, componentes, contratos, configuraciones)
     ↓
F2: ContextScout descubre estado actual de .gobernanza/ (qué hay ya registrado)
     ↓
F3: OpenAgent compara guía vs inventario → detecta qué falta o debe actualizarse
     ↓
F4: CodeReviewer valida las propuestas contra schema + reglas de nombrado
     ↓
═════════════════════════════════════════════════
  PROPUESTA AL USUARIO — Esperar aprobación (R3)
═════════════════════════════════════════════════
     ↓  (solo tras aprobación)
F5: Aplica cambios + valida contra schema (R4)
     ↓
F6: Resumen con fecha/hora + cambios aplicados
```

---

## Entrada del usuario

El usuario indicará los siguientes campos. El **obligatorio** es imprescindible. El **opcional** se puede omitir.

```
--- CAMPO OBLIGATORIO ---

Guía de referencia: [ruta al subdirectorio de la guía, ej: stage-management-system/conocimiento-guias-ia/workflow-engine/]

--- CAMPO OPCIONAL ---

Tipo de guía: [creada | actualizada]
   creada     → la guía es nueva, todo su contenido es nuevo (por defecto)
   actualizada → la guía ya existía y se ha modificado, solo los cambios son nuevos
```

Usa esta información para guiar todas las fases.

---

## Fase 1 — Extracción de recursos de la guía (CodeReviewer)

Delegar en CodeReviewer para analizar la guía fuente y extraer todos los recursos que deberían estar registrados en el inventario:

```
task(
  subagent_type="CodeReviewer",
  description="Extraer recursos de guía [RUTA]",
  prompt="Lee los 3 documentos de la guía técnica ubicada en:
  [Guía de referencia]

   - 01-ficha-rapida.md
   - 02-arquitectura.md
   - 03-referencia-operativa.md

  Lee cada documento COMPLETAMENTE.

  Extrae y clasifica los siguientes recursos que deberían estar registrados
  en .gobernanza/inventario_recursos.yaml:

  1. VARIABLES DE ENTORNO: cualquier mención a variables de configuración que
     afecten al área documentada. Para cada una:

     - nombre: (MAYUSCULAS_CON_GUIONES_BAJOS)
     - tipo: (secret | config_backend | config_frontend | sql_query | mensaje)
     - proposito: (qué hace, 1 línea)
     - destino: (.env | config-wa.json | config-fe.json | config-sql-query.json | config-mensajes.json)
     - requerido: (true | false)
     - notas: (valor por defecto o condiciones, si aplica)
     - origen: (sección de la guía donde se menciona)

  2. ENDPOINTS: rutas y métodos que el área expone o consume. Para cada uno:

     - nombre: (identificador kebab-case, ej: auth-login)
     - url: (ruta, ej: /login)
     - metodo: (GET | POST | PUT | DELETE)
     - autenticacion: (true | false)
     - proposito: (1 línea)
     - servicio_externo: (true | false, si es una API externa)
     - origen: (sección de la guía)

  3. COMPONENTES INTERNOS: módulos, clases, servicios, tablas. Para cada uno:

     - nombre: (identificador snake_case, ej: auth_service)
     - tipo: (servicio | clase | modulo | tabla_bd)
     - proposito: (1 línea)
     - ruta: (ruta en el proyecto, si aplica)
     - dependencias: (lista de otros componentes, si aplica)
     - origen: (sección de la guía)

  4. CONTRATOS ENTRE SERVICIOS: si el área se comunica con otros servicios.
     Para cada uno:

     - id: (identificador, ej: cont_auth_api)
     - servicio_origen: (componente que inicia la comunicación)
     - servicio_destino: (componente destino)
     - endpoint: (ruta del endpoint)
     - metodo: (GET | POST | PUT | DELETE)
     - notas: (detalles de autenticación, formato, etc.)
     - origen: (sección de la guía)

  5. RUTAS DE CONFIGURACIÓN: archivos de configuración nuevos que el área
     introduce o requiere. Para cada uno:

     - archivo: (ruta al archivo)
     - proposito: (1 línea)
     - formato: (json | yaml | xml | sql | clave=valor)
     - versionado: (true | false)
     - origen: (sección de la guía)

  Para CADA recurso extraído, indica:
  - El recurso con todos sus campos
  - El documento de origen (01, 02, o 03) y la sección
  - Si es NUEVO (no existe en el inventario actual) o EXISTENTE (ya registrado)

  Si el Tipo de guía es 'actualizada', presta especial atención a los recursos
  que han CAMBIADO respecto a la versión anterior."
)
```

**Salida de Fase 1:** Lista completa de recursos extraídos de la guía, clasificados por tipo (variables, endpoints, componentes, contratos, configuraciones), marcados como NUEVOS o EXISTENTES.

---

## Fase 2 — Estado actual de .gobernanza/ (ContextScout)

Delegar en ContextScout para descubrir el estado actual del sistema de gobernanza:

```
task(
  subagent_type="ContextScout",
  description="Descubrir estado de .gobernanza/",
  prompt="Analiza el estado actual del sistema de gobernanza:

  1. Lee .gobernanza/inventario_recursos.yaml COMPLETAMENTE
  2. Lee .gobernanza/navigation.md COMPLETAMENTE

  Identifica:

  1. VARIABLES YA REGISTRADAS: lista de variables de entorno existentes en el
     inventario, agrupadas por sección (BD, Aplicación, APIs IA, Autenticación, etc.)
  2. ENDPOINTS YA REGISTRADOS: lista de endpoints existentes, tanto internos como externos
  3. COMPONENTES YA REGISTRADOS: lista de servicios, clases, módulos y tablas existentes
  4. CONTRATOS YA REGISTRADOS: lista de contratos entre servicios existentes
  5. RUTAS DE CONFIGURACIÓN YA REGISTRADAS: archivos de configuración existentes en el inventario
  6. NAVIGATION ACTUAL: qué archivos están mapeados en navigation.md
  7. ÚLTIMA REVISIÓN: fecha de la última revisión registrada en el inventario
     (gobernanza.ultima_revision)

  Devuelve la información estructurada para poder compararla con los recursos
  extraídos de la guía en Fase 1."
)
```

**Salida de Fase 2:** Estado completo del inventario actual y navigation.md, estructurado por secciones.

---

## Fase 3 — Comparación y detección de diferencias (OpenAgent)

Sintetiza los hallazgos de Fase 1 y Fase 2. Para cada recurso extraído de la guía, determina:

| Estado | Significado | Acción |
|--------|-------------|--------|
| **✅ Ya registrado** | El recurso ya existe en el inventario con los mismos datos | No hacer nada |
| **⚠️ Discrepancia** | El recurso existe pero los datos difieren (ej: distinto tipo, destino, o propósito) | Proponer actualización |
| **🆕 No registrado** | El recurso no existe en el inventario | Proponer alta (R3) |
| **📦 Nueva sección** | Los recursos no encajan en ninguna sección existente | Proponer nueva sección (R8) |

### Clasificar por sección del inventario

Para los recursos nuevos, determinar en qué sección del inventario deben ubicarse:

| Tipo de recurso | Sección en inventario_recursos.yaml |
|-----------------|-------------------------------------|
| Variables de entorno | `variables_entorno` |
| Endpoints y URLs | `endpoints` |
| Componentes internos | `componentes_internos` |
| Contratos entre servicios | `contratos_servicios` |
| Rutas de configuración | `rutas_configuracion` |

Si algún recurso no encaja en ninguna de las 5 secciones existentes -> **aplicar R8** (proponer nueva sección con su estructura y schema).

### Preparar propuesta estructurada

Para CADA recurso nuevo o con discrepancies, preparar:

```
## [TIPO] — [nombre del recurso]

Estado: [🆕 Nuevo | ⚠️ Discrepancia]
Sección: [variables_entorno | endpoints | componentes_internos | contratos_servicios | rutas_configuracion]
Datos propuestos:
  [campo1]: [valor1]
  [campo2]: [valor2]
  ...
Origen: [documento y sección de la guía]
Justificación: [por qué debería registrarse]
```

---

## Fase 4 — Validación de propuestas (CodeReviewer)

Antes de presentar al usuario, validar que las propuestas cumplen con las reglas del inventario:

```
task(
  subagent_type="CodeReviewer",
  description="Validar propuestas de nuevos recursos",
  prompt="Valida las siguientes propuestas de nuevos recursos para el inventario
  contra las reglas vinculantes de .gobernanza/inventario-recursos-reglas.md.

  PROPUESTAS:
  [LISTA DE PROPUESTAS DE FASE 3]

  Verifica para cada una:

  1. CONVENCIONES DE NOMBRADO (R3):
     - Variables de entorno: MAYUSCULAS_CON_GUIONES_BAJOS, sin abreviaciones
     - Endpoints y componentes: kebab-case o snake_case, descriptivos, en inglés
     - Prefijos de ámbito: PUBLIC_, INTERNAL_, SECRET_ cuando aplique
     - Los nombres NO deben estar abreviados ni ser crípticos

  2. NO DUPLICACIÓN (R1):
     - ¿El recurso ya existe en el inventario con otro nombre?
     - ¿Hay algún recurso existente que cubra el mismo propósito?

  3. INTEGRIDAD DE REFERENCIAS (R5):
     - Si el recurso tiene dependencias, ¿esas dependencias existen como entradas?
     - Si el recurso es un contrato, ¿servicio_origen y servicio_destino existen?

  4. CLASIFICACIÓN CORRECTA:
     - ¿El tipo asignado es correcto según RG-C? (secret, config_backend, etc.)
     - ¿La sección del inventario es la adecuada?

  5. R8 — NUEVA SECCIÓN: (si aplica)
     - ¿Realmente no encaja en las 5 secciones existentes?
     - ¿La estructura propuesta para la nueva sección tiene definición en schema?

  Para cada problema encontrado, indica:
  - El recurso
  - La regla violada
  - La corrección sugerida

  Si NO hay problemas, indica: 'VALIDACIÓN DE PROPUESTAS SUPERADA'
  Si HAY problemas, indica: 'VALIDACIÓN CON ERRORES — corregir propuestas'"
)
```

**Si hay errores en las propuestas:** corregir según las sugerencias de CodeReviewer y repetir Fase 4.

---

## Punto de control — Propuesta al usuario (R3)

Una vez superada la validación, presentar la propuesta al usuario con este formato EXACTO y **DETENERSE** a esperar respuesta:

```
## Propuesta de actualización de .gobernanza/

**Guía de referencia:** [ruta]
**Tipo:** [creada | actualizada]
**Fecha y hora:** [YYYY-MM-DD HH:MM]

### Resumen de cambios propuestos

| Sección | 🆕 Nuevos | ⚠️ Discrepancias | ✅ Sin cambios |
|---------|:--------:|:-----------------:|:--------------:|
| variables_entorno | [n] | [n] | [n] |
| endpoints | [n] | [n] | [n] |
| componentes_internos | [n] | [n] | [n] |
| contratos_servicios | [n] | [n] | [n] |
| rutas_configuracion | [n] | [n] | [n] |
| navigation.md | [n] | [n] | [n] |

### Detalle de cambios propuestos

[Por cada recurso nuevo o con discrepancia, mostrar:

#### 🆕 variables_entorno: NOMBRE_VARIABLE

**Tipo:** [secret | config_backend]
**Propósito:** [descripción]
**Destino:** [.env | config-wa.json | ...]
**Requerido:** [true | false]
**Origen:** [documento y sección de la guía]

... (repetir para cada recurso nuevo o modificado) ]

---

**REGLAS APLICABLES:**
- R3: Debes aprobar explícitamente los nombres nuevos antes de registrarlos
- R4: Se validará contra schema después de aplicar los cambios
- Si algún nombre no te convence, indícalo y se ajustará

**¿Apruebas la aplicación de estos cambios?** (responde Sí / No / Modificar)
```

**El agente NO continúa hasta recibir respuesta del usuario.** Esto es obligatorio (R3).

**Si el usuario responde «Sí»:** proceder a Fase 5.

**Si el usuario responde «No»:** detener el proceso. No aplicar cambios.

**Si el usuario responde «Modificar» con indicaciones:** ajustar las propuestas según las indicaciones y volver a presentar.

---

## Fase 5 — Aplicación de cambios (solo tras aprobación)

**Esta fase solo se ejecuta después de la aprobación explícita del usuario (R3).**

### 5.1 Actualizar inventario_recursos.yaml

Para cada recurso aprobado:

- **Nuevo:** añadir la entrada completa en la sección correspondiente del YAML
- **Discrepancia:** actualizar los campos modificados
- **Nueva sección (R8):** crear la sección en el YAML + actualizar el schema JSON

Usar el formato exacto del inventario existente (mantener indentación, orden alfabético dentro de cada sección, etc.).

### 5.2 Validar contra schema (R4)

Inmediatamente después de cada modificación:

```bash
check-jsonschema --schemafile .gobernanza/schemas/inventario_recursos.schema.json \
    .gobernanza/inventario_recursos.yaml
```

**Si la validación falla:**
- El cambio NO es válido
- Corregir hasta que pase
- No continuar sin validación exitosa

### 5.3 Actualizar navigation.md (si procede)

Si se ha añadido alguna ruta de configuración nueva o archivo relevante, actualizar `.gobernanza/navigation.md` para reflejarlo.

### 5.4 Actualizar ultima_revision

Actualizar el campo `gobernanza.ultima_revision` en el inventario con la fecha actual.

---

## Fase 6 — Resumen y confirmación

Presentar al usuario el resultado final:

```
## Gobernanza actualizada

**Guía de referencia:** [ruta]
**Fecha y hora de actualización:** [YYYY-MM-DD HH:MM]

### Cambios aplicados

| Sección | Acción | Recursos afectados |
|---------|--------|-------------------|
| variables_entorno | [nuevos: n / actualizados: n / sin cambios] | [lista] |
| endpoints | [nuevos: n / actualizados: n / sin cambios] | [lista] |
| componentes_internos | [nuevos: n / actualizados: n / sin cambios] | [lista] |
| contratos_servicios | [nuevos: n / actualizados: n / sin cambios] | [lista] |
| rutas_configuracion | [nuevos: n / actualizados: n / sin cambios] | [lista] |
| navigation.md | [actualizado / sin cambios] | [archivos afectados] |

### Validaciones

| Validación | Resultado |
|------------|-----------|
| check-jsonschema (R4) | [PASS / FAIL → corregido] |
| Integridad referencias (R5) | [OK / ajustes] |
| Convenciones de nombrado (R3) | [OK / ajustes] |

### Reglas cumplidas

- ✅ R1 — SSOT: inventario actualizado como fuente de verdad única
- ✅ R3 — Nombres aprobados por el usuario
- ✅ R4 — Validación contra schema superada
- ✅ R5 — Referencias cruzadas íntegras
- ✅ R6 — Sin histórico ni bitácora añadidos
- ✅ R7 — Actualización antes de integrar
- [✅ R8 — Nueva sección creada con schema] (si aplica)

¿Confirmas la integración de estos cambios?
```

--- FIN DEL PROMPT ---
