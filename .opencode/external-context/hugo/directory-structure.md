---
source: Context7 API
library: Hugo
package: hugo
topic: Directory Structure
fetched: 2026-06-16T00:00:00Z
official_docs: https://gohugo.io/getting-started/directory-structure/
---

# Estructura de Directorios de un Proyecto Hugo

## Estructura por Defecto (generada por `hugo new site`)

```
my-project/
├── archetypes/
│   └── default.md
├── assets/
├── content/
├── data/
├── i18n/
├── layouts/
├── static/
├── themes/
└── hugo.toml         # ← Archivo de configuración del proyecto
```

## Estructura Después del Build (`hugo`)

Al construir el sitio, Hugo genera dos directorios adicionales:

```
my-project/
├── archetypes/
│   └── default.md
├── assets/
├── config/
│   └── _default/
│       └── hugo.toml    # ← Configuración (alternativa a hugo.toml en raíz)
├── content/
├── data/
├── i18n/
├── layouts/
├── public/               # ← CREADO AL BUILD: sitio generado (HTML, CSS, JS)
├── resources/            # ← CREADO AL BUILD: assets cacheados optimizados
├── static/
└── themes/
```

## Propósito de Cada Directorio

### `archetypes/`
Plantillas para nuevo contenido. Cuando ejecutas `hugo new content posts/mi-post.md`, Hugo usa el archetype correspondiente para pre-poblar el archivo con front matter y estructura.

### `assets/`
Archivos que necesitan ser procesados por Hugo (ej: Sass/SCSS, TypeScript, imágenes a optimizar). Se accede a ellos mediante `resources.Get`. Ejemplos:
- `assets/css/main.scss` (procesado por Hugo Pipes)
- `assets/js/main.js` (procesado/empaquetado por Hugo Pipes)
- `assets/img/logo.png` (procesado con image processing)

### `content/`
Todo el contenido del sitio en Markdown (u otros formatos como HTML, AsciiDoc, etc.). La estructura de este directorio define la estructura del sitio web.

```
content/
├── _index.md              # Página de inicio (home page)
├── about.md               # Página "about" (single page)
├── posts/                 # Sección "posts"
│   ├── _index.md          # Listado de posts
│   ├── mi-primer-post.md  # Post individual
│   └── post-con-imagenes/
│       ├── index.md       # Page bundle con recursos
│       └── cover.jpg
└── products/              # Sección "products"
    └── ... 
```

### `data/`
Archivos de datos estructurados (JSON, TOML, YAML) accesibles desde las plantillas mediante `.Site.Data`. Útil para contenido que no cambia frecuentemente.

```
data/
└── mytheme/
    └── foo.json
```

### `i18n/`
Archivos de internacionalización (traducciones). Contiene archivos de idioma que Hugo usa para traducir strings en las plantillas.

```
i18n/
├── en.toml
├── es.toml
└── fr.toml
```

### `layouts/`
Plantillas HTML (Go templates) que definen cómo se renderiza el contenido. Hugo busca aquí primero, luego en los temas.

```
layouts/
├── _default/
│   ├── baseof.html        # Plantilla base (estructura HTML común)
│   ├── list.html          # Plantilla para páginas de listado
│   ├── single.html        # Plantilla para páginas individuales
│   └── home.html          # Para la página de inicio
├── partials/
│   ├── head.html
│   ├── header.html
│   └── footer.html
├── posts/
│   ├── list.html          # Listado específico para sección posts
│   └── single.html        # Post individual específico
└── index.html             # Home page template
```

### `static/`
Archivos estáticos que se copian directamente al directorio `public/` sin ningún procesamiento (imágenes, PDFs, favicons, fuentes, etc.).

```
static/
├── images/
│   ├── logo.png
│   └── favicon.ico
├── css/
│   └── custom.css
└── robots.txt
```

### `themes/`
Temas instalados como submódulos de git o descargados. Cada tema es un proyecto Hugo completo con sus propios `layouts/`, `assets/`, `i18n/`, etc.

```
themes/
├── ananke/
├── hugo-book/
└── papermod/
```

### `public/` (generado)
Directorio de salida con el sitio HTML estático generado. Esto es lo que se despliega al servidor web. Se crea al ejecutar `hugo`.

### `resources/` (generado)
Directorio de caché para assets procesados (imágenes optimizadas, CSS compilado, JS empaquetado). Se regenera automáticamente.

### `config/` (alternativa a hugo.toml)
Para configuraciones complejas, Hugo permite usar un directorio `config/`:

```
config/
└── _default/
    └── hugo.toml          # Configuración base
└── production/
    └── hugo.toml          # Override para producción
└── staging/
    └── hugo.toml          # Override para staging
```

## Los 7 Tipos de Componentes de Hugo (Módulos)

Hugo reconoce 7 tipos de componentes que pueden ser montados tanto desde el proyecto como desde temas/módulos:

1. **`static`** → Archivos estáticos (copia directa)
2. **`content`** → Contenido (Markdown, etc.)
3. **`layouts`** → Plantillas
4. **`data`** → Archivos de datos
5. **`assets`** → Assets procesables
6. **`i18n`** → Traducciones
7. **`archetypes`** → Plantillas de contenido

## Estructura de Secciones en `content/`

Cada directorio de primer nivel en `content/` es una **sección**. Las secciones pueden tener subsecciones:

```
content/
├── articles/             # section (directorio de nivel superior)
│   ├── 2022/
│   │   ├── article-1/
│   │   │   ├── cover.jpg
│   │   │   └── index.md
│   │   └── article-2.md
│   └── 2023/
│       ├── article-3.md
│       └── article-4.md
├── products/             # section
│   ├── product-1/        # section (tiene _index.md)
│   │   ├── _index.md
│   │   ├── benefits/     # section
│   │   │   ├── _index.md
│   │   │   ├── benefit-1.md
│   │   │   └── benefit-2.md
│   │   └── features/
│   │       ├── _index.md
│   │       ├── feature-1.md
│   │       └── feature-2.md
│   └── product-2/
│       └── ...
├── _index.md
└── about.md
```

Cada sección puede tener un archivo `_index.md` que define el contenido y front matter para la página de listado de esa sección.
