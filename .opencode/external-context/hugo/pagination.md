---
source: Context7 API
library: Hugo
topic: Pagination
fetched: 2026-06-16
official_docs: https://gohugo.io/templates/pagination/
---

# Paginación en Hugo

## Config
hugo.toml: paginate = 10

## Uso en list.html
{{ $paginator := .Paginate .Pages }}
{{ range $paginator.Pages }}...{{ end }}
{{ partial "paginacion.html" . }}

## Con filtro
{{ $posts := where site.RegularPages "Section" "posts" }}
{{ $posts = $posts.ByDate.Reverse }}
{{ range (.Paginate $posts 5).Pages }}...{{ end }}

## Propiedades del paginador
.PageNumber, .TotalPages, .HasPrev, .HasNext, .Prev, .Next, .First, .Last, .Pages, .Pagers

## Paginate vs Paginator
.Paginate acepta colección y tamaño. .Paginator usa la colección de la página actual y el config.
