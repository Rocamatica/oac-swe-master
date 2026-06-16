# Herramientas NO validadas para instalación

**Propósito**: Registro de herramientas del catálogo original que se evaluaron pero NO se incluirán en la instalación de Fase 3, con la razón de exclusión.

**Fecha**: 2026-06-16

---

## Excluidas por duplicidad funcional

### hugo-frontmatter-mcp (wdm0006)

| Campo | Valor |
|-------|-------|
| **Estado** | ❌ No incluido |
| **Razón** | Sus operaciones de frontmatter (get/set tags, fechas) están cubiertas por hugo-mcp. Alcance limitado, valor marginal bajo. |

---

### HugoMods Search

| Campo | Valor |
|-------|-------|
| **Estado** | ❌ No incluido |
| **Razón** | Duplicidad directa con Pagefind (ya incluido). Pagefind es superior: más ligero (~10KB JS), más preciso (indexa HTML real), estándar de la comunidad Hugo 2026. HugoMods Search usa Fuse.js (JS cliente, índice JSON, más pesado). Incluir ambos sería duplicar funcionalidad sin beneficio claro. |

---

## Excluidas por dependencia de decisión de diseño

---


---

### HugoMods Docker

| Campo | Valor |
|-------|-------|
| **Estado** | ⏳ Condicional — no incluido por ahora |
| **Razón** | Imágenes Docker para despliegue. Solo si el proyecto lo requiere y no se usa Cloudflare Pages directamente. |

---

## Referencias arquitectónicas (no se instalan)

Estas herramientas no son instalables. Son referencias para el diseño de artefactos OAC en REPOC.

### Claude Blog (AgriciDaniel)

| Campo | Valor |
|-------|-------|
| **URL** | https://github.com/agricidaniel/claude-blog |
| **Tipo** | Suite de 30 sub-skills, 5 agentes IA, 12 plantillas para blogs (833⭐, MIT) |
| **Estado** | ❌ No se instala — referencia arquitectónica |

**Explicación**: Claude Blog no es una herramienta que se instale como las demás (npm, Python, MCP). Es código fuente en GitHub con una estructura de skills y agentes. Su valor para REPOC es **arquitectónico**: estudiar cómo organiza 30 sub-skills por competencia (write, rewrite, analyze, seo, schema, geo), cómo implementa el sistema de "5-gate Delivery Contract" para calidad, y cómo define agentes especializados. REPOC se inspira en ese diseño para crear sus propios skills, pero no copia ni dependende del proyecto.

### HugoBlox

| Campo | Valor |
|-------|-------|
| **URL** | https://hugoblox.com/ |
| **Tipo** | Framework de contenido estructurado con 31+ bloques (9.426⭐, MIT, 150.000+ sitios) |
| **Estado** | ❌ No se instala — referencia arquitectónica. Si se desea como tema, se evalúa al crear un REPON. |

**Explicación**: HugoBlox podría ser un tema instalable como dependencia Hugo en un REPON, pero su valor principal para REPOC es **arquitectónico**: su sistema de 31+ bloques reutilizables configurables vía frontmatter es la inspiración para diseñar layouts genéricos en REPOC. También demuestra con "Hugo Chat AI" que un asistente IA puede generar sitios Hugo completos desde lenguaje natural, lo que valida la dirección de REPOC. No se incluye como dependencia forzada porque el tema del sitio es decisión del usuario en REPON, no de REPOC.

### Docsy (Google)

**Uso en REPOC**: Lista de verificación de accesibilidad IA (llms.txt, output Markdown, etc.). Estándar que REPOC debe cumplir.

---

*Documento generado por OpenAgent durante la validación item por item de la selección de herramientas.*
