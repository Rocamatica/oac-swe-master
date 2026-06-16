---
description: Build Hugo site and deploy to Cloudflare Pages via Wrangler. Single command for production deployment.
tags: [hugo, deploy, cloudflare, wrangler, build]
---

# /hugo-deploy

Build Hugo site with production settings and deploy to Cloudflare Pages.

## Workflow

1. **Verify prerequisites**
   - Hugo installed (`hugo version`)
   - Wrangler installed (`wrangler --version`)
   - Logged into Cloudflare (`wrangler whois`)

2. **Build site**
   ```bash
   hugo --minify --gc
   ```

3. **Index search** (if Pagefind is available)
   ```bash
   npx pagefind --source public
   ```

4. **Deploy to Cloudflare Pages**
   ```bash
   wrangler pages deploy public/ --project-name=<project-name>
   ```

## First-time setup

If no Cloudflare project exists yet:
```bash
wrangler pages project create --name <project-name> --production-branch main
```

## Flags

- `--project <name>`: Override project name (default: auto-detect from config)
- `--dry-run`: Build only, skip deploy
- `--skip-audit`: Skip SEO/AEO audit checks before deploy

## Note to OCA

1. Ask the user for the Cloudflare project name if not configured
2. Run build first, check for errors before deploying
3. After deploy, confirm the deployment URL to the user
