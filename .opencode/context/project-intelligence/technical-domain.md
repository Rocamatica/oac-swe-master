<!-- Context: project-intelligence/technical | Priority: critical | Version: 2.0 | Updated: 2026-06-16 -->

# Technical Domain

> Project documentation site powered by Hugo Extended + Pagefind, orchestrated by OpenAgents Control (OAC) v0.7.1 via MCP stdio, CLI tools, and delegated subagents. All deployment through Cloudflare Pages — no GitHub CI/CD.

## Quick Reference

| Aspect | Detail |
|--------|--------|
| **Purpose** | Understand the technical stack, patterns, conventions, and security posture of the Hugo/OAC project |
| **Update When** | Tool version bumps, new MCPs, skill/command additions, convention changes |
| **Audience** | Developers, AI agents, DevOps, technical stakeholders |
| **Key Principle** | MVI — every context file <200 lines, scannable in <30s |

## Primary Stack

| Layer | Technology | Version | Rationale |
|-------|-----------|---------|-----------|
| SSG | Hugo Extended | v0.163.2 | Go-based static site generation, fast builds, flexible templating |
| Language | Go (templates) + Markdown | — | Hugo template engine for layouts; content in Markdown |
| Search | Pagefind | v1.5.2 | Static search index, zero external dependencies at runtime |
| Audit | agentic-seo | v1.0.0 | SEO automation and content quality auditing |
| Audit | seofor.dev | v3.0.1 | Go-based SEO analyzer, CLI via `seo` binary |
| Deploy | Cloudflare Pages (Wrangler) | v4.101.0 | Edge deployment, low latency, generous free tier |
| Orchestration | OpenAgents Control (OAC) | v0.7.1 | AI-agent workflow orchestration via MCP stdio + subagent delegation |

## Code Patterns

### API / Interface Pattern

| Interface | Details |
|-----------|---------|
| **MCP stdio** (3 servers) | `hugo-mcp` (content CRUD), `hugo-memex` (FTS5 search), `hugo-docs-mcp` (quality audit) |
| **CLI npm/Go** | `pagefind`, `agentic-seo`, `seo` (seofor.dev), `wrangler` |
| **OCA delegation** | `task(subagent_type="...")` → specialized subagents |
| **Slash commands** | `/hugo-deploy`, `/commit`, `/context`, `/add-context`, etc. |

### Component Pattern

| Component Type | Location | Count |
|----------------|----------|-------|
| **Skills** | `.opencode/skills/<skill>/SKILL.md` | 10 (7 Hugo + 3 OAC) |
| **Commands** | `.opencode/command/<name>.md` | 18 total |
| **Context files** | `.opencode/context/` (function-based) | Category-organized |
| **External context** | `.opencode/external-context/` (package-based) | Per-library/package |
| **Hugo content** | `content/` pages + `layouts/` templates | Markdown + YAML frontmatter |

## Naming Conventions

| Artifact | Convention | Example |
|----------|-----------|---------|
| Markdown files | kebab-case | `technical-domain.md` |
| Index files | numeric prefix `NN_` | `01_estructura-completa.md` |
| Skills | kebab-case | `hugo-mcp-adapter` |
| Commands | kebab-case | `add-context` |
| Scripts | kebab-case | `install-tools.sh` |
| TS/Go functions | camelCase | `getContent()` |
| TS/Go types/classes | PascalCase | `ContentManager` |

## Code Standards

- **MVI**: Every context file <200 lines, scannable <30s. Formula: concept (1-3 frases) + puntos clave (3-5) + ejemplo mínimo + referencia a código
- **Frontmatter**: HTML `<!-- -->` for `.opencode/context/`; YAML `---` for `.opencode/external-context/`
- **Skills**: Written in English, standard OAC `.md` format. One skill = one directory + `SKILL.md`
- **MCPs**: Python in venv (not global), Go compiled to binary. Communication via MCP stdio only
- **Deployment**: Wrangler + Cloudflare Pages exclusively. No GitHub Actions or CI/CD
- **Build pipeline**: `hugo --minify --gc` → `pagefind --source public` → `wrangler pages deploy`
- **Version pinning**: All tool versions frozen in `.opencode/scripts/install-tools.sh` for reproducibility

## Security Requirements

- **API keys**: Environment variables (`.env`) only, never hardcoded. `.env` in `.gitignore`
- **OCA permissions**: `sudo * deny`, `**/*.env* deny`, `rm -rf * ask`
- **MCP isolation**: Each MCP in its own venv/binary; local communication via stdio (no ports exposed)
- **Wrangler auth**: Manual `wrangler login` per REPON (not automatable)
- **Version lock**: All dependency versions frozen in `install-tools.sh` for deterministic builds

## 📂 Codebase References

| Reference | Location | Purpose |
|-----------|----------|---------|
| Tool installer | `.opencode/scripts/install-tools.sh` | Versions pinned here for all tools |
| MCP configs | `.opencode/mcp/*/.mcp.json` | MCP server definitions |
| Skills | `.opencode/skills/*/SKILL.md` | Skill definitions (7 Hugo + 3 OAC) |
| Commands | `.opencode/command/*.md` | Slash command implementations (18 total) |
| Hugo source | `content/` + `layouts/` | Site content and templates |
| OAC plugin | `.opencode/package.json` | `@opencode-ai/plugin@1.17.7` |

## Related Files

- `business-domain.md` — Business context and problem the tech serves
- `business-tech-bridge.md` — How business needs map to technical solutions
- `decisions-log.md` — Full decision history with rationale (tool choices, architecture)
- `living-notes.md` — Active issues, tech debt, open questions
- `navigation.md` — Quick-start index for project intelligence
