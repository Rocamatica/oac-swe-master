---
source: REPOC (oac-swe-master)
library: REPOC
package: oac-repoc
topic: plugins-y-herramientas
fetched: 2026-06-16
version: v0.7.1
official_docs: ""
---

# Plugins y herramientas personalizadas

**Propósito**: Documentación de los plugins del sistema de eventos y las
herramientas personalizadas (`tool/`) del REPOC. Estos componentes amplían
las capacidades nativas de OAC.

**Fecha**: 2026-06-16

---

## Índice

- [Plugin de notificaciones](#plugin-de-notificaciones)
- [Herramienta de variables de entorno](#herramienta-de-variables-de-entorno)
- [Herramienta de integración Gemini](#herramienta-de-integración-gemini)
- [Ver también](#ver-también)

---

## Plugin de notificaciones

| Campo | Valor |
|-------|-------|
| **Archivo** | `.opencode/plugin/notify.ts` |
| **Lenguaje** | TypeScript |
| **Tipo** | Plugin del sistema de eventos OAC |
| **Importa de** | `@opencode-ai/plugin` |
| **Estado** | ⏸️ Deshabilitado (`ENABLED = false`) |

### Descripción

Plugin de notificaciones que puede integrarse con el sistema de eventos de
OAC. Actualmente está deshabilitado en el código fuente — no se ejecuta a
menos que se active explícitamente cambiando `ENABLED = true`.

### Eventos que puede interceptar

Al activarse, el plugin responde a los eventos del ciclo de vida de OAC:

- `agent:start` / `agent:end`
- `task:start` / `task:end`
- `command:execute`
- `skill:load` / `skill:unload`
- `tool:execute`

### Activación

Para activar el plugin:

1. Editar `.opencode/plugin/notify.ts`
2. Cambiar `const ENABLED = false` a `const ENABLED = true`
3. Configurar el destino de las notificaciones (según implementación)

---

## Herramienta de variables de entorno

| Campo | Valor |
|-------|-------|
| **Archivo** | `.opencode/tool/env/index.ts` |
| **Lenguaje** | TypeScript |
| **Tipo** | Custom tool de OAC |
| **Importa de** | `fs/promises`, `path` |

### Descripción

Carga variables de entorno desde archivos `.env` siguiendo la configuración
definida en `env.example`. Proporciona una interfaz tipada para leer
variables de configuración del entorno.

### Interfaz

```typescript
export interface EnvLoaderConfig {
  searchPaths?: string[]   // Rutas personalizadas para buscar .env
  verbose?: boolean        // Log cuando se cargan variables
}
```

### Uso

Usada internamente por otras herramientas (ej. Gemini) para obtener
credenciales de API sin hardcodearlas.

---

## Herramienta de integración Gemini

| Campo | Valor |
|-------|-------|
| **Archivo** | `.opencode/tool/gemini/index.ts` |
| **Lenguaje** | TypeScript |
| **Tipo** | Custom tool de OAC |
| **Importa de** | `@opencode-ai/plugin/tool`, `fs/promises` |

### Descripción

Integración con Gemini AI para edición y análisis de imágenes. Usa la API de
Gemini para procesar imágenes subidas por el usuario o generadas durante el
desarrollo.

### Capacidades

- Análisis de imágenes (contenido, metadatos, descripción)
- Edición de imágenes mediante prompts
- Generación de variantes

### Dependencias

- API key de Gemini configurada en variable de entorno
- Herramienta `env` (`.opencode/tool/env/`) para cargar la API key

### Modo test

```typescript
// Se activa con variable de entorno
process.env.GEMINI_TEST_MODE === 'true'
```

---

## Ver también

- [Estructura completa de `.opencode/`](01_estructura-completa-opencode.md)
- [Scripts de arranque](07_scripts-de-arranque.md)
- [Estructura de tools OAC](../recursos/01_recapitulacion-entendimiento-openagent.md)
