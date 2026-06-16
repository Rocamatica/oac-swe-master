# Estado de los Prompts del Sistema de Guías

> **Generado por:** OpenAgent (OCA)
> **Fecha y hora:** 2026-06-12
> **Propósito:** Reporte del estado actual de todos los prompts en `stage-management-system/prompts/guias/` tras las mejoras integrales aplicadas.

---

## Índice

1. [Resumen del estado](#1-resumen-del-estado-completo-de-los-prompts)
2. [Arquitectura del Sistema de Guías](#2-arquitectura-del-sistema-de-guías)
3. [Flujo de trabajo completo](#3-flujo-de-trabajo-completo)
4. [Mejoras transversales aplicadas](#4-mejoras-transversales-aplicadas)
5. [Subagentes utilizados por prompt](#5-subagentes-utilizados-por-prompt)
6. [Tamaño de los archivos](#6-tamaño-de-los-archivos)
7. [Notas](#7-notas)

---

<a id="1-resumen-del-estado-completo-de-los-prompts"></a>
## 1. Resumen del estado completo de los prompts

| # | Prompt | Líneas | Estado |
|:-:|--------|:------:|:------:|
| — | `01-recapitulacion-sistema-guias.md` | — | ❌ Eliminado (contenido migrado a 01-flujo-trabajo-uso-rapido.md) |
| — | `01-flujo-trabajo-uso-rapido.md` | — | 🆕 Nuevo (guía visual de uso) |
| 03 | `P-crear-guia.md` | 638 | ✅ Actualizado |
| 04 | `P-actualizar-guia.md` | 672 | ✅ Actualizado |
| 05 | `P-tematicas-guia.md` | 381 | ✅ Actualizado |
| 06 | `P-auditar-directorio.md` | 280 | ✅ Actualizado |
| 07 | `P-auditar-codigo-vs-plan.md` | 590 | ✅ Actualizado |
| 08 | `P-sincronizar-contexto.md` | 320 | 🆕 Nuevo |
| 09 | `P-actualizar-gobernanza.md` | 509 | 🆕 Nuevo |
| — | `ejemplos-uso-prompts.md` | — | 🔄 Renombrado + actualizado |

---

<a id="2-arquitectura-del-sistema-de-guías"></a>
## 2. Arquitectura del Sistema de Guías

> *Contenido migrado desde 01-recapitulacion-sistema-guias.md (documento de diseño original). Ahora en 01-flujo-trabajo-uso-rapido.md como «Contenido ampliado».*

### Objetivo del sistema

Crear guías técnicas **reutilizables, agnósticas y completas** sobre cualquier parte/función/área del proyecto, para que un agente IA de OpenCode/OpenAgentControl pueda:

- Entender qué es y para qué sirve
- Conocer sus elementos, componentes y artefactos
- Comprender dependencias internas y externas
- Saber cómo crearlo, usarlo, configurarlo y ejecutarlo
- Evitar errores conocidos (no corregirlos, **evitarlos**)

Sin necesidad de tener contexto previo sobre esa parte del sistema.

### Cuándo se usa

- Al **crear** una nueva función en el proyecto
- Al **modificar/mejorar** una función existente

Se lanza al finalizar el desarrollo de esa parte, aprovechando el conocimiento fresco.

### Estructura de la guía (3 documentos)

Cada guía se compone de 3 documentos con **referencias cruzadas obligatorias** para evitar duplicación y versiones descoordinadas.

| Documento | Tamaño | Propósito | Contenido | Público |
|-----------|:------:|-----------|-----------|---------|
| **01-ficha-rapida.md** | Máx. 100 líneas | Visión general para decidir si leer los otros docs | Qué es, para qué sirve, dónde está, archivos clave, dependencias principales | IA que necesita contexto rápido |
| **02-arquitectura.md** | — | Explicar cómo funciona, no cómo se usa | Diagramas Mermaid, flujos, ciclos de vida, relaciones entre componentes, árboles de dependencia | IA que va a modificar o extender la funcionalidad |
| **03-referencia-operativa.md** | — | Explicar cómo se usa, no cómo funciona | Configuración, creación, comandos, ejemplos de código, troubleshooting, errores conocidos | IA que va a operar o configurar la funcionalidad |

### Reglas de los 3 docs

- Cada doc referencia explícitamente a los otros 2 cuando un tema se solapa
- No repetir explicaciones entre docs
- Si un contenido es relevante para más de un doc, se pone en uno y se referencia desde los otros

### Ubicación de las guías

```
stage-management-system/conocimiento-guias-ia/
├── [area-descriptiva]/
│   ├── 01-ficha-rapida.md
│   ├── 02-arquitectura.md
│   └── 03-referencia-operativa.md
└── ...
```

Los nombres `01`, `02`, `03` son fijos para todas las áreas. El sufijo descriptivo también es fijo. El subdirectorio `[area-descriptiva]` es el único que varía según la parte del proyecto documentada.

---

<a id="3-flujo-de-trabajo-completo"></a>
## 3. Flujo de trabajo completo

```
Desarrollo nuevo → 03-P-crear-guia.md → GUÍA CREADA
                                            ↓
Mejora existente → 04-P-actualizar-guia.md → GUÍA ACTUALIZADA
                                                ↓
                              ┌── 08-P-sincronizar-contexto ──→ .opencode/context/
                              │         (vía /context extract, organize, validate)
                              │
                              └── 09-P-actualizar-gobernanza ──→ .gobernanza/
                                                                      ↓
                                                                [user aprueba R3]
                                                                      ↓
                                                          + validación schema (R4)
```

> **Nota:** El `01-flujo-trabajo-uso-rapido.md` contiene diagramas Mermaid interactivos de este mismo flujo, incluyendo los transversales y el mapa completo del sistema.

---

<a id="4-mejoras-transversales-aplicadas"></a>
## 4. Mejoras transversales aplicadas

| Mejora | 03 | 04 | 05 | 06 | 07 | 08 | 09 |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| Instrucciones de usuario | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Bloque --- INICIO / --- FIN | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Engram eliminado | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| explore (mapeo estructural) | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| ContextRetriever | ✅ | ✅ | ✅ | ❌ | ✅ | ❌ | ❌ |
| TechnicalWriter primario | ✅ | ✅ | ❌ | ❌ | ✅ | ❌ | ❌ |
| DocWriter alternativa | ✅ | ✅ | ❌ | ❌ | ✅ | ❌ | ❌ |
| TaskManager opcional | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| ContextOrganizer | ✅ | ✅ | ❌ | ❌ | ❌ | ✅ vía cmd | ❌ |
| BuildAgent opcional | ✅ | ✅ | ❌ | ✅ | ❌ | ❌ | ❌ |
| Verificación contra inventario | ✅ | ✅ | ❌ | ✅ | ✅ | ❌ | ✅ |
| Fecha/hora en resumen | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Campos opcionales | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Instrucciones paralelización | ❌ | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ |
| Punto de control R3 (aprobación) | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ |

---

<a id="5-subagentes-utilizados-por-prompt"></a>
## 5. Subagentes utilizados por prompt

| Subagente | 03 Crear | 04 Actualizar | 05 Temáticas | 06 Auditar Dir | 07 Auditar Plan | 08 Sinc. Contexto | 09 Act. Gobernanza |
|-----------|:--------:|:-------------:|:------------:|:---------------:|:----------------:|:-----------------:|:------------------:|
| **explore** | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| **ContextScout** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **ExternalScout** | ⚠️ cond. | ⚠️ cond. | ❌ | ❌ | ⚠️ cond. | ❌ | ❌ |
| **ContextRetriever** | ✅ | ✅ | ✅ | ❌ | ✅ | ❌ | ❌ |
| **CodeReviewer** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **TechnicalWriter** | ✅ primario | ✅ primario | ❌ | ❌ | ✅ primario | ❌ | ❌ |
| **DocWriter** | ⚠️ altern. | ⚠️ altern. | ❌ | ❌ | ⚠️ altern. | ❌ | ❌ |
| **ContextOrganizer** | ✅ | ✅ | ❌ | ❌ | ❌ | ✅ vía cmd | ❌ |
| **TaskManager** | ⚠️ opc. | ⚠️ opc. | ❌ | ❌ | ❌ | ❌ | ❌ |
| **BuildAgent** | ⚠️ opc. | ⚠️ opc. | ❌ | ⚠️ opc. | ❌ | ❌ | ❌ |
| **Engram** | ❌ eliminado | ❌ eliminado | ❌ eliminado | ❌ eliminado | ❌ eliminado | ❌ eliminado | ❌ eliminado |

**Leyenda:** ✅ Siempre / ⚠️ Condicional u opcional / ❌ No aplica

---

<a id="6-tamaño-de-los-archivos"></a>
## 6. Tamaño de los archivos

| Archivo | Líneas |
|---------|:------:|
| `01-flujo-trabajo-uso-rapido.md` | — |
| `03-P-crear-guia.md` | 638 |
| `04-P-actualizar-guia.md` | 672 |
| `05-P-tematicas-guia.md` | 381 |
| `06-P-auditar-directorio.md` | 280 |
| `07-P-auditar-codigo-vs-plan.md` | 590 |
| `08-P-sincronizar-contexto.md` | 320 |
| `09-P-actualizar-gobernanza.md` | 509 |
| **Total prompts activos** | **3.390** |

---

<a id="7-notas"></a>
## 7. Notas

- **Engram eliminado** de todos los prompts.
- **Todos los prompts** tienen instrucciones de usuario al inicio y formato de bloque único (`--- INICIO DEL PROMPT ---` / `--- FIN DEL PROMPT ---`).
- **TechnicalWriter** es el escritor primario en 03, 04 y 07 (documentación técnica para consumo IA).
- **08-P-sincronizar-contexto** usa comandos `/context` nativos de OAC (no `task()` directo).
- **09-P-actualizar-gobernanza** incluye punto de control R3 obligatorio: el agente se detiene y espera aprobación del usuario antes de modificar el inventario.
- **01-recapitulacion-sistema-guias.md** eliminado. Su contenido útil (objetivo del sistema y estructura de guías) está migrado a `01-flujo-trabajo-uso-rapido.md` (sección «Contenido ampliado»).
- **09-ejemplos-uso-prompts.md** renombrado a `ejemplos-uso-prompts.md` (documento de referencia, no prompt numerado).
