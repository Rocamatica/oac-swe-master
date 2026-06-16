---
source: Context7 API
library: Hugo
package: hugo
topic: Configuration
fetched: 2026-06-16T00:00:00Z
official_docs: https://gohugo.io/configuration/introduction/
---

# Configuración Base de Hugo (hugo.toml / hugo.yaml)

## Configuración Mínima

La configuración mínima de un proyecto Hugo se define en `hugo.toml` (o `hugo.yaml` / `hugo.json`) en la raíz del proyecto:

```toml
baseURL = 'https://example.org/'
locale = 'en-us'
title = 'My New Hugo Site'
```

### Configuración con Tema

```toml
baseURL = 'https://example.org/'
locale = 'en-us'
title = 'My New Hugo Site'
theme = ['mi-tema']
```

## Variables Principales de Configuración

| Variable | Descripción | Ejemplo |
|----------|-------------|---------|
| `baseURL` | URL base del sitio (debe incluir protocolo y terminar con /) | `https://example.org/` |
| `locale` | Locale del sitio | `en-us`, `es-es` |
| `title` | Título del sitio | `Mi Sitio Hugo` |
| `theme` | Tema(s) a usar (array o string) | `['mi-tema']` o `'mi-tema'` |
| `disableKinds` | Tipos de contenido a deshabilitar | `['taxonomy', 'term']` |
| `defaultContentLanguage` | Idioma por defecto | `en` |
| `defaultContentLanguageInSubdir` | Usar subdirectorio para idioma default | `true` / `false` |

## Configuración Multilingüe

### Single-host (mismo dominio para todos los idiomas)

```toml
defaultContentLanguage = 'de'
defaultContentLanguageInSubdir = true
disableDefaultLanguageRedirect = false

[languages.de]
contentDir = 'content/de'
direction = 'ltr'
disabled = false
label = 'Deutsch'
locale = 'de-DE'
title = 'Projekt Dokumentation'
weight = 1

[languages.de.params]
subtitle = 'Referenz, Tutorials und Erklärungen'

[languages.en]
contentDir = 'content/en'
direction = 'ltr'
disabled = false
label = 'English'
locale = 'en-US'
title = 'Project Documentation'
weight = 2

[languages.en.params]
subtitle = 'Reference, Tutorials, and Explanations'
```

### Multi-host (dominio distinto por idioma)

```toml
defaultContentLanguage = 'fr'

[languages.en]
baseURL = 'https://en.example.org/'
label = 'English'
title = 'In English'
weight = 2

[languages.fr]
baseURL = 'https://fr.example.org'
label = 'Français'
title = 'En Français'
weight = 1
```

## Configuración de Menús

```toml
[[menus.main]]
name = 'About'
pageRef = '/about'
weight = 10

[[menus.main]]
name = 'Contact'
pageRef = '/contact'
weight = 20

[[menus.main]]
name = 'Hugo'
url = 'https://gohugo.io'
weight = 30
[menus.main.params]
  rel = 'external'
```

## Configuración mediante Directorio `config/`

Para configuraciones más complejas o específicas por entorno, Hugo permite usar un directorio `config/` en lugar de un archivo único:

```
my-project/
├── config/
│   └── _default/
│       └── hugo.toml       # Configuración base
│   └── production/
│       └── hugo.toml       # Override para producción
│   └── staging/
│       └── hugo.toml       # Override para staging
├── ... (resto del proyecto)
```

```sh
# Construir con configuración de staging
hugo -e staging

# Construir con configuración de producción (default)
hugo
```

Hugo mergea las configuraciones: la de `_default/` es la base, y las de entornos específicos (`production/`, `staging/`, etc.) sobrescriben valores.

## Configuración de Módulos y Mounts

```toml
disableKinds = ["taxonomy", "term"]
defaultContentLanguage = "en"
defaultContentLanguageInSubdir = true

[languages]
[languages.en]
languageName = "English"
weight = 1
[languages.fr]
languageName = "Français"
weight = 2

[module]
[[module.mounts]]
source = "content"
target = "content"
[[module.mounts]]
source = "static"
target = "static"
```

## Deshabilitar Tipos de Contenido

```toml
# Deshabilitar RSS, sitemap, robotsTXT, 404, taxonomies y terms
baseURL = "http://example.org/"
disableKinds = ["RSS", "sitemap", "robotsTXT", "404", "taxonomy", "term"]
```

## Configuración de Despliegue

```toml
[deployment]
  order = ['.jpg$', '.gif$']
  [[deployment.matchers]]
    cacheControl = 'max-age=31536000, no-transform, public'
    gzip = true
    pattern = '^.+\.(js|css|svg|ttf)$'
  [[deployment.targets]]
    url = 's3://my_production_bucket?region=us-west-1'
    name = 'production'
  [[deployment.targets]]
    url = 's3://my_staging_bucket?region=us-west-1'
    name = 'staging'
```
