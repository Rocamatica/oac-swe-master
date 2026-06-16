---
name: hugo-seo-audit
description: Skill que envuelve seofor.dev para auditoría SEO técnica con exportación AI-Ready. Crawling local, IndexNow, y reportes interpretables por OCA.
---

# Hugo SEO Audit

## Overview

Wraps [seofor.dev](https://github.com/ugolbck/seofordev) — a CLI-first SEO audit tool with AI-Ready exports. Use when the user asks for technical SEO analysis, performance checks, or pre-launch audit.

## Installation

```bash
curl -sSfL https://raw.githubusercontent.com/ugolbck/seofordev/main/install.sh | bash
```

## How to Invoke

```bash
# Audit localhost (default port 3000)
seo audit run

# Audit specific port (e.g., Hugo dev server on 1313)
seo audit run --port 1313

# List past audits
seo audit list

# Show detailed results
seo audit show <id>
```

## Usage

### Pre-launch SEO check

When user says "audita el SEO antes de desplegar":
1. Start Hugo dev server: `hugo server -D --port 1313`
2. In parallel, run: `seo audit run --port 1313`
3. Read the AI-Ready export
4. Present SEO findings to the user:
   - Missing meta tags
   - Performance issues
   - Broken links found
   - IndexNow submission suggestion
5. Fix issues and re-audit

### IndexNow submission

After deploying new content:
```bash
seo index submit <url>
```

## Dependencies

- Go binary installed at `/usr/local/bin/seo`
- Playwright browsers (auto-installed on first `seo audit run`)
- Hugo dev server running during audit
