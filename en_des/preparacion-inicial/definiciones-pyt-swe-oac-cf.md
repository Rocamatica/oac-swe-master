# Definiciones del Proyecto: Objetivos

**Propósito**: Definir los objetivos y el proceso acordado del proyecto de creación de sitios web estáticos con Hugo, Cloudflare y OpenAgentsControl.

**Fecha**: 2026-06-16

**Documentos de referencia**:
- `legado/analisis-pyt-swe-oac-cf.md` — Análisis y recomendación original del proyecto (archivado)
- `analisis-hugo.md` — Análisis de Hugo como generador de sitios estáticos
- `notas/01-flujo-trabajo-hugo.md` — Flujo de trabajo completo con Hugo
- `notas/01B-flujo-trabajo-hugo-chklist.md` — Checklist ejecutable (Fase 0 incluida)
- `notas/07-diagnostico-contexto-oac.md` — Diagnóstico de contexto OAC (208 archivos, 36 gaps)
- `reglas-oac-hugo.md` — Reglas de interacción Usuario ↔ OAC ↔ Hugo
- `notas/08-analisis-oac-perfiles-recomendacion.md` — Mapa de necesidades vs OAC, perfiles y recomendación full
- `notas/09-investigacion-skills-hugo.md` — Investigación del ecosistema Hugo para skills incorporables

---

## Objetivos del proyecto

### 1. Identidad del proyecto
- **Nombre descriptivo**: Preparando OAC+Hugo.
- **Repositorio en GitHub**: `oac-swe-master` (este repositorio).
- **Propósito**: Crear la versión 1 de la base OAC+Hugo con toda la infraestructura necesaria (Hugo, plantillas, configuración Cloudflare, habilidades OAC) para después clonar en otros repositorios y crear sitios web estáticos (SWE) directamente.
- ✅ Repositorio ya creado: `oac-swe-master`.

### 2. Generador de sitio estático
- ✅ **Hugo decidido** (v0.163.1+). Análisis completo en `analisis-hugo.md`.
- [ ] Crear estructura de proyecto Hugo base: archetypes, configuración base, plantillas mínimas.

### 3. Instalar y configurar OAC
- ✅ Perfil completo (full) instalado.
- ✅ Contexto de OAC descubierto (vía ContextScout). El repositorio tiene **208 archivos de contexto** en `.opencode/context/`.
  - **Categoría `openagents-repo/`**: contiene guías de instalación, registro, agentes, skills, perfiles, plugins, errores y troubleshooting de OAC.
  - **Categoría `core/`**: estándares de calidad, workflows, sistema de contexto y gestión de tareas.
  - **✅ Contexto Hugo completo** — 13 fichas técnicas en `.opencode/external-context/hugo/` (vía ExternalScout).
  - **⚠️ No hay contexto interno de Cloudflare** — se necesitará ExternalScout para documentación actualizada.


#### Arquitectura de interacción

La relación entre el usuario, OAC y Hugo sigue estas reglas (definidas en `reglas-oac-hugo.md`):

```
Usuario ↔ OAC (OCC) ↔ Hugo
```

- El usuario interactúa **exclusivamente con OAC**. No ejecuta comandos de Hugo directamente.
- OAC, mediante OCC (OpenCoder), gestiona todo el trabajo con Hugo: instalación, configuración, generación de contenido, build y despliegue.
- Cualquier cambio en la configuración o estructura de Hugo se canaliza a través de OAC para mantener la coherencia del contexto.
- Para que OAC pueda gestionar Hugo, primero hay que prepararlo: verificar contexto completo y rellenar gaps.


### 4. Crear las habilidades necesarias

> **Nota**: OAC ya dispone de contexto sobre Hugo (13 fichas) y los patrones cubiertos. Revisar si estas habilidades deben ser skills de OpenCode o si el contexto OAC existente es suficiente. Los gaps detectados (36 archivos) pueden priorizarse antes de crear nuevas habilidades.

| Habilidad | Propósito |
|-----------|-----------|
| Cloudflare Pages | Despliegue, configuración de compilación, dominios personalizados |
| Hugo | Generación de sitios, configuración, archetypes, shortcodes, optimización de compilación |
| Redacción SEO | Optimización de contenidos para buscadores |
| Traducción i18n | Internacionalización de los sitios |
| Estructura de sitio web estático | Arquitectura y organización de secciones |

### 5. Proceso de trabajo con Hugo
- ✅ Proceso acordado documentado en `notas/01B-flujo-trabajo-hugo-chklist.md` (7 etapas: Fase 0 + 6 etapas).


---

*Fin del documento*
