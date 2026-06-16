# Inicio rapido -- De REPOC a primer sitio Hugo

**Proposito**: Guia de inicio para desarrolladores que clonan REPOC (repositorio base clonable) y quieren arrancar un proyecto Hugo con OCA. Explica desde la clonacion hasta la verificacion de herramientas, sin entrar en la creacion del proyecto.

**Fecha**: 2026-06-16

**Aplica a**: REPOC (oac-swe-master) basado en OAC + Hugo + Cloudflare Pages

---

## Indice

- [1. Que es REPOC](#1-que-es-repoc)
- [2. Clonar el repositorio](#2-clonar-el-repositorio)
- [3. Instalar herramientas](#3-instalar-herramientas)
- [4. Primer proyecto](#4-primer-proyecto)
- [5. Verificar instalacion](#5-verificar-instalacion)
- [6. Solucion de problemas comunes](#6-solucion-de-problemas-comunes)
- [7. Arquitectura general](#7-arquitectura-general)
- [Ver tambien](#ver-tambien)

---

## 1. Que es REPOC

REPOC es el **repositorio base clonable** de OAC para Hugo. No contiene un sitio web especifico, sino la fabrica que construye sitios Hugo.

| Concepto | Descripcion |
|----------|-------------|
| **REPOC** | Este repositorio. Contiene la configuracion de OCA, skills, herramientas y recursos reutilizables. |
| **REPON** | El proyecto que se crea al clonar REPOC. Aqui vivira el sitio Hugo. |
| **Herencia** | Solo `.opencode/` y `recursos/` se heredan al clonar. El resto (ej. `en_des/`) permanece en REPOC. |
| **OCA** | OpenAgent, el asistente IA que interpreta tus intenciones y delega en skills, MCPs y herramientas. |

Modelo de herencia REPOC a REPON:

```
REPOC (este repositorio)              REPON (nuevo proyecto)
     │                                       │
     │  git clone                            │
     ├───────────────────────────────────────┤
     │                                       │
     ├── .opencode/       ──hereda──>        ├── .opencode/    (base + ajustes)
     ├── recursos/        ──hereda──>        ├── recursos/     (base + ajustes)
     ├── en_des/          ──NO hereda        ├── (proyecto Hugo)
     └── reglas-*.txt     ──NO hereda        └── (archivos propios)
```

---

## 2. Clonar el repositorio

Abre un terminal y ejecuta:

```bash
git clone <url-del-repositorio>
cd <directorio-clonado>
```

Sustituye `<url-del-repositorio>` por la URL de REPOC (HTTPS o SSH) y `<directorio-clonado>` por el nombre del directorio donde se clono.

Despues de clonar, la estructura incluye:

```
<directorio>/
├── .opencode/         # Configuracion OAC, skills, comandos, contexto
├── recursos/          # Documentacion, guias, flujos
├── en_des/            # Material en desarrollo (no se hereda)
├── README.md          # Documentacion principal
└── reglas-abreviaciones.txt  # Reglas del proyecto (no se heredan)
```

---

## 3. Instalar herramientas

REPOC incluye un script de instalacion automatizada. Ejecutalo desde la raiz del repositorio clonado:

```bash
bash .opencode/scripts/install-tools.sh
```

### Que instala el script

| Categoria | Herramienta | Tipo de instalacion |
|-----------|-------------|---------------------|
| SSG | hugo-extended | npm global |
| Busqueda | Pagefind | npm global |
| Auditoria AEO | agentic-seo | npm global |
| Auditoria SEO | seofor.dev | binario Go |
| Despliegue | wrangler (Cloudflare Pages) | npm global |
| MCP contenido | hugo-mcp (jmrGrav) | Python venv en `.opencode/mcp/hugo-mcp-src/venv/` |
| MCP busqueda | hugo-memex (queelius) | Python venv en `.opencode/mcp/hugo-memex-src/venv/` |
| MCP auditoria | hugo-docs-mcp (danfinn5) | Go build en `.opencode/mcp/hugo-docs-mcp-src/` |

El script tambien crea los entornos virtuales Python necesarios para los MCPs que requieren dependencias.

---

## 4. Primer proyecto

Una vez instaladas las herramientas, abre OCA:

```bash
opencode --agent OpenAgent
```

Dentro de OCA, di:

> "Quiero crear un proyecto Hugo"

OCA iniciara un dialogo interactivo en el que preguntara una cosa a la vez: nombre del proyecto, titulo, URL base e idioma. No necesitas conocer la configuracion de Hugo de antemano; OCA la genera automaticamente.

Para mas detalles sobre el proceso de creacion, consulta la [guia de creacion de proyectos](02_crear-proyecto.md).

---

## 5. Verificar instalacion

Ejecuta estos comandos para comprobar que cada herramienta esta operativa:

| Herramienta | Comando de verificacion | Salida esperada |
|-------------|-------------------------|-----------------|
| Hugo | `hugo version` | `hugo v0.163.2+extended ...` |
| Pagefind | `pagefind --version` | `pagefind 1.5.2` |
| agentic-seo | `agentic-seo --version` | `1.0.0` |
| seofor.dev | `seo --version` | `3.0.1` |
| wrangler | `wrangler --version` | `4.101.0` |
| hugo-mcp venv | `ls .opencode/mcp/hugo-mcp-src/venv/bin/python` | Fichero existente |
| hugo-memex venv | `ls .opencode/mcp/hugo-memex-src/venv/bin/python` | Fichero existente |

Si alguna herramienta no aparece, ejecuta de nuevo el script de instalacion o instala la herramienta manualmente.

---

## 6. Solucion de problemas comunes

### venv no encontrado

```
ERROR: hugo-mcp venv → NO CREADO
```

Causa: el script no encontro el directorio fuente del MCP. Solucion:

```bash
git clone https://github.com/jmrGrav/hugo-mcp.git .opencode/mcp/hugo-mcp-src
git clone https://github.com/queelius/hugo-memex.git .opencode/mcp/hugo-memex-src
```

Despues, ejecuta de nuevo `bash .opencode/scripts/install-tools.sh`.

### npm permission errors

```
Error: EACCES: permission denied, unlink '/usr/local/lib/node_modules/...'
```

Causa: npm intenta escribir en un directorio sin permisos de escritura. Soluciones:

- Usar `npm install -g` con `sudo` (no recomendado).
- Configurar npm para usar un directorio local:

```bash
npm config set prefix ~/.npm-global
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

### wrangler no autenticado

```
Error: You must be logged in to use Wrangler.
```

Causa: wrangler requiere autenticacion contra Cloudflare. Solucion:

```bash
wrangler login
```

Esto abre un navegador para iniciar sesion en Cloudflare. Si el codespace no tiene navegador, usa:

```bash
wrangler login --browser=false
```

Sigue las instrucciones en terminal para copiar el token de autenticacion.

---

## 7. Arquitectura general

Diagrama de flujo: desde la peticion del usuario hasta la generacion del sitio Hugo.

```mermaid
flowchart LR
    U[Usuario] -->|intencion en lenguaje natural| OCA[OpenAgent OCA]
    OCA -->|analiza y delega| SK[Skill]
    OCA -->|ejecuta comando| CM[/hugo-deploy]
    OCA -->|invoca subagente| SA[Subagente especializado]
    SK -->|usa MCP| MCP[MCP Server<br/>hugo-mcp / hugo-memex]
    SK -->|ejecuta CLI| CLI[Herramienta CLI<br/>hugo-extended / pagefind]
    SA --> MCP
    MCP -->|opera sobre| HUGO[Hugo SSG]
    CLI --> HUGO
    CM -->|build + deploy| WR[Wrangler<br/>Cloudflare Pages]
    HUGO -->|genera| SITIO[Sitio estatico]
    SITIO --> WR
    WR -->|publica| PROD[Produccion<br/>*.pages.dev]
```

Flujo tipico de una peticion:

1. El usuario expresa una intencion en lenguaje natural (ej. "crea una pagina de contacto").
2. OCA analiza la peticion y selecciona la capacidad adecuada.
3. OCA delega en una skill, subagente o comando segun corresponda.
4. La skill invoca la herramienta o MCP correspondiente.
5. La herramienta opera sobre Hugo (crea ficheros, genera el sitio, etc.).
6. OCA verifica el resultado y confirma al usuario.

---

## Ver tambien

- [Crear y configurar un proyecto Hugo](02_crear-proyecto.md) -- Proceso detallado de creacion de un sitio Hugo con OCA.
- [Gestion de contenido con OCA](04_gestion-contenido.md) -- Como crear, editar, buscar y eliminar contenido usando lenguaje natural.
- [Capacidades OCA para Hugo](../flujos/01_capacidades-oca-hugo.md) -- Catalogo completo de capacidades de OCA para gestionar sitios Hugo.
- [Seleccion de herramientas Hugo para OAC](../02_seleccion-herramientas-hugo-oac.md) -- Detalle de cada herramienta seleccionada y criterios de eleccion.
