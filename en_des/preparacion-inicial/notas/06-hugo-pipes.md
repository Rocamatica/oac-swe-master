# Hugo Pipes: Procesamiento de CSS, JS e imágenes

**Fuente**: `.opencode/external-context/hugo/`
**Contexto**: Proyecto PYT-SWE (OAC+Hugo)
**Fecha**: 2026-06-16

---

## ¿Qué es Hugo Pipes?

Es el sistema integrado de Hugo para procesar assets (CSS, JS, imágenes) **sin necesidad de Webpack, Vite, Gulp ni ninguna herramienta externa**. Usa esbuild internamente.

## Diferencia clave: assets/ vs static/

| Directorio | Qué ocurre |
|---|---|
| `static/` | Los archivos se copian **tal cual** a `public/`. Sin procesamiento. |
| `assets/` | Los archivos pasan por **Hugo Pipes** (Sass a CSS, minificar, fingerprint, etc.) |

## Operaciones disponibles

| Operación | Función | Para qué sirve |
|---|---|---|
| Sass a CSS | `css.Sass` | Convertir archivos `.scss` o `.sass` a CSS |
| PostCSS | `postCSS` | Procesar CSS con plugins PostCSS |
| TailwindCSS | `css.TailwindCSS` | Procesar CSS con Tailwind |
| Empaquetar JS | `js.Build` | Compilar JS con esbuild (imports, minify) |
| Minificar | `resources.Minify` | Comprimir CSS y JS |
| Fingerprint | `resources.Fingerprint` | Añadir hash al nombre para caché infinita |
| Procesar imágenes | `images.Process` | Redimensionar, convertir a WebP/AVIF |

## Ejemplo CSS con Sass

### Archivo fuente: `assets/css/main.scss`

```scss
$primary: #0066cc;

body {
  font-family: system-ui, sans-serif;
  color: $primary;
}
```

### En `layouts/partials/head.html`:

```go-html-template
{{ with resources.Get "css/main.scss" }}
  {{ $opts := dict
    "outputStyle" (cond hugo.IsDevelopment "expanded" "compressed")
    "targetPath" "css/main.css"
  }}
  {{ with . | css.Sass $opts }}
    {{ if hugo.IsDevelopment }}
      <link rel="stylesheet" href="{{ .RelPermalink }}">
    {{ else }}
      {{ with . | minify | fingerprint }}
        <link rel="stylesheet" href="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}">
      {{ end }}
    {{ end }}
  {{ end }}
{{ end }}
```

## Ejemplo JS con esbuild

### Archivo fuente: `assets/js/main.js`

```javascript
import './components/nav.js';
console.log('Sitio cargado');
```

### En `layouts/partials/head.html` (al final del body):

```go-html-template
{{ with resources.Get "js/main.js" }}
  {{ $opts := dict "minify" (not hugo.IsDevelopment) }}
  {{ with . | js.Build $opts }}
    {{ if hugo.IsDevelopment }}
      <script src="{{ .RelPermalink }}"></script>
    {{ else }}
      {{ with . | fingerprint }}
        <script src="{{ .RelPermalink }}" integrity="{{ .Data.Integrity }}"></script>
      {{ end }}
    {{ end }}
  {{ end }}
{{ end }}
```

## Desarrollo vs Producción

| Entorno | Comando | Comportamiento |
|---|---|---|
| Desarrollo | `hugo server` | Sass expandido, source maps, sin fingerprint, LiveReload |
| Producción | `hugo --minify --gc` | CSS comprimido, minificado, fingerprint, sin source maps |

Hugo detecta automáticamente el entorno con la variable `hugo.IsDevelopment`.

## Fingerprint (caché infinita)

El fingerprint añade un hash al nombre del archivo basado en su contenido:

```
main.css  →  main.a1b2c3d4.css
```

Si el contenido cambia, el hash cambia. El navegador interpreta que es un archivo nuevo y lo descarga. Si no cambia, usa la caché. Así consigues **caché infinita** sin problemas de actualización.

## Flujo visual

```
assets/css/main.scss
        │
        │  css.Sass (Sass → CSS)
        ▼
   CSS plano
        │
        │  resources.Minify (comprimir)
        ▼
   CSS minificado
        │
        │  resources.Fingerprint (hash)
        ▼
   main.a1b2c3.css
        │
        │  se copia a public/
        ▼
   public/css/main.a1b2c3.css
```

En la plantilla solo usas `.RelPermalink`. Hugo gestiona todo el pipeline automáticamente.
