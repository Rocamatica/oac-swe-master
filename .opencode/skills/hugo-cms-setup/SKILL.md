---
name: hugo-cms-setup
description: Skill que configura Decap CMS (vía HugoMods) en un proyecto Hugo. Genera static/admin/config.yml con tipos de contenido y configuración de autenticación GitHub OAuth.
---

# Hugo CMS Setup

## Overview

Configures [Decap CMS](https://decapcms.org/docs/hugo/) (the most popular Git-based CMS for Hugo) via the HugoMods Decap CMS module. Use when the user wants a visual CMS to manage content without touching Markdown or Git.

## Configuration Steps

### 1. Enable HugoMods Decap CMS

Add to `hugo.toml`:
```toml
[[module.imports]]
path = "github.com/hugomods/decap-cms"
```

### 2. Generate config.yml

Create `static/admin/config.yml`:
```yaml
backend:
  name: github
  repo: owner/repo-name
  branch: main
  base_url: https://api.github.com

media_folder: "static/images"
public_folder: "/images"

collections:
  - name: "posts"
    label: "Posts"
    folder: "content/posts"
    create: true
    slug: "{{slug}}"
    fields:
      - { label: "Title", name: "title", widget: "string" }
      - { label: "Publish Date", name: "date", widget: "datetime" }
      - { label: "Draft", name: "draft", widget: "boolean", default: true }
      - { label: "Tags", name: "tags", widget: "list" }
      - { label: "Body", name: "body", widget: "markdown" }
```

### 3. Configure GitHub OAuth

The user must:
1. Create a GitHub OAuth App (Settings → Developer settings → OAuth Apps)
2. Set the callback URL to `https://api.netlify.com/auth/done` (Decap uses Netlify's auth endpoint)
3. The CMS authenticates via GitHub OAuth

## Usage

When user says "configura un CMS para el sitio":
1. Ask the user which content types they need (posts, pages, etc.)
2. Generate `static/admin/config.yml` with the appropriate collections
3. Guide the user through GitHub OAuth setup
4. Verify the CMS loads at `/admin/` on the deployed site

## Dependencies

- HugoMods Decap CMS module in `hugo.toml`
- GitHub account for OAuth authentication
- Site must be deployed (CMS doesn't work on localhost)
