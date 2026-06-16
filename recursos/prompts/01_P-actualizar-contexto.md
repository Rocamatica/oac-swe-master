# Prompt: Actualizar sistema de contexto

**Propósito**: Inicializar o actualizar el sistema de contexto del REPOC/REPON
después de clonar, hacer pull, o añadir nueva documentación. Ejecuta todos los
pasos de la Fase 8 del plan de implementación.

**Uso**: Copia y pega este bloque en el chat de OCA.

---

## Prompt

```
Carga recursos/05_plan-implementacion-repoc.md y localiza la sección "Fase 8: Integración del sistema de contexto".

Ejecuta la Fase 8 completa paso a paso:

1. **Fase 8.1** — Indexar external-context/ en navigation.md
   - Añade rutas directas a external-context/oac/ y external-context/hugo/ en la tabla de rutas rápidas
   - Añade subcategoría external-context/ en "By Category"

2. **Fase 8.2** — ContextOrganizer sobre .opencode/external-context/
   - Delega al subagente ContextOrganizer para analizar la estructura
   - 34 archivos en oac/ (14), hugo/ (19), cloudflare-pages-tools/ (1)
   - Evaluar si la estructura plana por tema es suficiente o necesita reestructuración

3. **Fase 8.3** — Ejecutar /add-context --update
   - Wizard interactivo de 6 preguntas
   - Registrar tech stack: Hugo + HugoMods + Cloudflare Pages + OAC v0.7.1
   - Registrar API pattern: MCP stdio, npm CLI, Go binaries
   - Registrar component pattern: skills .md, comandos slash, contextos markdown
   - Registrar naming: kebab-case, prefijo numérico NN_ para índices
   - Registrar standards: MVI <200 líneas, frontmatter YAML, referencias cruzadas
   - Registrar security: API keys en env, permisos denegados para sudo/*.env

4. **Fase 8.4** — Ejecutar /context harvest
   - Extraer conocimiento de resúmenes de sesión a contexto permanente
   - Buscar archivos *OVERVIEW.md, *SUMMARY.md, SESSION-*.md, etc.

5. **Fase 8.5** — Ejecutar /context organize (modo dry-run primero)
   - Revisar estructura de core/ y project-intelligence/
   - Aplicar reorganización si es necesaria

6. **Fase 8.6** — Ejecutar /context validate
   - Verificar integridad: enlaces rotos, frontmatter, referencias

7. **Fase 8.7** — Verificación final
   - Confirmar que ContextScout descubre todos los archivos
   - Confirmar que navigation.md referencia todos los directorios
   - Hacer commit + push si todo está correcto

Importante: antes de cada acción, preséntame el plan y espera mi aprobación.
Explica cada paso antes de ejecutarlo.
```

---

## Uso rápido (una línea)

Si prefieres algo más breve:

```
Ejecuta la Fase 8 completa de recursos/05_plan-implementacion-repoc.md paso a paso, pidiendo aprobación antes de cada acción.
```

---

## Notas

- Los comandos `/add-context` y `/context` son comandos slash de OAC — se
  ejecutan dentro del chat, no en terminal
- `/add-context --update` es un wizard interactivo de 6 preguntas (~5 min)
- `/context harvest` extrae conocimiento de archivos temporales a contexto permanente
- `/context validate` verifica enlaces rotos y consistencia
- Si es un REPON recién clonado, ejecuta primero
  `bash .opencode/scripts/install-tools.sh` antes de este prompt
