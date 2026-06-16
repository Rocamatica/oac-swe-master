---
source: Context7 API
library: Hugo
package: hugo
topic: Taxonomies
fetched: 2026-06-16
official_docs: https://gohugo.io/content-management/taxonomies/
---

# Taxonomías en Hugo

## Por defecto
tags, categories incluidas de serie.

## Personalizadas
Se definen en hugo.toml:
[taxonomies]
author = 'autores'
series = 'series'

## Front matter
tags: ["go", "hugo"]
categories: ["desarrollo"]
author: ["Juan Pérez"]

## Plantillas
Hugo usa list.html para taxonomías también.
Se puede crear layouts/taxonomy/list.html para personalizar.

## Visualización en single.html
{{ with .Params.tags }}
  {{ range . }}
    <a href="{{ "tags/" | relLangURL }}{{ . | urlize }}">{{ . }}</a>
  {{ end }}
{{ end }}
