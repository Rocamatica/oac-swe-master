---
source: Web Research (websearch, webfetch, Context7)
library: Cloudflare
package: cloudflare-pages-tools
topic: Comprehensive investigation of Cloudflare Pages management tools
fetched: 2026-06-16T12:00:00Z
official_docs: https://developers.cloudflare.com/pages/
---

# Investigación: Herramientas para Cloudflare Pages

**Fecha:** 2026-06-16

## Resumen Ejecutivo

**No existe una herramienta integral única que cubra todo el ciclo de vida de Cloudflare Pages.** El ecosistema se compone de herramientas complementarias. **Wrangler CLI** es la herramienta central y más completa para gestión de Pages (despliegue, configuración, secrets, functions). Para integración con asistentes IA, el **Cloudflare API MCP Server** (cloudflare/mcp, codemode) ofrece acceso a los 2500+ endpoints de la API de Cloudflare incluyendo Pages. Cloudflare **está absorbiendo Pages dentro de Workers** (desde abril 2025), por lo que la estrategia recomendada es usar Workers con Static Assets en lugar de Pages para proyectos nuevos.

> **Hallazgo crítico:** Cloudflare Pages fue deprecado en abril 2025. Cloudflare está unificando toda la plataforma bajo Workers. Las herramientas para "Pages" son ahora herramientas para "Workers + Static Assets". Para proyectos nuevos, NO se recomienda crear nuevos proyectos Pages.

---

## Índice

1. [Herramientas Integrales](#1-herramientas-integrales)
2. [MCP Servers](#2-mcp-servers)
3. [Agentes IA](#3-agentes-ia)
4. [Ecosistema de Herramientas](#4-ecosistema-de-herramientas)
5. [Recomendación](#5-recomendación)

---

## 1. Herramientas Integrales

### 1.1 Wrangler CLI (⭐⭐⭐⭐⭐ - La Herramienta Central)

- **Repositorio:** https://github.com/cloudflare/workers-sdk
- **Documentación:** https://developers.cloudflare.com/workers/wrangler/
- **Instalación:** `npm install -g wrangler` o `npm install -D wrangler`
- **Estrellas:** 4.2k ⭐
- **Versión actual:** Wrangler v4 (v4.78.0+)

**Descripción:** Wrangler es el CLI oficial de Cloudflare para gestionar Workers y Pages. Es la herramienta **más completa** para Pages, con subcomandos dedicados:

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
- Headless CMS / deploy hooks (solo trigger via API)
- Branch management (configurable en dashboard)

**Comandos clave de Pages:**
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

**Valoración:** ⭐⭐⭐⭐⭐ (5/5) - Esencial, la base de cualquier workflow con Pages.

---

### 1.2 Cloudflare TypeScript SDK (⭐ Official SDK)

- **Package npm:** https://www.npmjs.com/package/cloudflare
- **Repositorio:** https://github.com/cloudflare/cloudflare-typescript
- **Documentación:** https://developers.cloudflare.com/api/
- **Versión:** v6.4.0

**Descripción:** SDK oficial de TypeScript para la API REST de Cloudflare. Cubre TODOS los servicios incluyendo Pages con endpoints tipados.

**Ámbitos que cubre de Pages:**
- `pages.projects.list()` / `pages.projects.get()` / `pages.projects.create()` / `pages.projects.delete()`
- `pages.deployments.list()` / `pages.deployments.get()` / `pages.deployments.create()` / `pages.deployments.delete()`
- `pages.builds.list()` / `pages.builds.get()`
- Gestión completa de deploys vía API

**Instalación:**
```bash
npm install cloudflare
```

**Uso básico:**
```typescript
import Cloudflare from 'cloudflare';
const client = new Cloudflare({ apiToken: process.env.CLOUDFLARE_API_TOKEN });

// Listar proyectos Pages
const projects = await client.pages.projects.list({ accountId });

// Obtener deployments
const deployments = await client.pages.deployments.list({
  accountId, projectName: 'mi-proyecto'
});
```

**Valoración:** ⭐⭐⭐⭐ (4/5) - SDK oficial, bien tipado, cubre toda la API.

---

### 1.3 Cloudflare Terraform Provider (Infrastructure as Code)

- **Repositorio:** https://github.com/cloudflare/terraform-provider-cloudflare
- **Registry:** https://registry.terraform.io/providers/cloudflare/cloudflare/
- **Estrellas:** 1.3k ⭐ | Descargas: 270.5M+
- **Versión:** v5.20.0 (junio 2026) - reescritura completa con generación de código OpenAPI

**Descripción:** Provider oficial de Terraform para Cloudflare. Permite gestionar Pages como infraestructura como código, incluyendo Workers con Static Assets (el reemplazo de Pages).

**Ámbitos que cubre:**
- `cloudflare_workers_script` con `assets` block (equivalente a Pages): static assets, headers, redirects, JWT
- `cloudflare_workers_deployment` - despliegues graduales (percentage-based)
- `cloudflare_worker` - gestión de Workers
- DNS, Zones, certificados SSL
- `cloudflare_record` - registros DNS para dominios personalizados
- `cloudflare_rules` - reglas de transformación/redirect

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

**Valoración:** ⭐⭐⭐⭐ (4/5) - Ideal para equipos que ya usan Terraform, aunque más complejo de configurar.

---

### 1.4 Cloudflare Pulumi Provider (IaC Alternativa)

- **Registry:** https://www.pulumi.com/registry/packages/cloudflare/
- **Paquetes:** `@pulumi/cloudflare` (Node.js), `pulumi-cloudflare` (Python), etc.

**Descripción:** Alternativa a Terraform para Infraestructura como Código. Soportado en múltiples lenguajes (TypeScript, Python, Go, .NET, Java).

**Valoración:** ⭐⭐⭐½ (3.5/5) - Similar a Terraform, más idiomático para desarrolladores.

---

## 2. MCP Servers

### 2.1 Cloudflare API MCP Server (Codemode) ⭐⭐⭐⭐⭐

- **Repositorio:** https://github.com/cloudflare/mcp
- **URL MCP:** `https://mcp.cloudflare.com/mcp`
- **Estrellas:** 547 ⭐
- **Autenticación:** OAuth

**Descripción:** El MCP server más avanzado de Cloudflare. Usa **Code Mode** (codemode) para exponer los 2,500+ endpoints de la API de Cloudflare usando solo **3 tools** (~1,000 tokens de contexto). Esto es 99.9% más eficiente que un MCP nativo que consumiría ~1.17M tokens.

**Tools:**
| Tool | Descripción |
|------|-------------|
| `docs` | Buscar documentación de Cloudflare Developer |
| `search` | Escribir JavaScript para explorar `spec.paths` y encontrar endpoints |
| `execute` | Escribir JavaScript para llamar `cloudflare.request()` con los endpoints descubiertos |

**Cobertura de Pages:**
- Este server NO tiene tools específicas para Pages. En su lugar, el agente escribe código JavaScript para:
  - Listar/crear/eliminar proyectos Pages: `spec.paths['/accounts/{account_id}/pages/projects']`
  - Gestionar deployments: `spec.paths['/accounts/{account_id}/pages/projects/{project_name}/deployments']`
  - Configurar dominios: `spec.paths['/accounts/{account_id}/pages/projects/{project_name}/domains']`
  - Y cualquier otro endpoint de la API de Cloudflare

**Ventaja clave:** Como el agente escribe código JS directamente contra el OpenAPI spec, NO hay límite en qué operaciones de Pages se pueden hacer. Cobertura TOTAL de la API.

```json
// Config en Claude Desktop / Cursor
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

**Valoración:** ⭐⭐⭐⭐⭐ (5/5) - La opción MÁS completa para gestionar Pages desde asistentes IA.

---

### 2.2 @cloudflare/mcp-server-cloudflare (Workers Bindings)

- **Package npm:** https://www.npmjs.com/package/@cloudflare/mcp-server-cloudflare
- **Repositorio:** https://github.com/cloudflare/mcp-server-cloudflare
- **URL MCP:** `https://bindings.mcp.cloudflare.com/mcp`
- **Estrellas:** 3.9k ⭐
- **Autenticación:** OAuth
- **Versión:** v0.2.0

**Descripción:** El MCP server original de Cloudflare con 25 tools para gestionar Workers, KV, R2, D1, Hyperdrive, Durable Objects, Analytics y Queues.

**Tools disponibles:**
- **KV:** `get_kvs`, `kv_get`, `kv_put`, `kv_list`, `kv_delete`
- **R2:** `r2_list_buckets`, `r2_create_bucket`, `r2_delete_bucket`, `r2_list_objects`, `r2_get_object`, `r2_put_object`, `r2_delete_object`
- **D1:** `d1_list_databases`, `d1_create_database`, `d1_delete_database`, `d1_query`
- **Workers:** `worker_list`, `worker_get`, `worker_put`, `worker_delete`
- **Durable Objects:** ` durable_objects_list`
- **Queues:** `queues_list`, `queues_create`, `queues_delete`
- **Analytics:** `analytics_get`
- **Account:** `account_list`, `account_set`

**⚠️ Limitación importante:** Este server NO tiene tools específicas para Pages. No hay `pages_deploy`, `pages_list_projects`, etc. Las operaciones de Pages no están cubiertas directamente.

**Valoración:** ⭐⭐⭐ (3/5) para Pages (no tiene tools específicas de Pages)

---

### 2.3 Cloudflare Docs MCP Server

- **URL MCP:** `https://docs.mcp.cloudflare.com/mcp` (también vía SSE: `https://docs.mcp.cloudflare.com/sse`)
- **Autenticación:** OAuth (abierto, sin API key)

**Descripción:** Servidor MCP que proporciona acceso a la documentación oficial de Cloudflare mediante búsqueda semántica con Vectorize. NO gestiona recursos, solo proporciona información/documentación.

**Tools:**
- 2 tools de búsqueda en documentación
- Cobertura: Workers, Pages, Security, AI, Storage, etc.

**Valoración:** ⭐⭐⭐ (3/5) - Útil como referencia, no para gestión.

---

### 2.4 Comparativa MCP Servers

| Característica | cloudflare/mcp (Codemode) | @cloudflare/mcp-server-cloudflare | Docs MCP |
|----------------|--------------------------|-----------------------------------|----------|
| Cobertura Pages | ✅ Total (vía API code execution) | ❌ No tiene tools Pages | ❌ Solo docs |
| Tools específicas | 3 (search, execute, docs) | 25 (KV, R2, D1, Workers...) | 2 |
| Tokens necesarios | ~1,000 | ~244,000+ | Bajo |
| Autenticación | OAuth | OAuth | OAuth |
| Ideal para | **Gestión completa de Cloudflare + Pages desde IA** | Gestión de Workers/KV/R2/D1 | Consultar documentación |
| Estrellas | 547 ⭐ | 3,900 ⭐ | N/A |

---

## 3. Agentes IA

### 3.1 Cloudflare Agents SDK

- **Repositorio:** https://github.com/cloudflare/agents
- **Package:** `npm install agents`
- **Documentación:** https://developers.cloudflare.com/agents/

**Descripción:** Framework oficial de Cloudflare para construir agentes IA persistentes y stateful que se ejecutan en Durable Objects. Cada agente tiene estado propio, almacenamiento, ciclo de vida, y soporte nativo para MCP.

**No es una herramienta para gestionar Pages**, sino un framework para **construir agentes que pueden gestionar Pages** usando las tools de MCP o la API de Cloudflare.

**Uso relevante:** Podrías construir un agente IA personalizado que gestione Pages usando el Agents SDK + el Cloudflare API MCP server.

**Valoración:** ⭐⭐⭐½ (3.5/5) como herramienta de gestión indirecta.

---

### 3.2 Skills / Agentes OpenCode (LobeHub)

| Skill | Descripción | Enlace |
|-------|-------------|--------|
| `cloudflare-ci-cd-github-actions` | Skill para configurar CI/CD de Workers/Pages con GitHub Actions, D1/R2, tests, deploys multi-entorno | https://lobehub.com/skills/agentivecity-skillfactory-cloudflare-ci-cd-github-actions |
| `cloudflare-manager` | Gestión integral de cuenta Cloudflare: Workers, KV, R2, Pages, DNS, Routes | Mencionado en mcp.directory |
| `cloudflare` | Skill integral de la plataforma Cloudflare: Workers, Pages, KV, D1, R2, AI, WAF, Terraform | Mencionado en mcp.directory |

No existen agentes IA autónomos específicamente diseñados para gestionar Cloudflare Pages. El enfoque actual es usar MCP servers + asistentes IA (Claude Desktop, Cursor, Windsurf).

---

## 4. Ecosistema de Herramientas

Dado que NO existe una herramienta integral única, este es el mejor ecosistema de herramientas complementarias:

### 4.1 Para CI/CD y Despliegue

| Herramienta | Propósito | Enlace |
|-------------|-----------|--------|
| **cloudflare/wrangler-action** (v3+) | GitHub Action oficial para Workers y Pages. Soporta Wrangler v4. 1.9k ⭐ | https://github.com/marketplace/actions/deploy-to-cloudflare-workers-with-wrangler |
| **cloudflare/pages-action** | ⚠️ **DEPRECATED** - Migrar a wrangler-action | https://github.com/cloudflare/pages-action (archivado) |
| **andykenward/github-actions-cloudflare-pages** | Action alternativa con GitHub Environments, PR comments, delete deployments | https://github.com/andykenward/github-actions-cloudflare-pages |

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

### 4.2 Para Automatización Programática

| Herramienta | Propósito | Enlace |
|-------------|-----------|--------|
| **Cloudflare REST API** | API completa para Pages (proyectos, deployments, builds, hooks) | https://developers.cloudflare.com/pages/configuration/api/ |
| **Cloudflare TypeScript SDK** (`cloudflare`) | SDK oficial con tipos para toda la API | https://github.com/cloudflare/cloudflare-typescript |
| **Cloudflare Python SDK** (`cloudflare-python`) | SDK oficial para Python | https://github.com/cloudflare/cloudflare-python |
| **Cloudflare Go SDK** (`cloudflare-go`) | SDK oficial para Go | https://github.com/cloudflare/cloudflare-go |

### 4.3 Para Infraestructura como Código

| Herramienta | Propósito | Estado Pages |
|-------------|-----------|-------------|
| **Terraform** (cloudflare/cloudflare) | Provider oficial, v5.20.0. Pages vía `cloudflare_workers_script` con `assets` block | ✅ Reemplazo completo |
| **Pulumi** (@pulumi/cloudflare) | Provider oficial multi-lenguaje | ✅ Reemplazo completo |

### 4.4 Para Frameworks Específicos

| Herramienta | Propósito | Estado |
|-------------|-----------|--------|
| **@cloudflare/next-on-pages** | CLI para Next.js en Pages | ⚠️ **DEPRECATED** - Usar OpenNext |
| **OpenNext** | Next.js en Cloudflare Workers (Pages replacement) | ✅ https://opennext.js.org/cloudflare |
| **Astro adapter-cloudflare** | Astro en Cloudflare | ✅ https://docs.astro.build/en/guides/integrations-guide/cloudflare/ |
| **SvelteKit adapter-cloudflare** | SvelteKit en Cloudflare | ✅ https://kit.svelte.dev/docs/adapter-cloudflare |
| **Remix Cloudflare template** | Remix en Cloudflare | ✅ https://remix.run/docs/en/main/guides/vite |

---

## 5. Recomendación

### Mejor Opción Integral: Wrangler CLI + Cloudflare API MCP Server (Codemode)

No existe UNA herramienta que haga todo. Pero esta combinación cubre el 100%:

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
│   │  → 2,500 endpoints en ~1,000 tokens     │       │
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

### ⚠️ Aviso Importante: Pages está siendo absorbido por Workers

**Cloudflare Pages fue deprecado en abril 2025.** Las nuevas funcionalidades solo llegan a Workers. Pages recibe solo mantenimiento. Estrategia recomendada:

| Escenario | Recomendación |
|-----------|---------------|
| **Proyecto NUEVO** | Usar Workers + Static Assets (`wrangler deploy` con `assets` en `wrangler.jsonc`). NO crear nuevo proyecto Pages. |
| **Proyecto EXISTENTE en Pages** | Migrar gradualmente a Workers. Usar el script de migración oficial: https://developers.cloudflare.com/workers/static-assets/migration-guides/migrate-from-pages/ |
| **Pages Functions existentes** | Se mantienen funcionales en Pages pero las nuevas features (Durable Objects, Cron Triggers, Queues) son Workers-only. Migrar. |

### Tabla de Cobertura por Ámbito

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

### Veredicto Final

**No existe una herramienta "única y definitiva" para Cloudflare Pages.** El mejor stack en 2026 es:

1. **Wrangler CLI** → Operaciones diarias (dev, deploy, secrets)
2. **cloudflare/wrangler-action** → CI/CD en GitHub
3. **cloudflare/mcp (Codemode)** → Integración con asistentes IA (Claude, Cursor, Windsurf)
4. **TypeScript SDK** → Automatización programática
5. **Terraform/Pulumi** → Infrastructure as Code

Y para proyectos NUEVOS, **usa Workers con Static Assets**, no Pages.

---

## Referencias

- Wrangler CLI: https://developers.cloudflare.com/workers/wrangler/
- Cloudflare API: https://developers.cloudflare.com/api/
- Pages REST API: https://developers.cloudflare.com/pages/configuration/api/
- Cloudflare MCP Servers: https://developers.cloudflare.com/agents/model-context-protocol/mcp-servers-for-cloudflare/
- cloudflare/mcp (Codemode): https://github.com/cloudflare/mcp
- @cloudflare/mcp-server-cloudflare: https://github.com/cloudflare/mcp-server-cloudflare
- Wrangler GitHub Action: https://github.com/cloudflare/wrangler-action
- TypeScript SDK: https://github.com/cloudflare/cloudflare-typescript
- Terraform Provider: https://github.com/cloudflare/terraform-provider-cloudflare
- Pages → Workers Migration Guide: https://developers.cloudflare.com/workers/static-assets/migration-guides/migrate-from-pages/
- Cloudflare Agents SDK: https://github.com/cloudflare/agents
- Cloudflare Workers SDK (Wrangler source): https://github.com/cloudflare/workers-sdk
