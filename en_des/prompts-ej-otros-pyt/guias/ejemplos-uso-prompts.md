# Ejemplos de uso — Prompts de guías

> **Propósito:** Referencia rápida con ejemplos prácticos de cómo ejecutar cada prompt del sistema de guías.
> **Ubicación de los prompts:** `stage-management-system/prompts/guias/`

---

## Índice

1. [P-crear-guia — Ejemplos](#1-p-crear-guia--ejemplos)
2. [P-actualizar-guia — Ejemplo](#2-p-actualizar-guia--ejemplo)
3. [P-auditar-codigo-vs-plan — Ejemplos](#3-p-auditar-codigo-vs-plan--ejemplos)
4. [P-sincronizar-contexto — Ejemplo](#4-p-sincronizar-contexto--ejemplo)
5. [P-actualizar-gobernanza — Ejemplo](#5-p-actualizar-gobernanza--ejemplo)
6. [Resumen de campos de entrada](#6-resumen-de-campos-de-entrada)

---

## 1. P-crear-guia — Ejemplos

El usuario pega el contenido de `P-crear-guia.md` como primer mensaje y añade su entrada.

### Para un área grande (módulo completo)

```
Área a documentar: Workflow Stages — sistema de stages del motor PipeFlow.
12 stages personalizados con patrón Stage + StageFactory + InteractionType.
Incluye: FileUpload, PdfExtractor, ExecutorAi (genérico), ExecutorAiDeepSeek,
ExecutorAiGemini, JsonExtractor, JsonValidator, FileWrite, PhpExecutor,
OpenForm, RegisterValue. Cada stage con su factory asociada.
Dependencia externa: marcosiino/pipeflow (^1.0).
```

**Campos opcionales:**
```
Complejidad: alta
```

### Para un componente pequeño (un servicio)

```
Área a documentar: TranslatorService — servicio de traducción multiidioma.
Implementación propia que reemplazó a la librería externa anterior.
Incluye TwigTranslationExtension para usar en vistas Twig.
Archivos: src/Application/I18n/TranslatorService.php, lang/es-ES.php, lang/en-UK.php.
```

### Para una integración externa

```
Área a documentar: Integración con WooCommerce — WooCommerceService,
WpMediaService, rutas de la API REST, autenticación mediante token
y sincronización de productos desde los workflows automatizados.
Incluye WooCommerceServiceMock y WpMediaServiceMock para testing.
Dependencias: GuzzleHttp (^7.10), WordPress nativo.
```

---

## 2. P-actualizar-guia — Ejemplo

El usuario pega el contenido de `P-actualizar-guia.md` como primer mensaje y añade su entrada:

```
Área a actualizar: auth-system
Cambios realizados: Se añadió un nuevo método validarSesion en AuthService,
se eliminó el driver antiguo WpCookieAuthService, se añadieron 2 nuevas
rutas de perfil (/profile y /settings), y se modificó LocaleMiddleware
para extraer el locale de la cookie de sesión además de la URI.
```

**Campos opcionales (opcional):**
```
Complejidad: normal
```

---

## 3. P-auditar-codigo-vs-plan — Ejemplos

El usuario pega el contenido de `P-auditar-codigo-vs-plan.md` como primer mensaje y elige un modo.

### Modo A — Contra un plan concreto

Útil cuando el área se desarrolló siguiendo un documento de diseño específico.

```
## Modo A — Auditoría contra plan concreto

Área a auditar: Sistema de formularios externos FEX — cfle-wc-product-ia
Plan de referencia: documentacion-desarrollo/formularios-externos/especificacion-diseno-final.md
```

### Modo B — Contra la definición del proyecto

Útil cuando no hay un plan de diseño concreto.

```
## Modo B — Auditoría contra definición del proyecto

Área a auditar: Sistema de autenticación — src/Application/Auth/
```

---

## 4. P-sincronizar-contexto — Ejemplo

El usuario pega el contenido de `P-sincronizar-contexto.md` como primer mensaje y añade su entrada.

```
Guía de referencia: stage-management-system/conocimiento-guias-ia/workflow-engine/
```

**Campos opcionales (opcional):**
```
Tipo de guía: creada
Skip validate: false
```

---

## 5. P-actualizar-gobernanza — Ejemplo

El usuario pega el contenido de `P-actualizar-gobernanza.md` como primer mensaje y añade su entrada.

```
Guía de referencia: stage-management-system/conocimiento-guias-ia/workflow-stages/
```

**Campos opcionales (opcional):**
```
Tipo de guía: creada
```

El agente ejecutará las fases, presentará una **propuesta de nuevos recursos** al usuario, y esperará aprobación antes de modificar el inventario.

---

## 6. Resumen de campos de entrada

| Prompt | Campo | Obligatorio | Formato |
|--------|-------|:-----------:|---------|
| **P-crear-guia** | Área a documentar | ✅ | Descripción libre del área |
| | Writer override | ❌ | `DocWriter` \| `TechnicalWriter` |
| | Complejidad | ❌ | `normal` \| `alta` |
| **P-actualizar-guia** | Área a actualizar | ✅ | Nombre del subdirectorio en `conocimiento-guias-ia/` |
| | Cambios realizados | ✅ | Descripción libre de qué cambió |
| | Writer override | ❌ | `DocWriter` \| `TechnicalWriter` |
| | Complejidad | ❌ | `normal` \| `alta` |
| | Skip BuildAgent | ❌ | `true` \| `false` |
| **P-auditar-codigo-vs-plan** (Modo A) | Área a auditar | ✅ | Descripción libre |
| | Plan de referencia | ✅ | Ruta al documento de diseño |
| **P-auditar-codigo-vs-plan** (Modo B) | Área a auditar | ✅ | Descripción libre |
| (Ambos modos) | Writer override | ❌ | `DocWriter` \| `TechnicalWriter` |
| **P-sincronizar-contexto** | Guía de referencia | ✅ | Ruta al subdirectorio de la guía |
| | Tipo de guía | ❌ | `creada` \| `actualizada` |
| | Skip validate | ❌ | `true` \| `false` |
| **P-actualizar-gobernanza** | Guía de referencia | ✅ | Ruta al subdirectorio de la guía |
| | Tipo de guía | ❌ | `creada` \| `actualizada` |

---

> **Nota:** Los prompts `P-tematicas-guia` y `P-auditar-directorio` son autoexplicativos y no requieren ejemplos adicionales. Sus instrucciones de usuario en el propio prompt son suficientes.
