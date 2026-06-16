# HugoMods PWA Module

**Purpose**: Convert Hugo site into a Progressive Web App with service worker, manifest.json, and offline support.
**Module URL**: https://hugomods.com/en/docs/pwa/

## Configuration

Add to `hugo.toml`:
```toml
[[module.imports]]
path = "github.com/hugomods/pwa"

[params.pwa]
enable = true
```

### Customization
```toml
[params.pwa]
enable = true
name = "Site Name"
short_name = "Site"
description = "Site description"
background_color = "#ffffff"
theme_color = "#000000"
display = "standalone"
start_url = "/"
```

## Features

- Service worker for offline caching
- Installable on mobile/desktop (add to home screen)
- Splash screen with configured colors
- Offline fallback page
- Automatic icon generation from configured logo

## Icons

Place a 512x512 PNG logo at `static/icon.png`. The module generates all required sizes.

## Dependencies

- HugoMods base
- Hugo 0.123.0+
