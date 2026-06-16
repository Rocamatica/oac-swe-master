# Checklist — Pasos 1 a 3 del flujo Hugo (interacción dinámica OAC)

**Propósito**: Checklist de trabajo para implementar los pasos 1 a 3 del flujo Hugo usando artefactos OAC (interacción dinámica adaptativa).

**Fecha**: 2026-06-16

**Flujo de referencia**: `01-flujo-trabajo-hugo.md` (pasos 1-3)

---

## Fase A: Preparar contexto Hugo

- [x] **A1** — Consultar documentación actual de Hugo con ExternalScout/Context7
      → Ya existe contexto en `.opencode/external-context/hugo/` (12+ archivos, 4 en manifest)
      → configuration.md cubre hugo.toml, directory-structure.md cubre estructura
      → Suficiente para pasos 1-3. Se puede ampliar más adelante si es necesario.
- [x] **A2** — Verificar versión de Hugo en el sistema y última versión estable disponible
      → Instalado: **v0.157.0** (Feb 2026)
      → Última estable: **v0.163.1** (según web oficial Hugo, Jun 2026)
      → Hay que actualizar

## Fase B: Definir la interacción dinámica (el "algo de OAC")

- [x] **B1** — Diseñar el árbol de preguntas adaptativas para recopilar:
      - Nombre del proyecto (determina `hugo new site <nombre>`)
      - Datos para `hugo.toml` (`baseURL`, `title`, `locale`, `params`, etc.)
      - Preguntas dependientes según respuestas anteriores
      → Documentado en `recursos/flujos/interaccion-dinamica-inicializar-hugo.md`
- [x] **B2** — Decidir el artefacto OAC concreto:
      - ✅ **Workflow ejecutado por OpenAgent directamente**
      - Guiado por el documento de flujo + contexto Hugo
      - El prompt 01-P es el punto de entrada
      → Decisión documentada en el mismo archivo (sección B2)
- [x] **B3** — Implementar la lógica de preguntas condicionales:
      - Pseudocódigo del flujo de interacción
      - 8 nodos de preguntas con ramas condicionales y opcionales
      - Confirmación final antes de ejecutar
      → Documentado en el mismo archivo (sección B3)

## Fase C: Mejorar el prompt 01-P

- [x] **C1** — Reescribir `01-P-iniciar-sitio-hugo.md` como prompt OCA actualizado:
      - Regla de versiones corregida (última estable, funcional y no beta)
      - Nueva estructura en 3 fases: verificar Hugo → interacción dinámica → confirmar + ejecutar
      - Árbol de 8 preguntas adaptativas con opcionales
      - Pregunta una a la vez, sin adelantarse
      - Referencias a `recursos/flujos/interaccion-dinamica-inicializar-hugo.md`
      → Prompt reescrito como `recursos/prompts/01-P-iniciar-sitio-hugo.md`

## Fase D: Ejecución (cuando esté aprobado)

- [ ] **D1** — Verificar/instalar Hugo (última versión estable)
- [ ] **D2** — Desplegar la interacción dinámica con el usuario
- [ ] **D3** — Crear el proyecto Hugo + `hugo.toml` con datos recopilados
- [ ] **D4** — Verificar estructura y confirmar

---

## Orden de ejecución recomendado

```
Fase B (definir interacción) → Fase A + C (contexto + prompt, en paralelo) → Fase D (ejecución)
```

*Checklist generado a partir de la sesión de entendimiento OpenAgent — 2026-06-16*
