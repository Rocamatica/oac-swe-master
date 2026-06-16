# Crear y configurar un proyecto Hugo

**Proposito**: Guia paso a paso para crear un sitio Hugo desde cero usando OCA. Cubre el dialogo interactivo de configuracion, la seleccion de tema, la activacion de modulos HugoMods y la verificacion del sitio en local.

**Fecha**: 2026-06-16

**Aplica a**: REPON (proyecto clonado de REPOC) con herramientas instaladas

**Prerrequisito**: Herramientas instaladas segun [guia de inicio rapido](01_inicio-rapido.md).

---

## Indice

- [1. Iniciar un proyecto](#1-iniciar-un-proyecto)
- [2. Dialogo interactivo de configuracion](#2-dialogo-interactivo-de-configuracion)
- [3. Configurar hugo.toml](#3-configurar-hugotoml)
- [4. Anadir un tema](#4-anadir-un-tema)
- [5. Activar HugoMods](#5-activar-hugomods)
- [6. Primer build](#6-primer-build)
- [7. Flujo completo](#7-flujo-completo)
- [Ver tambien](#ver-tambien)

---

## 1. Iniciar un proyecto

Abre OCA y expresa tu intencion:

```
opencode --agent OpenAgent
> "Quiero crear un proyecto Hugo"
```

OCA ejecuta internamente `hugo new site <nombre>` para crear la estructura base del proyecto. Este comando genera:

```
<nombre>/
├── archetypes/
├── assets/
├── content/
├── data/
├── layouts/
├── static/
├── themes/
├── hugo.toml
└── ...
```

No es necesario que conozcas la estructura de Hugo; OCA la gestiona automaticamente.

---

## 2. Dialogo interactivo de configuracion

OCA no lanza un cuestionario fijo. Pregunta una cosa a la vez, adaptandose a las respuestas anteriores.

Orden tipico de preguntas:

| Orden | Pregunta | Ejemplo de respuesta |
|-------|----------|----------------------|
| 1 | "Como se llama el proyecto?" | `mi-blog-tecnico` |
| 2 | "Que titulo tendra el sitio?" | `Mi Blog Tecnico` |
| 3 | "Cual es la URL base?" | `https://miblog.ejemplo.com` |
| 4 | "En que idioma estara el sitio?" | `es` |

Cada respuesta determina el siguiente paso. Si el usuario ya ha definido algun campo, OCA lo omite y pasa al siguiente.

---

## 3. Configurar hugo.toml

Una vez recopilados los datos, OCA escribe `hugo.toml` con los valores proporcionados.

Campos principales que OCA configura:

| Campo | Descripcion | Ejemplo |
|-------|-------------|---------|
| `baseURL` | URL base del sitio en produccion | `https://miblog.ejemplo.com` |
| `title` | Titulo del sitio | `Mi Blog Tecnico` |
| `languageCode` | Idioma principal (ISO 639-1) | `es-ES` |
| `theme` | Lista de temas activos | `["mi-tema"]` |
| `params` | Parametros personalizados del tema | `{ description: "Blog sobre tecnologia" }` |
| `defaultContentLanguage` | Idioma por defecto para contenido | `es` |
| `paginate` | Numero de elementos por pagina | `10` |

Ejemplo de `hugo.toml` generado:

```toml
baseURL = "https://miblog.ejemplo.com"
title = "Mi Blog Tecnico"
languageCode = "es-ES"
defaultContentLanguage = "es"
theme = ["mi-tema"]
paginate = 10

[params]
  description = "Blog sobre tecnologia"
  author = "Tu nombre"
```

Si el proyecto necesita cambios posteriores, puedes decir "cambia la URL base a X" y OCA actualizara el fichero.

---

## 4. Anadir un tema

Para anadir un tema, di a OCA:

> "Quiero usar el tema X"

o

> "Aplica este tema: https://github.com/usuario/tema-hugo"

OCA realiza los siguientes pasos:

1. Pregunta el nombre o URL del tema (si no se proporciono en la peticion).
2. Instala el tema mediante `git clone` en `themes/` o `hugo mod init` si es un modulo.
3. Actualiza `hugo.toml` anadiendo el tema al campo `theme`.
4. Verifica que el tema se visualiza correctamente con un build de prueba.

Si el tema requiere configuracion adicional (parametros, menus, widgets), OCA pregunta los valores necesarios uno a uno.

---

## 5. Activar HugoMods

HugoMods es un ecosistema de modulos funcionales para Hugo. OCA puede activarlos bajo peticion.

Para activar un modulo, di:

> "Anade SEO al sitio"
> "Quiero iconos de Bootstrap"
> "Activa PWA"

OCA realiza:

1. Identifica el modulo solicitado (SEO, Images, PWA, Icons, etc.).
2. Anade el import del modulo en `hugo.toml`.
3. Configura las opciones basicas del modulo.
4. Verifica que el modulo funciona correctamente.

Modulos disponibles actualmente:

| Modulo | Que aporta | Como se activa |
|--------|------------|----------------|
| SEO | Meta tags, Open Graph, Twitter Cards, Schema | `"Anade SEO al sitio"` |
| Images | Procesamiento de imagenes desde Markdown | `"Activa el modulo de imagenes"` |
| PWA | Progressive Web App offline | `"Activa PWA"` |
| Icons | Iconos SVG (Bootstrap, FA, Material) | `"Quiero iconos de Bootstrap"` |

Consulta la [guia de gestion de contenido](04_gestion-contenido.md) para saber como crear paginas una vez configurado el proyecto.

---

## 6. Primer build

Para ver el sitio en funcionamiento, di a OCA:

> "Arranca el servidor de desarrollo"

OCA ejecuta:

```bash
hugo server -D
```

El servidor se inicia en `http://localhost:1313/`. El flag `-D` incluye contenido en draft (borrador) para previsualizacion.

Para construir el sitio para produccion:

> "Haz build del sitio"

OCA ejecuta:

```bash
hugo --minify --gc
```

El sitio generado se encuentra en `public/`.

Para desplegar en Cloudflare Pages, usa el comando `/hugo-deploy`:

```
/hugo-deploy
```

OCA ejecuta `hugo --minify --gc && wrangler pages deploy public/ --project-name=<nombre>` y confirma la URL de despliegue.

---

## 7. Flujo completo

Diagrama Mermaid del proceso completo desde la creacion del proyecto hasta el sitio funcionando:

```mermaid
flowchart TD
    A[Usuario: "Quiero crear un proyecto Hugo"] --> B[OCA verifica herramientas instaladas]
    B --> C{Herramientas OK?}
    C -->|No| D[OCA ejecuta install-tools.sh]
    D --> B
    C -->|Si| E[OCA pregunta nombre del proyecto]
    E --> F[OCA pregunta titulo]
    F --> G[OCA pregunta URL base]
    G --> H[OCA pregunta idioma]
    H --> I[OCA ejecuta: hugo new site <nombre>]
    I --> J[OCA escribe hugo.toml con los datos]
    J --> K{Usuario quiere tema?}
    K -->|Si| L[OCA pregunta tema y lo instala]
    L --> M[OCA actualiza hugo.toml]
    K -->|No| M
    M --> N{Usuario quiere modulos?}
    N -->|Si| O[OCA activa modulo solicitado]
    O --> P[OCA configura opciones del modulo]
    N -->|No| P
    P --> Q[OCA ejecuta: hugo server -D]
    Q --> R[Sitio funcionando en localhost:1313]
    R --> S{Desplegar?}
    S -->|Si| T[Usuario ejecuta /hugo-deploy]
    T --> U[OCA build + wrangler push]
    U --> V[Sitio en Cloudflare Pages]
    S -->|No| R
```

Pasos resumidos:

1. Usuario expresa intencion de crear proyecto.
2. OCA verifica herramientas instaladas (si faltan, las instala).
3. OCA recopila datos mediante preguntas adaptativas (una a la vez).
4. OCA ejecuta `hugo new site` y escribe `hugo.toml`.
5. Opcional: anadir tema y modulos HugoMods.
6. OCA arranca el servidor de desarrollo.
7. Opcional: desplegar con `/hugo-deploy`.

---

## Ver tambien

- [Inicio rapido -- De REPOC a primer sitio Hugo](01_inicio-rapido.md) -- Instalacion de herramientas y primeros pasos.
- [Gestion de contenido con OCA](04_gestion-contenido.md) -- Crear, editar y gestionar paginas una vez creado el proyecto.
- [Capacidades OCA para Hugo](../flujos/01_capacidades-oca-hugo.md) -- Catalogo completo de capacidades C1 a C10.
- [Seleccion de herramientas Hugo para OAC](../02_seleccion-herramientas-hugo-oac.md) -- Detalle de herramientas instaladas.
