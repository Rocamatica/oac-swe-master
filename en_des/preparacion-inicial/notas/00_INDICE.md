# Índice de documentación — Hugo

**Propósito**: Este directorio contiene toda la documentación de aprendizaje y consulta sobre Hugo y OAC para el proyecto PYT-SWE (OAC+Hugo). Los archivos están numerados en orden lógico de lectura, de conceptos fundamentales a avanzados, siguiendo las dependencias entre ellos.

**Fecha de creación**: 2026-06-16

---

## Contenido del directorio

```
en_des/preparacion-inicial/notas/
├── 00_INDICE.md               ← Este archivo
├── 01-flujo-trabajo-hugo.md
├── 01B-flujo-trabajo-hugo-chklist.md
├── 02-estructura-proyecto-hugo.md
├── 03-conceptos-hugo.md
├── 04-conceptos-hugo-parte-2.md
├── 05-plantillas-hugo.md
├── 06-hugo-pipes.md
├── 07-diagnostico-contexto-oac.md
├── 08-analisis-oac-perfiles-recomendacion.md
└── 09-investigacion-skills-hugo.md
```

No existen subcarpetas.

---

## Tabla de archivos

| Nº | Nombre | Ruta relativa | Finalidad | Dependencias | Resumen breve |
|:--:|--------|---------------|-----------|--------------|---------------|
| 01 | `01-flujo-trabajo-hugo.md` | `en_des/preparacion-inicial/notas/01-flujo-trabajo-hugo.md` | Guía práctica paso a paso para crear un sitio Hugo desde cero hasta desplegarlo | Ninguna (lectura inicial) | Describe el ciclo completo: instalar Hugo, crear proyecto, configurar, crear layouts y archetypes, añadir CSS/JS, contenido de prueba, servidor de desarrollo, build de producción y despliegue con Wrangler. 10 pasos numerados. |
| 01B | `01B-flujo-trabajo-hugo-chklist.md` | `en_des/preparacion-inicial/notas/01B-flujo-trabajo-hugo-chklist.md` | Checklist ejecutable con fases y tareas para arrancar el proyecto | Depende de 01 (pasos del flujo) | Checklist en tres fases: (0) preparar OAC — rellenar gaps de contexto, ExternalScout; (1) instalación y estructura base Hugo; (2) contenido, build y despliegue. Casillas verificables. |
| 02 | `02-estructura-proyecto-hugo.md` | `en_des/preparacion-inicial/notas/02-estructura-proyecto-hugo.md` | Explicación de la estructura de directorios, configuración y conceptos base de Hugo | Depende de 01 para contexto general | Cubre: estructura de directorios (`archetypes/`, `content/`, `layouts/`, `static/`, `assets/`, etc.), qué es front matter (YAML/TOML/JSON), diferencia entre archetypes y layouts, analogía con PHP, los 6 formatos de contenido (Markdown, HTML, AsciiDoc, Org, Pandoc, RST), y configuración base `hugo.toml`. |
| 03 | `03-conceptos-hugo.md` | `en_des/preparacion-inicial/notas/03-conceptos-hugo.md` | Page Bundles y Shortcodes personalizados | Depende de 02 (estructura de directorios) | Explica los dos tipos de Page Bundles (leaf con `index.md` y branch con `_index.md`) para agrupar contenido con recursos. Explica shortcodes personalizados (fragmentos HTML reutilizables en Markdown), cómo crearlos en `layouts/shortcodes/` y ejemplos prácticos (botón, alerta). |
| 04 | `04-conceptos-hugo-parte-2.md` | `en_des/preparacion-inicial/notas/04-conceptos-hugo-parte-2.md` | Taxonomías, paginación, resúmenes, cascade y menús | Depende de 03 (conceptos base) y de 02 (front matter) | Cinco conceptos avanzados: (1) taxonomías nativas y personalizadas (`tags`, `categories`, `author`), (2) paginación con `.Paginate` y `.Paginator`, (3) resúmenes con `<!--more-->` y `.Summary`, (4) herencia de front matter con `cascade`, (5) menús desde front matter y `sectionPagesMenu`. |
| 05 | `05-plantillas-hugo.md` | `en_des/preparacion-inicial/notas/05-plantillas-hugo.md` | Jerarquía de plantillas y sistema de renderizado | Depende de 02 (estructura de layouts) y de 03 (conceptos de contenido) | Explica la jerarquía completa: `baseof.html` como esqueleto común con `block "main"`, `home.html` para portada, `single.html` para páginas individuales, `list.html` para listados, partials reutilizables (`head.html`, `header.html`, `footer.html`), orden de búsqueda (template lookup order) y buenas prácticas. |
| 06 | `06-hugo-pipes.md` | `en_des/preparacion-inicial/notas/06-hugo-pipes.md` | Procesamiento de CSS, JS e imágenes | Depende de 05 (partials donde se insertan los pipelines) | Explica Hugo Pipes: diferencia entre `assets/` (procesable) y `static/` (copia directa), funciones `css.Sass`, `js.Build`, `resources.Minify`, `resources.Fingerprint`, ejemplos de pipeline CSS y JS con desarrollo vs producción, y flujo visual del procesamiento. |
| 07 | `07-diagnostico-contexto-oac.md` | `en_des/preparacion-inicial/notas/07-diagnostico-contexto-oac.md` | Diagnóstico completo del contexto OAC en el repositorio | Depende de 01B (gaps a rellenar) | Inventario de los 208 archivos de contexto del repositorio, estado por área (core, openagents-repo, development, UI, etc.), 36 gaps críticos de archivos referenciados pero no existentes, y recomendaciones ExternalScout. |
| 08 | `08-analisis-oac-perfiles-recomendacion.md` | `en_des/preparacion-inicial/notas/08-analisis-oac-perfiles-recomendacion.md` | Análisis de componentes OAC, perfiles de instalación y recomendación del perfil completo | Depende de 07 (contexto OAC) | Mapa de necesidades del proyecto contra componentes de OAC (agentes, habilidades, comandos, contexto), comparativa de 5 perfiles de instalación (esencial a avanzado), y recomendación razonada del perfil completo (full) con tabla de uso prevista. |
| 09 | `09-investigacion-skills-hugo.md` | `en_des/preparacion-inicial/notas/09-investigacion-skills-hugo.md` | Investigación exhaustiva del ecosistema Hugo para identificar skills y herramientas incorporables | Independiente (referencia) | Catálogo de 998 líneas con MCP servers, módulos HugoMods, temas destacados, CLI y GHActions, integraciones CMS, SEO, formularios, búsqueda, imágenes, i18n, herramientas IA y tabla comparativa con recomendaciones para `.opencode/skills/`. |

---

## Orden de lectura recomendado

```
01 → 01B → 02 → 03 → 04 → 05 → 06 → 07 → [08 ↔ 09]
```

Cada archivo asume los conceptos del anterior. El archivo 01 (flujo de trabajo) puede leerse primero para tener una visión general, 01B es el checklist ejecutable, y luego los archivos 02 a 06 profundizan en cada etapa. El 07 (ContextScout report) se consulta tras entender la base. Los archivos 08 y 09 son documentos de referencia que pueden leerse en cualquier orden (08: análisis de perfiles OAC, 09: investigación de skills Hugo).

## Relaciones entre archivos

```
01-flujo-trabajo-hugo.md  (visión general, referencia a todos los pasos)
        │
        ▼
01B-flujo-trabajo-hugo-chklist.md  (checklist ejecutable)
        │
        ▼
02-estructura-proyecto-hugo.md  (base: directorios, front matter, config)
        │
        ├──────────────────┐
        ▼                  ▼
03-conceptos-hugo.md    05-plantillas-hugo.md
(page bundles,           (baseof, single, list,
 shortcodes)              home, partials)
        │                  │
        ▼                  ▼
04-conceptos-hugo-       06-hugo-pipes.md
   parte-2.md             (CSS, JS, assets)
(taxonomías, paginación,  │
 resúmenes, cascade,      │
 menús)                   │
        │                  │
        └──────┬───────────┘
               ▼
        07-diagnostico-contexto-oac.md
       (diagnóstico del repositorio,
        gaps de contexto OAC)
               │
       ┌───────┴───────┐
       ▼               ▼
08-analisis-oac-    09-investigacion-
  perfiles-           skills-hugo.md
  recomendacion.md   (ecosistema Hugo,
 (perfiles OAC,       skills, MCP,
  componentes,        módulos, temas,
  recomendación       herramientas IA)
  full)
```

## Notas

- Todos los archivos están en formato Markdown (.md)
- Las fuentes de información están citadas al inicio de cada documento: `.opencode/external-context/hugo/` y documentación oficial de Hugo
- El contexto de todos los documentos es el proyecto PYT-SWE (OAC+Hugo)
- **Arquitectura de interacción**: el usuario interactúa con OAC; OAC, mediante OCC (OpenCoder), gestiona todo el trabajo con Hugo. No se interactúa directamente con Hugo.
- **Actualizado**: 2026-06-16 — añadidos 01B, 07, 08 y 09
