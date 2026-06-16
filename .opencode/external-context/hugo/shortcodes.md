---
source: Context7 API + Documentación oficial Hugo
library: Hugo
topic: Shortcodes
fetched: 2026-06-16
official_docs: https://gohugo.io/content-management/shortcodes/
---

# Shortcodes en Hugo

## ¿Qué son?

Fragmentos HTML reutilizables que se insertan dentro del Markdown sin salir de él. Hugo incluye shortcodes incorporados (figure, youtube, gist, highlight, param, ref, relref) y permite crear shortcodes personalizados.

## Directorio

Se almacenan en `layouts/shortcodes/`:

```
layouts/
└── _shortcodes/
    ├── diagrams/
    │   ├── kroki.html
    │   └── plotly.html
    ├── media/
    │   ├── audio.html
    │   ├── gallery.html
    │   └── video.html
    ├── capture.html
    ├── column.html
    ├── include.html
    └── row.html
```

Si están en subdirectorio, se llaman con la ruta relativa sin extensión: `{{</* diagrams/kroki */>}}`.

## Shortcode personalizado: ejemplo botón

`layouts/shortcodes/boton.html`:

```go-html-template
<a href="{{ .Get "url" }}" class="btn btn-{{ .Get "color" | default "azul" }}">
  {{ .Inner }}
</a>
```

Uso en Markdown:

```markdown
{{</* boton url="/contacto" color="verde" */>}}Escríbenos{{</* /boton */>}}
```

Resultado:

```html
<a href="/contacto" class="btn btn-verde">Escríbenos</a>
```

## Variante inline (sin cierre)

```markdown
{{</* icono nombre="github" */>}}
```

## Shortcode highlight inline personalizado

`layouts/shortcodes/hl.html`:

```go-html-template
{{ $code := .Inner | strings.TrimSpace }}
{{ $lang := or (.Get 0) "go" }}
{{ $opts := dict "hl_inline" true "noClasses" true }}
{{ transform.Highlight $code $lang $opts }}
```

Uso:

```markdown
Esto es código {{</* hl "go" */>}}fmt.Println("hola"){{</* /hl */>}} inline.
```

## ¿Para qué sirven?

- Componentes reutilizables (galerías, botones, alertas, tablas, diagramas Mermaid)
- El Copista de OAC puede usarlos sin saber HTML
- Mantienen el Markdown limpio y legible
