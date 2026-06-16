# HugoMods Bootstrap Module

**Purpose**: Integrate Bootstrap 5 CSS framework with Hugo Pipes. Includes responsive grid, components, and utilities via SCSS.
**Module URL**: https://hugomods.com/en/docs/bootstrap/

## Configuration

Add to `hugo.toml`:
```toml
[[module.imports]]
path = "github.com/hugomods/bootstrap"
```

### Customize Bootstrap variables

Create `assets/hugomods/bootstrap/scss/_variables.scss`:
```scss
$primary: #0d6efd;
$border-radius: 0.5rem;
$font-family-base: 'Inter', sans-serif;
```

### Include only needed components

Create `assets/hugomods/bootstrap/scss/_index.scss`:
```scss
@import "functions";
@import "variables";
@import "maps";
@import "mixins";
@import "root";
@import "reboot";
@import "type";
@import "grid";
@import "buttons";
@import "nav";
@import "navbar";
@import "card";
```

## Features

- SCSS compilation via Hugo Pipes (minified + fingerprinted in production)
- Customizable variables
- Only include components you need (smaller CSS)
- Auto-purge unused styles in production

## Usage in layouts

```html
<div class="container">
  <div class="row">
    <div class="col-md-6">
      <div class="card">
        <div class="card-body">
          <h5 class="card-title">Título</h5>
          <p class="card-text">Contenido</p>
        </div>
      </div>
    </div>
  </div>
</div>
```

## Dependencies

- HugoMods base
- Hugo 0.123.0+
