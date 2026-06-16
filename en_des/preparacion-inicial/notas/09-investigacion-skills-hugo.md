# Investigación de Skills Existentes para Hugo

**Propósito**: Identificar y documentar todas las herramientas, módulos, MCP servers, plugins, temas y skills existentes en el ecosistema Hugo que sean candidatos para incorporar a un directorio `.opencode/skills/`.

**Fecha**: 2026-06-15

**Fuentes consultadas**:
- https://gohugo.io/ (documentación oficial)
- https://themes.gohugo.io/ (galería oficial de temas)
- https://hugomods.com/ (módulos Hugo comunitarios)
- https://hugoblox.com/ (framework Hugo Blox)
- https://github.com/gohugoio/hugo (repositorio oficial, 88k+ estrellas)
- https://github.com/ (búsqueda general de repositorios Hugo)
- https://discourse.gohugo.io/ (foro comunitario)
- https://www.npmjs.com/ (paquetes npm)
- https://pypi.org/project/hugo/ (paquete pip)
- https://pkg.go.dev/github.com/gohugoio/hugo (documentación Go)
- Búsquedas web generales sobre herramientas, SEO, i18n, formularios, etc.

---

## Índice
1. [Resumen ejecutivo](#1-resumen-ejecutivo)
2. [MCP Servers e integraciones IA](#2-mcp-servers-e-integraciones-ia)
3. [Módulos Hugo oficiales y comunitarios](#3-módulos-hugo-oficiales-y-comunitarios)
4. [Temas con funcionalidades destacadas](#4-temas-con-funcionalidades-destacadas)
5. [Herramientas CLI y GitHub Actions](#5-herramientas-cli-y-github-actions)
6. [Integraciones CMS](#6-integraciones-cms)
7. [Utilidades de contenido y SEO](#7-utilidades-de-contenido-y-seo)
8. [Formularios y búsqueda](#8-formularios-y-búsqueda)
9. [Procesamiento de imágenes](#9-procesamiento-de-imágenes)
10. [Internacionalización (i18n)](#10-internacionalización-i18n)
11. [Herramientas IA para contenido Hugo](#11-herramientas-ia-para-contenido-hugo)
12. [Tabla comparativa de skills por competencia](#12-tabla-comparativa-de-skills-por-competencia)
13. [Recomendaciones para incorporar a .opencode/skills/](#13-recomendaciones-para-incorporar-a-opencode-skills)

---

## 1. Resumen ejecutivo

El ecosistema Hugo en 2026 es extremadamente maduro. Con **88,547 estrellas** en GitHub, **v0.163.1** como última versión y **más de 14 años de desarrollo**, Hugo cuenta con:

- **4 MCP servers** activos para integración con asistentes IA (Claude, Cursor, etc.)
- **1 solicitud oficial** en el repositorio central de Hugo para un MCP server oficial (issue #14747)
- **25+ módulos** en el ecosistema HugoMods (SEO, imágenes, bootstrap, búsqueda, PWA, etc.)
- **300+ temas** en la galería oficial, con al menos 10 que superan las 2000 estrellas
- **7+ integraciones CMS** principales (Decap CMS, Tina CMS, CloudCannon, Front Matter CMS, etc.)
- **5+ servicios de formularios** compatibles con sitios estáticos Hugo
- **6+ soluciones de búsqueda** (Pagefind, Fuse.js, FlexSearch, Lunr, Algolia, etc.)
- **3+ herramientas IA especializadas** para generación de contenido Hugo
- **Múltiples GitHub Actions** para CI/CD, incluyendo peaceiris/actions-hugo (la más usada)
- **Docker images oficiales** mantenidas por el equipo de HugoMods

El ecosistema está **altamente activo**, con la mayoría de herramientas principales recibiendo actualizaciones en 2026.

---

## 2. MCP Servers e integraciones IA

> **¿Qué es y para qué sirve?** MCP (Model Context Protocol) es un estándar abierto que permite a asistentes de inteligencia artificial —como Claude, ChatGPT o Gemini— comunicarse directamente con herramientas y servicios externos. Un MCP Server para Hugo actúa como un puente: el agente de IA puede, a través de él, leer, crear, modificar y eliminar páginas, ejecutar compilaciones, gestionar activos, consultar el contenido con búsqueda de texto completo y auditar el sitio. Esto convierte a Hugo en un sistema manejable íntegramente desde una conversación con IA. En esta sección se documentan los cuatro servidores MCP activos encontrados en el ecosistema, sus capacidades y su valor para el proyecto.

### 2.1 hugo-mcp (jmrGrav/hugo-mcp)

- **URL**: https://github.com/jmrGrav/hugo-mcp
- **Propósito**: MCP server completo para gestión de sitios Hugo desde Claude.ai. Expone 10 herramientas MCP para crear, leer, modificar y eliminar páginas, reconstruir el sitio, gestionar assets y auditorías.
- **Funciones principales**:
  - `list_pages` - Listar páginas con filtros por idioma/sección
  - `get_page` - Leer frontmatter + contenido Markdown
  - `create_page` - Crear página + reconstruir + purgar caché Cloudflare
  - `update_page` - Modificar página + reconstruir + purgar caché
  - `delete_page` - Eliminar página + reconstruir + purga completa CF
  - `build_site` - Reconstrucción completa + despliegue + purga CF
  - `upload_asset` - Subir imágenes a `static/`
  - `list_assets` - Listar assets estáticos y page bundles
  - `generate_featured_image` - Generar imagen destacada Tokyo Night
  - `check_sri_versions` - Auditar hashes SRI + versiones npm
- **Compatibilidad IA**: Total. Implementa protocolo MCP estándar. Compatible con Claude.ai (vía OAuth), Claude Desktop, Cursor.
- **Estado**: **Muy activo** (v2.1.0, mayo 2026). 12 releases en 2 semanas.
- **Estrellas GitHub**: ~0-9 (proyecto muy nuevo, mayo 2026)
- **Licencia**: MIT
- **Stack**: Python (FastAPI), JSON-RPC 2.0
- **Valor para PYT-SWE**: **ALTO**. Es el MCP server más completo para Hugo. Permite a un agente IA gestionar completamente un sitio Hugo. Ideal como modelo para crear skills OpenCode.

### 2.2 hugo-memex (queelius/hugo-memex)

- **URL**: https://github.com/queelius/hugo-memex
- **Propósito**: MCP server que indexa contenido Hugo en SQLite con FTS5 (búsqueda de texto completo) y lo expone a asistentes IA para consultas, búsqueda y creación de contenido.
- **Funciones principales**:
  - `execute_sql` - SQL de solo lectura con 10 consultas de ejemplo
  - `get_pages` - Recuperación masiva de contenido (filtros por sección, tag, FTS)
  - `get_content` - Markdown raw del sistema de archivos
  - `create_page` - Crear contenido con estructura de leaf bundle
  - `update_page` - Fusionar frontmatter / reemplazar cuerpo
  - `suggest_tags` - Sugerencias de tags basadas en FTS5
  - `get_front_matter_template` - Derivar convenciones de sección
  - `validate_page` - Verificar completitud, consistencia de tags, referencias cruzadas
  - `rebuild_index` - Re-sincronización incremental
- **Compatibilidad IA**: Total. Protocolo MCP estándar. Compatible con Claude Code (`.mcp.json`), Cursor, Cline.
- **Estado**: Activo (marzo 2026)
- **Estrellas GitHub**: Nueva, sin datos precisos
- **Licencia**: NO CONFIRMADA
- **Stack**: Python, SQLite FTS5
- **Valor para PYT-SWE**: **ALTO**. Aporta capacidad de búsqueda semántica y consultas SQL sobre el sitio Hugo. Útil para análisis de contenido masivo.

### 2.3 hugo-docs-mcp (danfinn5/hugo-docs-mcp)

- **URL**: https://github.com/danfinn5/hugo-docs-mcp
- **Propósito**: MCP server para equipos de documentación que gestionan sitios Hugo a escala. Auditoría de contenido, validación de frontmatter, verificación de enlaces y scaffolding de páginas.
- **Funciones principales**:
  - `audit_freshness` - Auditar antigüedad del contenido
  - `validate_frontmatter` - Validar campos de frontmatter
  - `create_page` - Crear páginas con scaffolding
  - `check_links` - Verificar enlaces rotos
  - `list_sections` - Listar secciones del sitio
  - `bulk_update_frontmatter` - Actualización masiva de frontmatter
  - `detect_duplicates` - Detectar contenido duplicado
- **Compatibilidad IA**: Total. MCP estándar. Compatible con Claude Code, Cursor.
- **Estado**: Activo (marzo 2026)
- **Estrellas GitHub**: < 10
- **Licencia**: NO CONFIRMADA
- **Stack**: Go
- **Valor para PYT-SWE**: **MEDIO-ALTO**. Ideal para equipos de documentación. Las funciones de auditoría y validación son directamente reutilizables como skills.

### 2.4 hugo-frontmatter-mcp (wdm0006/hugo-frontmatter-mcp)

- **URL**: https://github.com/wdm0006/hugo-frontmatter-mcp
- **Propósito**: MCP server especializado en operaciones de frontmatter YAML en archivos Markdown de Hugo. Lectura, actualización, validación y operaciones por lotes.
- **Funciones principales**:
  - `get_frontmatter` - Obtener todos los campos de frontmatter
  - `get_field` - Obtener un campo específico
  - `set_title`, `set_date`, `set_publish_date`, `set_description`, `set_draft_status`
  - `add_tag` / `remove_tag` - Gestionar tags
  - `add_image` / `remove_image` - Gestionar imágenes en frontmatter
  - `list_tags_in_directory` - Listar todos los tags
  - `find_posts_by_tag` - Buscar posts por tag
  - `rename_tag_in_directory` - Renombrar tags globalmente
  - `validate_date_formats` - Validar formatos de fecha
- **Compatibilidad IA**: Total. MCP estándar. Instalable vía Smithery. Compatible con Claude Desktop.
- **Estado**: Activo (última actualización febrero 2026)
- **Estrellas GitHub**: ~0 (nuevo)
- **Licencia**: MIT
- **Stack**: Python
- **Valor para PYT-SWE**: **MEDIO**. Muy específico para frontmatter. Útil como skill auxiliar pero limitado en alcance.

### 2.5 Feature Request: Official GoHugo MCP Server

- **URL**: https://github.com/gohugoio/hugo/issues/14747
- **Propósito**: Solicitud oficial a gohugoio para crear un MCP server oficial para Hugo.
- **Estado**: **Abierta**, etiquetada como "Proposal", milestone "Unscheduled" (abril 2026)
- **Funciones propuestas**:
  - Crear y editar contenido (posts, páginas, taxonomías)
  - Gestionar configuración del sitio
  - Ejecutar builds y previsualizaciones (`hugo server`, `hugo build`)
  - Consultar estructura del sitio (secciones, menús, taxonomías)
  - Gestionar temas y módulos
- **Valor para PYT-SWE**: **INFORMATIVO**. Indica que la comunidad y el equipo de Hugo están considerando oficializar un MCP server, lo que valida la dirección del proyecto.

### Tabla comparativa de MCP Servers

| Característica | hugo-mcp (2.1) | hugo-memex (2.2) | hugo-docs-mcp (2.3) | hugo-frontmatter-mcp (2.4) | Feature Request (2.5) |
|---|---|---|---|---|---|
| **Propósito principal** | Gestión completa de sitio Hugo desde IA | Indexación y búsqueda semántica de contenido | Auditoría y validación de documentación | Operaciones especializadas sobre frontmatter | Propuesta de MCP server oficial |
| **Funciones principales** | 10 herramientas: CRUD páginas, build, assets, SRI | 9 herramientas: SQL FTS5, crear/validar páginas, sugerir tags | 7 herramientas: auditoría, validar frontmatter, detectar duplicados, scaffolding | 10+ herramientas: get/set campos frontmatter, tags, fechas | 5 propuestas: contenido, configuración, builds, estructura, temas |
| **Soporta CRUD contenido** | ✅ `create_page`, `update_page`, `delete_page` | ✅ `create_page`, `update_page` | ✅ `create_page` (scaffolding) | ❌ Solo frontmatter | ✅ Propuesto |
| **Validación** | ⚠️ Parcial (SRI hashes) | ✅ `validate_page` (completitud, tags, referencias) | ✅ `validate_frontmatter`, `detect_duplicates`, `check_links` | ✅ `validate_date_formats` | ❌ No especificado |
| **Búsqueda / Consultas** | ⚠️ `list_pages` con filtros | ✅ SQL FTS5, `suggest_tags`, `get_content` | ✅ `list_sections` | ✅ `find_posts_by_tag`, `list_tags_in_directory` | ❌ No especificado |
| **Operaciones por lote** | ❌ No | ❌ No | ✅ `bulk_update_frontmatter` | ✅ `rename_tag_in_directory` | ❌ No |
| **Stack** | Python (FastAPI) | Python, SQLite FTS5 | Go | Python | Sin definir |
| **Versión** | v2.1.0 (mayo 2026) | — (marzo 2026) | — (marzo 2026) | — (febrero 2026) | Propuesta abierta |
| **Estado** | Muy activo (12 releases/2 sem) | Activo | Activo | Activo | Abierta (milestone Unscheduled) |
| **Licencia** | MIT | NO CONFIRMADA | NO CONFIRMADA | MIT | — |
| **Compatibilidad IA** | ✅ Claude.ai, Claude Desktop, Cursor | ✅ Claude Code, Cursor, Cline | ✅ Claude Code, Cursor | ✅ Claude Desktop (Smithery) | — |
| **Valor PYT-SWE** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ (Informativo) |

**Leyenda**: ✅ = Soporte completo | ⚠️ = Soporte parcial | ❌ = No soportado

---

## 3. Módulos Hugo oficiales y comunitarios

> **¿Qué es y para qué sirve?** Los módulos Hugo son paquetes reutilizables que extienden las capacidades del generador sin tener que escribir código desde cero. Funcionan mediante el sistema Hugo Modules (basado en Go Modules) y se instalan con una sola línea en la configuración. Pueden añadir desde galerías de imágenes, optimización SEO, integración con redes sociales, reproductores de video, hasta sistemas completos de búsqueda y temas. Son el equivalente a los plugins de WordPress o los paquetes npm, pero nativos de Hugo. Esta sección cataloga los ecosistemas modulares más relevantes, encabezados por HugoMods con más de 25 módulos funcionales.

### 3.1 HugoMods (hugomods.com)

- **URL**: https://hugomods.com/
- **Propósito**: Ecosistema integral de módulos Hugo para construir temas y sitios modulares. Incluye un framework de temas (HugoPress), procesamiento de imágenes, SEO, búsqueda, PWA, iconos y más.
- **Repositorio**: https://github.com/hugomods (organización GitHub)
- **Competencias**: SEO, imágenes, búsqueda, rendimiento, PWA, iconos, analytics
- **Compatibilidad IA**: NO directa (no es MCP), pero los módulos son consumibles por skills IA como documentación de referencia.
- **Estado**: **Muy activo** (actualizado semanalmente en 2026)
- **Estrellas GitHub**: 19 (hugopress), varios módulos individuales
- **Licencia**: MIT
- **Stack**: HTML, Go Templates, JavaScript

**Módulos destacados**:

| Módulo | URL | Propósito | Licencia | Precio |
|--------|-----|-----------|----------|--------|
| HugoPress | https://hugopress.hugomods.com/ | Sistema de hooks para temas modulares | MIT | Gratuito |
| SEO | https://hugomods.com/docs/seo/ | Meta tags, Open Graph, Twitter Cards, Schema, Favicons | MIT | Gratuito |
| Images | https://images.hugomods.com/ | Procesamiento de imágenes vía URL (redimensionar, recortar, filtros) | MIT | Gratuito |
| Search | https://search.hugomods.com/ | Búsqueda difusa cliente-side con Fuse.js | MIT | Gratuito |
| Icons | https://icons.hugomods.com/ | SVG icons (Bootstrap, FontAwesome, Material, Simple Icons, etc.) | MIT | Gratuito |
| PWA | https://hugomods.com/docs/ | Progressive Web Apps offline | MIT | Gratuito |
| Bootstrap | https://bootstrap.hugomods.com/docs/ | Shortcodes Bootstrap (grid, alerts, accordion, cards) | MIT | Gratuito |
| Decap CMS | https://decap-cms.hugomods.com/ | Integración con Decap CMS | MIT | Gratuito |
| Extended Shortcodes | — | Reproductores multimedia, code playgrounds | MIT | Gratuito |
| Mermaid/KaTeX | — | Diagramas y fórmulas matemáticas | MIT | Gratuito |
| Analytics | — | Google Analytics, Cloudflare, Baidu, Umami, Microsoft Clarity | MIT | Gratuito |
| Docker | https://hugomods.com/docs/docker/ | Imágenes Docker oficiales para Hugo | MIT | Gratuito |
| i18n JS | https://hugomods.com/docs/i18n-js/ | Traducciones en JavaScript | MIT | Gratuito |

- **Valor para PYT-SWE**: **MUY ALTO**. Los módulos de HugoMods representan funcionalidades directamente empaquetables como skills. Cada módulo es una competencia claramente definida.

### 3.2 HugoPress - Framework de hooks

- **URL**: https://hugopress.hugomods.com/
- **Propósito**: Sistema de hooks (eventos) para construir temas Hugo modulares. Permite que los temas carguen módulos automáticamente sin requerir nuevas funcionalidades.
- **Valor para PYT-SWE**: **MEDIO**. El concepto de hooks (eventos antes/después de renderizar) podría inspirar una skill similar para orquestar otras skills.

---

## 4. Temas con funcionalidades destacadas

> **¿Qué es y para qué sirve?** Los temas de Hugo determinan la apariencia, la estructura de navegación, el SEO, el rendimiento y la experiencia de usuario de un sitio. Aunque un tema es principalmente una plantilla visual, muchos incluyen funcionalidades integradas que resuelven problemas completos: generación automática de Open Graph, Twitter Cards, Schema.org, optimización de imágenes, soporte multilingüe, modo oscuro, búsqueda, y más. Seleccionar un tema adecuado puede ahorrar semanas de desarrollo. Esta sección analiza los temas más destacados del ecosistema Hugo, evaluando no solo su estética sino las competencias funcionales que aportan.

### 4.1 PaperMod

- **URL**: https://github.com/adityatelange/hugo-PaperMod
- **Estrellas**: 9,000+
- **Propósito**: Tema minimalista para blogs de desarrolladores. El más popular de Hugo por amplio margen.
- **Funcionalidades destacadas**:
  - Búsqueda Fuse.js cliente-side
  - Modo oscuro con detección del sistema
  - i18n multilingüe
  - Tabla de contenidos automática
  - Cover images
  - Breadcrumbs
  - 3 modos de layout
  - Zero dependencias JavaScript
- **Licencia**: MIT
- **Valor para PYT-SWE**: **MEDIO**. Sirve como referencia para entender expectativas de temas Hugo, pero como skill específico no es directamente incorporable.

### 4.2 Blowfish

- **URL**: https://github.com/nunocoracao/blowfish
- **Estrellas**: ~2,000+
- **Propósito**: Tema moderno basado en Tailwind CSS 3/4 con funcionalidades avanzadas. Competidor directo de PaperMod en el espacio Tailwind.
- **Funcionalidades destacadas**:
  - Tailwind CSS v4
  - Búsqueda Fuse.js
  - Firebase view counters y likes
  - Modo zen de lectura
  - Galerías de imágenes
  - Timeline layout
  - Mermaid/Chart.js/KaTeX
  - RTL support
  - SEO breadcrumbs estructurados
  - CLI propio (`npx blowfish-tools`, 600+ descargas/mes en npm)
  - GitHub Alerts/Admonitions
- **Licencia**: MIT
- **Valor para PYT-SWE**: **MEDIO**. Interesante por su CLI (blowfish-tools) como ejemplo de herramienta auxiliar.

### 4.3 HugoBlox (framework)

- **URL**: https://hugoblox.com/
- **Estrellas**: 9,426 (framework base)
- **Propósito**: Framework de contenido estructurado con blocks (bloques reutilizables). Orientado a sitios académicos, portfolios, documentación y landing pages.
- **Funcionalidades destacadas**:
  - 31+ bloques pre-construidos (hero, features, pricing, FAQ, testimonios, portfolio, etc.)
  - Arquitectura de bloques Go HTML o Preact (React liviano)
  - Tailwind CSS pipeline integrado
  - Markdown como fuente de datos
  - Integración con ORCID, OpenAlex, Zotero, BibTeX
  - Jupyter Notebooks como contenido
  - LaTeX/Math (KaTeX)
  - Mermaid diagrams
  - JSON-LD para SEO
  - Hugo Chat AI (asistente IA integrado)
  - 150,000+ sitios en producción (NASA, Stanford, MIT, NVIDIA)
- **Licencia**: MIT (framework gratuito, planes Plus/Pro para funciones IA)
- **Valor para PYT-SWE**: **ALTO**. El concepto de "bloques" reutilizables configurables vía frontmatter es directamente exportable a skills OpenCode. Hugo Chat AI es un skill IA que ya existe.

### 4.4 Docsy (Google)

- **URL**: https://github.com/google/docsy
- **Estrellas**: 2,919
- **Propósito**: Tema Hugo oficial de Google para documentación técnica. Usado por Kubernetes, Prometheus, gRPC y cientos de proyectos open source.
- **Funcionalidades destacadas**:
  - Navegación lateral autogenerada
  - Soporte multi-versión
  - Búsqueda (Algolia, Lunr, Google Custom Search)
  - Diagramas (Mermaid, PlantUML, Diagrams.net, MarkMap)
  - KaTeX para fórmulas matemáticas
  - `llms.txt` y soporte para agentes IA (v0.15.0, mayo 2026)
  - Output Markdown para consumo por IA
  - Alertas/admonitions
  - Internacionalización completa
  - 190+ contribuidores
- **Licencia**: Apache 2.0
- **Valor para PYT-SWE**: **ALTO**. Docsy v0.15.0 incluye soporte nativo para agentes IA (`llms.txt`, Markdown output, "View Markdown" links). Es el tema más avanzado en integración con IA.

### 4.5 Hextra

- **URL**: https://github.com/imfing/hextra
- **Estrellas**: 2,128
- **Propósito**: Tema moderno "batteries-included" para documentación, blogs y sitios estáticos. Inspirado en Nextra (Next.js).
- **Funcionalidades destacadas**:
  - Búsqueda offline con FlexSearch (sin configuración)
  - Tailwind CSS
  - Modo oscuro
  - Multi-lenguaje
  - SEO tags, Open Graph, Twitter Cards
  - LaTeX, Mermaid
  - Sin dependencia Node.js
  - GitHub Actions para deploy incluido
- **Licencia**: MIT
- **Valor para PYT-SWE**: **BAJO-MEDIO**. Tema correcto pero sin características únicas para skills.

### 4.6 Doks

- **URL**: https://github.com/thuliteio/doks
- **Estrellas**: 2,343
- **Propósito**: Tema de documentación con Thulite (fork de Hyas). Rápido, accesible y fácil de usar.
- **Funcionalidades destacadas**:
  - FlexSearch para búsqueda
  - Modo oscuro
  - i18n
  - Versionado de documentación
- **Licencia**: MIT
- **Valor para PYT-SWE**: **BAJO**. Similar a Docsy pero menos funcionalidades IA.

### 4.7 Hugo Book

- **URL**: https://github.com/alex-shpak/hugo-book
- **Estrellas**: 3,990
- **Propósito**: Tema de documentación "simple como un libro".
- **Funcionalidades destacadas**:
  - Diseño limpio y simple
  - Multi-idioma
  - Dark mode
  - Shortcodes
  - Comentarios
  - Sin dependencias JavaScript para funcionalidades principales
- **Licencia**: MIT
- **Valor para PYT-SWE**: **BAJO**.

### 4.8 Otros temas notables

| Tema | Estrellas | Especialidad |
|------|-----------|-------------|
| Congo | ~2,000 | Tailwind CSS, moderno, personal |
| Hugo Stack | ~3,000+ | Blog, tarjetas, clean |
| FixIt | ~500+ | Sucesor de LoveIt, PWA, AI summaries, cifrado |
| Terminal | ~3,000+ | Estilo terminal |
| Paper | ~2,000+ | Minimalista extremo, RTL |
| Ananke | ~1,000+ | Tema oficial de inicio rápido |

### Tabla comparativa de Temas

| Característica | PaperMod (4.1) | Blowfish (4.2) | HugoBlox (4.3) | Docsy (4.4) | Hextra (4.5) | Doks (4.6) | Hugo Book (4.7) |
|---|---|---|---|---|---|---|
| **Tipo** | Blog | Blog / General | Framework / Académico | Documentación | Documentación / Blog | Documentación | Documentación |
| **Estrellas GitHub** | 9,000+ | ~2,000+ | 9,426 | 2,919 | 2,128 | 2,343 | 3,990 |
| **SEO nativo (OG + Schema)** | ✅ | ✅ | ✅ JSON-LD | ✅ | ✅ | ✅ | ⚠️ Básico |
| **Búsqueda integrada** | ✅ Fuse.js | ✅ Fuse.js | — | ✅ Algolia/Lunr | ✅ FlexSearch | ✅ FlexSearch | ❌ |
| **i18n** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Modo oscuro** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Tailwind CSS** | ❌ | ✅ v4 | ✅ | ❌ | ✅ | ❌ | ❌ |
| **Soporte IA (llms.txt, output MD)** | ❌ | ❌ | ✅ Hugo Chat AI | ✅ v0.15.0 | ❌ | ❌ | ❌ |
| **Funcionalidad única** | Zero JS, 3 layouts | Firebase counters, CLI propio | 31+ bloques, Hugo Chat | Soporte agentes IA oficial | Sin Node.js, GitHub Actions incluidas | FlexSearch nativo | Sin JS para funcionalidades core |
| **Licencia** | MIT | MIT | MIT (+ planes IA) | Apache 2.0 | MIT | MIT | MIT |
| **Valor PYT-SWE** | ⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐ | ⭐⭐ |

**Leyenda**: ✅ = Soporte completo | ⚠️ = Soporte parcial o básico | ❌ = No soportado | — = No disponible / no aplica

---

## 5. Herramientas CLI y GitHub Actions

> **¿Qué es y para qué sirve?** Las herramientas CLI (Command Line Interface) y las GitHub Actions automatizan tareas repetitivas del flujo de trabajo con Hugo: instalar la versión correcta del binario, compilar el sitio, ejecutar comprobaciones de enlaces rotos, auditar SEO, optimizar imágenes, y desplegar en producción. Mientras que las CLI se ejecutan localmente o en scripts, las GitHub Actions se integran directamente en el repositorio para que cada vez que se suba un cambio (git push) se ejecute una tubería completa de construcción, verificación y publicación sin intervención manual. Esta sección documenta las acciones y herramientas más utilizadas y fiables del ecosistema.

### 5.1 peaceiris/actions-hugo

- **URL**: https://github.com/peaceiris/actions-hugo
- **Propósito**: GitHub Action para instalar Hugo en runners de GitHub Actions. Soporta versiones extended, Hugo Modules, Linux/macOS/Windows.
- **Uso estándar**:
  ```yaml
  - name: Setup Hugo
    uses: peaceiris/actions-hugo@v3
    with:
      hugo-version: '0.119.0'
      extended: true
  ```
- **Estado**: **Muy activo**. Es la GitHub Action más usada para Hugo.
- **Stack**: TypeScript (migrado de Docker)
- **Valor para PYT-SWE**: **ALTO**. Fundamental para cualquier pipeline CI/CD Hugo. Como skill, representa la capacidad de "setup y build automatizado".

### 5.2 slauger/hugo-gitops-pipeline

- **URL**: https://github.com/slauger/hugo-gitops-pipeline
- **Propósito**: Pipeline CI/CD reutilizable y completo para Hugo con despliegue GitOps a Kubernetes. Cumplimiento GDPR (sin CDNs externas).
- **Funcionalidades**:
  - Multi-entorno (dev, staging, QA, production)
  - ArgoCD para GitOps
  - Contenedores multi-etapa (builder Node.js+Hugo, runtime nginx)
  - Semantic versioning automatizado
  - Seguridad (digest de imágenes fijos, contenedores no-root)
- **Estado**: Activo (febrero 2026)
- **Valor para PYT-SWE**: **MEDIO**. Pipeline muy completo pero específico para organizaciones con Kubernetes.

### 5.3 hugo-extended (npm)

- **URL**: https://www.npmjs.com/package/hugo-extended
- **Propósito**: Binary wrapper para Hugo Extended con TypeScript type-safe. Permite usar Hugo desde Node.js/TypeScript sin instalar binarios manualmente.
- **Funcionalidades**:
  - CLI completa de Hugo con tipos TypeScript
  - APIs funcionales y builder-style
  - Zero configuración
  - 212,500+ descargas semanales
- **Stack**: TypeScript/JavaScript
- **Valor para PYT-SWE**: **ALTO**. Permite integrar Hugo en entornos Node/JS nativamente. Ideal para skills que necesiten ejecutar comandos Hugo desde JavaScript.

### 5.4 hugo-bin (npm)

- **URL**: https://www.npmjs.com/package/hugo-bin
- **Propósito**: Binary wrapper para Hugo (predecesor de hugo-extended). Similar funcionalidad.
- **Estrellas GitHub**: 95
- **Stack**: JavaScript
- **Valor para PYT-SWE**: **BAJO-MEDIO**. Reemplazado funcionalmente por hugo-extended, pero aún mantenido.

### 5.5 hugo (pip)

- **URL**: https://pypi.org/project/hugo/
- **Propósito**: Wheels Python de Hugo para instalar vía `pip`. Soporta Hugo Extended + withdeploy.
- **Stack**: Python (wheels)
- **Valor para PYT-SWE**: **MEDIO**. Útil para entornos Python donde se prefiera `pip` sobre descargas directas.

### 5.6 hugoreleaser (gohugoio/hugoreleaser)

- **URL**: https://github.com/gohugoio/hugoreleaser
- **Propósito**: Herramienta oficial de release para Hugo. Usada por el equipo de Hugo para generar releases multiplataforma.
- **Estado**: v0.61.2 (enero 2026), Apache 2.0
- **Stack**: Go
- **Valor para PYT-SWE**: **BAJO**. Herramienta interna del equipo Hugo, no diseñada para usuarios generales.

### 5.7 Otras GitHub Actions relevantes

| Action | URL | Propósito |
|--------|-----|-----------|
| actions/configure-pages | https://github.com/actions/configure-pages | Configurar GitHub Pages (oficial) |
| actions/deploy-pages | https://github.com/actions/deploy-pages | Deploy a GitHub Pages (oficial) |
| peaceiris/actions-gh-pages | https://github.com/peaceiris/actions-gh-pages | Deploy a GitHub Pages vía gh-pages branch |
| jakejarvis/s3-sync-action | https://github.com/jakejarvis/s3-sync-action | Sincronizar con S3 |
| burnett01/rsync-deployments | https://github.com/burnett01/rsync-deployments | Deploy vía rsync a VPS |

---

## 6. Integraciones CMS

> **¿Qué es y para qué sirve?** Un CMS (Content Management System) para Hugo proporciona una interfaz gráfica —similar a WordPress— para que personas sin conocimientos técnicos puedan crear, editar y organizar el contenido del sitio sin tocar archivos Markdown ni código. Como Hugo es un generador de sitios estáticos (no tiene backend), estos CMS funcionan normalmente sobre repositorios Git: guardan el contenido como archivos Markdown con front matter en el propio repositorio, y Hugo lo compila al publicar. Esto permite que el flujo Copista (IA) y el editor humano convivan: la IA genera el Markdown y el humano lo revisa y ajusta desde el CMS. Esta sección recoge las integraciones CMS más maduras y compatibles con Hugo.

### 6.1 Decap CMS (formerly Netlify CMS)

- **URL**: https://decapcms.org/docs/hugo/
- **Propósito**: CMS Git-based open source para sitios estáticos. Interfaz web tipo WordPress para editar contenido.
- **Funcionalidades**:
  - Editor visual WYSIWYG
  - Autenticación vía GitHub/Netlify Identity
  - Configurable vía `config.yml`
  - Widgets para frontmatter
  - Editor de componentes para shortcodes Hugo
  - Integración directa con repositorio Git
- **Módulo Hugo**: https://decap-cms.hugomods.com/ (configurable vía Hugo)
- **Estado**: **Muy activo**. Es la integración CMS más popular para Hugo.
- **Licencia**: MIT
- **Valor para PYT-SWE**: **ALTO**. Representa la capacidad de "gestión de contenido visual". Como skill, permitiría a un agente IA configurar Decap CMS para un proyecto Hugo.

### 6.2 Tina CMS

- **URL**: https://tina.io/
- **Propósito**: CMS Git-based con editor visual en el sitio. API-driven y open source.
- **Funcionalidades**:
  - Edición inline visual
  - Git-based (versión controlada)
  - Templating system para tipos de contenido
  - UI intuitiva con preview
- **Soporte Hugo**: Vía Hugolify y configuración manual
- **Estado**: Activo, pero el soporte Hugo es comunitario (no oficial como tal)
- **Valor para PYT-SWE**: **MEDIO**. Menos integrado que Decap CMS en el ecosistema Hugo.

### 6.3 CloudCannon

- **URL**: https://cloudcannon.com/
- **Propósito**: CMS premium para sitios estáticos. Edición visual inline con Bookshop (componentes visuales).
- **Funcionalidades**:
  - Edición visual inline directamente en la página
  - Bookshop (framework de componentes open source)
  - Soporte multi-SSG (Hugo, Eleventy, Jekyll, Astro)
  - Autenticación y roles
- **Precio**: Premium (SaaS), con prueba gratuita
- **Estado**: Activo. Es la opción CMS premium más robusta para Hugo.
- **Valor para PYT-SWE**: **BAJO-MEDIO**. Es un servicio SaaS de pago, no una skill empaquetable.

### 6.4 Front Matter CMS

- **URL**: https://frontmatter.codes/
- **Propósito**: CMS liviano que funciona dentro de Visual Studio Code. Gestión de contenido directamente desde el editor.
- **Funcionalidades**:
  - Edición de frontmatter con UI visual
  - Preview en tiempo real
  - Trabajo offline
  - 100% seguro (no requiere servidor externo)
  - Taxonomías, snippets, media manager
- **Estado**: Activo
- **Valor para PYT-SWE**: **MEDIO**. Interesante como skill para edición de contenido desde VS Code. No empaquetable directamente.

### 6.5 Hugolify

- **URL**: https://www.hugolify.io/
- **Propósito**: Framework Hugo completo con Bootstrap + 7 CMS headless (CloudCannon, Decap, Netlify, Pages, Static, Sveltia y Tina).
- **Funcionalidades**:
  - 10+ tipos de contenido (pages, persons, posts, projects)
  - 25+ bloques de contenido
  - CMS intercambiable (misma configuración, diferente backend)
  - Accesibilidad first
  - Rendimiento web (PageSpeed)
  - Bajo carbono (imágenes responsive, lazy loading)
  - GDPR compliant (sin cookies, sin Google)
- **Estado**: Activo
- **Licencia**: NO CONFIRMADA
- **Stack**: Hugo + Bootstrap
- **Valor para PYT-SWE**: **ALTO**. Framework completo que abstrae la complejidad de elegir CMS. Como skill, ofrece una plantilla de proyecto completa.

### Tabla comparativa de Integraciones CMS

| Característica | Decap CMS (6.1) | Tina CMS (6.2) | CloudCannon (6.3) | Front Matter CMS (6.4) | Hugolify (6.5) |
|---|---|---|---|---|---|
| **URL** | [decapcms.org](https://decapcms.org/docs/hugo/) | [tina.io](https://tina.io/) | [cloudcannon.com](https://cloudcannon.com/) | [frontmatter.codes](https://frontmatter.codes/) | [hugolify.io](https://www.hugolify.io/) |
| **Licencia** | MIT | Apache 2.0 | SaaS propietario | MIT | NO CONFIRMADA |
| **Precio** | Gratuito | Open source (gratuito) | Premium (SaaS) | Gratuito (VS Code) | Gratuito |
| **Tipo** | CMS Git-based web | CMS Git-based visual | CMS SaaS premium | Extensión VS Code | Framework Hugo + CMS |
| **Editor** | Web WYSIWYG | Inline visual sobre el sitio | Inline visual + Bookshop | UI visual en VS Code | Intercambiable (7 CMS) |
| **Shortcodes Hugo** | ✅ Editor de componentes | ❌ No | ✅ Bookshop components | ⚠️ Snippets | ✅ 25+ bloques |
| **Frontmatter** | ✅ Widgets configurables | ✅ Templating system | ✅ Campos visuales | ✅ UI visual dedicada | ✅ 10+ tipos de contenido |
| **Autenticación** | GitHub / Netlify Identity | Git-based | Propia (SaaS) | No requiere (local) | Depende del CMS elegido |
| **Trabajo offline** | ❌ No | ❌ No | ❌ No | ✅ Sí | ❌ No |
| **Soporte Hugo** | ✅ Oficial (módulo HugoMods) | ⚠️ Comunitario (vía Hugolify) | ✅ Multi-SSG oficial | ✅ Nativo (VS Code) | ✅ Framework nativo Hugo |
| **Estado** | Muy activo | Activo | Activo | Activo | Activo |
| **Valor PYT-SWE** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |

**Leyenda**: ✅ = Soporte completo | ⚠️ = Soporte parcial | ❌ = No soportado

---

## 7. Utilidades de contenido y SEO

> **¿Qué es y para qué sirve?** Las utilidades de contenido y SEO son herramientas complementarias que mejoran la calidad, el posicionamiento y la capacidad de ser encontrado de un sitio Hugo. Mientras que Hugo incluye generación básica de metadatos (Open Graph, Twitter Cards, Schema), estas herramientas añaden auditoría automatizada, linting de SEO técnico, verificación de enlaces rotos, comprobación de visibilidad para agentes de IA (AEO), puntuaciones de optimización, y sugerencias correctivas. Son el equivalente a tener un auditor SEO robotizado que revisa cada página antes de publicarla. Esta sección cataloga las utilidades más útiles encontradas en el ecosistema.

### 7.1 Victor Hugo (SEO plugin)

- **URL**: https://github.com/doncabreraphone/victorhugo
- **Estrellas**: 74
- **Propósito**: Plugin SEO para Hugo en forma de partial template. Audita contenido mientras se escribe y da una puntuación basada en mejores prácticas SEO.
- **Funcionalidades**:
  - Verifica stop words en slugs
  - Detecta voz pasiva
  - Optimización de keyword/keyphrase
  - Meta descriptions SEO-friendly
  - Flesch Reading Ease Test
  - Funciona sin extensiones de navegador ni servicios externos
  - Compatible con cualquier tema Hugo
- **Estado**: Mantenimiento (última actividad 2024)
- **Licencia**: GPL v3
- **Stack**: HTML/JavaScript (jQuery)
- **Valor para PYT-SWE**: **MEDIO**. Interesante concepto pero implementación desactualizada (usa jQuery). La idea de "auditor SEO inline" es válida.

### 7.2 Hugo SEO Linter (por Steve Edwards)

- **URL**: https://sedward5.com/ultimate-hugo-seo-guide/ (artículo)
- **Propósito**: Linter SEO para Hugo que se ejecuta como GitHub Action. Valida títulos, meta descriptions y estructura de contenido.
- **Funcionalidades**:
  - Ejecuta como GitHub Action en archivos modificados
  - Verifica mínimo 500 palabras por post
  - Valida ausencia de H1 en Markdown (gestionado por plantilla)
  - Title (50-60 caracteres) y description (120-158 caracteres)
- **Estado**: Activo (2025)
- **Valor para PYT-SWE**: **ALTO**. Es directamente empaquetable como skill de auditoría SEO.

### 7.3 Hugo Broken Link & Image Checker

- **URL**: https://sedward5.com/ultimate-hugo-seo-guide/ (artículo)
- **Propósito**: GitHub Action para detectar enlaces e imágenes rotas en archivos Markdown Hugo.
- **Funcionalidades**:
  - Valida shortcodes existen en layout directory
  - Verifica `featured_image` y otros campos de frontmatter
  - Parsea archivos Markdown buscando enlaces e imágenes rotas
- **Valor para PYT-SWE**: **ALTO**. Skill de verificación de integridad directamente utilizable.

### 7.4 Hugo Image Optimization GitHub Action

- **URL**: https://sedward5.com/ultimate-hugo-seo-guide/ (artículo)
- **Propósito**: GitHub Action que optimiza imágenes automáticamente (conversión a WebP, redimensionado).
- **Funcionalidades**:
  - Convierte todo a WebP
  - Redimensiona inline images a 800px
  - Redimensiona featured images a 1920px
  - Actualiza referencias en Markdown
- **Valor para PYT-SWE**: **ALTO**. Procesamiento de imágenes automatizado como skill.

### 7.5 seofor.dev (SEO CLI)

- **URL**: https://github.com/ugolbck/seofordev
- **Estrellas**: 9
- **Propósito**: CLI open source para auditorías SEO locales con exportación de prompts para IA.
- **Funcionalidades**:
  - Auditorías SEO de localhost
  - Exportación "AI-Ready" (prompts para Claude, Cursor, ChatGPT)
  - Crawling de páginas JavaScript
  - Integración IndexNow
  - Zero configuración
- **Estado**: Activo (v3.0.1, febrero 2026)
- **Licencia**: Otra (NOASSERTION)
- **Stack**: Go + Playwright
- **Valor para PYT-SWE**: **ALTO**. Herramienta CLI moderna que exporta prompts para IA. Ideal como skill de auditoría + generación de reportes para agentes IA.

### 7.6 @capgo/seo-checker

- **URL**: https://github.com/Cap-go/seo-checker
- **Estrellas**: 2
- **Propósito**: Static SEO checker para sitios estáticos. 1000+ reglas de SEO.
- **Funcionalidades**:
  - Metadata, headings, indexability, links, imágenes
  - OpenGraph, Twitter Cards
  - SEO internacional (hreflang)
  - JSON-LD validation
  - Accesibilidad
  - Output: console, JSON, SARIF, GitHub
- **Estado**: Activo (v0.0.13, marzo 2026)
- **Stack**: TypeScript
- **Valor para PYT-SWE**: **MEDIO-ALTO**. Las reglas SEO son referencia para construir skills de validación. Ejecutable en CI/CD.

### 7.7 agentic-seo (addyosmani/agentic-seo)

- **URL**: https://github.com/addyosmani/agentic-seo
- **Estrellas**: NO CONFIRMADO
- **Propósito**: Auditoría de sitios para visibilidad en agentes IA (AEO - Agentic Engine Optimization).
- **Funcionalidades**:
  - Verifica `robots.txt` (no bloquear crawlers IA)
  - Verifica `llms.txt` (índice estructurado para IA)
  - Verifica `AGENTS.md`/`CLAUDE.md`
  - Token counting con `gpt-tokenizer`
  - Simulación de agente IA
  - Soporta Hugo como framework detectado automáticamente
- **Estado**: Muy reciente (abril 2026)
- **Stack**: TypeScript
- **Valor para PYT-SWE**: **MUY ALTO**. Es exactamente el tipo de skill que buscamos: audita si un sitio está optimizado para ser consumido por agentes IA. Directamente relevante para PYT-SWE.

### Tabla comparativa de Utilidades de contenido y SEO

| Característica | Victor Hugo (7.1) | Hugo SEO Linter (7.2) | Broken Link Checker (7.3) | Image Optimization (7.4) | seofor.dev (7.5) | @capgo/seo-checker (7.6) | agentic-seo (7.7) |
|---|---|---|---|---|---|---|
| **Tipo** | Partial template inline | GitHub Action | GitHub Action | GitHub Action | CLI local | CLI / npm | CLI TypeScript |
| **Propósito** | Auditoría SEO inline al escribir | Validar títulos y descripciones | Detectar enlaces e imágenes rotas | Optimizar imágenes a WebP | Auditoría SEO + exportación IA | 1000+ reglas SEO estáticas | Auditoría visibilidad agentes IA (AEO) |
| **Ejecución** | En el navegador (partial) | CI/CD (Git push) | CI/CD (Git push) | CI/CD (Git push) | Local / Terminal | Local / CI/CD | Local / CI/CD |
| **Validación frontmatter** | ❌ No | ✅ Title (50-60), Description (120-158) | ✅ `featured_image` y otros campos | ❌ No | ❌ No | ✅ Metadata, headings | ✅ `llms.txt`, `robots.txt` |
| **Validación enlaces** | ❌ No | ❌ No | ✅ Enlaces e imágenes rotas | ❌ No | ❌ No | ✅ Links, indexability | ❌ No |
| **Validación shortcodes** | ❌ No | ❌ No | ✅ Verifica existen en layouts | ❌ No | ❌ No | ❌ No | ❌ No |
| **SEO técnico** | ⚠️ Básico (keywords, stop words) | ⚠️ Básico (títulos, descripciones) | ❌ No | ❌ No | ✅ Completo (crawling local) | ✅ 1000+ reglas (OG, hreflang, JSON-LD, accesibilidad) | ✅ AEO (visibilidad en motores IA) |
| **Exportación IA** | ❌ No | ❌ No | ❌ No | ❌ No | ✅ Prompts para Claude, Cursor, ChatGPT | ❌ No | ✅ Simulación agente IA, token counting |
| **Stack** | HTML/JS (jQuery) | YAML (GitHub Action) | YAML (GitHub Action) | YAML (GitHub Action) | Go + Playwright | TypeScript | TypeScript |
| **Licencia** | GPL v3 | NO CONFIRMADA | NO CONFIRMADA | NO CONFIRMADA | NOASSERTION | NO CONFIRMADA | NO CONFIRMADA |
| **Precio** | Gratuito | Gratuito | Gratuito | Gratuito | Gratuito | Gratuito | Gratuito |
| **Estado** | Mantenimiento (2024) | Activo (2025) | Activo | Activo | Activo (v3.0.1, feb 2026) | Activo (v0.0.13, mar 2026) | Muy reciente (abr 2026) |
| **Valor PYT-SWE** | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |

**Leyenda**: ✅ = Soporte completo | ⚠️ = Soporte parcial | ❌ = No soportado | — = No disponible / no aplica

---

## 8. Formularios y búsqueda

> **¿Qué es y para qué sirve?** Los formularios y la búsqueda son dos funcionalidades que un sitio estático como Hugo no puede resolver por sí mismo al carecer de backend. Los formularios (contacto, suscripción, encuestas) necesitan un servicio externo que reciba los datos y los procese o los reenvíe por correo. La búsqueda (búsqueda en el sitio) necesita un índice generado tras la compilación y una librería JavaScript que lo consulte en el navegador del usuario. Ambas funcionalidades son críticas para cualquier sitio corporativo o blog, y existen múltiples soluciones probadas y compatibles con Hugo. Esta sección documenta las opciones más recomendables en cada categoría.

### 8.1 Formularios para sitios estáticos Hugo

Dado que Hugo genera HTML estático sin backend, los formularios requieren servicios externos. Estos son los principales:

| Servicio | URL | Plan Gratuito | Límite Gratuito | Spam | Webhooks |
|----------|-----|---------------|-----------------|------|----------|
| Web3Forms | https://web3forms.com/ | ✅ | 250/mes | reCaptcha | Pro |
| FabForm | https://fabform.io/ | ✅ | 50/mes | Honeypot | ✅ |
| SplitForms | https://splitforms.com/ | ✅ | 1,000/mes | IA + Honeypot | ✅ Gratis |
| Formspree | https://formspree.io/ | ✅ | 50/mes | reCaptcha | Premium |
| Getform | https://getform.io/ | ✅ | 50/mes | Spam filter | Pro |
| Netlify Forms | https://www.netlify.com/products/forms/ | ✅ | 100/mes | reCaptcha | ❌ |

- **Valor para PYT-SWE**: **MEDIO**. Los formularios son externalizados, no empaquetables como skills. Sin embargo, el módulo `tnd-forms` (https://github.com/theNewDynamic/hugo-module-tnd-forms) sí es un módulo Hugo reutilizable que abstrae múltiples proveedores.

### 8.2 Soluciones de búsqueda para Hugo

| Herramienta | URL | Tipo | Peso | Idioma |
|-------------|-----|------|------|--------|
| **Pagefind** | https://pagefind.app/ | Post-build indexing | ~10KB JS + ~75KB WASM | Multilingüe |
| **Fuse.js** | https://fusejs.io/ | Client-side JSON index | ~520KB | Fuzzy search |
| **FlexSearch** | https://github.com/nextapps-de/flexsearch | Client-side library | ~10KB | Más rápido |
| **Lunr.js** | https://lunrjs.com/ | Client-side | ~204KB | Abandonado (2020) |
| **Algolia DocSearch** | https://docsearch.algolia.com/ | SaaS (gratis para OSS) | ~30KB | Cloud |
| **Meilisearch** | https://www.meilisearch.com/ | Self-hosted/SaaS | Variable | Cloud |

**Recomendación 2026**: Pagefind es la opción por defecto para sitios estáticos Hugo. Fuse.js es común en temas (PaperMod, Blowfish). FlexSearch es usado por Hextra.

- **Valor para PYT-SWE**: **ALTO**. Pagefind es empaquetable como skill de post-build indexing. Fuse.js como skill de búsqueda cliente-side.

---

## 9. Procesamiento de imágenes

> **¿Qué es y para qué sirve?** El procesamiento de imágenes abarca todas las operaciones necesarias para que las fotografías y gráficos de un sitio web tengan el tamaño, formato y peso óptimos sin perder calidad: redimensionado, recorte, conversión a formatos modernos (WebP, AVIF), ajuste de calidad, y generación de múltiples versiones para diferentes tamaños de pantalla (responsive images). Una gestión inadecuada de imágenes es la principal causa de páginas lentas y malas puntuaciones en Lighthouse. Hugo incluye un sistema nativo (Hugo Pipes) y la comunidad ha desarrollado módulos complementarios. Esta sección detalla ambas opciones.

### 9.1 Hugo Pipes (nativo)

- **URL**: https://gohugo.io/content-management/image-processing/
- **Propósito**: Sistema nativo de procesamiento de imágenes en Hugo. Redimensionado, recorte, filtros, conversión de formato.
- **Métodos**: `Crop`, `Fill`, `Fit`, `Filter`, `Resize`, `Process`
- **Formatos**: BMP, GIF, JPEG, PNG, TIFF, WebP, AVIF
- **Funciones de metadatos**: EXIF, IPTC, XMP (lectura)
- **Valor para PYT-SWE**: **ALTO**. Las capacidades nativas de Hugo Pipes son referencia obligada. Un skill de procesamiento de imágenes debe conocer y usar estas funciones.

### 9.2 Hugo Images Module (HugoMods)

- **URL**: https://images.hugomods.com/
- **Propósito**: Procesamiento de imágenes vía URL query string. Facilita el uso de Hugo Pipes desde Markdown.
- **Funcionalidades**:
  - Procesar imágenes por URL (resize, crop, fit, fill, align)
  - Conversión a WebP con fallback
  - Lazy loading
  - Atributos width/height para CLS
  - Hashing de URLs
  - Filtros: brightness, ColorBalance, Colorize, Contrast, GaussianBlur, Grayscale, etc.
- **Valor para PYT-SWE**: **ALTO**. Representa la interfaz de usuario del procesamiento de imágenes.

### 9.3 future-wd/hugo-responsive-images

- **URL**: https://github.com/future-wd/hugo-responsive-images
- **Propósito**: Generación de imágenes responsive con srcset para Hugo.
- **Valor para PYT-SWE**: **BAJO-MEDIO**. Funcionalidad solapada con Hugo Pipes nativo.

---

## 10. Internacionalización (i18n)

> **¿Qué es y para qué sirve?** La internacionalización (i18n) es la capacidad de un sitio web de ofrecer su contenido en múltiples idiomas. En Hugo, esto incluye: tener versiones traducidas de cada página, cambiar el idioma de la interfaz (menús, pies de página, fechas), gestionar URLs con prefijo de idioma (sitio.com/es/, sitio.com/en/), y permitir que cada idioma tenga sus propias taxonomías y configuración. Es una funcionalidad imprescindible si el proyecto PYT-SWE debe servir contenido en español e inglés u otros idiomas. Esta sección analiza el soporte nativo de Hugo y las herramientas comunitarias que lo complementan.

### 10.1 Hugo i18n nativo

- **URL**: https://gohugo.io/content-management/multilingual/
- **Propósito**: Soporte multilingüe integrado en Hugo. No requiere plugins ni herramientas externas.
- **Funcionalidades**:
  - Configuración single-host y multihost
  - Tablas de traducción (`i18n/` directory)
  - URLs localizadas por idioma
  - Soporte RTL (right-to-left) para árabe, hebreo
  - Permalinks por idioma
  - Content merges con `lang.Merge`
  - Placeholders para traducciones faltantes
  - Pluralización CLDR (200+ idiomas)
- **Motor subyacente**: https://github.com/nicksnyder/go-i18n (biblioteca Go de traducciones)
- **Valor para PYT-SWE**: **MUY ALTO**. El sistema de i18n de Hugo es first-class y completo. Una skill de i18n debería conocer y usar estas capacidades nativas.

### 10.2 Hugo i18n JS Module (HugoMods)

- **URL**: https://hugomods.com/docs/i18n-js/
- **Propósito**: Renderizar traducciones en JavaScript para componentes JS.
- **Funcionalidades**:
  - Almacena todas las traducciones en memoria
  - Usa el idioma del tag `<html>`
  - Soporta pluralización (one/other)
  - Sintaxis de placeholders tipo `{name}`
- **Valor para PYT-SWE**: **MEDIO**. Complemento JS para i18n, necesario cuando se usan componentes JavaScript.

---

## 11. Herramientas IA para contenido Hugo

> **¿Qué es y para qué sirve?** Las herramientas de inteligencia artificial para Hugo son skills, agentes y servicios que utilizan modelos de lenguaje (Claude, ChatGPT, Gemini) para generar, optimizar y auditar contenido específicamente formateado para Hugo. Van desde skills para Claude Code que integran 30 sub-skills de escritura y SEO con salida directa en Markdown con front matter de Hugo, hasta optimizadores AEO/GEO que preparan el contenido para que sea correctamente interpretado por asistentes IA (respuestas de ChatGPT, fragmentos de Google AI Overviews, búsqueda en Perplexity). También incluyen generadores de sitio completo por prompt. Esta sección documenta las herramientas existentes más relevantes para el flujo Copista → Hugo del proyecto PYT-SWE.

### Tabla de herramientas IA para contenido Hugo

| # | Herramienta | Propósito | 3 funcionalidades más relevantes | Licencia | Precio |
|---|-------------|-----------|----------------------------------|----------|--------|
| 1 | **Claude Blog** (11.1) | Suite de skills para Claude Code que escribe, optimiza y audita contenido de blogs. 30 sub-skills, 5 agentes IA, 12 plantillas | `/blog write` (escribir artículo), `/blog analyze` (auditoría 0-100), `/blog schema` + `/blog geo` (SEO + GEO + Schema) | MIT | Gratuito |
| 2 | **Akii SEO Optimizer** (11.2) | Plugin para Claude Code que integra SEO, AEO (visibilidad en agentes IA) y GEO (optimización para motores generativos) | Auditoría AEO/GEO completa, estimación visibilidad IA (ChatGPT, Claude, Gemini), 5 agentes especializados (SEO, contenido, competencia, IA, Schema) | NO CONFIRMADA | Gratuito |
| 3 | **AnyPost AI** (11.3) | AI SEO Blog Writer para Hugo. Genera contenido SEO-optimizado con frontmatter y despliegue via Content Adapters | Generación automática de Markdown, frontmatter configurable, Content Adapters para integración directa | SaaS propietario | Freemium |
| 4 | **OctoBoost** (11.4) | Motor automatizado de contenido SEO para SaaS. Keywords, competidores, generación y publicación multi-plataforma | Auto-push .md/.mdx a repositorios Hugo, 2000-2500 palabras por artículo, GEO score para citación IA | SaaS propietario | Pago |
| 5 | **Hugo Chat** (11.5) | AI website builder de HugoBlox que genera sitios Hugo completos desde descripción en lenguaje natural | Genera sitio completo desde un prompt, output en Markdown puro (sin lock-in), editable manualmente después | SaaS propietario | Freemium |
| 6 | **VSCode Ghostwriter** (11.6) | Extensión VS Code para generación de contenido asistida por IA (GitHub Copilot). Conductores de entrevistas y artículos | Page bundle support para Hugo (`slug/index.md`), SEO optimization, multi-lenguaje (20+ idiomas) | MIT | Gratuito |
| 7 | **SEO Blog Writer** (11.7) | Skill para Claude Code que convierte URLs, notas o temas en posts de blog optimizados para SEO | Tono humano anti-detección IA, E-E-A-T signals, FAQ schema + tabla de contenidos | MIT | Gratuito |

### 11.1 Claude Blog (AgriciDaniel/claude-blog)

- **URL**: https://github.com/agricidaniel/claude-blog
- **Estrellas**: 833
- **Propósito**: Suite de skills para Claude Code que escribe, optimiza y audita contenido de blogs. 30 sub-skills, 5 agentes IA, 12 plantillas de contenido.
- **Funcionalidades**:
  - `/blog write` - Escribir artículo desde cero
  - `/blog rewrite` - Optimizar artículo existente
  - `/blog analyze` - Auditoría de calidad con puntuación 0-100
  - `/blog brief` - Generar briefing de contenido
  - `/blog calendar` - Calendario editorial
  - `/blog strategy` - Estrategia de blog y topic ideation
  - `/blog outline` - Outline informado por SERP
  - `/blog seo-check` - Validación SEO post-escritura
  - `/blog schema` - Generar JSON-LD schema markup
  - `/blog geo` - Auditoría de citación IA (GEO)
  - `/blog image` - Generación de imágenes IA (Gemini)
  - Dual-optimized para Google rankings y AI citations
- **Compatibilidad Hugo**: Explícitamente soportado (Next.js MDX, Astro, Hugo, Jekyll, WordPress, Ghost, 11ty, Gatsby y static HTML)
- **Estado**: **Muy activo** (v1.9.0, mayo 2026). 30 sub-skills, 5-gate Delivery Contract.
- **Licencia**: MIT
- **Stack**: Claude Code skill (MD files)
- **Valor para PYT-SWE**: **MUY ALTO**. Es EL modelo a seguir. Es una suite completa de skills para Claude Code que hace exactamente lo que PYT-SWE quiere lograr. Incluye SEO, generación de contenido, auditoría, schema markup y optimización para IA. Directamente adaptable como conjunto de skills OpenCode.

### 11.2 Akii SEO AI Search Optimizer

- **URL**: https://github.com/akii-technologies-ltd/akii-seo-ai-search-optimizer
- **Propósito**: Plugin gratuito para Claude Code que integra SEO, AEO (Agentic Engine Optimization) y GEO (Generative Engine Optimization).
- **Funcionalidades**:
  - Auditoría SEO completa de sitios
  - Estrategia de contenido (content pillars + clusters)
  - Content briefs
  - Keyword clustering por intención
  - Schema markup (JSON-LD) en lote
  - Estimación de visibilidad IA (ChatGPT, Claude, Gemini, Perplexity, Copilot, Google AI Overviews)
  - Generación de `llms.txt`
  - GEO rewrite tactics (basado en estudio Princeton/IIT Delhi)
  - 5 agentes especializados (SEO Auditor, Content Strategist, Competitor Analyzer, AI Visibility Analyzer, Schema Generator)
- **Estado**: Activo (mayo 2026)
- **Licencia**: NO CONFIRMADA
- **Compatibilidad Hugo**: Explícitamente soportado (plataforma-agnóstico)
- **Valor para PYT-SWE**: **MUY ALTO**. Cubre el gap entre SEO tradicional y optimización para motores de IA. Las tácticas GEO del estudio académico son únicas.

### 11.3 AnyPost AI (integración Hugo)

- **URL**: https://anypost.ai/integrations/hugo
- **Propósito**: AI SEO Blog Writer para Hugo. Genera contenido SEO-optimizado con frontmatter adecuado y despliega vía Content Adapters.
- **Funcionalidades**:
  - Generación automática de contenido Markdown
  - Frontmatter configurable
  - Publicación programada
  - Content Adapters para integración directa
- **Estado**: Activo (servicio SaaS)
- **Precio**: SaaS (freemium)
- **Valor para PYT-SWE**: **BAJO-MEDIO**. Es un servicio SaaS, no empaquetable como skill.

### 11.4 OctoBoost

- **URL**: https://octoboost.app/
- **Propósito**: Motor automatizado de contenido SEO para SaaS. Investigación de keywords, análisis de competidores, generación de artículos, publicación multi-plataforma.
- **Funcionalidades**:
  - Auto-push .md/.mdx a repositorios Hugo
  - 2000-2500 palabras por artículo
  - Publicación en 11 plataformas con backlinks canónicos
  - GEO score para citación IA
- **Estado**: Activo (servicio SaaS)
- **Precio**: SaaS
- **Valor para PYT-SWE**: **BAJO**. SaaS comercial, no empaquetable.

### 11.5 Hugo Chat (HugoBlox AI)

- **URL**: https://hugoblox.com/chat
- **Propósito**: AI website builder que genera sitios Hugo completos desde una descripción en lenguaje natural. Output en Markdown puro.
- **Funcionalidades**:
  - Genera sitio completo desde un prompt
  - Output en Markdown (no React, no lock-in)
  - Landing page, blog, portfolio, docs
  - Basado en HugoBlox framework
  - Editable manualmente después
- **Estado**: Activo (2026). SaaS freemium.
- **Valor para PYT-SWE**: **MEDIO**. Interesante como concepto de "generación de sitio completo vía IA", pero es SaaS.

### 11.6 VSCode Ghostwriter

- **URL**: https://github.com/estruyf/vscode-ghostwriter
- **Estrellas**: 2
- **Propósito**: Extensión VS Code para generación de contenido asistida por IA (GitHub Copilot). Conductores de entrevistas y generación de artículos.
- **Funcionalidades**:
  - Page bundle support (`slug/index.md`) para Hugo
  - SEO optimization
  - Multi-lenguaje (20+ idiomas)
  - Writer agents customizables
  - Frontmatter template
- **Estado**: Activo (marzo 2026)
- **Licencia**: MIT
- **Valor para PYT-SWE**: **MEDIO**. Es una extensión VS Code, no una skill empaquetable independiente.

### 11.7 SEO Blog Writer Claude Skill (rediumvex)

- **URL**: https://github.com/rediumvex/seo-blog-writer-claude
- **Propósito**: Skill para Claude Code que convierte URLs, notas o temas en posts de blog optimizados para SEO.
- **Funcionalidades**:
  - Tono humano (anti-detección IA)
  - E-E-A-T signals
  - FAQ schema
  - Tabla de contenidos + sidebar
  - Sugerencias de enlaces internos
  - Output Markdown listo para CMS
- **Estado**: Activo (abril 2026)
- **Estrellas**: ~1
- **Licencia**: MIT
- **Valor para PYT-SWE**: **MEDIO**. Skill simple pero efectiva para generación de contenido.

---

## 12. Tabla comparativa de skills por competencia

| Competencia | Herramienta/Skill | Tipo | Compatible IA | Estado | Valor PYT-SWE |
|-------------|-------------------|------|---------------|--------|---------------|
| **MCP Server** | hugo-mcp (jmrGrav) | MCP Server | ✅ Claude/Cursor | Muy activo | ⭐⭐⭐⭐⭐ |
| **MCP Server** | hugo-memex | MCP Server | ✅ Claude/Cursor | Activo | ⭐⭐⭐⭐⭐ |
| **MCP Server** | hugo-docs-mcp | MCP Server | ✅ Claude/Cursor | Activo | ⭐⭐⭐⭐ |
| **MCP Server** | hugo-frontmatter-mcp | MCP Server | ✅ Claude/Cursor | Activo | ⭐⭐⭐ |
| **MCP Server** | Official Hugo MCP (propuesta) | Propuesta | ✅ | Abierta | ⭐⭐⭐ |
| **Generación Contenido** | Claude Blog | Claude Skill | ✅ Claude Code | Muy activo | ⭐⭐⭐⭐⭐ |
| **SEO + AEO + GEO** | Akii SEO Optimizer | Claude Skill | ✅ Claude Code | Activo | ⭐⭐⭐⭐⭐ |
| **AEO (visibilidad IA)** | agentic-seo | CLI/Herramienta | ✅ Multi-plat | Muy reciente | ⭐⭐⭐⭐⭐ |
| **SEO CLI** | seofor.dev | CLI Go | ✅ (exporta prompts) | Activo | ⭐⭐⭐⭐ |
| **SEO Static Checker** | @capgo/seo-checker | CLI/NPM | ❌ Directa | Activo | ⭐⭐⭐⭐ |
| **SEO Linter** | Hugo SEO Linter | GitHub Action | ❌ Directa | Activo | ⭐⭐⭐⭐ |
| **SEO Plugin** | Victor Hugo | Partial HTML | ❌ Directa | Mantenimiento | ⭐⭐⭐ |
| **Link Checker** | Hugo Broken Link Checker | GitHub Action | ❌ Directa | Activo | ⭐⭐⭐⭐ |
| **Image Optimization** | Hugo Image Opt. Action | GitHub Action | ❌ Directa | Activo | ⭐⭐⭐⭐ |
| **Módulos Funcionales** | HugoMods (ecosistema) | Módulos Hugo | ❌ Directa | Muy activo | ⭐⭐⭐⭐⭐ |
| **Framework Temas** | HugoBlox | Framework | ✅ (Hugo Chat AI) | Muy activo | ⭐⭐⭐⭐ |
| **Tema Documentación** | Docsy (Google) | Tema Hugo | ✅ (llms.txt, MD output) | Muy activo | ⭐⭐⭐⭐ |
| **CMS Git-based** | Decap CMS | CMS | ❌ Directa | Muy activo | ⭐⭐⭐⭐ |
| **CMS + Framework** | Hugolify | Framework | ❌ Directa | Activo | ⭐⭐⭐⭐ |
| **CI/CD Setup** | peaceiris/actions-hugo | GitHub Action | ❌ Directa | Muy activo | ⭐⭐⭐⭐ |
| **CI/CD Pipeline** | hugo-gitops-pipeline | GH Action Workflow | ❌ Directa | Activo | ⭐⭐⭐ |
| **Binary Wrapper** | hugo-extended (npm) | Paquete NPM | ❌ Directa | Muy activo | ⭐⭐⭐⭐ |
| **Búsqueda** | Pagefind | Post-build tool | ❌ Directa | Muy activo | ⭐⭐⭐⭐ |
| **Búsqueda** | Fuse.js / FlexSearch | Librerías JS | ❌ Directa | Activo | ⭐⭐⭐ |
| **Formularios** | Web3Forms / SplitForms | Servicios | ❌ Directa | Activos | ⭐⭐⭐ |
| **Formularios (módulo)** | tnd-forms | Módulo Hugo | ❌ Directa | Activo | ⭐⭐⭐ |
| **i18n** | Hugo i18n nativo | Built-in | ❌ Directa | Estable | ⭐⭐⭐⭐⭐ |
| **Imágenes** | Hugo Images Module | Módulo Hugo | ❌ Directa | Activo | ⭐⭐⭐⭐ |
| **Docker** | hugomods/hugo | Docker Image | ❌ Directa | Muy activo | ⭐⭐⭐ |
| **AI Website Builder** | Hugo Chat (HugoBlox) | SaaS | ✅ IA nativa | Activo | ⭐⭐⭐ |
| **Blog Writer** | SEO Blog Writer Claude Skill | Claude Skill | ✅ Claude Code | Activo | ⭐⭐⭐ |
| **VSCode CMS** | Front Matter CMS | Extensión VS Code | ❌ Directa | Activo | ⭐⭐⭐ |
| **VSCode Writer** | Ghostwriter | Extensión VS Code | ✅ GitHub Copilot | Activo | ⭐⭐⭐ |
| **Blog Writer SaaS** | AnyPost AI | SaaS | ✅ IA nativa | Activo | ⭐⭐ |
| **Content Engine** | OctoBoost | SaaS | ✅ IA nativa | Activo | ⭐⭐ |

---

## 13. Recomendaciones para incorporar a .opencode/skills/

Basado en esta investigación, estas son las recomendaciones priorizadas para crear skills OpenCode para el ecosistema Hugo:

### Prioridad 1 - Inmediata (competencias core que faltan)

| Skill | Descripción | Basado en | Competencias |
|-------|-------------|-----------|-------------|
| **hugo-mcp-adapter** | Adaptador MCP para Hugo que unifique las capacidades de los 4 MCP servers existentes + funciones específicas OpenCode | hugo-mcp, hugo-memex, hugo-docs-mcp | Gestión contenido, consultas SQL, auditoría, frontmatter |
| **hugo-seo-auditor** | Skill de auditoría SEO + AEO + GEO para sitios Hugo | agentic-seo, Hugo SEO Linter, seofor.dev, @capgo/seo-checker | SEO técnico, visibilidad IA, meta tags, links |
| **hugo-content-writer** | Skill de generación de contenido optimizado para Hugo | Claude Blog, Akii SEO Optimizer, SEO Blog Writer | Escritura SEO, frontmatter, schema, GEO |
| **hugo-search-indexer** | Skill para configurar e indexar búsqueda en sitios Hugo | Pagefind, Hugo Search Module, Fuse.js | Búsqueda cliente-side, indexing post-build |

### Prioridad 2 - Alta (competencias deseables)

| Skill | Descripción | Basado en | Competencias |
|-------|-------------|-----------|-------------|
| **hugo-i18n-manager** | Gestión de traducciones y multilingüismo | Hugo i18n nativo, go-i18n, HugoMods i18n-js | i18n, traducciones, URLs multi-idioma |
| **hugo-image-processor** | Procesamiento y optimización de imágenes | Hugo Pipes, Hugo Images Module, Hugo Image Opt. Action | WebP, responsive, lazy loading, CLS |
| **hugo-deploy-pipeline** | Pipeline CI/CD completo para Hugo | peaceiris/actions-hugo, hugo-gitops-pipeline | Build, deploy, testing, GitOps |
| **hugo-cms-connector** | Conexión con CMS headless para Hugo | Decap CMS Module, Hugolify | CMS Git-based, configuración, widgets |

### Prioridad 3 - Media (competencias complementarias)

| Skill | Descripción | Basado en | Competencias |
|-------|-------------|-----------|-------------|
| **hugo-form-handler** | Gestión de formularios en sitios estáticos Hugo | Web3Forms, SplitForms, FabForm, tnd-forms | Formularios, spam, webhooks |
| **hugo-frontmatter-ops** | Operaciones avanzadas de frontmatter | hugo-frontmatter-mcp | Batch updates, validación, tags |
| **hugo-theme-scaffolder** | Scaffolding de proyectos Hugo con temas populares | Blowfish CLI, HugoBlox starters | Inicio rápido, configuración de temas |

### Principios de diseño para los skills

1. **Cada skill debe ser un MCP server o un conjunto de herramientas invocables por un agente IA**, siguiendo el modelo de Claude Blog y hugo-mcp.
2. **Las skills deben componerse**: una skill de alto nivel (e.g., `hugo-content-writer`) puede llamar a skills más específicas (e.g., `hugo-seo-auditor`, `hugo-frontmatter-ops`).
3. **Deben documentar dependencias claras**: ¿Requiere Hugo instalado? ¿Node.js? ¿Python?
4. **Deben incluir ejemplos de uso** en el formato `SKILL.md` de OpenCode.
5. **Deben ser verificables**: incluir tests o al menos ejemplos de output esperado.
6. **Compatibilidad hacia atrás**: deben funcionar con Hugo v0.120+ (la mayoría de sitios en producción usan v0.130+ en 2026).

---

*Documento generado el 2026-06-15. Fuentes verificadas mediante consulta directa a URLs, repositorios GitHub, documentación oficial y búsqueda web. Las herramientas marcadas como "NO CONFIRMADO" requieren verificación adicional.*
