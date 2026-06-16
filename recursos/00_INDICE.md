# Índice de recursos

**Propósito**: Punto de entrada único a toda la documentación del proyecto dentro
de `recursos/`. Este índice cataloga y ordena los 14 documentos que definen los
fundamentos, la selección de herramientas, los flujos, el plan de
implementación y las guías de usuario del REPOC (repositorio base clonable OAC
\+ Hugo).

**Fecha**: 2026-06-16

**Aplica a**: REPOC (oac-swe-master) y sus clones REPON

---

## Índice de contenido

- [Estructura del directorio](#estructura-del-directorio)
- [Orden de lectura recomendado](#orden-de-lectura-recomendado)
- [Catálogo de archivos](#catálogo-de-archivos)
  - [Raíz `recursos/`](#raíz-recursos)
  - [Subcarpeta `flujos/`](#subcarpeta-flujos)
  - [Subcarpeta `guias/`](#subcarpeta-guias)
- [Mapa de dependencias](#mapa-de-dependencias)
- [Relación con otros directorios](#relación-con-otros-directorios)

---

## Estructura del directorio

```
recursos/
├── 00_INDICE.md                                       ← Este archivo
├── 01_recapitulacion-entendimiento-openagent.md       ← Fundacional
├── 02_seleccion-herramientas-hugo-oac.md              ← Catálogo de herramientas
├── 03_seleccion-herramientas-hugo-oac-validado.md     ← Herramientas validadas
├── 04_seleccion-herramientas-hugo-oac-no-validado.md  ← Herramientas excluidas
├── 05_plan-implementacion-repoc.md                    ← Plan de implementación
├── flujos/
│   └── 01_capacidades-oca-hugo.md                     ← Capacidades OCA
└── guias/
    ├── 00_INDICE.md                                    ← Índice de guías
    ├── 01_inicio-rapido.md
    ├── 02_crear-proyecto.md
    ├── 03_modulos-hugomods.md
    ├── 04_gestion-contenido.md
    ├── 05_skills-comandos.md
    ├── 06_calidad-seo-busqueda.md
    └── 07_cms-decap.md
```

---

## Orden de lectura recomendado

| Paso | Archivo | Subcarpeta | Tema |
|------|---------|------------|------|
| 1º | **01** | raíz | Fundamento conceptual del proyecto |
| 2º | **02** | raíz | Catálogo de herramientas seleccionadas |
| 3º | **03** | raíz | Herramientas validadas para instalación |
| 4º | **04** | raíz | Herramientas excluidas con razones |
| 5º | **01** | `flujos/` | Capacidades OCA para Hugo |
| 6º | **05** | raíz | Plan de implementación del REPOC |
| 7º–13º | **01–07** | `guias/` | Guías de usuario (ver orden en `guias/00_INDICE.md`) |

Los pasos 3 y 4 son intercambiables; ambos derivan del catálogo (paso 2).

---

## Catálogo de archivos

### Raíz `recursos/`

| N.º | Archivo | Ruta relativa | Finalidad | Dependencias | Resumen breve |
|-----|---------|---------------|-----------|--------------|---------------|
| 01 | `01_recapitulacion-entendimiento-openagent.md` | `recursos/01_recapitulacion-entendimiento-openagent.md` | Documento fundacional del proyecto | Ninguna (punto de entrada conceptual) | 278 líneas. Describe quién es OpenAgent, stack tecnológico (OAC + Hugo + Cloudflare), arquitectura de interacción, modelo REPOC→REPON (herencia), reglas (G1–G12), restricciones y prioridades. Incluye tabla de estado actual con 14 aspectos verificados. |
| 02 | `02_seleccion-herramientas-hugo-oac.md` | `recursos/02_seleccion-herramientas-hugo-oac.md` | Catálogo maestro de herramientas seleccionadas | [01](01_recapitulacion-entendimiento-openagent.md) (comprender el modelo REPOC) | 465 líneas. 24 herramientas evaluadas con criterios de selección (valor REPOC, integración OAC, madurez, licencia). 9 categorías: instalación, contenido, búsqueda, SEO/AEO, HugoMods, modelos arquitectónicos, CMS, despliegue, mapa de delegación. Referencia los flujos de capacidades. |
| 03 | `03_seleccion-herramientas-hugo-oac-validado.md` | `recursos/03_seleccion-herramientas-hugo-oac-validado.md` | Herramientas validadas para instalación | [02](02_seleccion-herramientas-hugo-oac.md) (subconjunto del catálogo) | 257 líneas. 15 herramientas validadas item por item con criterio REPOC/REPON. Validación detallada: valor para REPOC (contexto heredable), valor para REPON (capacidad operativa), verificación de no duplicidad, riesgos identificados. Base para la Fase 3 del plan. |
| 04 | `04_seleccion-herramientas-hugo-oac-no-validado.md` | `recursos/04_seleccion-herramientas-hugo-oac-no-validado.md` | Herramientas evaluadas y excluidas | [02](02_seleccion-herramientas-hugo-oac.md) (complemento del catálogo) | 75 líneas. 5 herramientas excluidas agrupadas por razón: duplicidad funcional (hugo-frontmatter-mcp, HugoMods Search), dependencia de diseño (HugoMods Docker), referencias arquitectónicas (Claude Blog, HugoBlox, Docsy). Incluye estado y explicación de cada exclusión. |
| 05 | `05_plan-implementacion-repoc.md` | `recursos/05_plan-implementacion-repoc.md` | Plan de implementación del REPOC | [03](03_seleccion-herramientas-hugo-oac-validado.md) (herramientas a instalar), [flujos/01](flujos/01_capacidades-oca-hugo.md) (capacidades a implementar) | 139 líneas. Checklist maestro con 6 fases: limpieza, actualización de documentos, instalación (3 lotes), skills/comandos/contextos/MCPs, validación, guías de usuario. Cada fase con items checkeados y fechas de ejecución. |

---

### Subcarpeta `flujos/`

| N.º | Archivo | Ruta relativa | Finalidad | Dependencias | Resumen breve |
|-----|---------|---------------|-----------|--------------|---------------|
| 01 | `01_capacidades-oca-hugo.md` | `recursos/flujos/01_capacidades-oca-hugo.md` | Catálogo de capacidades OCA para Hugo | [01](01_recapitulacion-entendimiento-openagent.md) (modelo REPOC), [02](02_seleccion-herramientas-hugo-oac.md) (herramientas que ejecutan cada capacidad) | 185 líneas. 10 capacidades C1–C10: cada una define disparador en lenguaje natural, artefacto OAC que la ejecuta, herramienta subyacente, preguntas necesarias y pasos. Incluye modelo de interacción sin orden fijo y principios de funcionamiento. |

---

### Subcarpeta `guias/`

| N.º | Archivo | Ruta relativa | Finalidad | Dependencias | Resumen breve |
|-----|---------|---------------|-----------|--------------|---------------|
| — | `00_INDICE.md` | `recursos/guias/00_INDICE.md` | Índice del subdirectorio `guias/` | Ninguna (es la entrada a guías) | Propósito, estructura, orden de lectura, catálogo detallado de las 7 guías con dependencias y mapa de relaciones. Consultar este archivo para el detalle completo de cada guía. |
| 01 | `01_inicio-rapido.md` | `recursos/guias/01_inicio-rapido.md` | Guía de inicio para clonar REPOC y verificar herramientas | Ninguna (punto de entrada a guías) | 229 líneas. Qué es REPOC, clonación, `install-tools.sh`, verificación de 8 herramientas, solución de problemas (venv, npm, Wrangler), arquitectura general con diagrama Mermaid. |
| 02 | `02_crear-proyecto.md` | `recursos/guias/02_crear-proyecto.md` | Crear sitio Hugo desde cero con OCA | [guias/01](guias/01_inicio-rapido.md) (herramientas instaladas) | 243 líneas. Diálogo interactivo, `hugo.toml`, temas, HugoMods, primer build, despliegue. Diagrama Mermaid del flujo completo. |
| 03 | `03_modulos-hugomods.md` | `recursos/guias/03_modulos-hugomods.md` | Activar módulos HugoMods | [guias/02](guias/02_crear-proyecto.md) (proyecto creado) | 277 líneas. 6 módulos (SEO, Images, PWA, Icons, Analytics, Bootstrap), sintaxis de activación, ejemplos de configuración, referencia a contextos externos. |
| 04 | `04_gestion-contenido.md` | `recursos/guias/04_gestion-contenido.md` | CRUD de páginas y assets con OCA | [guias/02](guias/02_crear-proyecto.md) (proyecto creado) | 320 líneas. Crear, listar, editar, eliminar páginas, subir imágenes, tipos de contenido, frontmatter, búsqueda con hugo-memex, ejemplo práctico completo, diagrama de secuencia Mermaid. |
| 05 | `05_skills-comandos.md` | `recursos/guias/05_skills-comandos.md` | Catálogo de skills y comandos OCA | Ninguna (referencia transversal) | 254 líneas. 7 skills (hugo-mcp-adapter, hugo-query, hugo-search-index, hugo-agentic-audit, hugo-seo-audit, hugo-audit-quality, hugo-cms-setup), comando `/hugo-deploy`, 18 frases de invocación, subagentes, árbol de decisión Mermaid. |
| 06 | `06_calidad-seo-busqueda.md` | `recursos/guias/06_calidad-seo-busqueda.md` | Auditorías e indexación del sitio | [guias/01](guias/01_inicio-rapido.md) (herramientas), [guias/05](guias/05_skills-comandos.md) (skills) | 324 líneas. Pagefind (búsqueda), agentic-seo (AEO), seofor.dev (SEO técnico), hugo-docs-mcp (calidad). Tabla de frecuencias, ejemplos de resultados, diagrama Mermaid del flujo build→index→audit→deploy. |
| 07 | `07_cms-decap.md` | `recursos/guias/07_cms-decap.md` | CMS visual Decap | [guias/02](guias/02_crear-proyecto.md) (proyecto), [guias/04](guias/04_gestion-contenido.md) (alternativa chat), repositorio GitHub, sitio desplegado | 293 líneas. Activación del módulo, `config.yml`, OAuth GitHub, acceso a `/admin/`, limitaciones. Diagrama Mermaid del flujo CMS→commit→deploy. |

---

## Mapa de dependencias

```
01_recapitulacion-entendimiento-openagent.md  (fundacional)
  │
  ├── 02_seleccion-herramientas-hugo-oac.md  (catálogo)
  │     ├── 03_seleccion-herramientas-hugo-oac-validado.md  (validación)
  │     │     └── 05_plan-implementacion-repoc.md  (plan)
  │     └── 04_seleccion-herramientas-hugo-oac-no-validado.md  (exclusión)
  │
  └── flujos/01_capacidades-oca-hugo.md  (capacidades)
              │
              └── guias/  (7 guías de usuario, orden en guias/00_INDICE.md)
```

Las fechas de los archivos incluyen el año para facilitar la localización
temporal de cada documento.

---

## Relación con otros directorios

| Directorio | Relación |
|------------|----------|
| `.opencode/skills/` | Las guías (05 y 06) referencian los 7 skills. `02_seleccion-herramientas-hugo-oac.md` describe el artefacto OAC de cada herramienta, que puede ser un skill. |
| `.opencode/command/` | El comando `/hugo-deploy` se describe en `guias/05_skills-comandos.md`. `05_plan-implementacion-repoc.md` registra su creación en Fase 4. |
| `.opencode/external-context/hugo/` | Los contextos HugoMods (`hugomods-*.md`) se referencian desde `guias/03_modulos-hugomods.md` y `02_seleccion-herramientas-hugo-oac.md`. |
| `.opencode/mcp/` | Los MCP servers (hugo-mcp, hugo-memex, hugo-docs-mcp) se mencionan en `guias/04_gestion-contenido.md`, `guias/06_calidad-seo-busqueda.md` y `03_seleccion-herramientas-hugo-oac-validado.md`. |
