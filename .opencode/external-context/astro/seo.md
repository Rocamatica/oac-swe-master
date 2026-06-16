---
source: Context7 API (Astro docs)
library: Astro
package: astro
topic: SEO, Meta Tags, Open Graph, Canonical, Twitter Cards, Schema.org, Integraciones
fetched: 2026-06-15T10:00:00Z
official_docs: https://docs.astro.build/en/guides/configuring-astro
---

# SEO en Astro v5.x

## 1. Meta Tags (title, description)

Astro no tiene un sistema nativo de SEO. Los meta tags se configuran **manualmente** en cada página o mediante **componentes reutilizables**.

### Enfoque recomendado: componente `Head` reutilizable

```astro
---
// src/components/Head.astro
const { title = "Mi Sitio Astro", description = "Descripción por defecto" } = Astro.props;
---
<title>{title}</title>
<meta name="description" content={description} />
```

### Uso en una página:
```astro
---
import Head from '../components/Head.astro';
---
<html>
  <head>
    <Head title="Mi Página" description="Descripción de esta página" />
  </head>
  <body>
    ...
  </body>
</html>
```

**Fuente:** https://docs.astro.build/en/guides/configuring-astro

---

## 2. Open Graph (og:title, og:description, og:image, og:url)

Astro no tiene soporte nativo de Open Graph. Deben añadirse **manualmente** como meta tags HTML estándar.

### Ejemplo completo dentro de un componente Head:
```astro
---
// src/components/Head.astro
const { title, description, image, url } = Astro.props;
---
<meta property="og:title" content={title} />
<meta property="og:type" content="website" />
<meta property="og:url" content={url} />
<meta property="og:description" content={description} />
<meta property="og:image" content={image} />
<meta property="og:image:alt" content={title} />
```

### Generación de URL para OG Image (con Cloudinary):
```astro
---
import { getCldOgImageUrl } from 'astro-cloudinary/helpers';
const ogImageUrl = getCldOgImageUrl({ src: '<Public ID>' });
---
<meta property="og:image" content={ogImageUrl} />
<meta property="og:image:secure_url" content={ogImageUrl} />
<meta property="og:image:width" content="1200" />
<meta property="og:image:height" content="630" />
```

**Fuente:** https://docs.astro.build/en/guides/media/cloudinary

---

## 3. Canonical URL

Se construye usando `Astro.url` y `Astro.site` (configurado en `astro.config.mjs`):

```astro
---
const canonicalURL = new URL(Astro.url.pathname, Astro.site);
---
<link rel="canonical" href={canonicalURL} />
```

`Astro.canonicalURL` está **deprecated** desde v2.0. Usar `Astro.url` + `Astro.site`.

**Fuente:** https://docs.astro.build/en/reference/api-reference
**Fuente:** https://docs.astro.build/en/guides/upgrade-to/v2

---

## 4. Twitter Cards

Astro no tiene soporte nativo. Se añaden manualmente como meta tags:

```html
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:title" content="Título" />
<meta name="twitter:description" content="Descripción" />
<meta name="twitter:image" content="URL de imagen" />
```

**Fuente:** https://docs.astro.build/en/guides/media/cloudinary (ejemplo con Cloudinary incluye Twitter Card tags)

---

## 5. Schema.org / Structured Data (JSON-LD)

Astro no tiene soporte integrado para JSON-LD. Se inyecta manualmente usando `set:html` o directamente en el template:

```astro
<script type="application/ld+json" set:html={JSON.stringify({
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "Título del artículo",
  "description": "Descripción",
  "author": { "@type": "Person", "name": "Autor" }
})} />
```

**Fuente:** https://docs.astro.build/en/reference/directives-reference (directiva `set:html`)

---

## 6. Integraciones oficiales para SEO

### @astrojs/sitemap (oficial)
Genera automáticamente `sitemap-index.xml` y `sitemap-0.xml` en el build:

```javascript
import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://example.com',
  integrations: [sitemap({
    entryLimit: 10000,  // opcional: límite de entradas por archivo
  })],
});
```

**Fuente:** https://docs.astro.build/en/guides/integrations-guide/sitemap

### NO ENCONTRADO:
- No existe una integración oficial tipo `@astrojs/seo` que maneje meta tags, Open Graph y Twitter Cards automáticamente.
- No hay integración oficial para generar JSON-LD automáticamente.
- Tampoco se encontró una integración de terceros "muy popular" para SEO (aunque existen paquetes comunitarios como `astro-seo` o `@astrolib/seo`, no se mencionan en la documentación oficial de Astro consultada).

---

## 7. Gestión de meta descriptions y titles por página

Cada página Astro (`.astro` o `.md`) gestiona sus propios meta tags. El patrón típico es:

1. Definir un componente `BaseHead` o `SEO` en `src/components/`
2. En cada página, pasar props (title, description, image, etc.) a ese componente
3. Para páginas generadas desde Content Collections, los valores vienen del Front Matter

Ejemplo con Content Collections:
```astro
---
import { getCollection } from 'astro:content';
import BaseLayout from '../layouts/BaseLayout.astro';

export async function getStaticPaths() {
  const posts = await getCollection('blog');
  return posts.map(post => ({
    params: { slug: post.id },
    props: { post },
  }));
}

const { post } = Astro.props;
---
<BaseLayout 
  pageTitle={post.data.title}
  pageDescription={post.data.description}
>
  ...
</BaseLayout>
```

**Nota:** No existe una forma automática; cada página debe definir explícitamente sus tags.
