# Conceptos de Hugo (Parte 2): Taxonomías, Paginación, Resúmenes, Cascade y Menús

**Fuente**: `.opencode/external-context/hugo/`
**Contexto**: Proyecto PYT-SWE (OAC+Hugo)
**Fecha**: 2026-06-16

---

## Índice

1. [Taxonomías](#1-taxonomías)
2. [Paginación](#2-paginación)
3. [Resúmenes (Summaries)](#3-resúmenes-summaries)
4. [Cascade](#4-cascade)
5. [Menús desde front matter](#5-menús-desde-front-matter)

---

## 1. Taxonomías

### ¿Qué son?

Las taxonomías son sistemas de clasificación del contenido. Las más conocidas son **tags** y **categories**, pero Hugo permite crear taxonomías personalizadas (autores, series, temáticas, etc.).

### Taxonomías por defecto

Hugo incluye dos taxonomías de serie: `tags` y `categories`. Solo con añadirlas al front matter de un archivo, Hugo genera páginas de listado automáticas.

```yaml
---
title: "Mi artículo"
tags: ["hugo", "tutorial", "estático"]
categories: ["desarrollo", "web"]
---
```

Esto crea automáticamente las rutas:
- `/tags/hugo/` → listado de artículos con tag "hugo"
- `/categories/desarrollo/` → listado de artículos en categoría "desarrollo"

### Taxonomías personalizadas

Para crear una taxonomía propia (ej: "autores"), se define en `hugo.toml`:

```toml
[taxonomies]
tag = 'tags'
category = 'categories'
author = 'autores'
```

Luego en el front matter de cada artículo:

```yaml
---
title: "Mi artículo"
author: ["Juan Pérez", "María García"]
---
```

Y Hugo genera automáticamente `/autores/juan-perez/` con los artículos de ese autor.

### Visualización en plantillas

En `list.html` Hugo renderiza las taxonomías automáticamente (usa la misma plantilla `list.html` para secciones y taxonomías). Si quieres una plantilla específica para taxonomías:

```
layouts/
├── _default/
│   └── list.html              ← para secciones
└── taxonomy/
    └── list.html              ← solo para páginas de taxonomía
```

Para listar las tags de un artículo en `single.html`:

```go-html-template
{{ with .Params.tags }}
  <ul class="tags">
    {{ range . }}
      <li><a href="{{ "tags/" | relLangURL }}{{ . | urlize }}">{{ . }}</a></li>
    {{ end }}
  </ul>
{{ end }}
```

---

## 2. Paginación

### ¿Qué es?

Dividir listados largos en páginas. Si tienes 50 artículos en el blog, en lugar de mostrar 50 de golpe, la paginación muestra 10 por página con navegación (anterior/siguiente/números).

### Configuración

En `hugo.toml` se define el número de elementos por página:

```toml
paginate = 10
```

Por defecto son 10.

### Uso en `list.html`

```go-html-template
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}

  {{ $paginator := .Paginate .Pages }}

  <ul>
    {{ range $paginator.Pages }}
      <li>
        <a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a>
        <time>{{ .Date.Format "2 Jan 2006" }}</time>
      </li>
    {{ end }}
  </ul>

  {{ partial "paginacion.html" . }}
{{ end }}
```

### Partial de paginación

`layouts/partials/paginacion.html`:

```go-html-template
{{ with .Paginator }}
  <nav class="paginacion">
    {{ with .First }}
      {{ if ne $currentPageNumber .PageNumber }}
        <a href="{{ .URL }}">««</a>
      {{ end }}
    {{ end }}
    {{ with .Prev }}
      <a href="{{ .URL }}">«</a>
    {{ end }}
    {{ range .Pagers }}
      <a href="{{ .URL }}" {{ if eq .PageNumber $.Paginator.PageNumber }}class="activo"{{ end }}>
        {{ .PageNumber }}
      </a>
    {{ end }}
    {{ with .Next }}
      <a href="{{ .URL }}">»</a>
    {{ end }}
    {{ with .Last }}
      {{ if ne $currentPageNumber .PageNumber }}
        <a href="{{ .URL }}">»»</a>
      {{ end }}
    {{ end }}
  </nav>
{{ end }}
```

### Paginate vs Paginator

- **`.Paginate`** (recomendado): filtra, ordena y pagina una colección específica.
- **`.Paginator`**: paginia automáticamente la colección de la página actual.

```go-html-template
{{/* Paginate: puedes filtrar y ordenar */}}
{{ $posts := where site.RegularPages "Section" "posts" }}
{{ $posts = $posts.ByDate.Reverse }}
{{ range (.Paginate $posts 5).Pages }}
  ...
{{ end }}
```

### Propiedades del paginador

| Propiedad | Devuelve |
|---|---|
| `.PageNumber` | Número de página actual |
| `.TotalPages` | Total de páginas |
| `.HasPrev` | `true` si hay página anterior |
| `.HasNext` | `true` si hay página siguiente |
| `.Prev` | Página anterior |
| `.Next` | Página siguiente |
| `.First` | Primera página |
| `.Last` | Última página |
| `.Pages` | Elementos de la página actual |

---

## 3. Resúmenes (Summaries)

### ¿Qué son?

Los resúmenes son extractos breves del contenido que se muestran en los listados (página del blog, taxonomías) sin tener que cargar el artículo completo.

### Tres formas de definir un resumen

#### 1. Manual (la más recomendada)

Colocas `<!--more-->` en el Markdown donde quieras que termine el resumen:

```markdown
---
title: "Mi artículo"
date: 2026-06-16
---

Este es el primer párrafo del artículo. Aquí empieza el contenido que
aparecerá como resumen en el listado del blog.

<!--more-->

Este es el segundo párrafo. A partir de aquí va el resto del artículo
que solo se ve cuando el usuario hace clic para leer completo.
```

#### 2. En front matter

Defines un resumen independiente del cuerpo:

```yaml
---
title: "Mi artículo"
summary: "Este resumen es independiente del contenido del artículo."
---
```

#### 3. Automático

Si no pones `<!--more-->` ni `summary` en front matter, Hugo corta automáticamente por el número de palabras definido en `hugo.toml`:

```toml
summaryLength = 70
```

(por defecto 70 palabras)

### Jerarquía de prioridad

1. `<!--more-->` manual (máxima prioridad)
2. `summary` en front matter
3. Corte automático por palabras (mínima prioridad)

### Uso en `list.html`

```go-html-template
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ range .Pages }}
    <article>
      <h2><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></h2>
      <time>{{ .Date.Format "2 Jan 2006" }}</time>
      <div class="resumen">
        {{ .Summary }}
      </div>
      {{ if .Truncated }}
        <a href="{{ .RelPermalink }}">Leer más...</a>
      {{ end }}
    </article>
  {{ end }}
{{ end }}
```

- `.Summary` — muestra el resumen
- `.Truncated` — devuelve `true` si el contenido se ha truncado (es decir, hay más que leer)

---

## 4. Cascade

### ¿Qué es?

El cascade permite heredar front matter de una sección a todas sus páginas hijas, sin tener que repetir los mismos campos en cada archivo.

### Problema que resuelve

Sin cascade, si todas las páginas de la sección `posts/` deben tener `author: "Juan"`, hay que escribirlo en cada archivo:

```yaml
---
title: "Artículo 1"
author: "Juan"
---
```

```yaml
---
title: "Artículo 2"
author: "Juan"
---
```

### Solución con cascade

Se define una sola vez en `content/posts/_index.md`:

```yaml
---
title: "Blog"
cascade:
  author: "Juan"
  layout: "post"
---
```

Ahora todas las páginas dentro de `posts/` heredan `author: "Juan"` y `layout: "post"`, a menos que lo sobrescriban explícitamente.

### Cascade con targets específicos

Puedes aplicar cascade solo a un subconjunto de páginas usando `target`:

```yaml
---
title: "Blog"
cascade:
  - target:
      kind: "page"
    author: "Juan"
    layout: "post"
  - target:
      kind: "section"
    title: "Sección de Blog"
---
```

### Cascade desde config (global)

También puedes definir cascade global en `hugo.toml` para que aplique a todo el sitio:

```toml
[cascade]
author = "Administrador"
layout = "default"
```

### Regla importante

Un campo cascade **no sobrescribe** si la página hija ya define ese campo. La página hija siempre tiene la última palabra.

---

## 5. Menús desde front matter

### ¿Qué es?

Además de definir menús en `hugo.toml`, puedes añadir una página al menú directamente desde el front matter del archivo `.md`. Así cada página "se auto-registra" en el menú.

### Uso básico

En el front matter de cualquier archivo:

```yaml
---
title: "Sobre nosotros"
menus: "main"
---
```

Esto añade automáticamente la página al menú `main`. Se accede desde la plantilla con `{{ range site.Menus.main }}`.

### Múltiples menús

Una página puede pertenecer a varios menús:

```yaml
---
title: "Contacto"
menus: ["main", "footer"]
---
```

### Configuración avanzada

```yaml
---
title: "Servicios"
menus:
  main:
    parent: "Productos"
    weight: 20
    pre: '<i class="icono"></i>'
    params:
      class: "destacado"
---
```

Propiedades disponibles:

| Propiedad | Descripción |
|---|---|
| `parent` | Menú padre (para submenús anidados) |
| `weight` | Orden (menor = primero) |
| `pre` | HTML antes del nombre del enlace |
| `post` | HTML después del nombre del enlace |
| `params` | Parámetros personalizados |

### sectionPagesMenu (atajo)

En `hugo.toml` puedes activar que todas las secciones de primer nivel se añadan automáticamente al menú:

```toml
sectionPagesMenu = "main"
```

Esto crea automáticamente una entrada en `menus.main` por cada sección (`posts/`, `about/`, etc.) sin tener que tocar ningún front matter.

### Orden de búsqueda de menús

Hugo consulta los menús en este orden (gana el primero que encuentra):
1. Front matter de la página
2. `hugo.toml` (configuración global)
3. `sectionPagesMenu`

### Uso en plantillas

```go-html-template
<nav>
  {{ range site.Menus.main }}
    <a href="{{ .URL }}" {{ with .Params.class }}class="{{ . }}"{{ end }}>
      {{ .Pre }}{{ .Name }}{{ .Post }}
    </a>
  {{ end }}
</nav>
```

Los métodos disponibles para cada entrada de menú:
`.Identifier`, `.Name`, `.URL`, `.Weight`, `.Pre`, `.Post`, `.Parent`, `.Params`, `.Menu`, `.Page`
