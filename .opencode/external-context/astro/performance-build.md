---
source: Context7 API (Astro docs)
library: Astro
package: astro
topic: Rendimiento, Compilación, Assets, Minificación, Astro Islands
fetched: 2026-06-15T10:00:00Z
official_docs: https://docs.astro.build/en/concepts/islands
---

# Rendimiento y Compilación en Astro v5.x

## 1. Rendimiento de compilación para sitios estáticos

Astro está diseñado para ser **rápido en compilación**, especialmente para sitios estáticos. El output por defecto es un sitio estático (archivos HTML, CSS, JS planos) en la carpeta `dist/`.

### Características:
- **Zero JS por defecto**: Las páginas Astro se renderizan a HTML estático sin JavaScript del lado del cliente, a menos que se añada explícitamente
- **Output estático**: El build produce archivos HTML listos para servir con cualquier servidor web (NGINX, Apache, S3, Cloudflare Pages, etc.)
- **Build time eficiente**: El pipeline de build de Astro usa Vite internamente, que proporciona compilación rápida con esbuild y bundling optimizado

### Ejemplo Docker para sitio estático:
```dockerfile
FROM node:lts AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine AS runtime
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 8080
```

**Fuente:** https://docs.astro.build/en/recipes/docker

---

## 2. Pipeline de assets (CSS, JS, imágenes)

### CSS y JS
Astro usa **Vite** como bundler, lo que proporciona:
- Procesamiento automático de CSS (imports, postcss, Tailwind CSS)
- Bundle splitting automático
- Code splitting para componentes interactivos (Islands)
- Soporte para Sass, Less, Stylus vía Vite

### Imágenes: `astro:assets`
Astro tiene un sistema de imágenes integrado con los componentes `<Image />` y `<Picture />`:

```astro
---
import { Image } from 'astro:assets';
import myImage from '../assets/my_image.png';
---
<Image src={myImage} alt="Descripción" layout='constrained' width={800} height={600} />
```

**El componente `<Image />`** proporciona automáticamente:
- Optimización de formato (WebP por defecto)
- Redimensionamiento automático
- Generación de `srcset` y `sizes` para imágenes responsive
- Atributos `loading="lazy"` y `decoding="async"`
- Hashing de archivos para cache busting

```html
<!-- Output generado para imagen responsive -->
<img
  src="/_astro/my_image.hash3.webp"
  srcset="/_astro/my_image.hash1.webp 640w,
          /_astro/my_image.hash2.webp 750w,
          /_astro/my_image.hash3.webp 800w"
  alt="Descripción"
  sizes="(min-width: 800px) 800px, 100vw"
  loading="lazy"
  decoding="async"
  width="800"
  height="600"
>
```

**Fuente:** https://docs.astro.build/en/guides/images
**Fuente:** https://docs.astro.build/en/reference/modules/astro-assets

### Rutas de output personalizadas
Se puede configurar cómo se nombran los assets en el output:

```javascript
export default defineConfig({
  vite: {
    environments: {
      client: {
        build: {
          rollupOptions: {
            output: {
              entryFileNames: 'js/[name]-[hash].js',
              chunkFileNames: 'js/chunks/[name]-[hash].js',
              assetFileNames: 'static/[name]-[hash][extname]',
            },
          },
        },
      },
    },
  },
});
```

**Fuente:** https://docs.astro.build/en/recipes/customizing-output-filenames

---

## 3. Minificación y optimización de recursos

### Minificación
Astro minifica HTML, CSS y JS automáticamente en producción usando los built-in de Vite (esbuild/terser para JS, cssnano para CSS).

Se puede deshabilitar para debugging:
```javascript
export default defineConfig({
  adapter: cloudflare(),
  vite: {
    build: {
      minify: false,   // deshabilitar minificación
    },
  },
});
```

**Fuente:** https://docs.astro.build/en/guides/integrations-guide/cloudflare

### Caché de assets
Astro cachea imágenes procesadas para mejorar rendimiento en builds subsecuentes:

```javascript
// La caché se almacena por defecto en node_modules/
// Se puede configurar la ruta
```

**Fuente:** https://docs.astro.build/en/guides/images

### Optimizaciones disponibles:
- ✅ Minificación HTML automática
- ✅ Minificación CSS automática
- ✅ Minificación JS automática (vía esbuild/terser)
- ✅ Hashing de archivos para cache busting
- ✅ Optimización de imágenes (formato WebP, redimensionamiento)
- ✅ Lazy loading de imágenes
- ✅ Tree shaking (Vite elimina código no usado)
- ✅ Code splitting para componentes interactivos

---

## 4. Astro Islands

### ¿Qué son?

**Astro Islands** (o "Islands Architecture") es el patrón de arquitectura central de Astro. Una **isla** es un componente UI interactivo en una página mayormente estática.

### Concepto:
- La página se renderiza como HTML estático (cero JS)
- Solo los componentes con directivas `client:*` se "hidratan" en el cliente
- El resto de la página permanece como HTML estático ligero

### Directivas `client:*` disponibles:

| Directiva | Cuándo se hidrata |
|-----------|------------------|
| `client:load` | Inmediatamente al cargar la página |
| `client:idle` | Cuando el navegador está inactivo (requestIdleCallback) |
| `client:visible` | Cuando el componente es visible en el viewport (IntersectionObserver) |
| `client:media` | Cuando se cumple una media query específica |
| `client:only` | Solo en cliente (sin SSR). Requiere especificar el framework |

### Ejemplo:
```astro
---
import InteractiveButton from '../components/InteractiveButton.jsx';
import InteractiveCounter from '../components/InteractiveCounter.jsx';
---
<!-- Se hidrata inmediatamente -->
<InteractiveButton client:load />

<!-- Se hidrata solo cuando es visible -->
<InteractiveCounter client:visible />

<!-- Solo renderiza en cliente (sin SSR) -->
<InteractiveModal client:only="svelte" />
```

**Fuente:** https://docs.astro.build/en/concepts/islands
**Fuente:** https://docs.astro.build/en/guides/framework-components

### Impacto en rendimiento:

1. **Bundle JS mínimo**: Solo se envía al cliente el JS necesario para los componentes interactivos, no toda la página
2. **Carga diferida**: Los componentes pueden cargarse bajo demanda (cuando son visibles, cuando el navegador está idle, etc.)
3. **Aislamiento**: Cada isla es independiente; el JS de una no bloquea a las demás
4. **SSR + Partial Hydration**: Los componentes se pre-renderizan en el servidor y luego "se despiertan" en el cliente

Beneficio práctico: Sitios Astro con Islands cargan mucho más rápido que SPAs tradicionales porque la mayor parte del contenido es HTML estático, y solo los componentes interactivos añaden JS.

**Fuente:** https://docs.astro.build/en/tutorial/6-islands/1
**Fuente:** https://docs.astro.build/en/concepts/islands
