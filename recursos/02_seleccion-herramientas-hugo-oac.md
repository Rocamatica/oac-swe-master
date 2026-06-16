# Selección curada de herramientas Hugo para OAC

**Propósito**: Catálogo seleccionado de herramientas, MCP servers, módulos y servicios del ecosistema Hugo que OAC (OpenAgent) usará mediante delegación. Cada entrada define el artefacto OAC concreto que la envuelve y cómo OCA decide usarla según la intención del usuario.

**Fecha**: 2026-06-16

**Fuente**: Investigación original del ecosistema Hugo (2026-06-15)

**Principio**: No reinventar. Aprovechar lo existente. OCA orquesta delegando en skills, MCPs, módulos y herramientas probadas.

---

## Criterios de selección

| Criterio | Peso | Explicación |
|----------|------|-------------|
| **Valor para REPOC** | Alto | ¿Ayuda a construir la fábrica clonable? |
| **Integrable con OAC** | Alto | ¿Puede OCA delegar en ello mediante task/bash/subagente? |
| **Madurez** | Medio | ¿Está activo, mantenido y con comunidad? |
| **Licencia** | Medio | MIT / Apache 2.0 / Open Source preferido. Evitar SaaS propietario |
| **No reinventa** | Alto | ¿Ya resuelve el problema mejor de lo que podríamos hacerlo? |

---

## Índice de categorías

- [1. Instalación y entorno](#1-instalación-y-entorno)
- [2. Gestión de contenido (MCP)](#2-gestión-de-contenido-mcp)
- [3. Búsqueda en sitio](#3-búsqueda-en-sitio)
- [4. SEO, AEO y visibilidad IA](#4-seo-aeo-y-visibilidad-ia)
- [5. Módulos funcionales HugoMods](#5-módulos-funcionales-hugomods)
- [6. Modelos arquitectónicos (referencia)](#6-modelos-arquitectónicos-referencia)
- [7. CMS y edición visual](#7-cms-y-edición-visual)
- [8. Despliegue](#8-despliegue)
- [9. Mapa de delegación OCA](#9-mapa-de-delegación-oca)

---

## 1. Instalación y entorno

### 1.1 hugo-extended (npm)

| Campo | Valor |
|-------|-------|
| **Qué es** | Binary wrapper para Hugo Extended con TypeScript type-safe. 212.500+ descargas semanales |
| **URL** | https://www.npmjs.com/package/hugo-extended |
| **Licencia** | MIT |
| **Madurez** | Muy activo (v0.154.5, Jun 2026) |

**Artefacto OAC**: Comando `/hugo-install` + Context file de referencia

**Integración**:
- OCA verifica si `hugo-extended` está instalado vía npm
- Si no → OCA ejecuta `npm install -g hugo-extended`
- Si sí → OCA verifica versión vs última disponible
- El contexto en `.opencode/external-context/hugo/` documenta la versión y uso

**Flujo**: Instalación inicial — cuando el usuario solicita crear un proyecto Hugo

**Seleccionado**: ✅ Sí. Evita gestionar binarios manualmente, da tipado TypeScript.


---

## 2. Gestión de contenido (MCP)

### 2.1 hugo-mcp (jmrGrav)

| Campo | Valor |
|-------|-------|
| **Qué es** | MCP server completo para gestión de sitios Hugo desde IA. 10 herramientas: CRUD páginas, build, assets, SRI |
| **URL** | https://github.com/jmrGrav/hugo-mcp |
| **Licencia** | MIT |
| **Madurez** | Muy activo (v2.1.0, mayo 2026, 12 releases en 2 semanas) |

**Artefacto OAC**: Subagente "HugoMCPSpecialist" + Skill de invocación

**Integración**:
```
Usuario: "Crea un artículo sobre X"
    ↓
OCA recibe la instrucción
    ↓
OCA delega en HugoMCPSpecialist (subagente)
    ↓
Subagente invoca hugo-mcp: create_page("articulo-x", ...)
    ↓
hugo-mcp ejecuta: crea archivo .md + reconstruye + purga CF
    ↓
Subagente devuelve resultado a OCA
    ↓
OCA resume al usuario
```

**Flujo**: Creación y edición de contenido — cuando el usuario pide crear/modificar páginas

**Seleccionado**: ✅ Sí. Es el MCP más completo y activo. La pieza central para que OCA gestione contenido sin tocar archivos manualmente.

---

### 2.2 hugo-memex (queelius)

| Campo | Valor |
|-------|-------|
| **Qué es** | MCP server que indexa contenido Hugo en SQLite con FTS5. Búsqueda semántica, consultas SQL, sugerencia de tags |
| **URL** | https://github.com/queelius/hugo-memex |
| **Licencia** | Sin confirmar (código disponible) |
| **Madurez** | Activo (marzo 2026) |

**Artefacto OAC**: Skill "hugo-query" (search + analysis)

**Integración**:
- OCA lo usa para consultar contenido existente antes de crear/editar
- Búsqueda semántica para encontrar contenido relacionado
- Sugerencia de tags basada en FTS5
- Validación de contenido (completitud, referencias cruzadas)

**Flujo**: Mantenimiento continuo — búsqueda y validación de contenido

**Seleccionado**: ✅ Sí. Complementa a hugo-mcp añadiendo capacidad de consulta semántica.

---

### 2.3 hugo-docs-mcp (danfinn5) — *Selección condicional*

| Campo | Valor |
|-------|-------|
| **Qué es** | MCP server para auditoría de documentación: validación de frontmatter, verificación de enlaces, scaffolding |
| **URL** | https://github.com/danfinn5/hugo-docs-mcp |
| **Licencia** | Sin confirmar |
| **Madurez** | Activo (marzo 2026) |

**Artefacto OAC**: Skill "hugo-audit-quality"

**Integración**:
- Auditoría de antigüedad del contenido
- Detección de contenido duplicado
- Verificación de enlaces rotos
- Actualización masiva de frontmatter

**Seleccionado**: ⏳ Condicional. Valor alto pero solapa parcialmente con hugo-mcp + hugo-memex. Evaluar cuando se necesiten funciones específicas de auditoría.

---

### 2.4 hugo-frontmatter-mcp (wdm0006) — *No seleccionado*

| Razón | Detalle |
|-------|---------|
| **Solapamiento** | Las operaciones de frontmatter (get/set tags, fechas, etc.) están cubiertas por hugo-mcp |
| **Alcance limitado** | Solo frontmatter, sin CRUD de contenido completo |
| **Valor marginal** | Bajo una vez que se tiene hugo-mcp |

**Seleccionado**: ❌ No. Sus funciones quedan cubiertas por hugo-mcp (seleccionado).

---

## 3. Búsqueda en sitio

### 3.1 Pagefind

| Campo | Valor |
|-------|-------|
| **Qué es** | Herramienta de post-build indexing para búsqueda en sitios estáticos. ~10KB JS + ~75KB WASM. Multilingüe. Estándar de facto 2026 |
| **URL** | https://pagefind.app/ |
| **Licencia** | MIT |
| **Madurez** | Muy activo |

**Artefacto OAC**: Skill "hugo-search-index" (post-build step)

**Integración**:
- OCA ejecuta Pagefind después de cada build (`hugo --minify --gc && npx pagefind`)
- Configuración de indexing por idioma/section
- OCA puede consultar el índice para responder preguntas del usuario sobre contenido

**Flujo**: Post-build — después de generar el sitio, indexar contenido para búsqueda

**Seleccionado**: ✅ Sí. Estándar 2026, MIT, ligero. Mejor opción para búsqueda en sitios Hugo.

---

## 4. SEO, AEO y visibilidad IA

### 4.1 agentic-seo (addyosmani)

| Campo | Valor |
|-------|-------|
| **Qué es** | Auditoría de sitios para visibilidad en agentes IA (AEO - Agentic Engine Optimization). Verifica robots.txt, llms.txt, AGENTS.md, simulación de crawlers IA |
| **URL** | https://github.com/addyosmani/agentic-seo |
| **Licencia** | Sin confirmar (código disponible) |
| **Madurez** | Muy reciente (abril 2026). Autor: Addy Osmani (Google Chrome) |

**Artefacto OAC**: Skill "hugo-agentic-audit"

**Integración**:
- OCA ejecuta agentic-seo contra el sitio en desarrollo o producción
- Verifica que el sitio sea correctamente interpretado por ChatGPT, Claude, Gemini, Perplexity
- Genera reporte de visibilidad IA
- Sugiere correcciones (llms.txt, robots.txt, etc.)

**Flujo**: Post-build / pre-deploy (calidad)

**Seleccionado**: ✅ Sí. Directamente alineado con el objetivo de REPOC: sitios que funcionan para humanos Y agentes IA.

---

### 4.2 seofor.dev

| Campo | Valor |
|-------|-------|
| **Qué es** | CLI de auditoría SEO con exportación "AI-Ready". Crawling local, IndexNow, exportación a prompts para Claude/Cursor/ChatGPT |
| **URL** | https://github.com/ugolbck/seofordev |
| **Licencia** | Otra (NOASSERTION) |
| **Madurez** | Activo (v3.0.1, febrero 2026) |

**Artefacto OAC**: Skill "hugo-seo-audit"

**Integración**:
- OCA ejecuta auditoría SEO local
- OCA interpreta el reporte y sugiere mejoras al usuario
- Exportación AI-Ready permite que OCA entienda los resultados

**Flujo**: Post-build (auditoría previa a publicación)

**Seleccionado**: ✅ Sí. Complementa a agentic-seo: uno enfocado en AEO, otro en SEO técnico.

---

### 4.3 HugoMods SEO — *Ver sección 5*

Incluido en el ecosistema HugoMods (sección siguiente). Cubre generación de meta tags, Open Graph, Twitter Cards y Schema desde el lado del template.

---

## 5. Módulos funcionales HugoMods

### 5.1 Ecosistema HugoMods

| Campo | Valor |
|-------|-------|
| **Qué es** | Ecosistema de 25+ módulos Hugo para SEO, imágenes, búsqueda, PWA, iconos, analytics, Bootstrap, etc. |
| **URL** | https://hugomods.com/ |
| **Licencia** | MIT (todos los módulos) |
| **Madurez** | Muy activo (actualizado semanalmente en 2026) |

**Artefacto OAC**: Context files + Templates de configuración

**Módulos seleccionados**:

| Módulo | ¿Seleccionado? | Artefacto OAC | Por qué |
|--------|---------------|---------------|---------|
| **SEO** | ✅ Sí | Context file (configuración) | Meta tags, OG, Twitter Cards, Schema. Estándar para cualquier sitio |
| **Images** | ✅ Sí | Context file (shortcodes) | Procesamiento de imágenes vía URL desde Markdown. Útil para contenido |
| **Search** | ⏳ Condicional | Template de configuración | Solapado con Pagefind (seleccionado). Evaluar si se necesita Fuse.js además |
| **PWA** | ✅ Sí | Context file (guía de configuración) | Progressive Web App offline. Añade valor a cualquier sitio |
| **Icons** | ✅ Sí | Context file (referencia) | SVG icons (Bootstrap, FA, Material, Simple Icons). Útil para layouts |
| **Analytics** | ⏳ Condicional | Template | Google Analytics, Cloudflare, Umami. Solo si el proyecto los requiere |
| **Bootstrap** | ❌ No | — | Framework CSS. Depende de decisión de diseño del proyecto |
| **Decap CMS** | ✅ Sí | Skill "hugo-cms-setup" (ver sección 7) | CMS Git-based. Ver sección específica |
| **Docker** | ⏳ Condicional | Template | Imágenes Docker. Solo si el despliegue lo requiere |

**Integración general**:
- OCA configura los módulos en `hugo.toml` durante la fase de configuración (paso 3)
- OCA genera shortcodes y partials que usan los módulos
- Los context files en `.opencode/external-context/hugo/` documentan la configuración de cada módulo

**Seleccionado**: ✅ Sí (los marcados). Ecosistema MIT, modular, bien mantenido.

---

## 6. Modelos arquitectónicos (referencia)

Estas herramientas NO se incorporan directamente como skills. Son **referencias arquitectónicas** que inspiran cómo estructurar los artefactos OAC.

### 6.1 Claude Blog (AgriciDaniel)

| Campo | Valor |
|-------|-------|
| **Qué es** | Suite de 30 sub-skills, 5 agentes IA, 12 plantillas para escritura, SEO y auditoría de blogs |
| **URL** | https://github.com/agricidaniel/claude-blog |
| **Estrellas** | 833 ⭐ |
| **Licencia** | MIT |
| **Madurez** | Muy activo (v1.9.0, mayo 2026) |

**Valor como referencia**: **MUY ALTO**

**Qué aporta a REPOC**:
- **Estructura de skills**: 30 sub-skills organizadas por competencia (write, rewrite, analyze, seo, schema, geo)
- **Modelo de delegación**: 5 agentes especializados que OCA podría emular
- **Gate system**: "5-gate Delivery Contract" como modelo de calidad
- **Formato de skill**: Archivos .md que OpenCode puede cargar directamente

**Seleccionado como referencia**: ✅ Sí. No se copia, se estudia como modelo arquitectónico para la estructura de skills OAC en REPOC.

---

### 6.2 HugoBlox

| Campo | Valor |
|-------|-------|
| **Qué es** | Framework de contenido estructurado con 31+ bloques reutilizables. 9.426 ⭐. 150.000+ sitios en producción |
| **URL** | https://hugoblox.com/ |
| **Licencia** | MIT |

**Valor como referencia**: **ALTO**

**Qué aporta a REPOC**:
- **Arquitectura de bloques**: Componentes reutilizables configurables vía frontmatter. Inspiración para los layouts genéricos de REPOC
- **Hugo Chat AI**: Demuestra que un asistente IA puede generar sitios Hugo completos desde lenguaje natural. Valida nuestra dirección

**Seleccionado como referencia**: ✅ Sí. No se incorpora como dependencia, pero su arquitectura de bloques inspira los layouts reutilizables de REPOC.

---

### 6.3 Docsy (Google)

| Campo | Valor |
|-------|-------|
| **Qué es** | Tema oficial de Google para documentación técnica con Hugo. Usado por Kubernetes, Prometheus, gRPC. 2.919 ⭐ |
| **URL** | https://github.com/google/docsy |
| **Licencia** | Apache 2.0 |

**Valor como referencia**: **ALTO**

**Qué aporta a REPOC**:
- **Soporte IA nativo** (v0.15.0, mayo 2026): `llms.txt`, output Markdown para consumo por IA, "View Markdown" links
- **Lista de verificación**: Todo sitio generado por REPOC debería cumplir con estos estándares de accesibilidad IA

**Seleccionado como referencia**: ✅ Sí. Sus características de soporte IA son el estándar que REPOC debe cumplir.

---

## 7. CMS y edición visual

### 7.1 Decap CMS (vía HugoMods)

| Campo | Valor |
|-------|-------|
| **Qué es** | CMS Git-based open source con interfaz web WYSIWYG. El más popular para Hugo |
| **URL** | https://decapcms.org/docs/hugo/ |
| **Licencia** | MIT |
| **Madurez** | Muy activo |

**Artefacto OAC**: Skill "hugo-cms-setup"

**Integración**:
- OCA configura Decap CMS durante la fase de configuración del proyecto
- OCA genera `static/admin/config.yml` con los tipos de contenido
- OCA configura la autenticación (GitHub)
- El módulo HugoMods Decap CMS facilita la integración

**Flujo**: Post-creación del proyecto (después de paso 6-7)

**Seleccionado**: ✅ Sí. MIT, open source, el CMS más usado para Hugo.

---

## 8. Despliegue

### 8.1 Wrangler (Cloudflare Pages)

| Campo | Valor |
|-------|-------|
| **Qué es** | CLI oficial de Cloudflare para desplegar sitios estáticos en Cloudflare Pages |
| **URL** | https://developers.cloudflare.com/pages/ |
| **Licencia** | MIT (código abierto) |
| **Madurez** | Muy activo (mantenido por Cloudflare) |

**Artefacto OAC**: Comando `/hugo-deploy` que OCA ejecuta directamente

**Integración**:
- OCA ejecuta `hugo --minify --gc && wrangler pages deploy public/ --project-name=<nombre>`
- No requiere GitHub Actions ni CI/CD externo
- Despliegue directo desde el entorno de OCA

**Seleccionado**: ✅ Sí. Única vía de despliegue. Sin necesidad de CI/CD de GitHub.

---

## 9. Mapa de delegación OCA

### Cómo OCA usa cada herramienta seleccionada

```
                    ┌─────────────────────────────────────┐
                    │           USUARIO                    │
                    │  (lenguaje natural, una cosa a la    │
                    │   vez, paso a paso)                  │
                    └──────────────────┬──────────────────┘
                                       │
                                       ▼
                    ┌─────────────────────────────────────┐
                    │         OPENAGENT (OCA)              │
                    │  Analiza → ContextScout → Propone    │
                    │  → Aprueba → Ejecuta → Valida       │
                    └──┬──────────┬──────────┬───────────┘
                       │          │          │
          ┌────────────┘          │          └──────────────┐
          ▼                       ▼                         ▼
┌──────────────────┐   ┌──────────────────┐   ┌──────────────────┐
│  SUBAGENTES      │   │  SKILLS          │   │  COMANDOS        │
│                  │   │                  │   │                  │
│ HugoMCPSpecialist│   │ hugo-search-index│   │ /hugo-install    │
│  (invoca hugo-mcp)│   │ hugo-agentic-audit│  │ /hugo-serve      │
│                  │   │ hugo-seo-audit   │   │ /hugo-build      │
│                  │   │ hugo-query       │   │                  │
│                  │   │ hugo-cms-setup   │   │                  │
└──────────────────┘   └──────────────────┘   └──────────────────┘
        │                       │                       │
        └───────────┬───────────┘                       │
                    │                                   │
                    ▼                                   ▼
       ┌──────────────────────┐              ┌──────────────────┐
       │  MCP SERVERS         │              │  HERRAMIENTAS     │
       │                      │              │  DIRECTAS         │
       │ hugo-mcp (CRUD)      │              │ hugo-extended npm │
       │ hugo-memex (search)  │              │ Pagefind (index)  │
       │                      │              │ agentic-seo (audit)│
       └──────────────────────┘              └──────────────────┘
                                                    │
                                                    ▼
                                       ┌──────────────────────┐
                                       │    HUGO (SSG)        │
                                       │  + HugoMods modules  │
                                       │  + Decap CMS         │
                                       └──────────────────────┘
```

### Resumen de selección por categoría

| Categoría | Seleccionado | Tipo OAC | Prioridad |
|-----------|-------------|----------|-----------|
| hugo-extended (npm) | ✅ | Comando / Context | Alta |
| Wrangler (Cloudflare) | ✅ | Comando | Alta |
| hugo-mcp | ✅ | Subagente | Alta |
| hugo-memex | ✅ | Skill | Alta |
| hugo-docs-mcp | ⏳ Condicional | Skill | Baja |
| hugo-frontmatter-mcp | ❌ No | — | — |
| Pagefind | ✅ | Skill (post-build) | Alta |
| agentic-seo | ✅ | Skill | Alta |
| seofor.dev | ✅ | Skill | Media |
| HugoMods SEO | ✅ | Context | Alta |
| HugoMods Images | ✅ | Context | Media |
| HugoMods PWA | ✅ | Context | Media |
| HugoMods Icons | ✅ | Context | Media |
| HugoMods Search | ⏳ Condicional | Template | Baja |
| HugoMods Analytics | ⏳ Condicional | Template | Baja |
| Claude Blog | 📖 Referencia | Arquitectura | Alta |
| HugoBlox | 📖 Referencia | Arquitectura | Media |
| Docsy (Google) | 📖 Referencia | Checklist IA | Media |
| Decap CMS | ✅ | Skill | Media |

**Leyenda**: ✅ Seleccionado | ❌ No seleccionado | ⏳ Condicional | 📖 Referencia

---

## Referencias cruzadas

- `recursos/flujos/01_capacidades-oca-hugo.md` — Catálogo de capacidades OCA para Hugo
- `recursos/01_recapitulacion-entendimiento-openagent.md` — Documento fundacional
- `recursos/05_plan-implementacion-repoc.md` — Plan de implementación
- `.opencode/external-context/hugo/` — Contexto externo de Hugo

---

*Documento generado por OpenAgent como selección curada de herramientas del ecosistema Hugo para delegación OAC.*
