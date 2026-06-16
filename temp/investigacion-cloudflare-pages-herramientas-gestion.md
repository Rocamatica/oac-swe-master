---
propósito: >
  Investigación exhaustiva de herramientas, skills, MCP servers y agentes IA
  para la gestión integral de Cloudflare Pages en todos sus ámbitos
  (despliegue, CI/CD, dominios, funciones, analíticas, entornos, assets).
  Busca una herramienta integral única, o en su defecto el mejor ecosistema
  de herramientas complementarias.
fecha: 2026-06-16
fuente: ExternalScout + Context7 + Web Research
estado: Completo
---

# Investigación: Herramientas para Cloudflare Pages — Gestión Integral

**Propósito:** Encontrar skills, MCP servers o agentes IA para gestionar Cloudflare Pages en todos sus ámbitos, priorizando una herramienta integral única.

**Fecha:** 2026-06-16

---

## Índice

1. [Resumen Ejecutivo](#1-resumen-ejecutivo)
2. [Hallazgo Crítico: Pages ha sido deprecado](#2-hallazgo-crítico-pages-ha-sido-deprecado)
3. [Herramientas Integrales](#3-herramientas-integrales)
   - 3.1 [Wrangler CLI](#31-wrangler-cli-)
   - 3.2 [Cloudflare TypeScript SDK](#32-cloudflare-typescript-sdk-)
   - 3.3 [Cloudflare Terraform Provider](#33-cloudflare-terraform-provider-)
   - 3.4 [Cloudflare Pulumi Provider](#34-cloudflare-pulumi-provider-)
4. [MCP Servers](#4-mcp-servers)
   - 4.1 [Cloudflare API MCP Server (Codemode)](#41-cloudflare-api-mcp-server-codemode-)
   - 4.2 [@cloudflare/mcp-server-cloudflare](#42-cloudflaremcp-server-cloudflare-)
   - 4.3 [Cloudflare Docs MCP Server](#43-cloudflare-docs-mcp-server-)
   - 4.4 [Comparativa MCP Servers](#44-comparativa-mcp-servers)
5. [Agentes IA](#5-agentes-ia)
   - 5.1 [Cloudflare Agents SDK](#51-cloudflare-agents-sdk)
   - 5.2 [Skills / Agentes OpenCode (LobeHub)](#52-skills--agentes-opencode-lobehub)
6. [Ecosistema de Herramientas](#6-ecosistema-de-herramientas)
   - 6.1 [CI/CD y Despliegue](#61-para-cicd-y-despliegue)
   - 6.2 [Automatización Programática](#62-para-automatización-programática)
   - 6.3 [Infraestructura como Código](#63-para-infraestructura-como-código)
   - 6.4 [Frameworks Específicos](#64-para-frameworks-específicos)
7. [Recomendación](#7-recomendación)
   - 7.1 [Mejor Stack 2026](#71-mejor-stack-2026)
   - 7.2 [Estrategia de Migración](#72-estrategia-de-migración)
   - 7.3 [Tabla de Cobertura por Ámbito](#73-tabla-de-cobertura-por-ámbito)
   - 7.4 [Veredicto Final](#74-veredicto-final)
8. [Referencias](#8-referencias)

---

## 1. Resumen Ejecutivo

**No existe una herramienta integral única que cubra todo el ciclo de vida de Cloudflare Pages.** El ecosistema se compone de herramientas complementarias. La conclusión principal es doble:

1. **Wrangler CLI** es la herramienta central y más completa para gestión de Pages (despliegue, configuración, secrets, functions).
2. **Cloudflare API MCP Server** (`cloudflare/mcp` en modo codemode) es la opción más potente para integración con asistentes IA: expone los 2.500+ endpoints de la API de Cloudflare usando solo ~1.000 tokens de contexto.

**Hallazgo crítico:** Cloudflare Pages fue deprecado en abril 2025 y está siendo absorbido por Workers + Static Assets.

---

## 2. Hallazgo Crítico: Pages ha sido deprecado

> **Cloudflare Pages fue deprecado en abril 2025.** Cloudflare está unificando toda la plataforma bajo Workers. Las herramientas para "Pages" son ahora herramientas para "Workers + Static Assets".

| Escenario | Recomendación |
|-----------|---------------|
| **Proyecto NUEVO** | Usar Workers + Static Assets (`wrangler deploy` con `assets` en `wrangler.jsonc`). NO crear nuevo proyecto Pages. |
| **Proyecto EXISTENTE en Pages** | Migrar gradualmente a Workers. Usar el script de migración oficial. |
| **Pages Functions existentes** | Se mantienen funcionales en Pages pero las nuevas features (Durable Objects, Cron Triggers, Queues) son Workers-only. Migrar. |

**Guía de migración oficial:** https://developers.cloudflare.com/workers/static-assets/migration-guides/migrate-from-pages/

---

## 3. Herramientas Integrales

### 3.1 Wrangler CLI ⭐⭐⭐⭐⭐

| Atributo | Valor |
|----------|-------|
| **Repositorio** | https://github.com/cloudflare/workers-sdk |
| **Documentación** | https://developers.cloudflare.com/workers/wrangler/ |
| **Instalación** | `npm install -g wrangler` o `npm install -D wrangler` |
| **Estrellas** | 4.2k ⭐ |
| **Versión** | Wrangler v4 (v4.78.0+) |

**Descripción:** CLI oficial de Cloudflare para gestionar Workers y Pages. Es la herramienta **más completa** para Pages, con subcomandos dedicados.

**Ámbitos que cubre:**

| Comando | Ámbito | Estado |
|---------|--------|--------|
| `wrangler pages project create/list/delete` | Gestión de proyectos Pages | ✅ Completo |
| `wrangler pages deploy` | Despliegue Direct Upload (atomic, content-addressed con blake3) | ✅ Completo |
| `wrangler pages dev` | Servidor de desarrollo local con Pages Functions | ✅ Completo |
| `wrangler pages functions` | Build y gestión de Pages Functions | ✅ Completo |
| `wrangler pages secret` | Gestión de secrets por entorno | ✅ Completo |
| `wrangler pages deployment list` | Listar y gestionar deployments | ✅ Completo |
| `wrangler pages download` | Descargar configuración del proyecto | ✅ Completo |
| `wrangler deploy` (Workers) | Despliegue a Workers (nuevo destino para static assets) | ✅ Completo |
| `wrangler.toml` / `wrangler.jsonc` | Configuración centralizada (redirects, headers, env vars, bindings) | ✅ Completo |
| `wrangler login` / `wrangler whoami` | Autenticación OAuth / API Token | ✅ Completo |
| `wrangler tail` | Logs en tiempo real | ✅ Completo |
| Compatibilidad con `_headers`, `_redirects`, `_routes.json` | Configuración de edge | ✅ Completo |

**Ámbitos NO cubiertos directamente por Wrangler:**
- Analíticas y monitorización avanzadas (requiere dashboard o API)
- Gestión de dominios personalizados y DNS (requiere API o dashboard)
- Headless CMS / deploy hooks (solo trigger vía API)
- Branch management (configurable en dashboard)

**Comandos clave:**
```bash
# Desplegar un proyecto Pages
npx wrangler pages deploy ./dist --project-name mi-proyecto --branch main

# Crear un proyecto
npx wrangler pages project create mi-proyecto --production-branch main

# Desarrollo local con Pages Functions
npx wrangler pages dev ./dist

# Gestionar secrets
npx wrangler pages secret put MI_SECRET --env preview
npx wrangler pages secret list

# Listar deployments
npx wrangler pages deployment list --project-name mi-proyecto
```

**Valoración:** ⭐⭐⭐⭐⭐ (5/5) — Esencial, la base de cualquier workflow con Pages.

---

### 3.2 Cloudflare TypeScript SDK ⭐⭐⭐⭐

| Atributo | Valor |
|----------|-------|
| **Package npm** | https://www.npmjs.com/package/cloudflare |
| **Repositorio** | https://github.com/cloudflare/cloudflare-typescript |
| **Documentación** | https://developers.cloudflare.com/api/ |
| **Versión** | v6.4.0 |

**Descripción:** SDK oficial de TypeScript para la API REST de Cloudflare. Cubre TODOS los servicios incluyendo Pages con endpoints tipados.

**Cobertura de Pages:**
- `pages.projects.list()` / `pages.projects.get()` / `pages.projects.create()` / `pages.projects.delete()`
- `pages.deployments.list()` / `pages.deployments.get()` / `pages.deployments.create()` / `pages.deployments.delete()`
- `pages.builds.list()` / `pages.builds.get()`
- Gestión completa de deploys vía API

```bash
npm install cloudflare
```

```typescript
import Cloudflare from 'cloudflare';
const client = new Cloudflare({ apiToken: process.env.CLOUDFLARE_API_TOKEN });

const projects = await client.pages.projects.list({ accountId });
const deployments = await client.pages.deployments.list({
  accountId, projectName: 'mi-proyecto'
});
```

**Valoración:** ⭐⭐⭐⭐ (4/5) — SDK oficial, bien tipado, cubre toda la API.

---

### 3.3 Cloudflare Terraform Provider ⭐⭐⭐⭐

| Atributo | Valor |
|----------|-------|
| **Repositorio** | https://github.com/cloudflare/terraform-provider-cloudflare |
| **Registry** | https://registry.terraform.io/providers/cloudflare/cloudflare/ |
| **Estrellas** | 1.3k ⭐ / Descargas: 270.5M+ |
| **Versión** | v5.20.0 (junio 2026) — reescritura con generación de código OpenAPI |

**Descripción:** Provider oficial de Terraform para Cloudflare. Permite gestionar Pages como infraestructura como código, incluyendo Workers con Static Assets (el reemplazo de Pages).

**Recurso clave para Pages (vía Workers Assets):**
```hcl
resource "cloudflare_workers_script" "mi_sitio" {
  account_id = var.account_id
  script_name = "mi-sitio"
  compatibility_date = "2025-04-01"
  
  assets {
    config {
      html_handling = "auto-trailing-slash"
      not_found_handling = "404-page"
      run_worker_first = false
      serve_directly = true
    }
    jwt = var.jwt_secret
  }
  
  bindings = [{
    name = "ENVIRONMENT"
    type = "plain_text"
    text = "production"
  }]
}
```

**Valoración:** ⭐⭐⭐⭐ (4/5) — Ideal para equipos que ya usan Terraform.

---

### 3.4 Cloudflare Pulumi Provider ⭐⭐⭐½

| Atributo | Valor |
|----------|-------|
| **Registry** | https://www.pulumi.com/registry/packages/cloudflare/ |
| **Paquetes** | `@pulumi/cloudflare` (Node.js), `pulumi-cloudflare` (Python), Go, .NET, Java |

**Descripción:** Alternativa a Terraform para Infraestructura como Código. Soportado en múltiples lenguajes.

**Valoración:** ⭐⭐⭐½ (3.5/5) — Similar a Terraform, más idiomático para desarrolladores.

---

## 4. MCP Servers

### 4.1 Cloudflare API MCP Server (Codemode) ⭐⭐⭐⭐⭐

| Atributo | Valor |
|----------|-------|
| **Repositorio** | https://github.com/cloudflare/mcp |
| **URL MCP** | `https://mcp.cloudflare.com/mcp` |
| **Estrellas** | 547 ⭐ |
| **Autenticación** | OAuth |

**Descripción:** El MCP server más avanzado de Cloudflare. Usa **Code Mode** (codemode) para exponer los 2.500+ endpoints de la API de Cloudflare usando solo **3 tools** (~1.000 tokens de contexto). Esto es 99.9% más eficiente que un MCP nativo que consumiría ~1.17M tokens.

**Tools:**

| Tool | Descripción |
|------|-------------|
| `docs` | Buscar documentación de Cloudflare Developer |
| `search` | Escribir JavaScript para explorar `spec.paths` y encontrar endpoints |
| `execute` | Escribir JavaScript para llamar `cloudflare.request()` con los endpoints descubiertos |

**Cobertura de Pages:** Total. El agente escribe código JavaScript contra el OpenAPI spec para cualquier operación de Pages: proyectos, deployments, dominios, builds, etc.

```json
// Config en Claude Desktop / Cursor / Windsurf
{
  "mcpServers": {
    "cloudflare-api": {
      "command": "npx",
      "args": ["-y", "cloudflare-mcp"],
      "env": {
        "CLOUDFLARE_API_TOKEN": "tu-token"
      }
    }
  }
}
```

**Valoración:** ⭐⭐⭐⭐⭐ (5/5) — La opción MÁS completa para gestionar Pages desde asistentes IA.

---

### 4.2 @cloudflare/mcp-server-cloudflare ⭐⭐⭐

| Atributo | Valor |
|----------|-------|
| **Package npm** | https://www.npmjs.com/package/@cloudflare/mcp-server-cloudflare |
| **Repositorio** | https://github.com/cloudflare/mcp-server-cloudflare |
| **URL MCP** | `https://bindings.mcp.cloudflare.com/mcp` |
| **Estrellas** | 3.9k ⭐ |
| **Autenticación** | OAuth |
| **Versión** | v0.2.0 |

**Descripción:** MCP server original de Cloudflare con 25 tools para gestionar Workers, KV, R2, D1, Hyperdrive, Durable Objects, Analytics y Queues.

**⚠️ Limitación importante:** NO tiene tools específicas para Pages. No hay `pages_deploy`, `pages_list_projects`, etc.

**Valoración:** ⭐⭐⭐ (3/5) para Pages (no tiene tools específicas).

---

### 4.3 Cloudflare Docs MCP Server ⭐⭐⭐

| Atributo | Valor |
|----------|-------|
| **URL MCP** | `https://docs.mcp.cloudflare.com/mcp` (también SSE: `https://docs.mcp.cloudflare.com/sse`) |
| **Autenticación** | OAuth (abierto, sin API key) |

**Descripción:** Servidor MCP que proporciona acceso a la documentación oficial de Cloudflare mediante búsqueda semántica con Vectorize. NO gestiona recursos, solo proporciona documentación.

**Valoración:** ⭐⭐⭐ (3/5) — Útil como referencia, no para gestión.

---

### 4.4 Comparativa MCP Servers

| Característica | cloudflare/mcp (Codemode) | @cloudflare/mcp-server-cloudflare | Docs MCP |
|----------------|:-------------------------:|:---------------------------------:|:--------:|
| Cobertura Pages | ✅ Total (vía API code execution) | ❌ Sin tools Pages | ❌ Solo docs |
| Tools específicas | 3 (search, execute, docs) | 25 (KV, R2, D1, Workers...) | 2 |
| Tokens necesarios | ~1.000 | ~244.000+ | Bajo |
| Autenticación | OAuth | OAuth | OAuth |
| Ideal para | **Gestión completa desde IA** | Workers/KV/R2/D1 | Consultar docs |
| Estrellas | 547 ⭐ | 3.900 ⭐ | N/A |

---

## 5. Agentes IA

### 5.1 Cloudflare Agents SDK ⭐⭐⭐½

| Atributo | Valor |
|----------|-------|
| **Repositorio** | https://github.com/cloudflare/agents |
| **Package** | `npm install agents` |
| **Documentación** | https://developers.cloudflare.com/agents/ |

**Descripción:** Framework oficial de Cloudflare para construir agentes IA persistentes y stateful que se ejecutan en Durable Objects. Cada agente tiene estado propio, almacenamiento, ciclo de vida, y soporte nativo para MCP.

**No es una herramienta para gestionar Pages**, sino un framework para **construir agentes** que pueden gestionar Pages usando las tools de MCP o la API de Cloudflare.

**Valoración:** ⭐⭐⭐½ (3.5/5) como herramienta de gestión indirecta.

---

### 5.2 Skills / Agentes OpenCode (LobeHub)

| Skill | Descripción | Enlace |
|-------|-------------|--------|
| `cloudflare-ci-cd-github-actions` | Configurar CI/CD de Workers/Pages con GitHub Actions, D1/R2, tests, deploys multi-entorno | https://lobehub.com/skills/agentivecity-skillfactory-cloudflare-ci-cd-github-actions |
| `cloudflare-manager` | Gestión integral de cuenta Cloudflare: Workers, KV, R2, Pages, DNS, Routes | Mencionado en mcp.directory |
| `cloudflare` | Skill integral: Workers, Pages, KV, D1, R2, AI, WAF, Terraform | Mencionado en mcp.directory |

**Conclusión:** No existen agentes IA autónomos específicamente diseñados para gestionar Cloudflare Pages. El enfoque actual es usar MCP servers + asistentes IA (Claude Desktop, Cursor, Windsurf).

---

## 6. Ecosistema de Herramientas

Dado que **no existe una herramienta integral única**, este es el mejor ecosistema de herramientas complementarias:

### 6.1 Para CI/CD y Despliegue

| Herramienta | Propósito | Enlace |
|-------------|-----------|--------|
| **cloudflare/wrangler-action** (v3+) | GitHub Action oficial para Workers y Pages. Wrangler v4. 1.9k ⭐ | https://github.com/marketplace/actions/deploy-to-cloudflare-workers-with-wrangler |
| ~~cloudflare/pages-action~~ | ⚠️ **DEPRECATED** — Migrar a wrangler-action | Archivado |
| andykenward/github-actions-cloudflare-pages | Action alternativa con GitHub Environments, PR comments, delete deployments | https://github.com/andykenward/github-actions-cloudflare-pages |

**Workflow CI/CD recomendado:**
```yaml
name: Deploy to Cloudflare
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm ci && npm run build
      - name: Deploy to Cloudflare
        uses: cloudflare/wrangler-action@v3
        with:
          apiToken: ${{ secrets.CLOUDFLARE_API_TOKEN }}
          command: pages deploy dist --project-name=mi-proyecto --branch=${{ github.head_ref || 'main' }}
```

### 6.2 Para Automatización Programática

| Herramienta | Propósito | Enlace |
|-------------|-----------|--------|
| **Cloudflare REST API** | API completa para Pages (proyectos, deployments, builds, hooks) | https://developers.cloudflare.com/pages/configuration/api/ |
| **Cloudflare TypeScript SDK** (`cloudflare`) | SDK oficial con tipos para toda la API | https://github.com/cloudflare/cloudflare-typescript |
| **Cloudflare Python SDK** (`cloudflare-python`) | SDK oficial para Python | https://github.com/cloudflare/cloudflare-python |
| **Cloudflare Go SDK** (`cloudflare-go`) | SDK oficial para Go | https://github.com/cloudflare/cloudflare-go |

### 6.3 Para Infraestructura como Código

| Herramienta | Propósito | Estado Pages |
|-------------|-----------|:------------:|
| **Terraform** (cloudflare/cloudflare) | Provider oficial, v5.20.0. Pages vía `cloudflare_workers_script` + `assets` block | ✅ Reemplazo completo |
| **Pulumi** (@pulumi/cloudflare) | Provider oficial multi-lenguaje | ✅ Reemplazo completo |

### 6.4 Para Frameworks Específicos

| Herramienta | Propósito | Estado |
|-------------|-----------|:------:|
| ~~@cloudflare/next-on-pages~~ | CLI para Next.js en Pages | ⚠️ **DEPRECATED** — Usar OpenNext |
| **OpenNext** | Next.js en Cloudflare Workers (reemplazo de Pages) | ✅ https://opennext.js.org/cloudflare |
| **Astro adapter-cloudflare** | Astro en Cloudflare | ✅ https://docs.astro.build/en/guides/integrations-guide/cloudflare/ |
| **SvelteKit adapter-cloudflare** | SvelteKit en Cloudflare | ✅ https://kit.svelte.dev/docs/adapter-cloudflare |
| **Remix Cloudflare template** | Remix en Cloudflare | ✅ https://remix.run/docs/en/main/guides/vite |

---

## 7. Recomendación

### 7.1 Mejor Stack 2026

No existe UNA herramienta que haga todo. Esta combinación cubre el 100%:

```
┌─────────────────────────────────────────────────────┐
│                                                     │
│   🎯 ESTRATEGIA RECOMENDADA 2026                    │
│                                                     │
│   Para gestión MANUAL:                              │
│   ┌─────────────────────────────────────────┐       │
│   │  Wrangler CLI (v4)                      │       │
│   │  → wrangler pages deploy/dev/project    │       │
│   │  → wrangler.toml para configuración     │       │
│   │  → wrangler pages secret/functions      │       │
│   └─────────────────────────────────────────┘       │
│                                                     │
│   Para automatización CI/CD:                        │
│   ┌─────────────────────────────────────────┐       │
│   │  cloudflare/wrangler-action (v3)         │       │
│   │  + GitHub Actions workflow               │       │
│   └─────────────────────────────────────────┘       │
│                                                     │
│   Para asistentes IA / agentes:                    │
│   ┌─────────────────────────────────────────┐       │
│   │  cloudflare/mcp (Codemode)              │       │
│   │  → https://mcp.cloudflare.com/mcp       │       │
│   │  → 2.500 endpoints en ~1.000 tokens     │       │
│   │  → Cubre Pages COMPLETAMENTE            │       │
│   └─────────────────────────────────────────┘       │
│                                                     │
│   Para programación/infraestructura:               │
│   ┌─────────────────────────────────────────┐       │
│   │  TypeScript SDK (cloudflare npm)        │       │
│   │  + Terraform / Pulumi (IaC)            │       │
│   └─────────────────────────────────────────┘       │
│                                                     │
└─────────────────────────────────────────────────────┘
```

### 7.2 Estrategia de Migración

| Situación | Acción recomendada |
|-----------|-------------------|
| Proyecto NUEVO | Workers + Static Assets (`wrangler deploy` con `assets`). NO usar Pages |
| Proyecto EXISTENTE en Pages | Migrar gradualmente a Workers + Static Assets |
| Pages Functions existentes | Migrar a Workers. Nuevas features (Durable Objects, Cron, Queues) son Workers-only |

Guía oficial de migración: https://developers.cloudflare.com/workers/static-assets/migration-guides/migrate-from-pages/

### 7.3 Tabla de Cobertura por Ámbito

| Ámbito | Wrangler CLI | MCP Codemode | TypeScript SDK | Terraform | GitHub Action |
|--------|:------------:|:------------:|:--------------:|:---------:|:-------------:|
| Despliegue y CI/CD | ✅ | ✅ | ✅ | ✅ | ✅ |
| Dominios personalizados/DNS | ❌ | ✅ | ✅ | ✅ | ❌ |
| Pages Functions | ✅ | ✅ | ✅ | ✅ | ❌ |
| Redirects/Headers/Routes | ✅ (vía `_headers`, `_redirects`, `wrangler.toml`) | ✅ | ✅ | ✅ (vía assets block) | ❌ |
| Analíticas/Monitorización | ⚠️ (wrangler tail) | ✅ | ✅ | ❌ | ❌ |
| Entornos (preview/prod) | ✅ | ✅ | ✅ | ✅ | ✅ |
| Branch management | ⚠️ (vía --branch flag) | ✅ | ✅ | ✅ | ✅ |
| Assets estáticos/optimización | ✅ | ✅ | ✅ | ✅ | ✅ |
| Secrets | ✅ (wrangler pages secret) | ✅ | ✅ | ✅ (vía bindings) | ✅ |

### 7.4 Veredicto Final

**No existe una herramienta "única y definitiva" para Cloudflare Pages.** El mejor stack en 2026 es:

1. **Wrangler CLI** → Operaciones diarias (dev, deploy, secrets)
2. **cloudflare/wrangler-action** → CI/CD en GitHub
3. **cloudflare/mcp (Codemode)** → Integración con asistentes IA (Claude, Cursor, Windsurf)
4. **TypeScript SDK** → Automatización programática
5. **Terraform/Pulumi** → Infrastructure as Code

> **Para proyectos NUEVOS, usa Workers con Static Assets, no Cloudflare Pages.**

---

## 8. Referencias

| Recurso | Enlace |
|---------|--------|
| Wrangler CLI | https://developers.cloudflare.com/workers/wrangler/ |
| Cloudflare API | https://developers.cloudflare.com/api/ |
| Pages REST API | https://developers.cloudflare.com/pages/configuration/api/ |
| MCP Servers Cloudflare | https://developers.cloudflare.com/agents/model-context-protocol/mcp-servers-for-cloudflare/ |
| cloudflare/mcp (Codemode) | https://github.com/cloudflare/mcp |
| @cloudflare/mcp-server-cloudflare | https://github.com/cloudflare/mcp-server-cloudflare |
| Wrangler GitHub Action | https://github.com/cloudflare/wrangler-action |
| TypeScript SDK | https://github.com/cloudflare/cloudflare-typescript |
| Terraform Provider | https://github.com/cloudflare/terraform-provider-cloudflare |
| Pages → Workers Migration | https://developers.cloudflare.com/workers/static-assets/migration-guides/migrate-from-pages/ |
| Cloudflare Agents SDK | https://github.com/cloudflare/agents |
| Cloudflare Workers SDK | https://github.com/cloudflare/workers-sdk |
