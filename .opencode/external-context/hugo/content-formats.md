---
source: Context7 API + Documentación oficial Hugo
library: Hugo
topic: Content Formats
fetched: 2026-06-16
official_docs: https://gohugo.io/content-management/formats/
---

# Formatos de Contenido en Hugo

## Los 6 formatos soportados

| Formato | Extensión | Propósito |
|---|---|---|
| **Markdown** | `.md` | Formato por defecto. Ligero, legible. Renderizador Goldmark (CommonMark + GFM). Ideal para el Copista de OAC. |
| **HTML** | `.html` | Control total del marcado. Hugo no lo procesa, lo usa tal cual. Para landing pages muy específicas. |
| **AsciiDoc** | `.adoc` | Documentación técnica avanzada. Tablas complejas, referencias cruzadas, includes. Requiere instalación de AsciiDoc. |
| **Org** (Emacs Org Mode) | `.org` | Formato del editor Emacs. Para flujos que ya trabajan con Org Mode. |
| **Pandoc** | `.pandoc` | Marca de la herramienta Pandoc. Para migraciones o flujos que ya usan Pandoc. |
| **reStructuredText (RST)** | `.rst` | Formato de documentación Python (Sphinx). Para migraciones desde proyectos Python. |

## ¿Por qué tantos formatos?

Hugo está diseñado para adaptarse a flujos de trabajo existentes. Si ya tienes documentación en AsciiDoc o RST, no necesitas convertirla a Markdown: Hugo la entiende directamente.

## Configuración del renderizador

Por defecto Hugo usa **Goldmark** (Markdown). Para cambiar a otro renderizador:

```toml
[markup]
defaultMarkdownHandler = 'asciidoc'
```

Los renderizadores alternativos (AsciiDoc, Pandoc, RST) requieren instalar el software correspondiente.

## Limitación importante

Los **render hooks** (personalización de cómo se renderizan imágenes, enlaces, cabeceras, tablas) **solo funcionan con Markdown**. Si eliges AsciiDoc, Org o RST, pierdes esa capacidad.

## Para el proyecto PYT-SWE

Usaremos exclusivamente **Markdown (.md)** porque:
- El Copista de OAC genera Markdown de forma natural
- Los render hooks permiten personalizar imágenes, enlaces, etc.
- Goldmark es rápido y compatible con CommonMark
- No requiere instalación de software adicional
