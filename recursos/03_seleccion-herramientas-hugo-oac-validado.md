# Selección validada de herramientas — Hugo + OAC

**Propósito**: Catálogo definitivo de herramientas que se instalarán en Fase 3, validado item por item según su valor para el modelo REPOC (base clonable) → REPON (proyecto clonado).

**Fecha**: 2026-06-16

**Criterio de validación**: Cada herramienta se evalúa por su aporte al REPOC (contextos, skills, configuraciones que hereda el clon) y al REPON (capacidades operativas del proyecto clonado), verificando que no hay duplicidad funcional.

---

## 1. Instalación y entorno

### 1.1 hugo-extended (npm) ✅ INCLUIDO

| Campo | Valor |
|-------|-------|
| **Tipo OAC** | Context file (versión, instalación, verificación) |
| **Instalación** | `npm install -g hugo-extended` |

**Validación para REPOC/REPON**:

- **Valor para REPOC**: OCA necesita un contexto file con la versión, instalación y verificación de Hugo para poder ejecutarlo al crear un REPON. Sin ese conocimiento en REPOC, el clon no sabe qué versión usar ni cómo instalarla.
- **Valor para REPON**: Es el motor del sitio. Sin Hugo no hay sitio.
- **¿Duplicado?**: No. No hay otra herramienta que sea el motor SSG. hugo-mcp y hugo-memex lo envuelven, no lo reemplazan.
- **Riesgo**: El wrapper npm puede ir por detrás de los releases oficiales de Hugo. Mitigación: OCA verifica versión antes de instalar y compara con la última disponible.

---

## 2. Gestión de contenido (MCP)

### 2.1 hugo-mcp (jmrGrav) ✅ INCLUIDO

| Campo | Valor |
|-------|-------|
| **Tipo OAC** | Subagente `HugoMCPSpecialist` + Skill de invocación |
| **Instalación** | Entorno virtual Python + integración MCP en opencode.json |

**Validación para REPOC/REPON**:

- **Valor para REPOC**: Permite crear un subagente (`HugoMCPSpecialist`) en REPOC que cualquier REPON hereda. Ese subagente sabe invocar hugo-mcp con los parámetros correctos. Sin la herramienta, el subagente no tendría qué invocar.
- **Valor para REPON**: Gestión de contenido sin tocar archivos manualmente. El usuario habla en lenguaje natural, OCA delega, hugo-mcp ejecuta.
- **¿Duplicado?**: No. Es el único MCP que hace CRUD completo de contenido. hugo-frontmatter-mcp (no seleccionado) solo toca frontmatter, y hugo-memex (siguiente item) solo consulta/busca — son complementarios, no duplicados.
- **Diferenciador clave**: 12 releases en 2 semanas (mayo 2026), muy activo, v2.1.0. Incluye purga Cloudflare y SRI que no tienen otros.

---

### 2.2 hugo-memex (queelius) ✅ INCLUIDO

| Campo | Valor |
|-------|-------|
| **Tipo OAC** | Skill `hugo-query` (search + analysis) |
| **Instalación** | Entorno virtual Python + integración MCP en opencode.json |

**Validación para REPOC/REPON**:

- **Valor para REPOC**: Permite crear un skill `hugo-query` en REPOC que encapsula consultas semánticas. Cualquier REPON hereda la capacidad de buscar en su propio contenido.
- **Valor para REPON**: OCA puede responder preguntas del usuario sobre el contenido del sitio sin leer archivos manualmente. Ej: "qué páginas tengo sobre Node.js?" → consulta FTS5 → respuesta inmediata.
- **¿Duplicado con hugo-mcp?**: No. hugo-mcp escribe y gestiona; hugo-memex lee y consulta. Son complementarios, no sustitutos.
- **¿Duplicado con Pagefind?**: No. Pagefind indexa para el visitante humano del sitio (buscador frontend); hugo-memex indexa para OCA (búsqueda interna, análisis). Pagefind es post-build, hugo-memex trabaja sobre el contenido fuente.

---

### 2.3 hugo-docs-mcp (danfinn5) ✅ INCLUIDO

| Campo | Valor |
|-------|-------|
| **Tipo OAC** | Skill `hugo-audit-quality` |
| **Instalación** | Entorno virtual Python + integración MCP en opencode.json |

**Validación para REPOC/REPON**:

- **Valor para REPOC**: Skill de auditoría de calidad que los REPON heredan para autoevaluar su contenido.
- **Valor para REPON**: OCA puede detectar enlaces rotos, frontmatter incompleto, contenido duplicado y páginas sin actualizar. Capacidad de "salud del sitio".
- **¿Duplicado?**: Solapamiento parcial con hugo-mcp (check_dead_links, validate_frontmatter), pero docs-mcp añade detección de duplicados, antigüedad y scaffolding que hugo-mcp no tiene. Se mantienen ambas: hugo-mcp para operaciones diarias, docs-mcp para auditorías periódicas.
- **Riesgo**: Menos activo (marzo 2026), licencia sin confirmar. Mitigación: si deja de funcionar, la funcionalidad crítica (enlaces rotos) sigue cubierta por hugo-mcp.

---

## 3. Búsqueda en sitio

### 3.1 Pagefind ✅ INCLUIDO

| Campo | Valor |
|-------|-------|
| **Tipo OAC** | Skill `hugo-search-index` (post-build step) |
| **Instalación** | `npm install -g pagefind` (o como dependencia del proyecto) |

**Validación para REPOC/REPON**:

- **Valor para REPOC**: Se traduce en un skill `hugo-search-index` que OCA ejecuta automáticamente post-build. El REPOC contiene la configuración de Pagefind (idiomas, secciones a indexar, etc.).
- **Valor para REPON**: El sitio del REPON tiene buscador sin esfuerzo. OCA lo configura y ejecuta, el usuario no toca nada.
- **¿Duplicado?**: No directamente, pero HugoMods tiene un módulo Search (Fuse.js). La diferencia: Pagefind es post-build sobre HTML (más preciso, no requiere JS en el cliente para el indexing), mientras que HugoMods Search es del lado del servidor/build. Pagefind es el estándar de la comunidad Hugo en 2026. Si se incluye HugoMods Search, habrá que decidir si mantener ambos o solo uno.

---

## 4. SEO, AEO y visibilidad IA

### 4.1 agentic-seo (addyosmani) ✅ INCLUIDO

| Campo | Valor |
|-------|-------|
| **Tipo OAC** | Skill `hugo-agentic-audit` |
| **Instalación** | `npm install -g agentic-seo` (o vía npx) |

**Validación para REPOC/REPON**:

- **Valor para REPOC**: Se traduce en un skill `hugo-agentic-audit`. REPOC hereda el conocimiento de qué verificaciones de visibilidad IA hacer y cómo interpretar los resultados.
- **Valor para REPON**: OCA puede auditar el REPON contra los estándares AEO actuales. El usuario sabe si su sitio es "visible para IA" sin ser experto.
- **¿Duplicado?**: No. Es la única herramienta específica de AEO. seofor.dev (siguiente item) es SEO técnico tradicional. Son complementos: uno mira a los agentes IA, otro mira a los buscadores tradicionales.

---

### 4.2 seofor.dev ✅ INCLUIDO

| Campo | Valor |
|-------|-------|
| **Tipo OAC** | Skill `hugo-seo-audit` |
| **Instalación** | `npm install -g seofor.dev` (o vía npx) |

**Validación para REPOC/REPON**:

- **Valor para REPOC**: Skill `hugo-seo-audit` que hereda la configuración de auditoría y la lógica para que OCA interprete los resultados AI-Ready.
- **Valor para REPON**: OCA audita SEO del sitio y da sugerencias accionables al usuario sin que este tenga que entender de SEO.
- **¿Duplicado con agentic-seo?**: No. agentic-seo = visibilidad IA (robots.txt, llms.txt, crawlers IA). seofor.dev = SEO técnico (rendimiento, IndexNow, meta). Uno no reemplaza al otro.
- **¿Duplicado con HugoMods SEO?**: No. HugoMods SEO genera los meta tags en el template. seofor.dev audita que esos meta tags sean correctos. Complementarios: uno produce, el otro verifica.

---

## 5. Módulos funcionales HugoMods

Los módulos HugoMods no se instalan como binarios. Se activan como dependencias Hugo en `hugo.toml`. OCA los configura mediante context files en REPOC.

### 5.1 HugoMods SEO ✅ INCLUIDO

| Campo | Valor |
|-------|-------|
| **Tipo OAC** | Context file (configuración en `hugo.toml`) |
| **Instalación** | Dependencia Hugo (`hugo.toml`), no requiere binario externo |

**Validación para REPOC/REPON**:

- **Valor para REPOC**: Contexto con configuración SEO por defecto que el REPON hereda. "SEO funcional desde el día 1".
- **Valor para REPON**: Meta tags OG, Twitter Cards y Schema generados automáticamente desde frontmatter. Sin tocar layouts.
- **¿Duplicado con agentic-seo / seofor.dev?**: No. agentic-seo y seofor.dev auditan; HugoMods SEO genera. Complementarios: uno produce, el otro verifica.

---

### 5.2 HugoMods Images ✅ INCLUIDO

| Campo | Valor |
|-------|-------|
| **Tipo OAC** | Context file (shortcodes + ejemplos) |
| **Instalación** | Dependencia Hugo (`hugo.toml`) |

**Validación para REPOC/REPON**:

- **Valor para REPOC**: Contexto con ejemplos de shortcodes de imagen. REPON puede añadir imágenes optimizadas sin escribir HTML.
- **Valor para REPON**: Imágenes responsivas, WebP/AVIF, lazy loading automático desde Markdown. Mejora rendimiento y Core Web Vitals.
- **¿Duplicado?**: No. Hugo tiene procesamiento de imágenes nativo (Pipes), pero HugoMods Images lo expone como shortcodes sencillos desde Markdown. Es una capa de conveniencia sobre la funcionalidad nativa.

---

### 5.3 HugoMods PWA ✅ INCLUIDO

| Campo | Valor |
|-------|-------|
| **Tipo OAC** | Context file (guía de configuración genérica) |
| **Instalación** | Dependencia Hugo (`hugo.toml`) |

**Validación para REPOC/REPON**:

- **Valor para REPOC**: Contexto con configuración PWA genérica que REPON hereda y personaliza (nombre, iconos, colores).
- **Valor para REPON**: PWA funcional sin tocar service workers manualmente. El sitio se puede "instalar" como app offline.
- **¿Duplicado?**: No. Ninguna otra herramienta seleccionada hace PWA. El service worker es específico de este módulo.

---

### 5.4 HugoMods Icons ✅ INCLUIDO

| Campo | Valor |
|-------|-------|
| **Tipo OAC** | Context file (referencia de shortcodes) |
| **Instalación** | Dependencia Hugo (`hugo.toml`) |

**Validación para REPOC/REPON**:

- **Valor para REPOC**: Contexto con ejemplos de iconos disponibles (Bootstrap, FA, Material, Simple Icons). REPON hereda la capacidad de usar iconos en layouts y contenido.
- **Valor para REPON**: Iconos SVG inline sin librerías CSS pesadas. Más rápido que icon-fonts.
- **¿Duplicado?**: No. Ninguna otra herramienta seleccionada proporciona iconos.

---

### 5.5 HugoMods Analytics ✅ INCLUIDO

| Campo | Valor |
|-------|-------|
| **Tipo OAC** | Context file (configuraciones de ejemplo por proveedor) |
| **Instalación** | Dependencia Hugo (`hugo.toml`) — proveedor a elegir por el usuario al configurar REPON |

**Validación para REPOC/REPON**:

- **Valor para REPOC**: Contexto con configuraciones de ejemplo para Google Analytics, Cloudflare y Umami. REPON hereda la capacidad de activar analytics sin tocar layouts.
- **Valor para REPON**: Analytics funcional con solo decir "OCA, activa Umami" (o el proveedor que elija el usuario).
- **¿Duplicado?**: No.
- **Nota**: El proveedor concreto se elige cuando el usuario lo solicite en REPON. REPOC proporciona los templates para todos los soportados.

---

### 5.6 HugoMods Bootstrap ✅ INCLUIDO

| Campo | Valor |
|-------|-------|
| **Tipo OAC** | Context file (guía de activación + ejemplos) |
| **Instalación** | Dependencia Hugo (`hugo.toml`) |

**Validación para REPOC/REPON**:

- **Valor para REPOC**: Contexto con configuración Bootstrap y ejemplos de componentes. REPON hereda la capacidad de usar Bootstrap sin configurarlo manualmente.
- **Valor para REPON**: Framework CSS listo para usar en layouts y contenido. Componentes responsive, grid, utilidades.
- **¿Duplicado?**: No. Ninguna otra herramienta seleccionada proporciona un framework CSS.

---

## 6. CMS y edición visual

### 6.1 Decap CMS (vía HugoMods) ✅ INCLUIDO

| Campo | Valor |
|-------|-------|
| **Tipo OAC** | Skill `hugo-cms-setup` |
| **Instalación** | Dependencia Hugo (`hugo.toml`) + generar `static/admin/config.yml` + configurar OAuth GitHub |

**Validación para REPOC/REPON**:

- **Valor para REPOC**: Skill que genera `static/admin/config.yml` con tipos de contenido y autenticación. REPON hereda CMS configurable con un comando de OCA.
- **Valor para REPON**: Interfaz web WYSIWYG para editar contenido sin tocar Markdown ni Git. Complementa al chat con OCA.
- **¿Duplicado?**: No. hugo-mcp gestiona contenido desde chat/IA; Decap CMS desde UI web. Canales complementarios, no sustitutos.
- **Riesgo**: Requiere autenticación GitHub (OAuth). No es automático — el usuario debe crear una OAuth App en GitHub.

---

## 7. Despliegue

### 7.1 Wrangler (Cloudflare Pages) ✅ INCLUIDO

| Campo | Valor |
|-------|-------|
| **Tipo OAC** | Comando `/hugo-deploy` |
| **Instalación** | `npm install -g wrangler` + `wrangler login` (configuración única) |

**Validación para REPOC/REPON**:

- **Valor para REPOC**: Comando `/hugo-deploy` + contexto de configuración de Cloudflare Pages. REPON hereda la capacidad de desplegar con un solo comando de OCA.
- **Valor para REPON**: Despliegue directo a Cloudflare Pages sin GitHub Actions ni CI/CD externo. `hugo --minify --gc && wrangler pages deploy public/`.
- **¿Duplicado?**: No. Es la única vía de despliegue.
- **Riesgo**: Requiere cuenta Cloudflare y token API configurado. Paso único por REPON.
---
