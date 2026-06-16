# Índice de guías de usuario

**Propósito**: Punto de entrada único a la documentación de usuario del REPOC. Este
índice cataloga y ordena las 7 guías que explican cómo usar OCA para crear,
configurar, gestionar contenido, auditar calidad, desplegar y administrar un
sitio Hugo, desde la clonación del repositorio hasta el CMS visual.

**Fecha**: 2026-06-16

**Aplica a**: REPOC (oac-swe-master) y sus clones REPON

---

## Índice de contenido

- [Estructura del directorio](#estructura-del-directorio)
- [Orden de lectura recomendado](#orden-de-lectura-recomendado)
- [Catálogo de guías](#catálogo-de-guías)
  - [01 — Inicio rápido](#01--inicio-rápido)
  - [02 — Crear y configurar proyecto](#02--crear-y-configurar-proyecto)
  - [03 — Módulos HugoMods](#03--módulos-hugomods)
  - [04 — Gestión de contenido](#04--gestión-de-contenido)
  - [05 — Skills y comandos](#05--skills-y-comandos)
  - [06 — Calidad, SEO y búsqueda](#06--calidad-seo-y-búsqueda)
  - [07 — CMS visual Decap](#07--cms-visual-decap)
- [Mapa de dependencias](#mapa-de-dependencias)
- [Relación con otros recursos](#relación-con-otros-recursos)

---

## Estructura del directorio

```
recursos/guias/
├── 00_INDICE.md              ← Este archivo
├── 01_inicio-rapido.md       ← Clonar, instalar, verificar
├── 02_crear-proyecto.md      ← Crear sitio Hugo con OCA
├── 03_modulos-hugomods.md    ← Módulos funcionales HugoMods
├── 04_gestion-contenido.md   ← CRUD de páginas y assets
├── 05_skills-comandos.md     ← Catálogo de skills y /hugo-deploy
├── 06_calidad-seo-busqueda.md← Auditorías e indexación
└── 07_cms-decap.md           ← CMS visual Decap
```

No hay subcarpetas. Los 8 ficheros (índice + 7 guías) residen en la raíz del
directorio.

---

## Orden de lectura recomendado

Las guías están numeradas en orden lógico ascendente. Cada guía asume los
conceptos de las anteriores:

| Paso | Guía | Tema | ¿Qué obtienes? |
|------|------|------|----------------|
| 1º | **01** | Inicio rápido | REPOC clonado, herramientas instaladas |
| 2º | **02** | Crear proyecto | `hugo.toml`, tema, primer `hugo server` |
| 3º | **03** | HugoMods | SEO, PWA, imágenes, iconos, analytics |
| 4º | **04** | Gestión contenido | Páginas creadas y editadas vía OCA |
| 5º | **05** | Skills y comandos | Catálogo de referencia de cada skill |
| 6º | **06** | Calidad y SEO | Pagefind, auditorías pre-deploy |
| 7º | **07** | CMS Decap | Panel web para editores no técnicos |

Las guías **05** y **06** son intercambiables en orden: la primera es un
catálogo de referencia, la segunda describe herramientas de auditoría. Se
recomienda leer 05 antes de 06 porque 06 referencia los skills.

---

## Catálogo de guías

### 01 — Inicio rápido

| Campo | Valor |
|-------|-------|
| **Archivo** | `01_inicio-rapido.md` |
| **Ruta** | `recursos/guias/01_inicio-rapido.md` |
| **Líneas** | 229 |
| **Finalidad** | Guía de inicio para quien clona REPOC por primera vez |
| **Dependencias** | Ninguna (es el punto de entrada) |
| **Resumen** | Explica qué es REPOC, cómo clonarlo, ejecutar `install-tools.sh`, verificar cada herramienta, solucionar problemas comunes (venv, permisos npm, autenticación Wrangler) y muestra la arquitectura general con diagrama Mermaid. |

---

### 02 — Crear y configurar proyecto

| Campo | Valor |
|-------|-------|
| **Archivo** | `02_crear-proyecto.md` |
| **Ruta** | `recursos/guias/02_crear-proyecto.md` |
| **Líneas** | 243 |
| **Finalidad** | Crear un sitio Hugo desde cero con OCA |
| **Dependencias** | [01_inicio-rapido](01_inicio-rapido.md) (herramientas instaladas) |
| **Resumen** | Cubre el diálogo interactivo de OCA (nombre, título, URL, idioma), configuración de `hugo.toml`, instalación de temas, activación de HugoMods, primer build y despliegue con `/hugo-deploy`. Incluye diagrama Mermaid del flujo completo. |

---

### 03 — Módulos HugoMods

| Campo | Valor |
|-------|-------|
| **Archivo** | `03_modulos-hugomods.md` |
| **Ruta** | `recursos/guias/03_modulos-hugomods.md` |
| **Líneas** | 277 |
| **Finalidad** | Cataloga y explica cómo activar los 6 módulos HugoMods disponibles |
| **Dependencias** | [02_crear-proyecto](02_crear-proyecto.md) (proyecto Hugo creado) |
| **Resumen** | Describe cada módulo (SEO, Images, PWA, Icons, Analytics, Bootstrap), su sintaxis de activación en `hugo.toml`, ejemplos de configuración y cómo invocarlos con OCA en lenguaje natural. Relaciona HugoMods SEO con las herramientas de auditoría de la guía 06. |

---

### 04 — Gestión de contenido

| Campo | Valor |
|-------|-------|
| **Archivo** | `04_gestion-contenido.md` |
| **Ruta** | `recursos/guias/04_gestion-contenido.md` |
| **Líneas** | 320 |
| **Finalidad** | CRUD de páginas y assets mediante OCA |
| **Dependencias** | [02_crear-proyecto](02_crear-proyecto.md) (proyecto Hugo creado) |
| **Resumen** | Explica cómo crear, listar, editar y eliminar páginas y subir imágenes usando lenguaje natural. Detalla tipos de contenido, frontmatter y búsqueda con hugo-memex. Incluye un ejemplo práctico completo (crear un blog post) y diagrama Mermaid de secuencia con OCA, skill, MCP y Hugo. |

---

### 05 — Skills y comandos

| Campo | Valor |
|-------|-------|
| **Archivo** | `05_skills-comandos.md` |
| **Ruta** | `recursos/guias/05_skills-comandos.md` |
| **Líneas** | 254 |
| **Finalidad** | Catálogo de los 7 skills y el comando `/hugo-deploy` |
| **Dependencias** | Ninguna (guía de referencia transversal) |
| **Resumen** | Define qué son los skills, lista los 7 con su función, herramienta subyacente y capacidad OCA asociada. Detalla el comando `/hugo-deploy` con flags y flujo interno. Incluye tabla de frases de invocación (18 ejemplos) y árbol de decisión Mermaid que mapea intención del usuario al skill correspondiente. |

---

### 06 — Calidad, SEO y búsqueda

| Campo | Valor |
|-------|-------|
| **Archivo** | `06_calidad-seo-busqueda.md` |
| **Ruta** | `recursos/guias/06_calidad-seo-busqueda.md` |
| **Líneas** | 324 |
| **Finalidad** | Indexar búsqueda (Pagefind), auditar visibilidad IA (agentic-seo), SEO técnico (seofor.dev) y calidad del contenido (hugo-docs-mcp) |
| **Dependencias** | [01_inicio-rapido](01_inicio-rapido.md) (herramientas instaladas), [05_skills-comandos](05_skills-comandos.md) (skills que ejecutan las auditorías), [03_modulos-hugomods](03_modulos-hugomods.md) (HugoMods SEO genera meta tags que seofor.dev audita) |
| **Resumen** | Cubre las 4 herramientas de auditoría e indexación: Pagefind (post-build), agentic-seo (AEO), seofor.dev (SEO técnico), hugo-docs-mcp (calidad). Incluye tabla de frecuencias recomendadas, ejemplos de resultados y diagrama Mermaid del flujo de calidad build → index → audit → deploy. |

---

### 07 — CMS visual Decap

| Campo | Valor |
|-------|-------|
| **Archivo** | `07_cms-decap.md` |
| **Ruta** | `recursos/guias/07_cms-decap.md` |
| **Líneas** | 293 |
| **Finalidad** | Configurar Decap CMS como panel de administración visual |
| **Dependencias** | [02_crear-proyecto](02_crear-proyecto.md) (proyecto creado), [04_gestion-contenido](04_gestion-contenido.md) (alternativa vía chat), [05_skills-comandos](05_skills-comandos.md) (skill `hugo-cms-setup`) |
| **Resumen** | Explica qué es Decap CMS, requisitos (GitHub, repositorio, sitio desplegado), activación del módulo HugoMods, generación de `static/admin/config.yml`, configuración OAuth de GitHub y acceso al panel. Incluye tabla de limitaciones con alternativas y diagrama Mermaid del flujo CMS → commit → deploy. |

---

## Mapa de dependencias

```
01_inicio-rapido.md
  └── 02_crear-proyecto.md
        ├── 03_modulos-hugomods.md
        │     └── 06_calidad-seo-busqueda.md
        └── 04_gestion-contenido.md
              └── 07_cms-decap.md
05_skills-comandos.md ──── referencia transversal ────┐
                                                       ├── 06_calidad-seo-busqueda.md
                                                       └── 07_cms-decap.md
```

Las dependencias indican qué guía debe leerse antes para entender los
conceptos previos. Las guías 05 (skills) y 06 (calidad) son intercambiables
en orden; 06 referencia 05.

---

## Relación con otros recursos

| Recurso | Relación |
|---------|----------|
| `recursos/flujos/capacidades-oca-hugo.md` | Las guías referencian las capacidades C1–C10. Este documento las cataloga. |
| `recursos/seleccion-herramientas-hugo-oac.md` | Detalle de cada herramienta y criterios de selección. Las guías asumen este conocimiento. |
| `recursos/seleccion-herramientas-hugo-oac-validado.md` | Lista de herramientas validadas para instalación. |
| `recursos/plan-implementacion-repoc.md` | Fase 6 del plan corresponde a la creación de estas guías. |
| `.opencode/external-context/hugo/hugomods-*.md` | Contextos de configuración detallada de cada módulo HugoMods (referenciados desde la guía 03). |
| `.opencode/skills/*/SKILL.md` | Definiciones formales de cada skill (referenciados desde la guía 05). |
