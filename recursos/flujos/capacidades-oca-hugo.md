# Capacidades OCA para Hugo

**Propósito**: Catálogo de capacidades que OCA (OpenAgent) ofrece para gestionar sitios Hugo. El usuario expresa una intención en lenguaje natural, OCA interpreta y ejecuta usando la habilidad adecuada (skill, MCP, herramienta, contexto).

**Fecha**: 2026-06-16

**Principio**: No hay flujo fijo de pasos. El usuario dice lo que quiere y OCA responde con la capacidad adecuada.

---

## Modelo de interacción

```
Usuario dice:                           OCA responde:
"Quiero crear un proyecto..."      →    Capacidad: Inicializar proyecto
"Crea una página de contacto"      →    Capacidad: Crear contenido
"Pon una foto en /images/logo"     →    Capacidad: Gestionar assets
"Haz una auditoría SEO"            →    Capacidad: Auditar SEO/AEO
"Despliega el sitio"               →    Capacidad: Desplegar
```

Cada capacidad se activa por **intención del usuario**, no por orden preestablecido. OCA analiza la petición, selecciona la capacidad, pregunta lo necesario y ejecuta delegando en la herramienta correspondiente.

---

## Catálogo de capacidades

### C1: Inicializar proyecto Hugo

| Atributo | Valor |
|----------|-------|
| **Disparador** | "Quiero crear un proyecto Hugo", "Inicia un sitio nuevo", "Crea proyecto 'x'" |
| **Artefacto OAC** | Directo (OCA) — no requiere skill externa |
| **Herramientas** | `hugo-extended` (npm) |
| **Preguntas necesarias** | Nombre del proyecto, título, base URL, idioma (adaptativas, una a la vez) |
| **Qué hace OCA** | 1. Verifica/instala Hugo → 2. Pregunta datos → 3. `hugo new site <nombre>` → 4. Escribe `hugo.toml` con datos recopilados |

---

### C2: Crear y gestionar contenido

| Atributo | Valor |
|----------|-------|
| **Disparador** | "Crea una página sobre X", "Añade un artículo", "Edita la página de inicio", "Elimina la página de contacto" |
| **Artefacto OAC** | Subagente `HugoMCPSpecialist` |
| **Herramientas** | `hugo-mcp` (MCP server) |
| **Qué hace OCA** | 1. Interpreta qué tipo de contenido quiere el usuario → 2. Delega en `HugoMCPSpecialist` → 3. El subagente invoca `hugo-mcp` (create_page, update_page, delete_page) → 4. Devuelve resultado |

**Comandos hugo-mcp disponibles**:
- `create_page(título, sección, contenido)` — Crear nueva página
- `update_page(ruta, contenido, frontmatter)` — Modificar página existente
- `delete_page(ruta)` — Eliminar página (con purga Cloudflare)
- `upload_asset(archivo, destino)` — Subir imagen/asset a `static/`
- `list_pages(sección)` — Listar páginas por sección

---

### C3: Buscar y consultar contenido

| Atributo | Valor |
|----------|-------|
| **Disparador** | "Busca artículos sobre X", "Qué páginas tengo en la sección Y", "Encuentra contenido relacionado con Z" |
| **Artefacto OAC** | Skill `hugo-query` |
| **Herramientas** | `hugo-memex` (MCP server) |
| **Qué hace OCA** | 1. Toma la consulta del usuario → 2. Invoca skill `hugo-query` → 3. La skill consulta vía FTS5 → 4. Devuelve resultados estructurados |

**Consultas disponibles**:
- Búsqueda de texto completo sobre todo el contenido
- Listado de páginas por sección, tag, fecha
- Sugerencia de tags basada en contenido existente
- Validación de contenido (completitud, referencias cruzadas)

---

### C4: Indexar búsqueda en el sitio

| Atributo | Valor |
|----------|-------|
| **Disparador** | "Quiero que el sitio tenga buscador", "Indexa el contenido para búsqueda" |
| **Artefacto OAC** | Skill `hugo-search-index` |
| **Herramientas** | `Pagefind` (npm) |
| **Qué hace OCA** | 1. Ejecuta `hugo --minify --gc` → 2. Ejecuta `npx pagefind --source public` → 3. Verifica que el índice se generó → 4. Confirma al usuario |

---

### C5: Auditar SEO y visibilidad IA

| Atributo | Valor |
|----------|-------|
| **Disparador** | "Audita el SEO del sitio", "Está optimizado para IA?", "Genera reporte de calidad" |
| **Artefacto OAC** | Skills `hugo-agentic-audit` + `hugo-seo-audit` |
| **Herramientas** | `agentic-seo` (AEO) + `seofor.dev` (SEO) |
| **Qué hace OCA** | 1. Ejecuta `agentic-seo` para auditoría de visibilidad en agentes IA → 2. Ejecuta `seofor.dev` para auditoría SEO técnica → 3. Interpreta resultados → 4. Presenta resumen y sugerencias al usuario |

---

### C6: Configurar tema o diseño

| Atributo | Valor |
|----------|-------|
| **Disparador** | "Quiero usar el tema X", "Cambia el diseño a Y", "Aplica este tema: [URL]" |
| **Artefacto OAC** | Directo (OCA) |
| **Herramientas** | `git clone` / `hugo mod init` / `hugo.toml` |
| **Qué hace OCA** | 1. Pregunta al usuario qué tema (nombre, URL) → 2. Lo instala (git clone o módulo) → 3. Actualiza `hugo.toml` con `theme = [...]` → 4. Verifica que el tema se ve correctamente |

---

### C7: Configurar CMS visual

| Atributo | Valor |
|----------|-------|
| **Disparador** | "Quiero un CMS para editar contenido", "Configura Decap CMS" |
| **Artefacto OAC** | Skill `hugo-cms-setup` |
| **Herramientas** | `Decap CMS` (vía HugoMods) |
| **Qué hace OCA** | 1. Pregunta al usuario tipos de contenido → 2. Genera `static/admin/config.yml` → 3. Configura autenticación (GitHub) → 4. Verifica que el CMS carga correctamente |

---

### C8: Configurar módulos HugoMods

| Atributo | Valor |
|----------|-------|
| **Disparador** | "Añade SEO al sitio", "Quiero iconos de Bootstrap", "Activa PWA" |
| **Artefacto OAC** | Context files + edición directa de `hugo.toml` |
| **Herramientas** | `HugoMods` (SEO, Images, PWA, Icons) |
| **Qué hace OCA** | 1. Identifica qué módulo solicita el usuario → 2. Añade el import del módulo en `hugo.toml` → 3. Configura opciones básicas → 4. Verifica que el módulo funciona |

**Módulos disponibles**: SEO, Images, PWA, Icons

---

### C9: Generar sitio y desplegar

| Atributo | Valor |
|----------|-------|
| **Disparador** | "Despliega el sitio", "Haz build + deploy", "Publica en producción" |
| **Artefacto OAC** | Comando `/hugo-deploy` |
| **Herramientas** | `hugo` + `wrangler` (Cloudflare Pages) |
| **Qué hace OCA** | 1. Ejecuta `hugo --minify --gc` (build) → 2. Si hay error, reporta y para → 3. Ejecuta `wrangler pages deploy public/ --project-name=<nombre>` → 4. Confirma URL de despliegue |

---

### C10: Auditar y verificar calidad

| Atributo | Valor |
|----------|-------|
| **Disparador** | "Hay enlaces rotos en el sitio?", "Verifica que el contenido está completo", "Detecta páginas duplicadas" |
| **Artefacto OAC** | Skill condicional `hugo-audit-quality` |
| **Herramientas** | `hugo-docs-mcp` (MCP server) — selección pendiente de evaluar |
| **Qué hace OCA** | 1. Evalúa si es necesario activar esta capacidad → 2. Si procede, delega en hugo-docs-mcp → 3. Devuelve reporte de auditoría |

---

## Mapa intención → capacidad

```
"crea proyecto/inicia sitio"         →  C1: Inicializar
"crea página/artículo/edita borra"   →  C2: Contenido (hugo-mcp)
"busca/encuentra/consulta"           →  C3: Consulta (hugo-memex)
"indexa/buscador"                    →  C4: Buscar (Pagefind)
"audita/seo/está optimizado"         →  C5: Auditoría (agentic-seo + seofor.dev)
"tema/diseño/apariencia"             →  C6: Tema
"cms/admin/panel"                    →  C7: Decap CMS
"seo/iconos/pwa/módulo"              →  C8: HugoMods
"despliega/publica/build"            →  C9: Deploy (wrangler)
"enlaces rotos/duplicados/audita"    →  C10: Calidad (hugo-docs-mcp)
```

---

## Consideraciones

1. **Una capacidad por petición**: OCA atiende una intención a la vez. Si el usuario dice "crea un proyecto y luego configúrale SEO", se trata como dos capacidades secuenciales.
2. **OCA pregunta lo necesario**: Cada capacidad tiene sus preguntas, siempre adaptativas, nunca un cuestionario fijo.
3. **Validación implícita**: Después de ejecutar una capacidad, OCA verifica el resultado antes de confirmar al usuario.
4. **Contexto compartido**: Si el usuario ya ha usado C1 (inicializar), las siguientes capacidades (C2-C10) operan dentro de ese mismo proyecto.
5. **Sin orden fijo**: El usuario puede saltar de C8 a C2 a C9 sin seguir una secuencia predeterminada.

---

## Referencias

- `recursos/seleccion-herramientas-hugo-oac.md` — Detalle de cada herramienta seleccionada
- `recursos/recapitulacion-entendimiento-openagent.md` — Documento fundacional
- `.opencode/external-context/hugo/` — Contexto técnico de Hugo
