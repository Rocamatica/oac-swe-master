# P-auditar-directorio — Auditoría de directorio contra código actual

> **Propósito:** Ejecutar explore + ContextScout + CodeReviewer sobre un directorio específico para detectar paths rotos, info desactualizada, duplicaciones y discrepancias contra el código actual. No modifica nada, solo informa.
> **Cuándo usarlo:** Antes de limpiar, reestructurar o actualizar cualquier directorio del proyecto.
> **Última actualización:** 2026-06-12
> **Subagentes:** explore, ContextScout, CodeReviewer, BuildAgent (opcional)
> **Salida:** `stage-development-system/auditoria/auditoria-[nombre-directorio].md`

---

## INSTRUCCIONES PARA EL USUARIO — Cómo usar este prompt

### ¿Qué hace este prompt?

Escanea un directorio específico del proyecto y lo compara contra el código actual. Detecta:

- **Paths rotos**: referencias a archivos o directorios que ya no existen
- **Info desactualizada**: contenido que contradice el código actual
- **Duplicaciones**: contenido que ya existe en `conocimiento-guias-ia/`
- **Discrepancias con estándares**: desviaciones de las reglas del proyecto
- **Discrepancias con el inventario**: recursos mencionados que no están en `inventario_recursos.yaml`

No modifica nada. Solo genera un informe con hallazgos clasificados por severidad.

### ¿Cómo se ejecuta?

**Paso 1 — Copia todo el contenido del bloque «PROMPT»** (desde `--- INICIO DEL PROMPT ---` hasta `--- FIN DEL PROMPT ---`).

**Paso 2 — Pégalo como primer mensaje** en el chat del agente IA (OpenAgent, OpenCode, etc.).

**Paso 3 — Completa el campo obligatorio:**

```
Ruta a auditar: [ruta/completa/del/directorio]
Ej: stage-management-system/conocimiento-guias-ia/
```

**Paso 4 (opcional) — Añade campos opcionales** si necesitas control adicional:

```
Skip BuildAgent: [true | false]     ← true=omite verificación de paths (por defecto false)
```

**Paso 5 — El agente ejecutará las fases y te presentará el informe.**

### ¿Qué obtienes como resultado?

- `stage-development-system/auditoria/auditoria-[nombre-directorio].md` con el informe
- Hallazgos clasificados por severidad: 🔴 Críticos, 🟡 Altos/Medios, 🟢 Informativos
- Cada hallazgo incluye: archivo, problema, acción recomendada
- Verificación de que el directorio está sano o necesita intervención

### Consideraciones

- **No se modifica ningún archivo.** Es solo diagnóstico.
- **La auditoría es útil antes de:** limpiar un directorio, reestructurarlo, migrar contenido, o verificar consistencia.
- **BuildAgent opcional** verifica que las rutas de archivo mencionadas en los documentos del directorio realmente existen en el filesystem.

---

--- INICIO DEL PROMPT ---

# P-auditar-directorio — Auditoría de directorio contra código actual

> **Propósito:** Ejecutar explore + ContextScout + CodeReviewer sobre un directorio específico para detectar paths rotos, info desactualizada, duplicaciones y discrepancias contra el código actual. No modifica nada, solo informa.
> **Cuándo usarlo:** Antes de limpiar, reestructurar o actualizar cualquier directorio del proyecto.
> **Subagentes:** explore, ContextScout, CodeReviewer, BuildAgent (opcional)
> **Salida:** `stage-development-system/auditoria/auditoria-[nombre-directorio].md`

---

## Instrucciones para el agente

1. No modifiques ningún archivo. Solo analiza e informa.
2. Verifica todo contra el código actual del proyecto.
3. Al finalizar, guarda el informe en `stage-development-system/auditoria/auditoria-[nombre].md`.

---

## Entrada del usuario

El usuario indicará la ruta a auditar. El campo **obligatorio** es imprescindible. Los **opcionales** se pueden omitir.

```
--- CAMPO OBLIGATORIO ---

Ruta a auditar: [ruta/completa/del/directorio]

--- CAMPO OPCIONAL ---

Skip BuildAgent: [true | false]   ← true=omite verificación de paths (por defecto false)
```

---

## Fase 1 — Exploración (explore)

Delegar en el agente explore para mapear el directorio a auditar:

```
task(
  subagent_type="explore",
  description="Explorar directorio [RUTA]",
  prompt="Explora el directorio [RUTA] con nivel de profundidad 'very thorough'.

  Identifica y devuelve:

  1. LISTADO COMPLETO: todos los archivos del directorio (recursivo) con ruta completa
  2. TOTAL: número total de archivos
  3. ESTRUCTURA: organización del directorio (subdirectorios, jerarquía)
  4. ÍNDICE: verifica si existe 00_INDICE.md, INDEX.md o README.md
  5. TIPOS DE ARCHIVO: clasificación por extensión (.md, .php, .json, .yaml, etc.)
  6. ARCHIVOS PRINCIPALES: los archivos más grandes o relevantes del directorio
     (por tamaño o por ser puntos de entrada)

  Devuelve la información estructurada para su análisis posterior."
)
```

---

## Fase 2 — ContextScout

```
task(
  subagent_type="ContextScout",
  description="Contexto sobre [RUTA]",
  prompt="Analiza el directorio [RUTA] y su contexto en el proyecto.

  Busca en .opencode/context/, stage-management-system/, src/,
  y conocimiento-guias-ia/ referencias cruzadas relacionadas.

  Para cada archivo o grupo de archivos en [RUTA], identifica:
  1. Ruta y propósito
  2. Referencias cruzadas desde otras partes del proyecto
  3. Paths rotos (referencias a archivos/dirs que no existen)
  4. Duplicación con conocimiento-guias-ia/ si aplica"
)
```

---

## Fase 3 — CodeReviewer

```
task(
  subagent_type="CodeReviewer",
  description="Verificar [RUTA] contra código",
  prompt="Analiza los archivos en [RUTA] contra el código actual.

  Para cada archivo o grupo, verifica estos 7 puntos:

  1. VIGENCIA: ¿La información sigue siendo válida según el código actual?
     (funcionalidades, clases, endpoints que ya no existen o han cambiado)

  2. PATHS ROTOS: ¿Las referencias a archivos, directorios o rutas existen
     realmente en el proyecto?

  3. DISCREPANCIAS: ¿Hay información que contradiga el código actual?
     (configuraciones, valores, comportamientos que ya no son correctos)

  4. DUPLICACIÓN: ¿El mismo contenido existe en conocimiento-guias-ia/?
     (posible duplicación con guías técnicas existentes)

  5. RECOMENDACIÓN: para cada archivo o grupo, recomendar:
     - Mantener (está correcto y vigente)
     - Actualizar (la info es correcta pero está desactualizada)
     - Integrar (duplicado, fusionar con otra fuente)
     - Eliminar (obsoleto, sin referencias, código muerto)

  6. INVENTARIO: ¿Los recursos mencionados (variables de entorno, endpoints,
     componentes) existen en .gobernanza/inventario_recursos.yaml?
     Si se menciona algo que no está en el inventario, reportarlo.

  7. ESTÁNDARES: ¿El contenido del directorio sigue los estándares del proyecto?
     (code-quality.md, security-patterns.md, convenciones de nomenclatura)

  Código real de referencia:
  - Capa de aplicación → lógica de negocio (src/Application/)
  - .opencode/context/ → estándares y contexto
  - stage-management-system/conocimiento-guias-ia/ → guías actuales
  - .gobernanza/inventario_recursos.yaml → inventario de recursos
  - composer.json, .env, archivos de configuración → configuración

  NO modifiques ningún archivo. Solo reporta.

  Para cada hallazgo, indica:
  - Archivo y línea (aproximada)
  - El problema concreto
  - La severidad (🔴 Crítico / 🟡 Alto/Medio / 🟢 Informativo)
  - La acción recomendada"
)
```

---

## Fase 4 — BuildAgent (opcional)

Si el usuario **no** especificó `Skip BuildAgent: true`, delegar en BuildAgent para verificar que las rutas de archivo mencionadas en los documentos del directorio realmente existen:

```
task(
  subagent_type="BuildAgent",
  description="Verificar paths en [RUTA]",
  prompt="Revisa los archivos del directorio [RUTA] y verifica que todas las
  referencias a rutas de archivo (src/..., bin/..., public/..., templates/..., etc.)
  que aparecen en el contenido sean válidas.

  Para cada referencia encontrada:
  1. ¿La ruta absoluta existe en el filesystem?
  2. ¿El archivo referenciado existe?
  3. Si la ruta es relativa, ¿resuelve correctamente?

  No modifiques nada. Solo reporta los paths rotos encontrados."
)
```

---

## Fase 5 — Informe

Sintetiza los hallazgos de todas las fases y guarda en `stage-development-system/auditoria/auditoria-[nombre].md` con esta estructura:

```markdown
# Auditoría — [ruta]

> **Generado por:** explore + ContextScout + CodeReviewer [ + BuildAgent]
> **Fecha y hora:** [YYYY-MM-DD HH:MM]
> **Total archivos:** [n]

---

## Índice

1. [Resumen](#1-resumen)
2. [🔴 Críticos](#2--críticos)
3. [🟡 Altos/Medios](#3--altosmedios)
4. [🟢 Informativos](#4--informativos)

---

## 1. Resumen

| Hallazgo | Severidad | Archivo |
|----------|:---------:|---------|
| ... | 🔴 Crítico | ... |

### Totales
- 🔴 Críticos: [n]
- 🟡 Altos/Medios: [n]
- 🟢 Informativos: [n]
- ✅ Correctos/Sin problemas: [n]

---

## 2. 🔴 Críticos

(Detalle de cada hallazgo crítico. Cada uno debe incluir: qué archivo, cuál es el problema, qué debería hacerse.)

---

## 3. 🟡 Altos/Medios

(Detalle de hallazgos medios. Mismo formato.)

---

## 4. 🟢 Informativos

- ✅ Lo que está correcto
- ℹ️ Observaciones

---

## Recomendaciones

[Lista priorizada de acciones recomendadas]
```

--- FIN DEL PROMPT ---
