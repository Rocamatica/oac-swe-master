---
source: Context7 API
library: Hugo
package: hugo
topic: Archetypes
fetched: 2026-06-16T00:00:00Z
official_docs: https://gohugo.io/content-management/archetypes/
---

# Archetypes en Hugo

## ¿Qué son los Archetypes?

Los **archetypes** son plantillas para crear nuevo contenido en Hugo. Definen la estructura estándar y el front matter que se genera automáticamente al ejecutar `hugo new content`.

## Directorio de Archetypes

Los archetypes se almacenan en el directorio `archetypes/` en la raíz del proyecto:

```
archetypes/
├── default.md          # Usado cuando no se especifica un kind
├── posts.md            # Archetype para contenido de tipo "posts"
└── tutorials.md        # Archetype para contenido de tipo "tutorials"
```

### Archetype por Defecto (`archetypes/default.md`)

```toml
---
title = '{{ replace .File.ContentBaseName `-` ` ` | title }}'
date = '{{ .Date }}'
draft = true
---
```

Este archetype genera un título a partir del nombre del archivo (reemplazando guiones con espacios y capitalizando), asigna la fecha actual, y marca el contenido como borrador.

### Ejemplo de Archetype para Documentación

```markdown
---
date: '{{ .Date }}'
draft: true
title: '{{ replace .File.ContentBaseName `-` ` ` | title }}'
---

A brief description of what the function does.

## Signature

```text
func someFunction(s string, n int) string
```

## Examples

One or more practical examples.

## Notes

Additional information as needed.
```

### Archetype en un Tema

```toml
---
title: "{{ replace .Name \"-\" \" \" | title }}"
date: {{ .Date }}
draft: true
---

Dummy content.
```

## Orden de Búsqueda (Lookup Order)

Hugo busca archetypes en el siguiente orden:

1. **Directorios de archetypes del proyecto** (raíz del proyecto)
2. **Temas o módulos instalados**
3. **Archetypes específicos del tipo de contenido** tienen prioridad sobre el default
4. Si no se encuentra ningún archetype personalizado, Hugo usa un **default integrado**

## Comandos de Uso

```sh
# Usa el archetype por defecto (default.md)
hugo new content articles/mi-articulo.md

# Usa un archetype específico con --kind
hugo new content --kind tutorials articles/mi-tutorial.md
```

## Contenido Generado con Archetypes

Al ejecutar `hugo new content`, Hugo procesa el archetype reemplazando las variables de plantilla (`.Date`, `.File.ContentBaseName`, etc.) y crea el archivo en el directorio `content/`.

## Buenas Prácticas

- Crear archetypes separados para cada tipo de contenido (posts, pages, tutorials, etc.)
- Incluir campos de front matter comunes como `title`, `date`, `draft`, `tags`, `categories`
- Usar variables de Hugo como `{{ .Date }}` y `{{ replace .File.ContentBaseName "-" " " | title }}` para auto-generar metadatos
