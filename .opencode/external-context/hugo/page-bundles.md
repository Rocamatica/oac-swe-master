---
source: Context7 API + Documentación oficial Hugo
library: Hugo
package: hugo
topic: Page Bundles
fetched: 2026-06-16
official_docs: https://gohugo.io/content-management/page-bundles/
---

# Page Bundles en Hugo

## ¿Qué son?

Los Page Bundles agrupan contenido con sus recursos asociados (imágenes, PDFs, etc.) dentro de un mismo directorio.

Hay dos tipos: **leaf bundles** (página individual) y **branch bundles** (sección).

## Leaf Bundle

Directorio con un `index.md`. Representa una página individual con recursos propios.

```
content/
└── posts/
    └── mi-post/
        ├── index.md       ← contenido + front matter
        ├── cover.jpg      ← recurso asociado
        └── grafico.png
```

Se accede a los recursos desde la plantilla con `.Resources`.

## Branch Bundle

Directorio con un `_index.md`. Representa una sección que agrupa páginas hijas.

```
content/
└── posts/
    ├── _index.md          ← metadatos de la sección
    ├── post-1/
    │   └── index.md       ← leaf bundle
    └── post-2/
        └── index.md       ← leaf bundle
```

La página de inicio (`/`) también es un branch bundle.

## BundleType en plantillas

```go-html-template
{{ .BundleType }}
```

Devuelve `"leaf"`, `"branch"` o cadena vacía.

## ¿Para qué sirven?

- Organizar recursos junto al contenido que los usa
- No depender de `static/` para imágenes de cada página
- Los layouts pueden referenciar recursos del bundle mediante `.Params.images`

## Ejemplo combinado

```
content/
├── branch-bundle-1/
│   ├── _index.md
│   ├── content-1.md
│   ├── image-1.jpg
├── branch-bundle-2/
│   ├── a-leaf-bundle/
│   │   └── index.md
│   └── _index.md
└── _index.md
```
