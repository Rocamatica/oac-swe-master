# Flujo de trabajo con Hugo

**Fuente**: `.opencode/external-context/hugo/`
**Contexto**: Proyecto PYT-SWE (OAC+Hugo)
**Fecha**: 2026-06-16

---

Este documento describe los pasos a seguir en orden, desde cero, para crear y desplegar un sitio con Hugo.

---

## 1. Instalar Hugo

Hugo es un solo binario. No requiere Node.js, PHP ni ninguna dependencia.

**Opción recomendada (Linux/Mac):**

```bash
# Linux (Debian/Ubuntu)
sudo apt install hugo

# macOS (Homebrew)
brew install hugo

# Verificar instalación
hugo version
```

**Opción para la última versión (Linux):** descargar el binario desde GitHub:

```bash
wget https://github.com/gohugoio/hugo/releases/download/v0.163.1/hugo_extended_0.163.1_linux-amd64.tar.gz
tar -xzf hugo_extended_0.163.1_linux-amd64.tar.gz
sudo mv hugo /usr/local/bin/
```

> **Nota**: instala siempre la versión "extended" para tener soporte de Sass/SCSS.

---

## 2. Crear el proyecto

```bash
hugo new site mi-sitio
cd mi-sitio
```

Esto genera la estructura de directorios:

```
mi-sitio/
├── archetypes/
│   └── default.md
├── assets/
├── content/
├── data/
├── i18n/
├── layouts/
├── static/
├── themes/
└── hugo.toml
```

---

## 3. Configurar hugo.toml

Editar `hugo.toml` con los valores del proyecto:

```toml
baseURL = 'https://midominio.com/'
locale = 'es-es'
title = 'Nombre del Sitio'

[params]
  description = 'Descripción global para SEO'
  author = 'Nombre del autor'
  [params.social]
    twitter = '@cuenta'
```

---

## 4. Crear la estructura de layouts

Crear la jerarquía mínima de plantillas:

```
layouts/
├── _default/
│   ├── baseof.html
│   ├── home.html
│   ├── single.html
│   └── list.html
└── partials/
    ├── head.html
    ├── header.html
    └── footer.html
```

### baseof.html

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
    {{ block "main" . }}{{ end }}
  </main>
  <footer>
    {{ partial "footer.html" . }}
  </footer>
</body>
</html>
```

### partials/head.html

```go-html-template
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{{ if .IsHome }}{{ site.Title }}{{ else }}{{ .Title }} | {{ site.Title }}{{ end }}</title>
{{ with .Description }}<meta name="description" content="{{ . }}">{{ end }}
{{ with resources.Get "css/main.css" }}<link rel="stylesheet" href="{{ .RelPermalink }}">{{ end }}
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
  <p>&copy; {{ now.Year }} {{ site.Title }}</p>
</footer>
```

### home.html

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

### single.html

```go-html-template
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ with .Date }}<time>{{ .Format "2 January 2006" }}</time>{{ end }}
  <div>{{ .Content }}</div>
{{ end }}
```

### list.html

```go-html-template
{{ define "main" }}
  <h1>{{ .Title }}</h1>
  {{ .Content }}
  <ul>
    {{ range .Pages }}
      <li><a href="{{ .RelPermalink }}">{{ .LinkTitle }}</a></li>
    {{ end }}
  </ul>
{{ end }}
```

---

## 5. Configurar Hugo Pipes (CSS y JS)

Colocar los archivos fuente en `assets/`:

```
assets/
├── css/
│   └── main.css      ← o main.scss si usas Sass
└── js/
    └── main.js
```

Añadir en `partials/head.html` el pipeline CSS:

```go-html-template
{{ with resources.Get "css/main.css" }}
  {{ if hugo.IsDevelopment }}
    <link rel="stylesheet" href="{{ .RelPermalink }}">
  {{ else }}
    {{ with . | minify | fingerprint }}
      <link rel="stylesheet" href="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}">
    {{ end }}
  {{ end }}
{{ end }}
```

Añadir en el footer el pipeline JS:

```go-html-template
{{ with resources.Get "js/main.js" }}
  {{ $opts := dict "minify" (not hugo.IsDevelopment) }}
  {{ with . | js.Build $opts }}
    {{ if hugo.IsDevelopment }}
      <script src="{{ .RelPermalink }}"></script>
    {{ else }}
      {{ with . | fingerprint }}
        <script src="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}"></script>
      {{ end }}
    {{ end }}
  {{ end }}
{{ end }}
```

---

## 6. Crear archetypes

Definir las plantillas de contenido en `archetypes/`:

### archetypes/default.md

```yaml
---
title: "{{ replace .File.ContentBaseName `-` ` ` | title }}"
date: {{ .Date }}
draft: true
description: ""
tags: []
---
```

### archetypes/posts.md

```yaml
---
title: "{{ replace .File.ContentBaseName `-` ` ` | title }}"
date: {{ .Date }}
draft: true
description: ""
tags: []
categories: []
---
```

---

## 7. Crear contenido de prueba

```bash
# Página de inicio
hugo new content _index.md

# Sección posts
hugo new content posts/_index.md

# Un artículo
hugo new content posts/mi-primer-articulo.md
```

Editar los archivos generados en `content/` para añadir el cuerpo del contenido.

---

## 8. Servidor de desarrollo

```bash
# Iniciar servidor con recarga automática
hugo server

# Incluir borradores (draft: true)
hugo server -D

# Ver en http://localhost:1313
```

Cada cambio en los archivos se refleja automáticamente en el navegador (LiveReload).

---

## 9. Build de producción

```bash
# Generar sitio optimizado para producción
hugo --minify --gc
```

- `--minify` : minifica HTML, CSS y JS
- `--gc` : limpia la caché de recursos (garbage collection)

El sitio generado estará en `public/`.

---

## 10. Desplegar con Wrangler (Cloudflare Pages)

### Requisitos previos

```bash
# Instalar Wrangler
npm install -g wrangler

# Iniciar sesión en Cloudflare
wrangler login
```

### Despliegue

```bash
# Primera vez: crear proyecto en Cloudflare Pages
wrangler pages project create mi-sitio --production-branch main

# Desplegar (cada vez que se actualiza el contenido)
hugo --minify --gc && wrangler pages deploy public/ --project-name=mi-sitio
```

---

## Resumen del ciclo completo

```
1. hugo new site mi-sitio
2. Editar hugo.toml
3. Crear layouts/ (baseof, partials, home, single, list)
4. Crear assets/ (CSS, JS)
5. Crear archetypes/
6. hugo new content posts/mi-articulo.md
7. Editar el .md (front matter + cuerpo)
8. hugo server -D  ← desarrollo
9. hugo --minify --gc  ← build producción
10. wrangler pages deploy public/  ← desplegar
```
