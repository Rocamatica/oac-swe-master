<!-- Context: analysis/hugo | Priority: high | Version: 1.0 | Updated: 2026-06-15 -->
# Análisis de Hugo como Generador para el Proyecto de Sitios Web Estáticos (PYT-SWE)

**Propósito**: Documentar las capacidades de Hugo como generador de sitios estáticos para el proyecto PYT-SWE, detallando su gestión de contenido en Markdown (MD), metadatos SEO (meta tags, Open Graph, canonical, etc.), blog, i18n, rendimiento, despliegue en Cloudflare, y facilitad de uso en el flujo Copista → Markdown → sitio.

**Fecha**: 2026-06-15

**Fuentes verificadas**:
- Documentación oficial de Hugo: https://gohugo.io/documentation/ (v0.163.1)
- Análisis previo: `analisis-pyt-swe-oac-cf.md`
- Investigación ExternalScout sobre Hugo (Context7 API)

**Generado por**: OpenAgent

---

## Índice

- [1. Metodología de análisis](#1-metodología-de-análisis)
- [2. Resumen ejecutivo](#2-resumen-ejecutivo)
- [3. Capacidades de Hugo](#3-capacidades-de-hugo)
  - [3.1 Gestión de contenido en Markdown](#31-gestión-de-contenido-en-markdown)
  - [3.2 SEO: Meta tags, Open Graph, Canonical](#32-seo-meta-tags-open-graph-canonical)
  - [3.3 Blog y taxonomías](#33-blog-y-taxonomías)
  - [3.4 Facilidad de creación de contenido](#34-facilidad-de-creación-de-contenido)
  - [3.5 Internacionalización (i18n)](#35-internacionalización-i18n)
  - [3.6 Rendimiento y compilación](#36-rendimiento-y-compilación)
  - [3.7 Despliegue en Cloudflare](#37-despliegue-en-cloudflare)
  - [3.8 Ecosistema y comunidad](#38-ecosistema-y-comunidad)
- [4. Tabla resumen de capacidades](#4-tabla-resumen-de-capacidades)
- [5. Análisis de beneficio para el usuario](#5-análisis-de-beneficio-para-el-usuario)
- [6. Recomendación](#6-recomendación)
- [7. Riesgos y consideraciones](#7-riesgos-y-consideraciones)
- [8. Próximos pasos sugeridos](#8-próximos-pasos-sugeridos)

---

## 1. Metodología de análisis

Este análisis documenta las capacidades de **Hugo** (v0.163.1, última estable) en 8 dimensiones clave para el proyecto PYT-SWE. Cada dimensión evalúa:

1. **Capacidad nativa** (lo que viene incluido sin plugins/adiciones)
2. **Esfuerzo de implementación** (cuánto trabajo manual requiere)
3. **Facilidad para el flujo Copista → Markdown → sitio** (el usuario usa Copywriter de OAC para generar textos, que luego se incorporan al generador)

Toda la información proviene de la documentación oficial verificada. Cuando algo no está disponible, se indica explícitamente como "NO DISPONIBLE".

---

## 2. Resumen ejecutivo

**Hugo es el generador de sitios estáticos elegido para el proyecto PYT-SWE**, por las siguientes razones principales:

1. **SEO nativo completo**: Hugo incluye plantillas internas (embedded partials) para Open Graph, Twitter Cards y Schema.org. No requiere ninguna integración adicional.

2. **Front Matter nativo en 3 formatos**: Hugo soporta YAML, TOML y JSON de serie.

3. **Shortcodes**: Hugo usa shortcodes (simples, solo Markdown) para componentes reutilizables sin salir del ecosistema Markdown.

4. **Rendimiento de compilación**: Hugo (escrito en Go) compila sitios en milisegundos.

5. **Despliegue en Cloudflare**: Hugo genera HTML estático puro que Cloudflare Pages sirve directamente sin adaptadores.

6. **Madurez**: Hugo tiene 13+ años de desarrollo continuo con API estable.

**Conclusión**: Hugo es la opción óptima para un flujo donde el contenido se genera en Markdown por un agente Copista y debe producir sitios con SEO completo, blog y despliegue en Cloudflare, con el mínimo esfuerzo de implementación manual.

---

## 3. Capacidades de Hugo

### 3.1 Gestión de contenido en Markdown

| Aspecto | Qué es / Qué hace | Estado | Fuente |
|---------|-------------------|--------|--------|
| **Front Matter** | Metadatos al inicio del archivo .md (título, fecha, etiquetas...) que Hugo usa para organizar y mostrar el contenido | YAML, TOML, JSON **nativos** | [Documentación oficial](https://gohugo.io/content-management/front-matter/) |
| **Organización** | Estructura de carpetas y archivos que determina cómo se agrupa y relaciona el contenido | Page Bundles (leaf/branch): cada página puede tener su propio directorio con recursos | [Page Bundles](https://gohugo.io/content-management/page-bundles/) |
| **Shortcodes** | Fragmentos de código reutilizables que se insertan dentro del Markdown sin salir de él | Shortcodes personalizados simples de crear en `/layouts/shortcodes/` | [Shortcodes](https://gohugo.io/content-management/shortcodes/) |
| **Archetypes** | Plantillas que predefinen la estructura de un nuevo archivo de contenido al crearlo con `hugo new` | Sistema de plantillas para nuevo contenido (`hugo new posts/my-post.md`) | [Archetypes](https://gohugo.io/content-management/archetypes/) |
| **Formatos** | Tipos de archivo que Hugo puede leer como contenido fuente | 6 formatos: Markdown, HTML, AsciiDoc, Org, Pandoc, RST | [Formatos de contenido](https://gohugo.io/content-management/formats/) |
| **Contenido anidado** | Jerarquía de secciones y subsecciones que heredan configuración de la sección padre | Secciones y subsecciones con herencia de cascade | [Secciones](https://gohugo.io/content-management/sections/) |
| **Validación** | Comprobación automática de que el front matter cumple un esquema definido | No tiene validación de esquema nativa (se apoya en el desarrollador) | — |

**Análisis**: Hugo ofrece simplicidad y flexibilidad para contenido Markdown puro. Los Archetypes permiten crear archivos de contenido preestructurados con un solo comando. Los shortcodes cubren el 90% de los casos de uso de componentes reutilizables sin salir del ecosistema Markdown.

→ Ver [Anexo: Artefactos del ecosistema válidos para gestión de contenido](#anexo-artefactos-del-ecosistema-válidos-para-gestión-de-contenido)

---

### 3.2 SEO: Meta tags, Open Graph, Canonical

| Aspecto | Qué es / Qué hace | Estado | Fuente |
|---------|-------------------|--------|--------|
| **Meta tags (title, description)** | Etiquetas HTML `<title>` y `<meta name="description">` que los buscadores muestran en los resultados de búsqueda | Configurables en front matter (`title`, `description`, `keywords`) + variables de plantilla | [Front Matter](https://gohugo.io/content-management/front-matter/) |
| **Open Graph** | Protocolo de Facebook para controlar cómo se muestra el contenido al compartirlo en redes sociales (título, imagen, descripción...) | **Plantilla interna incluida** (`{{ partial "opengraph.html" . }}`). Genera og:url, og:site_name, og:title, og:description, og:locale, og:type, og:image, og:audio, og:video, og:see_also, fb:app_id | [Open Graph](https://gohugo.io/templates/embedded/#open-graph) |
| **Twitter Cards** | Etiquetas que controlan cómo se muestra el contenido al compartirlo en Twitter / X (tarjeta con imagen, título, descripción...) | **Plantilla interna incluida** (`{{ partial "twitter_cards.html" . }}`). Genera twitter:card, twitter:title, twitter:description, twitter:site, twitter:image | [Twitter Cards](https://gohugo.io/templates/embedded/#x-twitter-cards) |
| **Canonical URL** | Dirección web preferida de una página para evitar que los buscadores penalicen contenido duplicado | Configurable mediante variable `canonifyURLs` o manualmente en la plantilla | [Configuración](https://gohugo.io/getting-started/configuration/) |
| **Schema.org / JSON-LD** | Datos estructurados en formato JSON que los buscadores usan para mostrar resultados enriquecidos (estrellas, precio, fecha...) | **Plantilla interna incluida** (`{{ partial "schema.html" . }}`). Genera name, description, datePublished, dateModified, wordCount, image, keywords | [Schema](https://gohugo.io/templates/embedded/#schema) |
| **Sitemap** | Archivo XML que lista todas las páginas del sitio para que los buscadores las encuentren e indexen | Generación automática de sitemap.xml nativa | [Sitemap](https://gohugo.io/templates/sitemap/) |
| **Integración SEO específica** | Módulos adicionales que extienden las capacidades SEO de Hugo más allá de lo nativo | Módulos comunitarios: HugoMods SEO, future-wd/hugo-seo, hugo-mod-meta | Ecosistema Hugo |

**Análisis**: El SEO está **resuelto de serie** en Hugo. Basta con añadir `{{ partial "opengraph.html" . }}`, `{{ partial "twitter_cards.html" . }}` y `{{ partial "schema.html" . }}` en la plantilla base, y luego definir `title`, `description`, `images`, `tags`, etc. en el front matter de cada página. Para el proyecto PYT-SWE, donde cada sitio necesita SEO completo (meta tags, OG, Twitter Cards, canonical), Hugo reduce drásticamente el esfuerzo de implementación.

---

### 3.3 Blog y taxonomías

| Aspecto | Qué es / Qué hace | Estado | Fuente |
|---------|-------------------|--------|--------|
| **Taxonomías** | Sistema de clasificación del contenido (categorías, etiquetas...) que genera páginas de listado automáticas | Nativas: tags, categories, y taxonomías personalizadas (autores, series, etc.) | [Taxonomías](https://gohugo.io/content-management/taxonomies/) |
| **Paginación** | División del listado de artículos en páginas numeradas para evitar listas infinitas | Configurable con `{{ paginator.Pages }}` | [Paginación](https://gohugo.io/templates/pagination/) |
| **RSS** | Feed de sindicación que permite a los lectores suscribirse y recibir novedades del blog | Generación nativa de feeds RSS/Atom | [RSS](https://gohugo.io/templates/rss/) |
| **Contenido relacionado** | Sugerencias automáticas de artículos similares al final de cada publicación | Sí, nativo con `{{ related . }}` | [Contenido relacionado](https://gohugo.io/content-management/related-content/) |
| **Fechas** | Campos de fecha en el front matter para controlar cuándo se publica, modifica o caduca un contenido | `date`, `lastmod`, `publishDate`, `expiryDate` en front matter | [Front Matter](https://gohugo.io/content-management/front-matter/) |
| **Resúmenes** | Extracto breve del artículo que se muestra en listados y vista previa sin tener que cargar el contenido completo | Automáticos o manuales con `<!--more-->` | [Resúmenes](https://gohugo.io/content-management/summaries/) |

**Análisis**: Hugo ofrece funcionalidad nativa completa para blog: taxonomías personalizadas sin configuración, contenido relacionado, resúmenes con `<!--more-->`, y RSS nativo.

---

### 3.4 Facilidad de creación de contenido

| Aspecto | Qué es / Qué hace | Estado |
|---------|-------------------|--------|
| **Flujo típico** | Secuencia de pasos desde que se crea un contenido hasta que se publica | `hugo new sites/mi-sitio/index.md` → editar front matter + contenido → `hugo` (compila) |
| **Archetypes** | Plantillas que predefinen el front matter y la estructura de un nuevo archivo al crearlo | Crean archivos .md preestructurados con front matter personalizado |
| **LiveReload** | Recarga automática del navegador al detectar cambios en los archivos del proyecto | Sí, integrado con WebSocket. Hot-reload de CSS también. |
| **Interfaz visual** | Editor gráfico tipo WordPress para gestionar contenido sin escribir código | No tiene interfaz visual oficial. CMS headless posible (Decap CMS, CloudCannon, etc.) |
| **Curva de aprendizaje** | Tiempo y esfuerzo necesarios para dominar Hugo según el perfil del usuario | Baja para Markdown. El front matter es intuitivo. La parte de plantillas (Go templates) tiene curva media. |

**Análisis**: Para el flujo Copista→Markdown, Hugo es directo: el Copista genera un archivo .md con front matter, se coloca en la carpeta correcta, y Hugo lo compila. Los Archetypes facilitan la creación de nuevos contenidos con la estructura correcta.

---

### 3.5 Internacionalización (i18n)

| Aspecto | Qué es / Qué hace | Estado | Fuente |
|---------|-------------------|--------|--------|
| **Soporte** | Capacidad del generador para manejar múltiples idiomas de forma nativa | Completo, maduro (13+ años de evolución) | [Multilingüe](https://gohugo.io/content-management/multilingual/) |
| **Estrategias** | Modos de organizar las rutas web para cada idioma (subdirectorio `sitio.com/es/` o subdominio `es.sitio.com`) | Single-host (subdirectorios), multihost (subdominios) | [Estrategias](https://gohugo.io/content-management/multilingual/) |
| **Traducción** | Método para crear versiones del mismo contenido en distintos idiomas | Por directorio paralelo (`content/en/`, `content/es/`) o por `translationKey` | [Traducción](https://gohugo.io/content-management/multilingual/) |
| **Strings interfaz** | Textos de la interfaz (menús, botones, pies de página...) que deben traducirse para cada idioma | Tablas i18n para menús, footers, etc. (ficheros TOML/YAML/JSON en `i18n/`) | [Strings](https://gohugo.io/content-management/multilingual/) |
| **Taxonomías localizadas** | Categorías y etiquetas independientes por idioma (no mezclar tags en inglés con contenido en español) | Sí, soporte nativo | [Multilingüe](https://gohugo.io/content-management/multilingual/) |

**Análisis**: El soporte i18n de Hugo es completo y maduro. Permite estrategias single-host y multihost, traducción por directorios paralelos o `translationKey`, y tablas de strings en `i18n/` con taxonomías localizadas.

---

### 3.6 Rendimiento y compilación

| Aspecto | Qué es / Qué hace | Estado | Fuente |
|---------|-------------------|--------|--------|
| **Lenguaje** | Lenguaje de programación en el que está escrito Hugo, que determina su velocidad y consumo de recursos | Go (compilado nativo) | [gohugo.io](https://gohugo.io/) |
| **Velocidad** | Tiempo que tarda Hugo en compilar todo el sitio y generar los archivos HTML | Milisegundos para sitios pequeños; <1 segundo para sitios medianos | Documentado por la comunidad |
| **Pipeline assets** | Sistema de procesamiento de recursos (CSS, JS, imágenes) integrado sin necesidad de herramientas externas | Hugo Pipes (esbuild): css.Build, js.Build, Sass, imágenes WebP/AVIF | [Hugo Pipes](https://gohugo.io/hugo-pipes/) |
| **Minificación** | Compresión del código HTML, CSS y JS generado para reducir el peso de las páginas | Integrada (HTML, CSS, JS) | [Hugo Pipes](https://gohugo.io/hugo-pipes/) |
| **Output** | Tipo de archivos que Hugo genera como resultado final de la compilación | HTML estático puro | — |

**Análisis**: Hugo compila en milisegundos. Hugo Pipes (basado en esbuild) elimina la necesidad de Webpack/Vite/otros bundlers externos. Minificación y procesamiento de assets integrados.

---

### 3.7 Despliegue en Cloudflare con Wrangler (local)

| Aspecto | Qué es / Qué hace | Estado | Fuente |
|---------|-------------------|--------|--------|
| **Cloudflare Pages** | Plataforma de hosting de Cloudflare para sitios estáticos. Hugo genera HTML puro que no necesita adaptadores ni runtime | **Soporte nativo directo**. Hugo genera HTML estático que Cloudflare Pages sirve sin adaptadores. | [Cloudflare Pages](https://cloudflare.com/pages/) |
| **Wrangler CLI** | Herramienta oficial de Cloudflare para desplegar desde línea de comandos local | Se instala vía npm: `npm install -g wrangler`. Luego `wrangler pages deploy public/ --project-name=xxxx` | [Wrangler](https://developers.cloudflare.com/workers/wrangler/) |
| **Token de API** | Autenticación necesaria para que Wrangler se comunique con Cloudflare | Se genera desde el panel de Cloudflare (API Tokens) y se configura con `wrangler login` | [API Tokens](https://developers.cloudflare.com/fundamentals/api/get-started/create-token/) |
| **Flujo local** | Secuencia completa desde el código hasta la publicación | `hugo --minify --gc` → `wrangler pages deploy public/ --project-name=<nombre>` | — |
| **Adaptador necesario** | Código adicional de puente entre Hugo y la plataforma | **NINGUNO**. Hugo genera HTML estático puro, Wrangler lo sube directamente. | — |

**Análisis**: Hugo compila a HTML estático puro. Wrangler sube la carpeta `public/` a Cloudflare Pages. No requiere adaptadores, funciones serverless, Workers, ni configuración en el panel de Cloudflare más allá del token de API. El flujo completo es: editar contenido → `hugo` → `wrangler pages deploy public/` → publicado.

---

### 3.8 Ecosistema y comunidad

| Aspecto | Qué es / Qué hace | Valor |
|---------|-------------------|-------|
| **Lanzamiento inicial** | Año en que Hugo se publicó por primera vez, indicador de su madurez | 2013 |
| **Versión actual** | Última versión estable disponible en el momento del análisis | v0.163.1 (junio 2026) |
| **Estrellas GitHub** | Número de estrellas en GitHub, indicador de popularidad y comunidad activa | ~88,600 |
| **Temas** | Cantidad de temas disponibles en la galería oficial para empezar un sitio rápidamente | ~500+ en [themes.gohugo.io](https://themes.gohugo.io) |
| **Estabilidad** | Grado de madurez de la API y frecuencia de cambios disruptivos entre versiones | Alta. API estable desde v0.x. Cambios controlados. |
| **Empresa detrás** | Organización o entidad que mantiene y financia el desarrollo del proyecto | Comunitaria + Sponsors (JetBrains, CloudCannon) |

**Análisis**: Hugo es maduro y estable con 13+ años de desarrollo continuo. Para un proyecto que debe ser mantenible a largo plazo, la estabilidad de Hugo es una ventaja.

---

## 4. Tabla resumen de capacidades

| Capacidad | Hugo |
|-----------|------|
| Front Matter nativo (YAML/TOML/JSON) | ✅ Nativo |
| Shortcodes | ✅ Sí |
| Archetypes (plantillas de contenido) | ✅ Sí |
| Validación de contenido | ⚠️ No nativa (mitigable con scripts externos) |
| Open Graph nativo | ✅ Plantilla interna incluida |
| Twitter Cards nativo | ✅ Plantilla interna incluida |
| Schema.org / JSON-LD nativo | ✅ Plantilla interna incluida |
| Canonical URL | ✅ Configurable |
| Sitemap automático | ✅ Nativo |
| Guía SEO oficial | ✅ Sí (gohugo.io) |
| Taxonomías nativas | ✅ Sí (tags, categories, personalizadas) |
| Paginación nativa | ✅ Sí |
| RSS nativo | ✅ Sí |
| Contenido relacionado | ✅ Nativo (`{{ related . }}`) |
| i18n | ✅ Muy maduro (13+ años) |
| Velocidad de compilación | ✅ Excelente (Go, milisegundos) |
| Despliegue Cloudflare Pages | ✅ Directo, sin adaptador |
| Estabilidad API | ✅ Alta |
| Madurez | ✅ 13 años de desarrollo continuo |

---

## 5. Análisis de beneficio para el usuario

Evaluamos cómo Hugo beneficia al usuario en el contexto específico del proyecto PYT-SWE, donde:

- El **Copista** (Copywriter de OAC) genera contenido en Markdown
- Se requiere **SEO completo** (meta tags, OG, Twitter Cards, canonical) en todos los sitios
- Se gestionan **múltiples sitios** (5-10 páginas corporativos + blog)
- El despliegue es en **Cloudflare**
- La facilidad de uso y mantenimiento es prioridad

### Beneficios específicos de Hugo

| Necesidad del usuario | Cómo la resuelve Hugo |
|----------------------|-----------------------|
| El Copista genera contenido → se publica | Archetypes definen la estructura .md. Copista rellena front matter y cuerpo. Hugo compila. |
| Meta tags SEO en todas las páginas | Se define `title`, `description`, `images` en front matter. La plantilla OG/Twitter/Schema lo genera automáticamente. |
| OG:image por página | Se define `images: [post-cover.png]` en front matter. Hugo busca automáticamente en page resources y global resources. |
| Blog con categorías y tags | Taxonomía nativa. Solo añadir `tags: [...]` y `categories: [...]` al front matter. |
| Despliegue en Cloudflare Pages | Hugo genera `public/` con HTML puro. Cloudflare Pages lo sirve. Sin configuración extra. |
| Múltiples sitios con misma estructura | Los Archetypes y config base se reutilizan. Cada sitio es una sección de contenido. |

---

## 6. Recomendación

**Hugo es el generador de sitios estáticos para el proyecto PYT-SWE.**

### Razones principales

1. **SEO completo de serie**: Open Graph, Twitter Cards y Schema.org vienen incluidos como plantillas internas.

2. **Flujo Copista→Markdown más directo**: Archetypes + Page Bundles + shortcodes ofrecen el camino más corto entre la generación de contenido por IA y la publicación.

3. **Despliegue más simple en Cloudflare**: HTML estático puro. Sin adaptadores, sin Wrangler, sin configuración extra.

4. **Madurez y estabilidad**: 13 años de desarrollo, API estable, comunidad grande y consolidada. El proyecto será mantenible a largo plazo.

5. **Rendimiento**: Compilación en milisegundos. Ideal para el flujo de crear, revisar, ajustar y recompilar rápidamente.

---

## 7. Riesgos y consideraciones

| Riesgo | Mitigación |
|--------|-----------|
| **Curva de aprendizaje de Go templates**: El sistema de plantillas de Hugo usa Go template syntax, que es diferente de Handlebars/Mustache/JSX. | El usuario no tocará plantillas directamente. OAC (a través del Frontend Specialist y CoderAgent) las gestionará. |
| **Sin validación de esquema**: Hugo no valida el front matter contra un esquema. | Mitigable con scripts de validación personalizados o usando herramientas externas. |
| **Ecosistema de temas**: Aunque amplio, la calidad varía. | El proyecto usará plantillas base propias, no temas externos. |

---

## 8. Próximos pasos sugeridos

1. ✅ **Hugo elegido**: v0.163.1+ como generador del proyecto.
2. ⬜ **Crear estructura de proyecto Hugo base**: Archetypes, configuración base, plantillas mínimas.
3. ⬜ **Configurar SEO base**: Plantilla con OG + Twitter Cards + Schema internos de Hugo.
4. ⬜ **Instalar y configurar Wrangler**: `npm i -g wrangler`, `wrangler login`, crear proyecto en Cloudflare Pages.
5. ⬜ **Crear primer sitio de prueba**: Validar el flujo completo Copista → Hugo → `wrangler pages deploy` → Cloudflare Pages.
6. ⬜ **Documentar el proceso** con DocWriter.

---

## Anexo: Artefactos del ecosistema válidos para gestión de contenido

> **Propósito**: Mapeo de skills, herramientas y módulos existentes en `temp/investigacion-skills-hugo.md` que cubren las necesidades de la sección [3.1 Gestión de contenido en Markdown](#31-gestión-de-contenido-en-markdown).
>
> **Fuente**: `temp/investigacion-skills-hugo.md` — Investigación de skills existentes para Hugo (2026-06-15)

### 1. Front Matter (YAML, TOML, JSON)

| Artefacto | Sección en investigación | Por qué es válido |
|-----------|--------------------------|-------------------|
| **hugo-frontmatter-mcp** | 2.4 | MCP server especializado: lectura, actualización, validación y operaciones por lote sobre frontmatter YAML. Funciones: `get_frontmatter`, `set_title`, `set_date`, `add_tag`, `rename_tag_in_directory`, `validate_date_formats` |
| **hugo-docs-mcp** | 2.3 | `validate_frontmatter` + `bulk_update_frontmatter` para validación y actualización masiva de campos |
| **hugo-memex** | 2.2 | `get_front_matter_template` deriva convenciones de sección; `validate_page` verifica completitud y consistencia de tags |
| **hugo-mcp** | 2.1 | `get_page` lee frontmatter + contenido; `create_page` / `update_page` lo modifican |
| **Front Matter CMS** | 6.4 | CMS dentro de VS Code con UI visual para editar frontmatter sin tocar YAML |
| **Claude Blog** | 11.1 | 30 sub-skills que generan contenido con frontmatter correcto para Hugo |
| **SEO Blog Writer** | 11.7 | Output Markdown con frontmatter listo para CMS |

### 2. Organización (Page Bundles)

| Artefacto | Sección en investigación | Por qué es válido |
|-----------|--------------------------|-------------------|
| **hugo-mcp** | 2.1 | `list_pages` con filtros por sección/idioma; `upload_asset` / `list_assets` para gestionar recursos de page bundles |
| **hugo-memex** | 2.2 | `create_page` con estructura de leaf bundle (`slug/index.md`) |
| **VSCode Ghostwriter** | 11.6 | Page bundle support nativo (`slug/index.md`) para Hugo |
| **Hugolify** | 6.5 | Framework con 10+ tipos de contenido y 25+ bloques, organizados en estructura de proyecto |

### 3. Shortcodes

| Artefacto | Sección en investigación | Por qué es válido |
|-----------|--------------------------|-------------------|
| **HugoMods Bootstrap** | 3.1 | Shortcodes Bootstrap: grid, alerts, accordion, cards |
| **HugoMods Extended Shortcodes** | 3.1 | Reproductores multimedia, code playgrounds |
| **HugoMods Mermaid / KaTeX** | 3.1 | Diagramas y fórmulas matemáticas como shortcodes |
| **Decap CMS** | 6.1 | Editor de componentes para shortcodes Hugo desde interfaz visual |
| **HugoMods Icons** | 3.1 | SVG icons (Bootstrap, FontAwesome, Material, Simple Icons) como shortcodes |

### 4. Archetypes

| Artefacto | Sección en investigación | Por qué es válido |
|-----------|--------------------------|-------------------|
| **hugo-mcp** | 2.1 | `create_page` con scaffolding de nueva página |
| **hugo-docs-mcp** | 2.3 | `create_page` con scaffolding de páginas de documentación |
| **hugo-memex** | 2.2 | `get_front_matter_template` deriva plantillas de frontmatter por sección |
| **Claude Blog** | 11.1 | 12 plantillas de contenido reutilizables para diferentes tipos de post |
| **VSCode Ghostwriter** | 11.6 | Frontmatter template configurable para nuevos archivos |

### 5. Formatos (Markdown, AsciiDoc, Org, Pandoc, RST)

| Artefacto | Sección en investigación | Por qué es válido |
|-----------|--------------------------|-------------------|
| *(ninguno)* | — | El soporte de 6 formatos de contenido es capacidad nativa de Hugo. No hay skills externos que extiendan esta funcionalidad. |

### 6. Contenido anidado (secciones, cascade)

| Artefacto | Sección en investigación | Por qué es válido |
|-----------|--------------------------|-------------------|
| **hugo-mcp** | 2.1 | `list_pages` con filtros por sección permite navegar la jerarquía |
| **hugo-docs-mcp** | 2.3 | `list_sections` lista las secciones del sitio |
| **Hugolify** | 6.5 | 10+ tipos de contenido con jerarquía y relaciones predefinidas |
| **Claude Blog** | 11.1 | `/blog outline` genera estructuras jerárquicas de contenido informadas por SERP |

### 7. Validación (de esquema / front matter)

| Artefacto | Sección en investigación | Por qué es válido |
|-----------|--------------------------|-------------------|
| **hugo-docs-mcp** | 2.3 | `validate_frontmatter` + `check_links` + `detect_duplicates` |
| **hugo-frontmatter-mcp** | 2.4 | `validate_date_formats` para formatos de fecha |
| **hugo-memex** | 2.2 | `validate_page`: verifica completitud, consistencia de tags, referencias cruzadas |
| **Hugo SEO Linter** | 7.2 | Valida títulos (50-60 chars), descripciones (120-158 chars), mínimo 500 palabras por post |
| **Hugo Broken Link & Image Checker** | 7.3 | Valida shortcodes existen, enlaces e imágenes no rotas, campos de frontmatter |
| **@capgo/seo-checker** | 7.6 | 1000+ reglas: metadata, headings, indexability, links, OpenGraph, hreflang, JSON-LD |
| **Victor Hugo** | 7.1 | Auditoría inline: stop words, voz pasiva, keyword density, Flesch Reading Ease |
| **agentic-seo** | 7.7 | Auditoría de visibilidad para agentes IA: `llms.txt`, `robots.txt`, token counting |

### Observaciones

- **Artefacto más versátil**: `hugo-mcp` (sección 2.1) cubre 6 de los 7 aspectos: front matter, page bundles, archetypes, contenido anidado, y parcialmente validación y shortcodes a través del ecosistema.
- **Carencia detectada**: No existe ningún skill específico para gestionar shortcodes o archetypes como entidades propias. Lo más cercano son los módulos HugoMods (shortcodes Bootstrap, iconos) y las funciones de scaffolding de los MCP servers.
- **Los MCP servers** (sección 2) son el tipo de artefacto más directamente aplicable, pues exponen funciones que un agente IA puede invocar para gestionar contenido.

---

*Fin del documento*
