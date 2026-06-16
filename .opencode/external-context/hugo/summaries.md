---
source: Context7 API
library: Hugo
package: hugo
topic: Summaries
fetched: 2026-06-16
official_docs: https://gohugo.io/content-management/summaries/
---

# Resúmenes en Hugo

## Tres formas (por prioridad)
1. Manual: <!--more--> en el Markdown
2. Front matter: summary: "texto"
3. Automático: summaryLength en hugo.toml (default 70 palabras)

## Uso en plantillas
{{ .Summary }}
{{ if .Truncated }}<a href="{{ .RelPermalink }}">Leer más</a>{{ end }}
