# Modulos HugoMods

**Proposito**: Catalogo de modulos funcionales HugoMods disponibles en REPOC. Se activan como dependencias en `hugo.toml`, no requieren binarios externos. Cada modulo aporta una capacidad especifica al sitio Hugo.

**Fecha**: 2026-06-16

**Aplica a**: REPON -- los modulos se configuran en el proyecto clonado

**Prerrequisito**: Proyecto Hugo creado segun [guia de creacion de proyectos](02_crear-proyecto.md).

---

## Indice

- [1. Que son HugoMods](#1-que-son-hugomods)
- [2. Catalogo de modulos disponibles](#2-catalogo-de-modulos-disponibles)
- [3. Como activar un modulo](#3-como-activar-un-modulo)
- [4. Ejemplos de configuracion](#4-ejemplos-de-configuracion)
- [5. Referencia](#5-referencia)
- [Ver tambien](#ver-tambien)

---

## 1. Que son HugoMods

HugoMods es un ecosistema de modulos funcionales para Hugo, publicados bajo licencia MIT. No se instalan como binarios ni requieren npm. Se activan como dependencias en el fichero `hugo.toml` del proyecto.

### Caracteristicas

- Se anaden como imports en `hugo.toml`.
- No requieren instalacion de binarios adicionales.
- Se actualizan via `hugo mod get`.
- Cada modulo tiene su contexto de configuracion en `.opencode/external-context/hugo/hugomods-*.md`.
- OCA puede activarlos bajo peticion del usuario en lenguaje natural.

### Diferencia con otras herramientas

| Herramienta | Tipo | Instalacion | Proposito |
|-------------|------|-------------|-----------|
| HugoMods | Modulo Hugo | `hugo.toml` | Generar meta tags, procesar imagenes, anadir PWA, iconos, analytics |
| agentic-seo | CLI | npm global | Auditar visibilidad en agentes IA |
| seofor.dev | CLI | binario Go | Auditar SEO tecnico |

HugoMods SEO **genera** los meta tags; agentic-seo y seofor.dev los **auditan**. Son complementarios: uno produce, el otro verifica.

---

## 2. Catalogo de modulos disponibles

| Modulo | Para que sirve | Contexto de configuracion |
|--------|---------------|---------------------------|
| SEO | Meta tags Open Graph, Twitter Cards, Schema.org JSON-LD | `.opencode/external-context/hugo/hugomods-seo.md` |
| Images | Shortcodes para imagenes responsivas (WebP, AVIF, lazy loading) | `.opencode/external-context/hugo/hugomods-images.md` |
| PWA | Service worker, manifest.json, soporte offline | `.opencode/external-context/hugo/hugomods-pwa.md` |
| Icons | Iconos SVG inline (Bootstrap, Font Awesome, Material, Simple Icons) | `.opencode/external-context/hugo/hugomods-icons.md` |
| Analytics | Integracion con Google Analytics, Cloudflare, Umami, Plausible | `.opencode/external-context/hugo/hugomods-analytics.md` |
| Bootstrap | Framework CSS Bootstrap 5 via SCSS | `.opencode/external-context/hugo/hugomods-bootstrap.md` |

### Detalle por modulo

**SEO**

- Submodulos: Open Graph, Twitter Cards, Schema.org
- Funciona automaticamente desde el frontmatter de cada pagina
- No requiere shortcodes ni cambios en layouts

**Images**

- Shortcode `{{< img src="..." alt="..." >}}`
- Procesamiento: redimension, conversion a WebP/AVIF, lazy loading nativo
- Soporta pie de foto, clases CSS y enlace

**PWA**

- Service worker automatico
- Manifest.json con personalizacion de nombre, iconos y colores
- Estrategia de cache: Network First para paginas, Cache First para assets

**Icons**

- Shortcode `{{< icon name="..." >}}`
- Librerias: Bootstrap Icons, Font Awesome, Material Design, Simple Icons
- Salida: SVG inline (sin peticiones HTTP adicionales)

**Analytics**

- Proveedores: Google Analytics (GA4), Cloudflare Web Analytics, Umami, Plausible
- Se activa con un par de parametros en `hugo.toml`
- No tocar layouts: el modulo inyecta el codigo automaticamente

**Bootstrap**

- Framework CSS completo via SCSS
- Componentes: grid, navbars, cards, modales, formularios
- Personalizable con variables SCSS

---

## 3. Como activar un modulo

Para activar un modulo, anade un bloque `[[module.imports]]` en `hugo.toml` con la ruta del modulo.

### Estructura general

```toml
[[module.imports]]
path = "github.com/hugomods/<modulo>"
```

### Modulos con submodulos (SEO)

```toml
[[module.imports]]
path = "github.com/hugomods/seo/modules/twitter-cards"

[[module.imports]]
path = "github.com/hugomods/seo/modules/open-graph"

[[module.imports]]
path = "github.com/hugomods/seo/modules/schema"
```

### Activar con OCA

El usuario puede activar cualquier modulo con una frase en lenguaje natural:

| Frase | Modulo que se activa |
|-------|---------------------|
| "Anade SEO al sitio" | SEO (los 3 submodulos) |
| "Quiero iconos de Bootstrap" | Icons (Bootstrap) |
| "Activa PWA" | PWA |
| "Activa el modulo de imagenes" | Images |
| "Quiero analytics con Umami" | Analytics (Umami) |
| "Anade Bootstrap al proyecto" | Bootstrap |

OCA anade automaticamente las entradas en `hugo.toml` y configura los parametros basicos.

---

## 4. Ejemplos de configuracion

### SEO

```toml
[[module.imports]]
path = "github.com/hugomods/seo/modules/twitter-cards"

[[module.imports]]
path = "github.com/hugomods/seo/modules/open-graph"

[[module.imports]]
path = "github.com/hugomods/seo/modules/schema"

[params.seo]
enable = true
```

Sin necesidad de configuracion adicional. Los meta tags se generan desde el frontmatter de cada pagina:

```yaml
---
title: "Mi articulo"
description: "Descripcion para SEO"
images: ["/images/og-default.jpg"]
date: 2026-06-16
---
```

### Images

```toml
[[module.imports]]
path = "github.com/hugomods/images"
```

Uso en contenido Markdown:

```markdown
{{< img src="/images/foto.jpg" alt="Descripcion" width="800" >}}
```

### PWA

```toml
[[module.imports]]
path = "github.com/hugomods/pwa"

[params.pwa]
enable = true
name = "Mi Sitio"
short_name = "Sitio"
description = "Descripcion del sitio"
background_color = "#ffffff"
theme_color = "#000000"
display = "standalone"
start_url = "/"
```

### Icons

```toml
[[module.imports]]
path = "github.com/hugomods/icons/vendors/bootstrap"
```

Uso en layouts o contenido:

```markdown
{{< icon name="github" >}}
{{< icon name="twitter" >}}
{{< icon name="linkedin" >}}
```

### Analytics (Umami como ejemplo)

```toml
[[module.imports]]
path = "github.com/hugomods/analytics"

[params.analytics]
enable = true

[params.analytics.umami]
enable = true
data_site_id = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
src = "https://analytics.ejemplo.com/script.js"
```

### Bootstrap

```toml
[[module.imports]]
path = "github.com/hugomods/bootstrap"
```

Uso en layouts:

```html
<div class="container">
  <div class="row">
    <div class="col-md-6">
      <h2>{{ .Title }}</h2>
    </div>
  </div>
</div>
```

---

## 5. Referencia

Cada modulo tiene su contexto de configuracion detallado en ficheros independientes dentro de `.opencode/external-context/hugo/`. OCA carga estos contextos cuando el usuario solicita activar un modulo.

| Contexto | Contenido |
|----------|-----------|
| `hugomods-seo.md` | Configuracion de Open Graph, Twitter Cards y Schema.org |
| `hugomods-images.md` | Shortcodes de imagen, parametros de procesamiento |
| `hugomods-pwa.md` | Service worker, manifest, personalizacion |
| `hugomods-icons.md` | Librerias disponibles, shortcodes, ejemplos |
| `hugomods-analytics.md` | Configuraciones por proveedor (GA4, Cloudflare, Umami, Plausible) |
| `hugomods-bootstrap.md` | Activacion, variables SCSS, componentes |

OCA utiliza estos contextos para:

1. Saber que parametros preguntar al usuario.
2. Generar la configuracion correcta en `hugo.toml`.
3. Verificar que el modulo funciona despues de activarlo.

---

## Ver tambien

- [Skills y comandos de OCA](05_skills-comandos.md) -- Skills que gestionan la activacion de modulos (C8).
- [Calidad, SEO y busqueda en el sitio](06_calidad-seo-busqueda.md) -- Herramientas de auditoria complementarias a HugoMods SEO.
- [CMS visual con Decap CMS](07_cms-decap.md) -- CMS que se activa como modulo HugoMods.
- [Crear y configurar un proyecto Hugo](02_crear-proyecto.md) -- Activacion de modulos durante la creacion del proyecto.
- [Capacidades OCA para Hugo](../flujos/01_capacidades-oca-hugo.md) -- Capacidad C8: configurar modulos HugoMods.
