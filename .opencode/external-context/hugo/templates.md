---
source: Context7 API
library: Hugo
package: hugo
topic: Templates
fetched: 2026-06-16T00:00:00Z
official_docs: https://gohugo.io/templates/types/
---

# Plantillas Mínimas en Hugo

## Jerarquía de Plantillas

| Tipo de Plantilla | Propósito | Archivo |
|------------------|-----------|---------|
| **Base** | Estructura HTML común (doctype, head, header, footer) | `_default/baseof.html` |
| **Home** | Página de inicio (`/`) | `_default/home.html` o `index.html` |
| **Single** | Página individual (post, about, etc.) | `_default/single.html` |
| **List** | Página de listado (sección, taxonomía) | `_default/list.html` |
| **All** | Fallback para cualquier tipo | `_default/all.html` |
| **Partials** | Fragmentos reutilizables | `partials/head.html`, etc. |

## 1. Plantilla Base: `layouts/_default/baseof.html`

Define la estructura HTML común del sitio. Otras plantillas "llenan" los bloques definidos aquí.

```go-html-template
<!DOCTYPE html>
<html lang="{{ site.Language.Locale }}" dir="{{ or site.Language.Direction `ltr` }}">
<head>
  {{ partial "head.html" . }}
</head>
<body>
  <header>
    {{ partial "header.html" . }}
  </header>
  <main>
    {{ block "main" . }}
      <!-- Este contenido se reemplaza por el "define" en otras plantillas -->
      Default main content.
    {{ end }}
  </main>
  <footer>
    {{ partial "footer.html" . }}
  </footer>
</body>
</html>
```

### Versión Simplificada (mínima)

```html
{{ partial "head.html" . }}

{{ partial "header.html" . }}

{{ block "main" . }}{{ end }}

{{ partial "footer.html" . }}
```

## 2. Partials (Fragmentos Reutilizables)

Se almacenan en `layouts/partials/` y se invocan con `{{ partial "nombre.html" . }}`.

### `layouts/partials/head.html`

```go-html-template
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{{ if .IsHome }}{{ site.Title }}{{ else }}{{ printf "%s | %s" .Title site.Title }}{{ end }}</title>
{{ with .Description }}
  <meta name="description" content="{{ . }}">
{{ end }}
{{ with site.Params.author }}
  <meta name="author" content="{{ . }}">
{{ end }}
{{ $css := resources.Get "css/main.css" | resources.Minify }}
<link rel="stylesheet" href="{{ $css.RelPermalink }}">
<link rel="icon" href="{{ "favicon.ico" | relURL }}">
```

### `layouts/partials/header.html`

```go-html-template
<nav>
  <a href="{{ "" | relLangURL }}">{{ site.Title }}</a>
  {{ range site.Menus.main }}
    <a href="{{ .URL }}">{{ .Name }}</a>
  {{ end }}
</nav>
```

### `layouts/partials/footer.html`

```go-html-template
<footer>
  <p>&copy; {{ now.Year }} {{ site.Title }}. All rights reserved.</p>
</footer>
```

## 3. Home Page: `layouts/_default/home.html` o `layouts/index.html`

Define el bloque `main` para la página de inicio. Usa la plantilla base (`baseof.html`).

```go-html-template
{{ define "main" }}
  {{ .Content }}
  <h2>Recent Posts</h2>
  <ul>
    {{ range .Site.RegularPages }}
      <li>
        <a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
        <time datetime="{{ .Date }}">{{ .Date.Format "Jan 2, 2006" }}</time>
      </li>
    {{ end }}
  </ul>
{{ end }}
```

### Versión con Filtro por Sección

```go-html-template
{{ define "main" }}
  {{ .Content }}
  <ul>
    {{ range where site.RegularPages "Section" "films" }}
      <li>{{ .Render "view_card" }}</li>
    {{ end }}
  </ul>
{{ end }}
```

## 4. Single Page: `layouts/_default/single.html`

Para páginas individuales (posts, about, contacto, etc.).

```go-html-template
{{ define "main" }}
  <article>
    <h1>{{ .Title }}</h1>
    {{ with .Date }}
      <time datetime="{{ . }}">{{ .Format "January 2, 2006" }}</time>
    {{ end }}
    {{ with .Params.tags }}
      <ul class="tags">
        {{ range . }}
          <li><a href="{{ "tags/" | relLangURL }}{{ . | urlize }}">{{ . }}</a></li>
        {{ end }}
      </ul>
    {{ end }}
    <div class="content">
      {{ .Content }}
    </div>
  </article>
{{ end }}
```

### Versión Mínima

```go-html-template
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
{{ end }}
```

## 5. List Page: `layouts/_default/list.html`

Para secciones, taxonomías y términos. Muestra un listado de páginas hijas.

```go-html-template
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
  <ul class="page-list">
    {{ range .Pages }}
      <li>
        <a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
        {{ with .Date }}
          <time datetime="{{ . }}">{{ .Format "Jan 2, 2006" }}</time>
        {{ end }}
      </li>
    {{ end }}
  </ul>
{{ end }}
```

### Section Template (similar, con énfasis en el título de sección)

```go-html-template
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
  {{ range .Pages }}
    <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
  {{ end }}
{{ end }}
```

## 6. All Template (Fallback): `layouts/_default/all.html`

Template comodín que maneja cualquier tipo de página. Útil para sitios muy simples.

```go-html-template
{{ define "main" }}
  {{ if eq .Kind "home" }}
    {{ .Content }}
    {{ range .Site.RegularPages }}
      <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
    {{ end }}
  {{ else if eq .Kind "page" }}
    <h1>{{ .Title }}</h1>
    {{ .Content }}
  {{ else if in (slice "section" "taxonomy" "term") .Kind }}
    <h1>{{ .Title }}</h1>
    {{ .Content }}
    {{ range .Pages }}
      <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
    {{ end }}
  {{ else }}
    {{ errorf "Unsupported page kind: %s" .Kind }}
  {{ end }}
{{ end }}
```

## 7. Template Lookup Order (Orden de Búsqueda)

Hugo busca plantillas en el siguiente orden (de más específico a más genérico):

1. **Custom layout** (definido en front matter: `layout: "custom"`)
2. **Page kind** (`home`, `section`, `single`, `taxonomy`, `term`)
3. **Standard layout 1** (`list` o `single`)
4. **Output format** (`rss`, `json`, `html`)
5. **Standard layout 2** (`all`)
6. **Language** (ej: `en`, `es`)
7. **Media type** (ej: `html`, `xml`)
8. **Page path** (ej: `posts/single.html`)
9. **Type** (ej: `posts/list.html`)

### Ejemplos de Nomenclatura de Plantillas

| Archivo | Propósito |
|---------|-----------|
| `index.html` | Home page |
| `home.html` | Home page (más específico que `index.html`) |
| `single.html` | Cualquier página individual |
| `list.html` | Cualquier página de listado |
| `posts/single.html` | Página individual dentro de la sección posts |
| `posts/list.html` | Listado de la sección posts |
| `all.html` | Fallback para cualquier página |
| `baseof.html` | Plantilla base compartida |
| `baseof.list.html` | Base template específica para listados |
| `baseof.single.html` | Base template específica para singles |

## Estructura Mínima Recomendada de `layouts/`

```
layouts/
├── _default/
│   ├── baseof.html         # Base template (obligatorio)
│   ├── home.html           # Home page
│   ├── single.html         # Páginas individuales
│   └── list.html           # Páginas de listado
├── partials/
│   ├── head.html           # <head> HTML
│   ├── header.html         # Header/nav
│   └── footer.html         # Footer
└── index.html              # Alternativa para home page
```

## Front Matter (Metadatos de Contenido)

Ejemplos de front matter que las plantillas pueden usar:

### TOML

```toml
title = 'Example'
date = 2024-02-02T04:14:54-08:00
draft = false
weight = 10
[params]
author = 'John Smith'
```

### YAML

```yaml
title: Example
categories:
  - vegetarian
  - gluten-free
tags:
  - appetizer
  - main course
```

### Aliases (URLs alternativas)

```yaml
title = 'Example 1'
date = 2025-02-02
alias = ['/old-url', 'old-name', '../old/path']
```

### Campos comunes de front matter

| Campo | Descripción |
|-------|-------------|
| `title` | Título de la página |
| `date` | Fecha de publicación |
| `draft` | Si es `true`, no se publica en build normal |
| `publishDate` | Fecha a partir de la cual publicar |
| `expiryDate` | Fecha a partir de la cual expirar |
| `weight` | Peso para ordenamiento (menor = primero) |
| `tags` | Array de tags |
| `categories` | Array de categorías |
| `aliases` | URLs alternativas (redirecciones) |
| `layout` | Plantilla personalizada a usar |
| `params` | Parámetros personalizados |

## Buenas Prácticas

1. **Siempre usar `baseof.html`** para evitar repetir la estructura HTML
2. **Usar partials** para elementos reutilizables (head, header, footer)
3. **Aprovechar el lookup order**: colocar plantillas específicas en subdirectorios (ej: `posts/single.html`)
4. **Usar `{{ define "main" }}`** en lugar de extender layouts manualmente
5. **Acceder al sitio con `site.Title`** en lugar de `.Site.Title` (es más corto y funciona en cualquier contexto)
6. **Usar `.RelPermalink`** para enlaces relativos (portabilidad entre entornos)
7. **Para páginas draft**, usar `hugo -D` para incluirlas en el build de desarrollo
