# External Context — Navegación

**Propósito**: Documentación de herramientas y frameworks externos, almacenada
por paquete/tema para consumo por agentes OCA.

**Estructura**: Package-based (no function-based). Cada subdirectorio agrupa
documentación de una herramienta o librería externa.

---

## Paquetes disponibles

| Paquete | Archivos | Descripción |
|---------|----------|-------------|
| `oac-repoc/` | 7 | Auto-conocimiento del REPOC: estructura `.opencode/`, agentes, comandos, skills, MCPs, tools, scripts |
| `oac-framework/` | 7 | Documentación del framework OAC: arquitectura, workflows, contexto, integración |
| `hugo/` | 19 | Documentación de Hugo, HugoMods y herramientas del ecosistema |
| `cloudflare-pages-tools/` | 1 | Investigación de herramientas para Cloudflare Pages |

---

## Rutas rápidas

| Necesitas... | Carga esto |
|-------------|------------|
| Entender la estructura de `.opencode/` | `external-context/oac-repoc/01_estructura-completa-opencode.md` |
| Saber qué agentes/subagentes hay | `external-context/oac-repoc/02_agents-catalogo.md` |
| Ver comandos slash disponibles | `external-context/oac-repoc/03_comandos-personalizados.md` |
| Conocer skills instalados | `external-context/oac-repoc/04_skills-instalados.md` |
| Documentación de MCPs | `external-context/oac-repoc/05_mcp-servers-configurados.md` |
| Plugins y tools | `external-context/oac-repoc/06_plugins-y-herramientas.md` |
| Script de bootstrap | `external-context/oac-repoc/07_scripts-de-arranque.md` |
| Arquitectura OAC | `external-context/oac-framework/architecture-overview.md` |
| Sistema de contexto OAC | `external-context/oac-framework/context-system-architecture.md` |
| Workflows de agentes | `external-context/oac-framework/agent-workflows.md` |
| Instalación de Hugo | `external-context/hugo/hugo-install.md` |
| Configuración de Hugo | `external-context/hugo/configuration.md` |
| Templates Hugo | `external-context/hugo/templates.md` |

---

## Notas

- **MVI exemption**: Los archivos en `external-context/` son documentación
  externa viva, no contexto interno comprimido. Están **exentos** del límite
  de 200 líneas de MVI. Archivos como `cloudflare-pages-tools/investigacion-herramientas.md`
  (471 líneas) o `oac-repoc/01_estructura-completa-opencode.md` (256 líneas)
  son esperablemente extensos por su naturaleza de documentación completa.

## Mantenimiento

- Al añadir un nuevo paquete: crear `{package}/.manifest.json` + actualizar
  este `navigation.md` + actualizar `.manifest.json` raíz
- Al añadir archivos a un paquete existente: actualizar su `.manifest.json`
- Los manifests son la fuente de verdad para el conteo de archivos
