---
name: hugo-agentic-audit
description: Skill que envuelve agentic-seo (addyosmani) para auditar la visibilidad del sitio en agentes IA (AEO — Agentic Engine Optimization). Verifica robots.txt, llms.txt, AGENTS.md y simulación de crawlers IA.
---

# Hugo Agentic Audit

## Overview

Wraps [agentic-seo](https://github.com/addyosmani/agentic-seo) by Addy Osmani (Google Chrome). Audits how AI agents (ChatGPT, Claude, Gemini, Perplexity) interpret the site. Use when the user asks about SEO/IA visibility or optimization.

## Installation

```bash
npm install -g agentic-seo
```

## How to Invoke

Run against the production site or local dev server:

```bash
# Audit production site
agentic-seo https://example.com

# Audit local dev server
agentic-seo http://localhost:1313
```

## Usage

### Full AEO audit

When user says "audita la visibilidad IA del sitio":
1. Run `agentic-seo <site-url>`
2. Parse the results
3. Present findings to the user:
   - robots.txt status
   - llms.txt presence and content
   - AGENTS.md configuration
   - Crawler simulation results for ChatGPT, Claude, Gemini, Perplexity
4. Suggest fixes if any checks fail

### Pre-deploy check

Before deploying a new site:
1. Run agentic-seo against the local build (`hugo server`)
2. Fix any AEO issues before going live

## Dependencies

- Node.js 18+
- agentic-seo CLI (`npm install -g agentic-seo`)
- Target site must be accessible (local or production URL)
