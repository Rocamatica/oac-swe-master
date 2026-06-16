# Proceso acordado — Flujo de trabajo con Hugo

**Propósito**: Checklist ejecutable del proceso acordado para el proyecto PYT-SWE (OAC+Hugo). Cada nivel 1 es una etapa del proceso; los niveles 2 son tareas verificables.

**Fuente**: `definiciones-pyt-swe-oac-cf.md` (sección "Proceso acordado"), `01-flujo-trabajo-hugo.md`

---

## Fase 0: Instalar y configurar OAC

Estado actual:
- ✅ Perfil completo (full) instalado
- ✅ Contexto de OAC descubierto (208 archivos en `.opencode/context/`)
- ✅ Contexto Hugo completo (13 fichas técnicas en `.opencode/external-context/hugo/`)
- ⚠️ Contexto de Cloudflare pendiente — se necesita ExternalScout para documentación actualizada

Pendiente:
- [ ] **Configurar el contexto del proyecto con las herramientas de OAC**:
  1. Leer las guías de OAC en `.opencode/context/openagents-repo/` (`quick-start.md`, `core-concepts/registry.md`, `guides/profile-validation.md`) para entender el sistema de contexto, el registro de componentes y la validación de perfiles
  2. Ejecutar `/add-context` y responder a las 6 preguntas del asistente: stack tecnológico (Hugo v0.163.1+, Cloudflare Pages, Cloudflare DNS), ejemplos de configuración, convenciones de nombres, estándares de código y requisitos de seguridad
  3. ContextScout descubrirá los patrones de contexto del proyecto y los priorizará automáticamente (según el flujo de trabajo de OAC: primero `/add-context`, luego ContextScout descubre)
  4. ExternalScout se activará automáticamente al detectar dependencias externas (Cloudflare Pages) para obtener documentación actualizada de sus APIs y configuración
- ✅ **Perfil completo (full) instalado**: incluye componentes técnicos (OpenCoder, CoderAgent, Frontend Specialist, DevOps Specialist, Reviewer, BuildAgent) y de contenido (Copywriter, Image Specialist). Según `08-analisis-oac-perfiles-recomendacion.md`, ningún perfil menor cubre ambos grupos simultáneamente.

---

## Etapa 1: Gestión de contenido — Estructura base Hugo

- [ ] **`hugo new site pyt-swe`** — crear estructura base de directorios del proyecto
- [ ] **Configurar `hugo.toml`** — definir `baseURL`, `title`, `theme` (vacío si plantillas propias), `languageCode`, `defaultContentLanguage`
- [ ] **Diseñar o seleccionar una plantilla base de apariencia**
- [ ] **Decidir marco de trabajo CSS**
- [ ] **Crear `layouts/` mínimos:**
  - `_default/baseof.html` — esqueleto común
  - `index.html` — portada (home)
  - `_default/single.html` — página individual
  - `_default/list.html` — listados
- [ ] **Crear `archetypes/default.md`** — plantilla base para `hugo new`
- [ ] **Añadir contenido de prueba** — `hugo new post/prueba.md`
- [ ] **Documentar esta etapa** — estructuras, plantilla, decisiones de CSS en `notas/` o `context/`

---

## Etapa 2: SEO

*(Pendiente de definir tareas concretas)*

- [ ] Configurar Open Graph
- [ ] Configurar Twitter Cards
- [ ] Configurar Schema.org
- [ ] Configurar canonical y sitemap
- [ ] **Documentar esta etapa** — configuración SEO en `notas/` o `context/`

---

## Etapa 3: Facilidad de creación

- [ ] **Servidor de desarrollo** — `hugo server -D` para ver el sitio en vivo con drafts
- [ ] **Documentar esta etapa** — flujo de creación, herramientas, LiveReload en `notas/` o `context/`

---

## Etapa 4: Internacionalización (i18n)

*(Pendiente de decidir si se integra desde el inicio junto con SEO o se añade después)*

- [ ] Decidir si el sitio será multilingüe desde la etapa 2 o en una fase posterior
- [ ] **Documentar esta etapa** — decisión de i18n, estructura multilingüe en `notas/` o `context/`

---

## Etapa 5: Rendimiento y compilación

- [ ] **Añadir CSS y JS:**
  - `assets/css/main.css` (o `assets/css/main.scss`)
  - Parcial `layouts/partials/head.html` que llame al pipeline con `resources.Get`
- [ ] **Build de producción** — `hugo` genera `public/`
- [ ] **Documentar esta etapa** — pipeline de assets, optimización, minificación en `notas/` o `context/`

---

## Etapa 6: Despliegue con Wrangler

- [ ] **Despliegue en Cloudflare Pages:**
  - `wrangler pages project create pyt-swe`
  - `hugo --minify --gc` → `wrangler pages deploy public/ --project-name pyt-swe`
- [ ] **Validar el flujo completo** con el sitio de prueba
- [ ] **Documentar esta etapa** — configuración Wrangler, despliegue, dominio en `notas/` o `context/`

---

## Documentar el proceso

- [ ] Documentar la creación de cada sitio
- [ ] Extraer patrones tras varios sitios creados

---

## Decisiones tomadas

| Decisión | Estado |
|----------|:------:|
| Hugo como generador de sitio estático (v0.163.1+) | ✅ |
| OAC (OpenAgentsControl) como gestor del flujo — usuario interactúa con OAC, OAC (vía OCC) gestiona Hugo | ✅ |
| Wrangler gestionado por OAC y OCC, sin CI/CD (el usuario no ejecuta comandos Hugo directamente) | ✅ |
| Sin GitHub Actions para automatizar despliegue | ❌ |
| Sin Workers. Solo Cloudflare Pages con HTML estático | ❌ |
| Internacionalización pendiente de decidir si se integra desde el inicio (etapa 2 junto con SEO) o se añade después | ⏳ |
