---
source: Context7 API
library: Hugo
topic: Menus from Front Matter
fetched: 2026-06-16
official_docs: https://gohugo.io/content-management/menus/
---

# Menús desde Front Matter

## Uso básico
```yaml
menus: "main"
```

## Múltiples menús
```yaml
menus: ["main", "footer"]
```

## Configuración avanzada
```yaml
menus:
  main:
    parent: "Productos"
    weight: 20
    pre: '<i class="icono"></i>'
    params:
      class: "destacado"
```

## sectionPagesMenu
En hugo.toml:
```toml
sectionPagesMenu = "main"
```
Añade automáticamente cada sección al menú principal.

## Orden de búsqueda
1. Front matter de la página
2. hugo.toml
3. sectionPagesMenu

## Propiedades de entrada de menú
.Identifier, .Name, .URL, .Weight, .Pre, .Post, .Parent, .Params, .Menu, .Page
