---
source: Context7 API
library: Hugo
package: hugo
topic: HugoMods Images
fetched: 2026-06-16
official_docs: https://hugomods.com/en/docs/images/
---

# HugoMods Images Module

**Purpose**: Image processing shortcodes for Markdown content. Resize, crop, WebP/AVIF, lazy loading, figures with caption.
**Module URL**: https://hugomods.com/en/docs/images/

## Configuration

Add to `hugo.toml`:
```toml
[[module.imports]]
path = "github.com/hugomods/images"
```

## Shortcodes

### Basic image
```markdown
{{< image src="/images/photo.jpg" alt="Descripción" width="800" >}}
```

### Image with caption
```markdown
{{< figure src="/images/photo.jpg" caption="Mi foto" alt="Descripción" >}}
```

### Responsive image
```markdown
{{< image src="/images/photo.jpg" width="1200" sizes="(max-width: 768px) 100vw, 50vw" >}}
```

## Features

- Automatic WebP/AVIF conversion
- Lazy loading (`loading="lazy"`)
- Responsive images with srcset
- Caption support with `<figure>` + `<figcaption>`
- Placeholder while loading

## Dependencies

- HugoMods base
- Hugo 0.123.0+
