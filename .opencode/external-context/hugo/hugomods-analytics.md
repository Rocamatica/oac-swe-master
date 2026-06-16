# HugoMods Analytics Module

**Purpose**: Integrate analytics services (Google Analytics, Cloudflare, Umami, Plausible) into the Hugo site without modifying layouts.
**Module URL**: https://hugomods.com/en/docs/analytics/

## Configuration

Choose ONE provider and add to `hugo.toml`:

### Google Analytics
```toml
[[module.imports]]
path = "github.com/hugomods/analytics/google-analytics"

[params.analytics.google_analytics]
id = "G-XXXXXXXXXX"
```

### Cloudflare Web Analytics
```toml
[[module.imports]]
path = "github.com/hugomods/analytics/cloudflare"

[params.analytics.cloudflare]
token = "your-cloudflare-token"
```

### Umami
```toml
[[module.imports]]
path = "github.com/hugomods/analytics/umami"

[params.analytics.umami]
src = "https://analytics.example.com/script.js"
id = "your-umami-id"
```

### Plausible
```toml
[[module.imports]]
path = "github.com/hugomods/analytics/plausible"

[params.analytics.plausible]
domain = "example.com"
src = "https://plausible.io/js/script.js"
```

## Features

- Single configuration point in `hugo.toml`
- No layout/partial modifications needed
- Provider can be swapped without changing templates
- Scripts injected into `<head>` automatically

## Dependencies

- HugoMods base
- Account with chosen analytics provider
