# Reglas OAC-Hugo

**Propósito**: Archivo único con todas las reglas que rigen la interacción entre el usuario, OAC y Hugo en el proyecto PYT-SWE.

**Fecha**: 2026-06-16

---

## Reglas generales del proyecto

6. **Este repositorio es una base clonable.** No contiene proyectos específicos (PYT). Todo el contenido que se cree aquí debe ser reutilizable al clonar el repositorio.

7. **No usar `/add-context` ni project-intelligence en este repositorio base.** Pertenecen al proyecto clonado, donde hay un stack concreto que registrar.

Seguir las reglas definidas en `reglas-abreviaciones.txt` (español de España RAE, no inventar, no abreviaciones en respuestas, reglas siempre presentes).

Además, se aplican las siguientes:

1. **Explicar como tutorial paso a paso**. No adelantarse a lo que el usuario pregunta. Responder solo a lo preguntado, sin información no solicitada.
2. **No ejecutar sin preguntar ni confirmar**. Antes de ejecutar cualquier acción (instalar, modificar, crear archivos), preguntar primero y esperar confirmación explícita del usuario.
3. **Guardar el conocimiento obtenido** de Context7, ExternalScout o cualquier fuente externa en `.opencode/external-context/hugo/` para que esté disponible en consultas futuras.
4. **OAC gestiona todo el trabajo con Hugo**. El usuario interactúa exclusivamente con OAC. OAC, mediante OCC (OpenCoder), gestiona instalación, configuración, generación de contenido, build y despliegue. Cualquier cambio se canaliza a través de OAC. Antes de gestionar Hugo, OAC debe estar preparado: contexto completo y sin gaps.
5. **No duplicar información**. Cada contenido debe aparecer una sola vez en un único archivo. No repetir parcial ni totalmente información dentro de un mismo archivo ni entre archivos distintos. Si un contenido es necesario desde otro lugar, usar referencias entre archivos (enlaces, citas a otros documentos) sin copiar ni duplicar el contenido original.

---

## Arquitectura de interacción: Usuario ↔ OAC ↔ Hugo

```
Usuario ↔ OAC (OCC) ↔ Hugo
```

### Reglas

1. **OAC gestiona todo el trabajo con Hugo** mediante OCC (OpenCoder). Toda interacción técnica con Hugo se realiza a través de OAC.
2. **El usuario interactúa exclusivamente con OAC**. OAC traduce las instrucciones del usuario a comandos y configuraciones de Hugo.
3. **No se ejecutan comandos de Hugo directamente**. OAC, a través de OCC, gestiona la instalación, configuración, generación de contenido, construcción y despliegue.
4. **Preparar OAC primero**. Para que OAC pueda gestionar Hugo, hay que verificar que el contexto de Hugo está completo en `.opencode/external-context/hugo/` y que no hay gaps.
5. **Los cambios se canalizan por OAC**. Cualquier modificación en la configuración o estructura de Hugo debe canalizarse a través de OAC para mantener la coherencia del contexto del proyecto.

---

## Abreviaciones del proyecto (extracto relevante)

Extraído de `reglas-abreviaciones.txt`:

| Abreviatura | Significado |
|-------------|-------------|
| OAC | OpenAgentsControl |
| OCC | OpenCoder |
| OC | OpenCode |
| PYT | Proyecto |
| SWE | Sitio Web Estático |
| H | Hugo |
| WF | Workflow / Flujo de trabajo |
