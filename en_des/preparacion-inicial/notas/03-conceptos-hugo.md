# Conceptos de Hugo (II): Page Bundles y Shortcodes

**Fuente**: `.opencode/external-context/hugo/`
**Contexto**: Proyecto PYT-SWE (OAC+Hugo)
**Fecha**: 2026-06-16

---

## 1. Page Bundles

Los Page Bundles agrupan contenido con sus **recursos asociados** (imágenes, PDFs, etc.) dentro de un mismo directorio. Hay dos tipos.

### Leaf Bundle

Página individual con recursos propios. Se identifica por tener un `index.md`.

```
content/
└── posts/
    └── mi-post/
        ├── index.md       ← contenido + front matter
        ├── cover.jpg      ← recurso asociado al post
        └── grafico.png
```

Desde la plantilla se accede a los recursos con `.Resources`.

### Branch Bundle

Sección que agrupa páginas hijas. Se identifica por tener un `_index.md`.

```
content/
└── posts/
    ├── _index.md          ← metadatos de la sección "posts"
    ├── post-1/
    │   └── index.md       ← leaf bundle
    └── post-2/
        └── index.md       ← leaf bundle
```

La página de inicio (`/`) también es un branch bundle.

### ¿Para qué sirven?

- Organizar recursos junto al contenido que los usa (una imagen al lado de su Markdown, no suelta en `static/images/`)
- Los layouts pueden referenciar recursos del bundle mediante `.Params.images`
- Evita depender de rutas globales en `static/`

### Ejemplo combinado

```
content/
├── branch-bundle-1/
│   ├── _index.md
│   ├── content-1.md
│   └── image-1.jpg
├── branch-bundle-2/
│   ├── a-leaf-bundle/
│   │   └── index.md
│   └── _index.md
└── _index.md
```

### BundleType en plantillas

```go-html-template
{{ .BundleType }}
```

Devuelve `"leaf"`, `"branch"` o cadena vacía si no es un bundle.

---

## 2. Shortcodes personalizados

Los shortcodes son fragmentos HTML reutilizables que se insertan dentro del Markdown sin salir de él.

Hugo incluye shortcodes incorporados (`figure`, `youtube`, `gist`, `highlight`, `param`, `ref`, `relref`). Además, puedes crear los tuyos propios.

### Directorio

Se almacenan en `layouts/shortcodes/`:

```
layouts/
└── shortcodes/
    ├── boton.html
    ├── alerta.html
    └── galeria.html
```

Si están en un subdirectorio, se llaman con la ruta relativa:

```
layouts/shortcodes/media/
├── audio.html
└── video.html
```

Uso en Markdown: `{{</* media/video src="intro.mp4" */>}}`

### Cómo se usa un shortcode en Markdown

Con apertura y cierre (envuelve contenido):

```markdown
{{</* boton url="/contacto" color="verde" */>}}Escríbenos{{</* /boton */>}}
```

Sin cierre (autocontenido):

```markdown
{{</* icono nombre="github" */>}}
```

### Ejemplo: shortcode botón

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

Resultado HTML:

```html
<a href="/contacto" class="btn btn-verde">Escríbenos</a>
```

### Ejemplo: shortcode alerta

`layouts/shortcodes/alerta.html`:

```go-html-template
<div class="alerta alerta-{{ .Get "tipo" | default "info" }}">
  <strong>{{ .Get "titulo" | default "Aviso" }}:</strong>
  {{ .Inner }}
</div>
```

Uso:

```markdown
{{</* alerta tipo="warning" titulo="Cuidado" */>}}Esto es importante{{</* /alerta */>}}
```

### ¿Para qué sirven?

- Componentes que se repiten en varias páginas (botones, alertas, galerías, tablas)
- El Copista de OAC puede usarlos sin saber HTML
- Mantienen el Markdown limpio y legible
- **Cubren el 90% de los casos de uso de componentes reutilizables sin salir del ecosistema Markdown**

### Shortcodes incorporados útiles

| Shortcode | Descripción |
|---|---|
| `figure` | Inserta una imagen con pie de foto |
| `youtube` | Inserta un vídeo de YouTube |
| `gist` | Inserta un Gist de GitHub |
| `highlight` | Resalta código con sintaxis coloreada |
| `param` | Muestra un parámetro del front matter |
| `ref` / `relref` | Enlace a otra página del sitio |
