# Estructura de un proyecto Hugo

**Fuente**: `.opencode/external-context/hugo/`
**Contexto**: Proyecto PYT-SWE (OAC+Hugo)
**Fecha**: 2026-06-16

---

## Índice

1. [Estructura de directorios de un proyecto Hugo](#1-estructura-de-directorios-de-un-proyecto-hugo)
2. [¿Qué es Front Matter?](#2-qué-es-front-matter)
3. [Diferencia entre Archetypes y Layouts](#3-diferencia-entre-archetypes-y-layouts)
4. [Analogía con PHP (settings.php)](#4-analogía-con-php)
5. [El flujo completo: quién escribe y quién renderiza](#5-el-flujo-completo)
6. [Resumen visual del flujo](#6-resumen-visual-del-flujo)
7. [Los 6 formatos de contenido](#7-los-6-formatos-de-contenido)
8. [Configuración base: hugo.toml](#8-configuración-base-hugotoml)

---

## 1. Estructura de directorios de un proyecto Hugo

### Estructura generada por `hugo new site`

```
mi-proyecto/
├── archetypes/       → Plantillas para nuevo contenido (hugo new)
├── assets/           → Archivos procesables (Sass, JS, imágenes)
├── content/          → Contenido del sitio en Markdown
├── data/             → Datos estructurados (JSON/YAML/TOML)
├── i18n/             → Traducciones para internacionalización
├── layouts/          → Plantillas HTML (Go templates)
├── static/           → Archivos estáticos (copiados tal cual)
├── themes/           → Temas instalados
└── hugo.toml         → Configuración del proyecto
```

### Tras ejecutar `hugo` (build)

```
mi-proyecto/
├── ... (los mismos anteriores)
├── public/           → HTML generado (lo que se despliega)
└── resources/        → Caché de assets optimizados
```

### Descripción de cada directorio

| Directorio | Propósito |
|---|---|
| `archetypes/` | Plantillas para crear nuevo contenido. Definen la estructura inicial (front matter) de los archivos `.md` |
| `assets/` | Archivos que Hugo procesa: Sass a CSS, TypeScript a JS, optimización de imágenes mediante Hugo Pipes |
| `content/` | Todo el contenido del sitio en Markdown. La jerarquía de carpetas define la estructura URL del sitio |
| `data/` | Datos estructurados (JSON, YAML, TOML) accesibles desde las plantillas |
| `i18n/` | Traducciones para internacionalización (strings de interfaz por idioma) |
| `layouts/` | Plantillas HTML que convierten el Markdown en páginas web |
| `static/` | Archivos que se copian directamente sin procesamiento: imágenes, favicon, robots.txt, PDFs |
| `themes/` | Temas instalados (submódulos git o descargados) |
| `public/` | **Generado**. HTML final compilado. Esto es lo que se despliega a producción |
| `resources/` | **Generado**. Caché de assets optimizados |

### Directorios clave para PYT-SWE

- **`content/`** — donde el Copista de OAC colocará los Markdown generados
- **`archetypes/`** — para estandarizar el front matter de cada tipo de página
- **`layouts/`** — para las plantillas con Open Graph, Twitter Cards y Schema

---

## 2. ¿Qué es Front Matter?

**Front matter** son metadatos al inicio de un archivo Markdown, delimitados por `---`. Definen propiedades de la página como título, fecha, etiquetas, descripción, etc.

Hugo soporta tres formatos: YAML, TOML y JSON.

### Ejemplo en TOML

```toml
+++
title = "Mi artículo"
date = 2026-06-16
draft = true
tags = ["hugo", "tutorial"]
+++
```

### Ejemplo en YAML (el más común)

```yaml
---
title: "Mi artículo"
date: 2026-06-16
draft: true
tags: ["hugo", "tutorial"]
description: "Un artículo de ejemplo"
---
```

### Campos típicos de front matter

| Campo | Descripción |
|---|---|
| `title` | Título de la página |
| `date` | Fecha de publicación |
| `draft` | Si es `true`, no se publica en build normal |
| `description` | Meta descripción para SEO |
| `tags` | Array de etiquetas |
| `categories` | Array de categorías |
| `weight` | Peso para ordenamiento (menor = primero) |
| `aliases` | URLs alternativas (redirecciones) |
| `images` | Imagen para Open Graph / Twitter Cards |
| `layout` | Plantilla personalizada a usar |

### Función del front matter

El front matter es la **fuente de datos** que Hugo usa para generar el HTML. Los layouts leerán estos campos para insertarlos en las etiquetas HTML correspondientes.

---

## 3. Diferencia entre Archetypes y Layouts

| Aspecto | Archetype | Layout |
|---|---|---|
| **Directorio** | `archetypes/` | `layouts/` |
| **Cuándo se usa** | Al crear contenido (`hugo new`) | Al compilar el sitio (`hugo`) |
| **Qué produce** | Archivo `.md` con front matter predefinido | Archivo `.html` renderizado |
| **Propósito** | Estructurar la **escritura** del contenido | Estructurar la **visualización** del contenido |
| **Quién lo usa** | El usuario / Copista al crear contenido | El navegador del visitante |

### Archetype: plantilla de creación

Un archetype define qué estructura tendrá el archivo Markdown cuando se crea.

**Ejemplo `archetypes/posts.md`:**

```yaml
---
title: "{{ replace .File.ContentBaseName `-` ` ` | title }}"
date: {{ .Date }}
draft: true
tags: []
description: ""
---
```

Al ejecutar `hugo new content posts/mi-articulo.md`, Hugo genera:

```yaml
---
title: "Mi Articulo"
date: 2026-06-16
draft: true
tags: []
description: ""
---
```

### Layout: plantilla de renderizado

Un layout define cómo se convierte el contenido Markdown a HTML para el visitante.

**Ejemplo `layouts/_default/single.html`:**

```go-html-template
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ with .Date }}
    <time datetime="{{ . }}">{{ .Format "January 2, 2006" }}</time>
  {{ end }}
  {{ with .Params.tags }}
    <ul>
      {{ range . }}
        <li>{{ . }}</li>
      {{ end }}
    </ul>
  {{ end }}
  <div class="content">
    {{ .Content }}
  </div>
{{ end }}
```

---

## 4. Analogía con PHP

Para entender mejor la relación entre estos componentes, podemos usar una analogía con PHP.

### La comparación del usuario

> "¿Podríamos suponer que archetypes-front matter es como un archivo de configuración en PHP (`settings.php`) que define variables, y los layouts son rutinas que se alimentan con esas variables y al ejecutarse generan el contenido en `content/`?"

**La parte correcta:** Sí, el front matter equivale a las variables de configuración de un `settings.php`. Define título, fecha, descripción, etc.

**La parte a corregir:** Los **layouts** no generan contenido en `content/`. Generan el **HTML final en `public/`**.

### Tabla de correspondencia

| Hugo | PHP | Propósito |
|---|---|---|
| Archetype | Plantilla de formulario | Define la estructura de campos a crear |
| Front matter (en `.md`) | `settings.php` / `$config` | Contiene los datos y variables |
| Layout (`single.html`) | `template.php` con `echo $title` | Renderiza los datos a HTML |
| `public/` | `html/` (salida) | Resultado final compilado y desplegable |

---

## 5. El flujo completo

### Paso a paso

1. **Archetype prepara el esqueleto**
   - Ejecutas `hugo new content posts/mi-articulo.md`
   - Hugo busca en `archetypes/` una plantilla para "posts"
   - Si existe, genera el `.md` con front matter predefinido

2. **El usuario rellena el contenido**
   - Abre `content/posts/mi-articulo.md`
   - **Ajusta el front matter**: añade `tags`, `description`, cambia `title`
   - **Escribe el cuerpo**: el texto, imágenes, enlaces debajo del `---`

3. **Los layouts renderizan a HTML**
   - Ejecutas `hugo` (o `hugo server`)
   - Hugo lee el `.md`, extrae front matter y cuerpo
   - Aplica los layouts de `layouts/` para generar HTML
   - El HTML resultante se escribe en `public/`

### Pregunta clave resuelta

> "Entiendo que archetypes + front matter generan Markdown en `content/`, pero esos Markdown están vacíos de contenido. El usuario es el que debe añadirle el contenido y esas variables predefinidas que luego serán usadas por los layouts, ¿correcto?"

**Respuesta: correcto.** El Markdown generado por `hugo new` contiene solo el front matter (metadatos) y opcionalmente un cuerpo de ejemplo. El usuario debe:

1. **Rellenar el cuerpo** del Markdown (texto, imágenes, etc.)
2. **Ajustar el front matter** (cambiar `tags`, `description`, `draft` a `false`, etc.)

Luego los layouts toman esos datos para generar el HTML final.

### Ejemplo completo

**Archetype** (`archetypes/posts.md`):

```yaml
---
title: "{{ replace .File.ContentBaseName "-" " " | title }}"
date: {{ .Date }}
draft: true
tags: []
description: ""
---
```

**Genera** (`hugo new posts/hugo-tutorial.md`):

```yaml
---
title: "Hugo Tutorial"
date: 2026-06-16
draft: true
tags: []
description: ""
---
```

**El usuario edita** y lo deja así:

```yaml
---
title: "Hugo Tutorial para principiantes"
date: 2026-06-16
draft: false
tags: ["hugo", "tutorial", "estático"]
description: "Aprende los fundamentos de Hugo paso a paso"
---
```

Aquí empieza el contenido del artículo...

## ¿Qué es Hugo?

Hugo es un generador de sitios estáticos...

```

**El layout** (`layouts/_default/single.html`) lo convierte a HTML:

```html
<!DOCTYPE html>
<html>
<head>
  <title>Hugo Tutorial para principiantes | Mi Sitio</title>
  <meta name="description" content="Aprende los fundamentos de Hugo paso a paso">
</head>
<body>
  <h1>Hugo Tutorial para principiantes</h1>
  <time>2026-06-16</time>
  <div class="content">
    <h2>¿Qué es Hugo?</h2>
    <p>Hugo es un generador de sitios estáticos...</p>
  </div>
</body>
</html>
```

---

## 6. Resumen visual del flujo

```
Archetype (archetypes/posts.md)
     │
     │  hugo new content posts/mi-articulo.md
     ▼
Archivo .md (content/posts/mi-articulo.md)
┌─────────────────────────────────┐
│ ---                            │
│ title: "..."                   │  ← Front matter (metadatos)
│ date: 2026-06-16               │      Lo escribe el archetype
│ draft: true                    │      Lo completa el usuario
│ tags: []                       │
│ description: ""                │
│ ---                            │
│                                │
│ Aquí el usuario escribe        │  ← Cuerpo (contenido real)
│ el contenido del artículo...   │      Lo escribe el usuario
└─────────────────────────────────┘
     │
     │  hugo (build)
     │
     ▼
Layout (layouts/_default/single.html)
     │
     │  Renderiza: {{ .Title }}, {{ .Content }}, etc.
     ▼
HTML final (public/posts/mi-articulo/index.html)
     │
     │  wrangler pages deploy public/
     ▼
Cloudflare Pages → Visitante
```

---

## 7. Los 6 formatos de contenido

Hugo puede leer contenido en 6 formatos diferentes, no solo Markdown.

| Formato | Extensión | Propósito |
|---|---|---|
| **Markdown** | `.md` | Formato por defecto. Ligero, legible. Renderizador Goldmark (CommonMark + GFM). El Copista de OAC lo genera de forma natural. |
| **HTML** | `.html` | Control total del marcado. Hugo no lo procesa, lo usa tal cual. Útil para landing pages específicas. |
| **AsciiDoc** | `.adoc` | Documentación técnica avanzada. Tablas complejas, referencias cruzadas, includes. Requiere instalar AsciiDoc. |
| **Org** (Emacs Org Mode) | `.org` | Formato del editor Emacs. Para flujos que ya usan Org Mode. |
| **Pandoc** | `.pandoc` | Marca de la herramienta Pandoc. Para migraciones o flujos existentes con Pandoc. |
| **reStructuredText (RST)** | `.rst` | Formato de documentación Python (Sphinx). Para migraciones desde proyectos Python. |

### ¿Por qué tantos formatos?

Porque Hugo está diseñado para adaptarse a flujos de trabajo existentes. Si ya tienes documentación en AsciiDoc o RST, no necesitas convertirla: Hugo la entiende directamente.

### Limitación importante

Los **render hooks** (personalización de cómo se renderizan imágenes, enlaces, cabeceras) **solo funcionan con Markdown**. Si usas AsciiDoc, Org o RST, pierdes esa capacidad.

### Para el proyecto PYT-SWE

Usaremos exclusivamente **Markdown (.md)** porque:
- El Copista de OAC genera Markdown de forma natural
- Los render hooks permiten personalizar imágenes, enlaces y cabeceras
- Goldmark es rápido y compatible con CommonMark y GitHub Flavored Markdown
- No requiere instalar software adicional

---

## 8. Configuración base: `hugo.toml`

### Configuración mínima (3 líneas)

```toml
baseURL = 'https://ejemplo.org/'
locale = 'es-es'
title = 'Mi Sitio Web'
```

- **`baseURL`** — URL raíz del sitio publicado. Incluye protocolo y termina con `/`.
- **`locale`** — idioma/región (`es-es`, `en-us`, etc.). Hugo lo usa para el atributo `lang` del HTML y formato de fechas.
- **`title`** — nombre del sitio. Se usa en `<title>`, RSS, Open Graph, etc.

### Añadiendo tema

```toml
theme = ['mi-tema']
```

### Parámetros personalizados (`[params]`)

Variables globales accesibles desde cualquier plantilla con `{{ site.Params.miVariable }}`:

```toml
[params]
  subtitle = 'El mejor generador de sitios estáticos'
  description = 'Descripción global del sitio para SEO'
  author = 'Tu Nombre'
  [params.social]
    twitter = '@tucuenta'
    facebook_admin = 'tu-perfil'
```

### Menús

```toml
[[menus.main]]
name = 'Inicio'
pageRef = '/'
weight = 10

[[menus.main]]
name = 'Blog'
pageRef = '/posts'
weight = 20
```

Cada entrada tiene `name` (texto visible), `pageRef` (página del sitio) y `weight` (orden). En las plantillas se recorren con `{{ range site.Menus.main }}`.

### Directorio `config/` (alternativa avanzada)

Para entornos múltiples:

```
config/
├── _default/
│   └── hugo.toml        ← base
├── production/
│   └── hugo.toml        ← solo producción
└── staging/
    └── hugo.toml        ← solo staging
```
