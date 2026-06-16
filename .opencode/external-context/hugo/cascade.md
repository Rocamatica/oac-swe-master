---
source: Context7 API
library: Hugo
package: hugo
topic: Cascade
fetched: 2026-06-16
official_docs: https://gohugo.io/content-management/front-matter/#cascade
---

# Cascade en Hugo

## Propósito
Heredar front matter de una sección a sus páginas hijas.

## Uso en _index.md
```yaml
cascade:
  author: "Juan"
  layout: "post"
```

## Con targets específicos
```yaml
cascade:
  - target:
      kind: "page"
    author: "Juan"
  - target:
      kind: "section"
    title: "Sección"
```

## Cascade global en hugo.toml
```toml
[cascade]
author = "Admin"
```

## Regla
La página hija no sobrescribe si ya define el campo.
