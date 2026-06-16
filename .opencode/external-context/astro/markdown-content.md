---
source: Context7 API (Astro docs)
library: Astro
package: astro
topic: Markdown, Front Matter, Content Collections, MDX, Shortcodes
fetched: 2026-06-15T10:00:00Z
official_docs: https://docs.astro.build/en/guides/markdown-content
---

# Markdown y Gestión de Contenido en Astro v5.x

## 1. Gestión de Markdown

Astro tiene soporte nativo de Markdown. Los archivos `.md` pueden usarse directamente como páginas (en `src/pages/`) o como contenido gestionado a través de **Content Collections**. Astro procesa el Markdown usando **remark** (con GFM — GitHub Flavored Markdown — activado por defecto).

**Fuente:** https://docs.astro.build/en/guides/markdown-content

### Configuración de Markdown

Astro permite configurar remark plugins, rehype plugins, syntax highlighting (Shiki o Prism), y GFM en `astro.config.mjs`:

```javascript
import { defineConfig } from 'astro/config';
import remarkToc from 'remark-toc';

export default defineConfig({
  markdown: {
    syntaxHighlight: 'prism',    // 'shiki' (default) | 'prism' | false
    remarkPlugins: [ [remarkToc, { heading: "contents" }] ],
    gfm: true,                    // GitHub Flavored Markdown (default: true)
  },
});
```

**Fuente:** https://docs.astro.build/en/reference/configuration-reference

---

## 2. Front Matter

Astro soporta **Front Matter en YAML** en archivos Markdown y MDX. El Front Matter se define entre bloques `---` al inicio del archivo.

### Formato soportado:
- **YAML** (formato nativo y principal): entre `---` y `---`
- **TOML**: Astro también soporta Front Matter en TOML para Content Collections
- **JSON**: soportado para Content Collections con loader `file()`

Ejemplo de Front Matter YAML en Markdown:
```markdown
---
layout: ../../layouts/MarkdownPostLayout.astro
title: 'Mi Primer Post'
pubDate: 2022-07-01
description: 'Descripción del post'
author: 'Astro Learner'
image:
    url: 'https://docs.astro.build/assets/rose.webp'
    alt: 'The Astro logo'
tags: ["astro", "blogging"]
---
```

**Fuente:** https://docs.astro.build/en/tutorial/4-layouts/2
**Fuente:** https://docs.astro.build/en/tutorial/2-pages/2

---

## 3. Content Collections

Astro tiene **Content Collections** como sistema oficial y recomendado para organizar y validar contenido. Es la forma principal de gestionar contenido en Astro v5.x.

### ¿Cómo funcionan?

1. Se define un archivo `src/content.config.ts` (o `src/content/config.ts` en versiones anteriores)
2. Se usa `defineCollection()` para definir cada colección
3. Se especifica un **loader** (`glob()` o `file()`) para indicar de dónde cargar el contenido
4. Se define un **schema** con Zod para validar y tipar el Front Matter

```typescript
// src/content.config.ts
import { defineCollection } from 'astro:content';
import { z } from 'astro/zod';
import { glob, file } from 'astro/loaders';

const blog = defineCollection({
  loader: glob({ base: './src/content/blog', pattern: '**/*.{md,mdx}' }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    pubDate: z.coerce.date(),
    updatedDate: z.coerce.date().optional(),
  })
});

const dogs = defineCollection({
  loader: file("src/data/dogs.json"),
  schema: z.object({
    id: z.string(),
    breed: z.string(),
    temperament: z.array(z.string()),
  }),
});

export const collections = { blog, dogs };
```

### Loaders disponibles:
- **`glob()`**: Para archivos locales (Markdown, MDX, JSON, YAML, TOML) en el sistema de archivos
- **`file()`**: Para cargar un único archivo (JSON, YAML, etc.)

**Fuente:** https://docs.astro.build/en/guides/content-collections

### Validación con Zod

El schema de Zod proporciona:
- Validación automática del Front Matter en build time
- Tipos TypeScript inferidos automáticamente
- Campos opcionales, fechas, arrays, referencias entre colecciones

```typescript
const blog = defineCollection({
  loader: glob({ pattern: '**/[^_]*.md', base: "./src/blog" }),
  schema: z.object({
    title: z.string(),
    pubDate: z.date(),
    description: z.string(),
    author: z.string(),
    image: z.object({
      url: z.string(),
      alt: z.string()
    }),
    tags: z.array(z.string())
  })
});
```

**Fuente:** https://docs.astro.build/en/tutorial/6-islands/4

### Referencias entre colecciones

Puedes relacionar colecciones usando `reference()`:

```typescript
const blog = defineCollection({
  loader: glob({ base: './src/content/blog', pattern: '**/*.{md,mdx}' }),
  schema: z.object({
    title: z.string(),
    author: reference('authors'),
    relatedPosts: z.array(reference('blog')),
  })
});
```

**Fuente:** https://docs.astro.build/en/guides/content-collections

---

## 4. Organización de archivos de contenido

### Estructura típica:
```
src/
  content/
    blog/
      post-1.md
      post-2.md
      category/
        post-3.md
    pages/
      about.md
      contact.md
```

### Contenido anidado

Los Content Collections soportan subdirectorios. El `id` de cada entrada refleja la ruta relativa. Puedes filtrar por subdirectorio:

```astro
---
import { getCollection } from 'astro:content';
const englishDocsEntries = await getCollection('docs', ({ id }) => {
  return id.startsWith('en/');
});
---
```

**Fuente:** https://docs.astro.build/en/guides/content-collections

---

## 5. MDX (Markdown con JSX)

Astro soporta MDX a través de la integración oficial `@astrojs/mdx`. Permite:

- Importar y usar componentes (Astro, React, Vue, Svelte, etc.) dentro de Markdown
- Usar JSX/expresiones en el contenido
- Asignar componentes personalizados a elementos HTML de Markdown
- Usar en Content Collections con el patrón `**/*.{md,mdx}`

### Instalación:
```bash
npm install @astrojs/mdx
```

### Ejemplo MDX:
```mdx
---
title: Mi primer post MDX
---
import ReactCounter from '../components/ReactCounter.jsx';

Aquí hay Markdown normal.

<ReactCounter client:load />
```

### Componentes personalizados para elementos HTML:

```mdx
import Blockquote from '../components/Blockquote.astro';
export const components = {blockquote: Blockquote};

> Esta cita usará el componente Blockquote personalizado
```

**Fuente:** https://docs.astro.build/en/guides/integrations-guide/mdx

---

## 6. Shortcodes / Equivalente

Astro **NO tiene shortcodes al estilo Hugo/WordPress**. En su lugar:

- **En MDX**: se importan componentes directamente y se usan como JSX
- **En Markdown plano**: se usa el sistema de `components` que mapea elementos HTML a componentes personalizados al renderizar
- **En Content Collections**: al hacer `render(entry)`, se pueden pasar componentes personalizados al `<Content />`

```astro
---
import { getEntry, render } from 'astro:content';
import CustomHeading from '../../components/CustomHeading.astro';
const entry = await getEntry('blog', 'post-1');
const { Content } = await render(entry);
---
<Content components={{ h1: CustomHeading }} />
```

**Fuente:** https://docs.astro.build/en/guides/integrations-guide/mdx

La migración desde Hugo (que usa shortcodes) se hace reemplazando la sintaxis de shortcodes con componentes MDX.

**Fuente:** https://docs.astro.build/en/guides/migrate-to-astro/from-hugo
