---
name: hugo-search-index
description: Skill post-build que ejecuta Pagefind para indexar el HTML generado por Hugo. Añade búsqueda full-text al sitio estático para los visitantes.
---

# Hugo Search Index

## Overview

Wraps [Pagefind](https://pagefind.app/) — the 2026 standard for static site search (~10KB JS + WASM). Run after each Hugo build to index content. The indexed search is used by site visitors, not by OCA.

## Installation

```bash
npm install -g pagefind
```

## How to Invoke

Run after every Hugo production build:

```bash
hugo --minify --gc && npx pagefind --source public
```

Or with custom options:

```bash
npx pagefind --source public --bundle-dir _pagefind --glob "**/*.html"
```

## Usage

### Standard index (recommended)

When the user does a build or deploy:
1. First run `hugo --minify --gc`
2. Then run `npx pagefind --source public`
3. Confirm indexing completed

### Multilingual sites

Pagefind auto-detects languages. For explicit config:
```bash
npx pagefind --source public --force-language es
```

### Verify index

Check that `public/pagefind/` was created with `pagefind.js` and the WASM bundle.

## Dependencies

- Node.js 18+
- Pagefind CLI (`npm install -g pagefind`)
- Must run AFTER `hugo` build, BEFORE deploy
