# HugoMods Icons Module

**Purpose**: SVG icon shortcodes from Bootstrap, Font Awesome, Material Design, and Simple Icons. Renders icons inline without loading icon font CSS.
**Module URL**: https://hugomods.com/en/docs/icons/

## Configuration

Add to `hugo.toml`:
```toml
[[module.imports]]
path = "github.com/hugomods/icons/vendors/bootstrap"
```

### Available vendor modules

| Vendor | Import path | Prefix |
|--------|-------------|--------|
| Bootstrap | `github.com/hugomods/icons/vendors/bootstrap` | `bi` |
| Font Awesome | `github.com/hugomods/icons/vendors/font-awesome` | `fa` |
| Material Design | `github.com/hugomods/icons/vendors/material-design` | `md` |
| Simple Icons | `github.com/hugomods/icons/vendors/simple-icons` | `si` |

## Shortcodes

```markdown
{{< icon "bootstrap bi-github" >}}
{{< icon "font-awesome fa-solid fa-house" >}}
{{< icon "material-design md-face" >}}
{{< icon "simple-icons si-nextdotjs" >}}
```

## Features

- SVG rendered inline (no HTTP requests)
- Customizable size and color via CSS
- No external CSS/font dependencies
- Supports all Bootstrap, FA, Material, and Simple Icons

## Dependencies

- At least one vendor module imported
- HugoMods base
