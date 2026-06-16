# P-iniciar-sitio-hugo — Inicializar Hugo y crear nuevo sitio

**Versión**: OCA v2 (adaptado para OpenAgent)
**Actualizado**: 2026-06-16

Configura Hugo e inicializa un nuevo sitio web estático con interacción dinámica adaptativa. Este prompt es el **punto de entrada** que activa el framework de configuración de Hugo en REPON.

---

## Flujo de trabajo

### Fase 1: Verificar/instalar Hugo

1. Comprueba si Hugo está instalado en el sistema.
2. Si no está instalado → instala la **última versión estable** (ver regla de versiones).
3. Si está instalado → verifica que sea la última versión estable disponible.
4. Confirma al usuario el resultado.

**Regla de versiones**: Siempre la **última versión estable** de los componentes requeridos. Hay que confirmar/verificar que sean **funcionales y no betas**. No usar versiones extended a menos que se requiera explícitamente Sass/SCSS.

### Fase 2: Interacción dinámica (recopilar datos)

Actúa como asistente interactivo. Pregunta al usuario **una cosa a la vez**, adaptando las siguientes preguntas según sus respuestas. Sigue el árbol definido en `recursos/flujos/interaccion-dinamica-inicializar-hugo.md`.

**Secuencia de preguntas** (cada respuesta determina la siguiente):

1. **Nombre del proyecto** → determina `hugo new site <nombre>`
2. **Título del sitio** → `title` en `hugo.toml`
3. **Base URL** → `baseURL` (si no tiene, valor por defecto)
4. **Idioma** → `locale` (si no sabe, `es-es`)
5. **Descripción SEO** → opcional (`params.description`)
6. **Autor** → opcional (`params.author`)
7. **Redes sociales** → opcional con bucle (`params.social.*`)
8. **Tema/estilo** → opcional avanzado

**Reglas de interacción**:
- Una pregunta a la vez, sin adelantarse
- Cada pregunta se elige según la respuesta anterior
- Campos opcionales se ofrecen como "¿Quieres añadir X?" con opción a saltar
- Si el usuario no sabe, proponer un valor sensato (siempre cambiable después)
- Explicar brevemente cada campo si es necesario (máximo 1 frase)

### Fase 3: Confirmación y ejecución

1. Cuando toda la información está recopilada, muestra un **resumen** al usuario:
   - Nombre del proyecto
   - Título
   - URL base
   - Idioma
   - Descripción (si la hay)
   - Autor (si lo hay)
   - Redes sociales (si las hay)
2. Pregunta: "¿Confirmamos?"
3. Si el usuario confirma → ejecuta `hugo new site <nombre>` y escribe `hugo.toml` con todos los datos.
4. Si el usuario rechaza → permite corregir el campo que desee.
5. Verifica la estructura creada y confirma al usuario que el sitio está listo.

---

## Referencias

- `recursos/flujos/triada-usuario-oac-hugo.md` — Arquitectura de la tríada
- `recursos/flujos/interaccion-dinamica-inicializar-hugo.md` — Árbol de preguntas detallado
- `.opencode/external-context/hugo/configuration.md` — Configuración de Hugo
- `.opencode/external-context/hugo/directory-structure.md` — Estructura del proyecto

## Notas

- El usuario no ejecuta comandos directamente. Todo se canaliza a través de OAC.
- No adelantarse, no explicar lo que viene después. Solo la pregunta actual.
- Tono tutorial pero conciso.
- Aplica a REPON (repositorio clonado), no a REPOC.
