---
source: Context7 API (Astro docs)
library: Astro
package: astro
topic: Blog, Taxonomías, Paginación, RSS, Templates
fetched: 2026-06-15T10:00:00Z
official_docs: https://docs.astro.build/en/guides/content-collections
---

# Blog en Astro v5.x

## 1. Estructura de un Blog

La estructura recomendada usa **Content Collections**:

```
src/
  content/
    blog/
      primer-post.md
      segundo-post.md
      una-categoria/
        tercer-post.md
  content.config.ts
  pages/
    blog/
      index.astro        (lista de posts)
      [slug].astro       (página individual de post)
    rss.xml.js           (feed RSS)
```

**Fuente:** https://docs.astro.build/en/tutorial/6-islands/4

---

## 2. Taxonomías (categorías, etiquetas, autores)

### Tags en Front Matter
Se definen como arrays en el schema de Zod y en el Front Matter:

```yaml
---
title: Mi Post
tags: ["astro", "blogging", "tutorial"]
---
```

### Página de índice de tags
Se extraen tags únicos de todos los posts usando `getCollection()`:

```astro
---
import { getCollection } from "astro:content";
const allPosts = await getCollection("blog");
const tags = [...new Set(allPosts.map((post) => post.data.tags).flat())];
---
```

### Páginas dinámicas por tag
Se usa `getStaticPaths()` para generar una página por cada tag:

```astro
---
import { getCollection } from "astro:content";

export async function getStaticPaths() {
  const allPosts = await getCollection("blog");
  const uniqueTags = [...new Set(allPosts.map((post) => post.data.tags).flat())];

  return uniqueTags.map((tag) => {
    const filteredPosts = allPosts.filter((post) =>
      post.data.tags.includes(tag)
    );
    return {
      params: { tag },
      props: { posts: filteredPosts },
    };
  });
}

const { tag } = Astro.params;
const { posts } = Astro.props;
---
<h1>Posts etiquetados con: {tag}</h1>
{posts.map(post => <p>{post.data.title}</p>)}
```

### Autores
Los autores pueden manejarse como:
- Campo string simple en Front Matter
- Colección separada con `reference('authors')` para datos más complejos

```typescript
const blog = defineCollection({
  schema: z.object({
    author: reference('authors'),
    // ...
  })
});
```

**Fuente:** https://docs.astro.build/en/tutorial/6-islands/4
**Fuente:** https://docs.astro.build/en/guides/content-collections

---

## 3. Listas de posts y paginación

### Lista completa de posts:
```astro
---
import { getCollection } from 'astro:content';
const allPosts = await getCollection('blog');
// Ordenar por fecha si se desea
const sortedPosts = allPosts.sort((a, b) => b.data.pubDate - a.data.pubDate);
---
{allPosts.map(post => (
  <article>
    <h2><a href={`/blog/${post.id}/`}>{post.data.title}</a></h2>
    <p>{post.data.description}</p>
  </article>
))}
```

### Paginación con `paginate()`
La función `paginate()` se usa dentro de `getStaticPaths()` para dividir contenido en páginas:

```astro
---
export async function getStaticPaths({ paginate }) {
  const response = await fetch(`https://pokeapi.co/api/v2/pokemon?limit=150`);
  const result = await response.json();
  const allPokemon = result.results;
  return paginate(allPokemon, { pageSize: 10 });
}

const { page } = Astro.props;
---
<h1>Página {page.currentPage} de {page.lastPage}</h1>
{page.data.map(item => <p>{item.name}</p>)}
```

**Fuente:** https://docs.astro.build/en/reference/routing-reference

---

## 4. RSS / Atom Feeds

Astro tiene una integración oficial: **`@astrojs/rss`**.

### Instalación:
```bash
npm install @astrojs/rss
```

### Crear feed (en `src/pages/rss.xml.js`):
```javascript
import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';

export async function GET(context) {
  const posts = await getCollection('blog');
  return rss({
    title: 'Mi Blog',
    description: 'Descripción del blog',
    site: context.site,
    items: posts.map((post) => ({
      title: post.data.title,
      pubDate: post.data.pubDate,
      description: post.data.description,
      link: `/blog/${post.id}/`,
    })),
    customData: `<language>es-es</language>`,
  });
}
```

También funciona con `pagesGlobToRssItems()` para posts fuera de Content Collections:
```javascript
items: await pagesGlobToRssItems(import.meta.glob('./blog/*.{md,mdx}')),
```

**Fuente:** https://docs.astro.build/en/recipes/rss
**Fuente:** https://docs.astro.build/en/tutorial/5-astro-api/4

---

## 5. Templates y ejemplos populares de blog

Astro ofrece **templates oficiales** que pueden usarse como punto de partida:

```bash
# Template oficial de blog
npm create astro@latest -- --template blog
```

### Templates oficiales disponibles:
- **`blog`**: Template oficial de blog con Astro
- **`portfolio`**: Template de portafolio
- **`docs`**: Template de documentación
- **`landing`**: Template de landing page
- **`e-commerce`**: Template de tienda online

Se puede usar cualquier repositorio de GitHub como template:
```bash
npm create astro@latest -- --template <github-username>/<github-repo>
```

**Fuente:** https://docs.astro.build/en/install-and-setup
**Fuente:** https://docs.astro.build/en/getting-started

---

## 6. Manejo de fechas

Las fechas en Front Matter se definen como strings y se validan con `z.coerce.date()` en el schema de Zod:

```yaml
---
pubDate: 2022-07-01
updatedDate: 2022-07-15
---
```

En el schema:
```typescript
schema: z.object({
  pubDate: z.coerce.date(),
  updatedDate: z.coerce.date().optional(),
})
```

`z.coerce.date()` acepta strings ISO, timestamps, o fechas en formato `YYYY-MM-DD`. Una vez en TypeScript, es un objeto `Date`, por lo que se pueden usar métodos como `.toDateString()`:

```astro
<p>Publicado: {post.data.pubDate.toDateString()}</p>
```

**Fuente:** https://docs.astro.build/en/guides/content-collections
