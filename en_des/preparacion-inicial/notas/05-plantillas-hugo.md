# Plantillas en Hugo: Jerarquía y funcionamiento

**Fuente**: `.opencode/external-context/hugo/templates.md`
**Contexto**: Proyecto PYT-SWE (OAC+Hugo)
**Fecha**: 2026-06-16

---

## Índice

1. [Estructura mínima de layouts/](#1-estructura-mínima-de-layouts)
2. [Cómo se relacionan: block y define](#2-cómo-se-relacionan-block-y-define)
3. [Cada plantilla para un tipo de página](#3-cada-plantilla-para-un-tipo-de-página)
4. [Los partials: fragmentos reutilizables](#4-los-partials-fragmentos-reutilizables)
5. [Orden de búsqueda (template lookup order)](#5-orden-de-búsqueda-template-lookup-order)
6. [Resumen visual](#6-resumen-visual)
7. [Buenas prácticas](#7-buenas-prácticas)

---

## 1. Estructura mínima de layouts/

```
layouts/
├── _default/
│   ├── baseof.html       ← Esqueleto HTML común (doctype, head, body)
│   ├── home.html         ← Portada del sitio (/)
│   ├── single.html       ← Páginas individuales (posts, about, etc.)
│   └── list.html         ← Páginas de listado (blog, categorías, tags)
└── partials/
    ├── head.html         ← Etiquetas <meta>, CSS, título
    ├── header.html       ← Barra de navegación / menú
    └── footer.html       ← Pie de página
```

---

## 2. Cómo se relacionan: block y define

Hay dos conceptos clave que trabajan juntos.

### baseof.html: la plantilla base

Define la estructura HTML común con un hueco llamado `block "main"`:

```go-html-template
<!DOCTYPE html>
<html lang="{{ site.Language.Locale }}">
<head>
  {{ partial "head.html" . }}
</head>
<body>
  <header>
    {{ partial "header.html" . }}
  </header>
  <main>
    {{ block "main" . }}{{ end }}  ← aquí se inserta el contenido de cada página
  </main>
  <footer>
    {{ partial "footer.html" . }}
  </footer>
</body>
</html>
```

### Las demás plantillas llenan ese hueco

Usan `define "main"` para proporcionar el contenido específico:

```go-html-template
{{/* single.html - versión mínima */}}
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  <div class="content">{{ .Content }}</div>
{{ end }}
```

### El proceso cuando Hugo renderiza una página

1. Hugo detecta qué tipo de página es (home, single, list)
2. Coge la plantilla específica (ej: `single.html`)
3. Ve que tiene `define "main"` y lo guarda
4. Usa `baseof.html` como envoltorio completo
5. Donde está `block "main"`, inserta lo que definió `single.html`

El resultado es un HTML completo sin haber repetido ni una línea de la estructura común.

---

## 3. Cada plantilla para un tipo de página

### home.html — la portada (`/`)

```go-html-template
{{ define "main" }}
  {{ .Content }}
  <h2>Últimos artículos</h2>
  <ul>
    {{ range site.RegularPages }}
      <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
    {{ end }}
  </ul>
{{ end }}
```

Muestra el contenido de `content/_index.md` y un listado de todas las páginas del sitio.

### single.html — una página concreta

Para artículos, página "sobre nosotros", contacto, etc.

```go-html-template
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ with .Date }}
    <time datetime="{{ . }}">{{ .Format "2 January 2006" }}</time>
  {{ end }}
  <div class="content">
    {{ .Content }}
  </div>
{{ end }}
```

### list.html — un listado de páginas

Para la página del blog, una categoría, una sección.

```go-html-template
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
  <ul>
    {{ range .Pages }}
      <li>
        <a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
        <time>{{ .Date.Format "2 Jan 2006" }}</time>
      </li>
    {{ end }}
  </ul>
{{ end }}
```

---

## 4. Los partials: fragmentos reutilizables

Archivos dentro de `layouts/partials/` que se insertan con `{{ partial "nombre.html" . }}`.

### partials/head.html

```go-html-template
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{{ if .IsHome }}{{ site.Title }}{{ else }}{{ .Title }} | {{ site.Title }}{{ end }}</title>
{{ with .Description }}
  <meta name="description" content="{{ . }}">
{{ end }}
{{ $css := resources.Get "css/main.css" | resources.Minify }}
<link rel="stylesheet" href="{{ $css.RelPermalink }}">
```

### partials/header.html

```go-html-template
<nav>
  <a href="{{ "" | relLangURL }}">{{ site.Title }}</a>
  {{ range site.Menus.main }}
    <a href="{{ .URL }}">{{ .Name }}</a>
  {{ end }}
</nav>
```

### partials/footer.html

```go-html-template
<footer>
  <p>&copy; {{ now.Year }} {{ site.Title }}. Todos los derechos reservados.</p>
</footer>
```

---

## 5. Orden de búsqueda (template lookup order)

Hugo busca la plantilla más específica posible antes de caer en la genérica.

### Prioridad (de más específico a más genérico)

1. **Layout personalizado** definido en front matter (`layout: "personalizado"`)
2. **Tipo de página** (`home`, `section`, `single`, `taxonomy`, `term`)
3. **Plantilla estándar** (`list` o `single`)
4. **Formato de salida** (`rss`, `json`, `html`)
5. **Plantilla comodín** (`all`)
6. **Idioma** (`en`, `es`)
7. **Tipo de medio** (`html`, `xml`)
8. **Ruta de la página** (`posts/single.html`)
9. **Tipo de contenido** (`posts/list.html`)

### Ejemplo de plantillas específicas por sección

Puedes crear subdirectorios en `layouts/` para secciones concretas:

```
layouts/
├── _default/
│   ├── baseof.html
│   ├── home.html
│   ├── single.html
│   └── list.html
└── posts/
    ├── list.html      ← solo para el listado de posts
    └── single.html    ← solo para artículos individuales de posts
```

Así, `about.md` usará `_default/single.html` pero `posts/mi-articulo.md` usará `posts/single.html`.

### Nomenclatura de archivos

| Archivo | Propósito |
|---|---|
| `home.html` | Página de inicio |
| `single.html` | Cualquier página individual |
| `list.html` | Cualquier página de listado |
| `all.html` | Fallback para cualquier página |
| `baseof.html` | Plantilla base compartida |
| `baseof.list.html` | Base específica para listados |
| `baseof.single.html` | Base específica para singles |

---

## 6. Resumen visual

```
Página solicitada          Plantilla que usa       Contenido que carga
─────────────────          ───────────────────     ─────────────────────
/                          home.html               content/_index.md
/about                     single.html             content/about.md
/posts/                    list.html               content/posts/_index.md
/posts/mi-articulo         single.html             content/posts/mi-articulo.md

Todas ellas envueltas en baseof.html (estructura común)
```

---

## 7. Buenas prácticas

1. **Usar siempre `baseof.html`** — evita repetir la estructura HTML en cada plantilla
2. **Usar partials** para elementos reutilizables (head, header, footer)
3. **Usar `define "main"`** en lugar de extender layouts manualmente
4. **Aprovechar el lookup order**: colocar plantillas específicas en subdirectorios (`posts/single.html`)
5. **Usar `site.Title`** en lugar de `.Site.Title` (funciona en cualquier contexto)
6. **Usar `.RelPermalink`** para enlaces relativos (portabilidad entre entornos)
7. **Para incluir drafts en desarrollo**: `hugo -D` o `hugo server -D`
