---
source: Context7 API
library: Hugo
package: hugo
topic: HugoMods SEO
fetched: 2026-06-16
official_docs: https://hugomods.com/en/docs/seo/
---

# HugoMods SEO Module

**Purpose**: Generate meta tags (Open Graph, Twitter Cards) and Schema.org structured data automatically from frontmatter.
**Module URL**: https://hugomods.com/en/docs/seo/

## Configuration

Add to `hugo.toml`:
```toml
[[module.imports]]
path = "github.com/hugomods/seo/modules/twitter-cards"

[[module.imports]]
path = "github.com/hugomods/seo/modules/open-graph"

[[module.imports]]
path = "github.com/hugomods/seo/modules/schema"
```

## Features

- Open Graph tags (og:title, og:description, og:image, og:url)
- Twitter Cards (summary, summary_large_image)
- Schema.org JSON-LD (Article, BlogPosting, WebPage)
- Auto-generated from page frontmatter (title, description, images, date)

## Usage

No shortcodes needed. Just add frontmatter to pages:

```yaml
---
title: "Mi página"
description: "Descripción para SEO"
image: "/images/og-default.jpg"
date: 2026-06-16
tags: ["tag1", "tag2"]
---
```

The module generates meta tags automatically in `<head>`.

## Dependencies

- HugoMods base
- Hugo 0.123.0+
