# Análisis OAC — Mapa de necesidades, perfiles y recomendación

**Propósito**: Documento de referencia con el análisis de componentes de OAC que aplican al proyecto PYT-SWE (OAC+Hugo), la comparación de perfiles de instalación y la recomendación razonada del perfil completo (full). Extraído del análisis original (ahora en `legado/analisis-pyt-swe-oac-cf.md`).

**Fecha**: 2026-06-16

---

## Resumen ejecutivo

El proyecto requiere simultáneamente componentes de ejecución técnica (orquestación, codificación, despliegue, validación) y componentes de contenido (redacción, imágenes). Ningún perfil de OAC por debajo de "completo (full)" cubre ambos grupos.

El perfil **completo (full)** (50 componentes) es el recomendado porque incluye tanto los agentes técnicos (OpenCoder, CoderAgent, Frontend Specialist, DevOps Specialist, Reviewer, BuildAgent) como los de contenido (Copywriter, Image Specialist), además de comandos útiles (`/optimize`, `/analyze-patterns`) y el contexto completo.

---

## Índice

1. [Mapa de necesidades del proyecto contra componentes de OAC](#1-mapa-de-necesidades-del-proyecto-contra-componentes-de-oac)
   - 1.1 Agentes y subagentes que aplican
   - 1.2 Habilidades (skills) necesarias
   - 1.3 Comandos útiles
   - 1.4 Sistema de contexto
2. [Perfiles de instalación de OAC: análisis](#2-perfiles-de-instalación-de-oac-análisis)
   - 2.1 Composición de cada perfil
   - 2.2 Cobertura de necesidades por perfil
3. [Nueva recomendación de perfil](#3-nueva-recomendación-de-perfil)
   - 3.1 Perfil recomendado: completo (full)
   - 3.2 Qué incluye que sirve para este proyecto
   - 3.3 Tabla de uso prevista

---

## 1. Mapa de necesidades del proyecto contra componentes de OAC

### 1.1 Agentes y subagentes que aplican

A continuación se listan los componentes de OAC que aplican a las necesidades confirmadas del proyecto.

| Necesidad del proyecto | Componente de OAC | Descripción |
|-----------------------|-------------------|-------------|
| **Orquestación general** del flujo: recibir necesidades, coordinar subagentes, tareas y validaciones | **OpenAgent** (agente universal) | Agente universal para preguntas, tareas y coordinación de workflows. Flujo: Analyze → Approve → Execute → Validate → Summarize → Confirm |
| **Orquestación compleja** con batches paralelos cuando se crean múltiples sitios | **OpenCoder** (orquestador de desarrollo) | Especialista en implementación compleja con ejecución paralela de tareas por batches usando BatchExecutor |
| **Descomposición** de la creación de cada sitio en tareas atómicas verificables | **TaskManager** | Descomposición de funcionalidades en subtareas atómicas JSON con dependencias |
| **Redacción de contenidos** del sitio (páginas, blog, SEO) | **Copista (Copywriter)** | Redacción de marketing y contenido |
| **Tratamiento de imágenes** (optimización, generación, adaptación) | **Especialista en Imágenes (Image Specialist)** | Subagente en categoría subagents/utils/ |
| **Creación de plantillas y diseño visual** de los sitios | **Especialista Frontend (OpenFrontendSpecialist)** | UI/UX con flujo de 4 etapas: Layout → Theme → Animation → Implementation |
| **Generación de código** HTML, CSS, JS, configuración de Hugo | **Agente de Codificación (CoderAgent)** | Implementación de subtareas de código individuales |
| **Configuración de despliegue** Cloudflare Pages | **Especialista en Operaciones (OpenDevopsSpecialist)** | CI/CD, infraestructura como código |
| **Validación** de que el sitio se ha generado y desplegado correctamente | **Revisor de Código (CodeReviewer)** | Code review + análisis de seguridad |
| **Validación de compilación** (asegurar que Hugo compila sin errores) | **Agente de Compilación (BuildAgent)** | Type checking + build validation |
| **Descubrimiento de contexto** del proyecto (configuraciones, plantillas, dominios) | **Rastreador de Contexto (ContextScout)** | Descubrimiento inteligente de archivos de contexto |
| **Documentación actualizada** de Hugo, Cloudflare Pages y sus APIs | **Rastreador Externo (ExternalScout)** vía Context7 | Documentación viva de librerías externas (vía Context7 API) |
| **Documentación** del proceso de creación de cada sitio y del proyecto en general | **Escritor de Documentación (DocWriter)** | Generación de documentación |

### 1.2 Habilidades (skills) necesarias

| Habilidad | Estado | Nota |
|-----------|--------|------|
| **Habilidad de gestión de tareas (task-management)** | Ya incluida en OAC (skill oficial) | CLI de gestión de tareas: SKILL.md + router.sh + scripts/task-cli.ts |
| **Habilidad de documentación actualizada (context7)** | Ya incluida en OAC (skill oficial) | Documentación actualizada de librerías vía API Context7 |
| **Cloudflare Pages** (despliegue, configuración de compilación, dominios personalizados) | Pendiente de crear | Habilidad especializada propuesta por el usuario |
| **Hugo** | Contexto completo (13 fichas en external-context); skill pendiente de crear si se necesita como skill OpenCode | Habilidad especializada propuesta por el usuario |
| **Redacción SEO** | Pendiente de crear | Habilidad especializada propuesta por el usuario |
| **Traducción i18n** | Pendiente de crear | Habilidad especializada propuesta por el usuario |
| **Estructura de sitio web estático** | Pendiente de crear | Habilidad especializada propuesta por el usuario |
| **Otras habilidades** | Según se necesiten | El usuario indicó que se usarán roles o skills disponibles en internet o creados a través de OAC |

### 1.3 Comandos útiles

| Comando de OAC | Aplicación en el proyecto |
|----------------|--------------------------|
| **`/add-context`** | Configurar el contexto del proyecto: definir el stack tecnológico (Hugo, Cloudflare Pages, Cloudflare DNS), convenciones de plantillas, requisitos de SEO y traducción |
| **`/context`** | Gestionar el sistema de contexto: extraer conocimiento de las primeras creaciones, organizar patrones de sitios |
| **`/commit`** | Commits inteligentes con formato convencional |
| **`/optimize`** | Posible optimización del código generado (HTML, CSS, JS) |
| **`/analyze-patterns`** | Analizar patrones recurrentes en la estructura de los sitios creados |
| **`/validate-repo`** | Validar la integridad del repositorio |

### 1.4 Sistema de contexto

De las categorías de contexto de OAC, las que aplican a este proyecto son:

| Categoría | Aplicación |
|-----------|-----------|
| **core/** | Estándares universales y flujos de trabajo |
| **development/** | Patrones de desarrollo web para Hugo |
| **ui/** | Diseño visual de las plantillas y los sitios |
| **content-creation/** | Creación de contenido, redacción SEO |
| **project-intelligence/** | Stack tecnológico, patrones y convenciones del proyecto de sitios estáticos |

Las habilidades (skills) que se creen para Cloudflare Pages, Hugo, SEO, i18n y estructura SWE se almacenarían en `.opencode/skills/` siguiendo el formato SKILL.md.

---

## 2. Perfiles de instalación de OAC: análisis

### 2.1 Composición de cada perfil

Según los datos del registro de OAC (registry.json), los 5 perfiles tienen la siguiente composición:

| Componente | esencial | desarrollador | negocio | completo | avanzado |
|------------|:--------:|:-------------:|:-------:|:--------:|:--------:|
| **OpenAgent** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **OpenCoder** | ❌ | ✅ | ❌ | ✅ | ✅ |
| **TaskManager** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Rastreador de Contexto** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Rastreador Externo** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Escritor de Documentación** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Agente de Codificación** | ❌ | ✅ | ❌ | ✅ | ✅ |
| **Revisor de Código** | ❌ | ✅ | ❌ | ✅ | ✅ |
| **Ingeniero de Pruebas** | ❌ | ✅ | ❌ | ✅ | ✅ |
| **Agente de Compilación** | ❌ | ✅ | ❌ | ✅ | ✅ |
| **Especialista en Operaciones** | ❌ | ✅ | ❌ | ✅ | ✅ |
| **Especialista Frontend** | ❌ | ✅ | ❌ | ✅ | ✅ |
| **Copista / Escritor Técnico** | ❌ | ❌ | ✅ | ✅ | ✅ |
| **Especialista en Imágenes + herramienta Gemini** | ❌ | ❌ | ✅ | ✅ | ✅ |
| **Generador de Sistemas** | ❌ | ❌ | ❌ | ❌ | ✅ |
| **Comando `/commit`** | ❌ | ✅ | ❌ | ✅ | ✅ |
| **Comando `/optimize`** | ❌ | ❌ | ❌ | ✅ | ✅ |
| **Comando `/analyze-patterns`** | ❌ | ❌ | ❌ | ✅ | ✅ |

### 2.2 Cobertura de necesidades por perfil

| Necesidad del proyecto | esencial | desarrollador | negocio | completo | avanzado |
|-----------------------|:--------:|:-------------:|:-------:|:--------:|:--------:|
| Orquestación general (OpenAgent) | ✅ | ✅ | ✅ | ✅ | ✅ |
| Orquestación compleja (OpenCoder) | ❌ | ✅ | ❌ | ✅ | ✅ |
| Descomposición en tareas (TaskManager) | ✅ | ✅ | ✅ | ✅ | ✅ |
| Redacción de contenidos (Copista) | ❌ | ❌ | ✅ | ✅ | ✅ |
| Imágenes (Especialista en Imágenes) | ❌ | ❌ | ✅ | ✅ | ✅ |
| Diseño de plantillas (Especialista Frontend) | ❌ | ✅ | ❌ | ✅ | ✅ |
| Generación de código (Agente de Codificación) | ❌ | ✅ | ❌ | ✅ | ✅ |
| Despliegue CI/CD (Especialista en Operaciones) | ❌ | ✅ | ❌ | ✅ | ✅ |
| Validación (Revisor de Código) | ❌ | ✅ | ❌ | ✅ | ✅ |
| Compilación (Agente de Compilación) | ❌ | ✅ | ❌ | ✅ | ✅ |
| Descubrimiento de contexto (Rastreador de Contexto) | ✅ | ✅ | ✅ | ✅ | ✅ |
| Documentación actualizada (Rastreador Externo) | ✅ | ✅ | ✅ | ✅ | ✅ |
| Optimización (comando `/optimize`) | ❌ | ❌ | ❌ | ✅ | ✅ |
| Análisis de patrones (comando `/analyze-patterns`) | ❌ | ❌ | ❌ | ✅ | ✅ |

Ningún perfil por debajo de **completo (full)** cubre todas las necesidades simultáneamente:

- **esencial**: carece de Copista, Especialista en Imágenes, Especialista Frontend, Agente de Codificación, Revisor, Operaciones y OpenCoder
- **desarrollador**: carece de Copista y Especialista en Imágenes (confirmados como necesarios por el usuario)
- **negocio**: carece de OpenCoder, Especialista Frontend, Agente de Codificación, Revisor, Operaciones y Agente de Compilación

---

## 3. Nueva recomendación de perfil

### 3.1 Perfil recomendado: completo (full)

**Razones:**

1. **Cubre todas las necesidades confirmadas**: el perfil completo incluye tanto los componentes de ejecución técnica (OpenCoder, Agente de Codificación, Especialista Frontend, Especialista en Operaciones, Revisor, Agente de Compilación) como los componentes de contenido (Copista, Especialista en Imágenes).

2. **No existe un perfil menor que cubra ambos grupos**: el perfil desarrollador tiene la parte técnica pero carece de Copista y Especialista en Imágenes. El perfil negocio tiene contenido e imágenes pero carece de ejecución técnica y orquestación compleja.

3. **Incluye comandos adicionales útiles**: `/optimize` (para optimizar el HTML, CSS y JS generado) y `/analyze-patterns` (para identificar patrones recurrentes en los sitios creados) solo están disponibles en completo y avanzado.

4. **Incluye el lote completo de contextos**: todas las categorías de contexto (core, ui, development, content-creation, etc.) están disponibles sin limitaciones, lo que permite definir patrones específicos de sitios estáticos, SEO, traducción y estructura SWE.

5. **50 componentes frente a 68 del avanzado**: el perfil avanzado añade el Generador de Sistemas (SystemBuilder) que, aunque podría ser útil, no está confirmado como necesario en este momento. Completar tiene todo lo necesario sin el peso del generador de sistemas.

**Contra el perfil avanzado (advanced)**: añade el Generador de Sistemas (SystemBuilder) y 18 componentes adicionales. No se ha confirmado que el Generador de Sistemas sea necesario para este proyecto. Se puede instalar más adelante si se necesita.

**Contra el perfil desarrollador (developer)**: no incluye Copista ni Especialista en Imágenes, ambos confirmados como necesarios. Aunque se podrían añadir manualmente como habilidades personalizadas, el perfil completo los incluye de serie con sus dependencias resueltas.

### 3.2 Qué incluye que sirve para este proyecto

| Componente | Aplicación en el proyecto |
|------------|--------------------------|
| **OpenAgent** | Coordinación general del proyecto y orquestación del flujo de creación de cada sitio |
| **OpenCoder** | Orquestación de la creación de múltiples sitios, ejecución por lotes paralelos |
| **TaskManager** | Descomposición de cada sitio en tareas atómicas verificables |
| **Copista** | Redacción de contenidos para páginas corporativas y blog, con instrucciones del usuario y rol adaptado al estilo |
| **Especialista en Imágenes** | Optimización, generación y tratamiento de imágenes para los sitios |
| **Especialista Frontend** | Creación de plantillas base, diseño visual, maquetación de los sitios |
| **Agente de Codificación** | Generación de código HTML, CSS, JS, configuración de Hugo |
| **Especialista en Operaciones** | Configuración de despliegue automatizado y gestión de CI/CD |
| **Revisor de Código** | Validación del código generado antes del despliegue |
| **Agente de Compilación** | Verificación de que Hugo compila sin errores |
| **Rastreador de Contexto** | Descubrimiento automático de configuraciones, plantillas y patrones |
| **Rastreador Externo** | Documentación actualizada de Hugo, Cloudflare Pages y otras herramientas |
| **Escritor de Documentación** | Documentación del proceso de creación de cada sitio |
| **Comando `/add-context`** | Definición del contexto del proyecto (stack, convenciones, requisitos) |
| **Comando `/context`** | Gestión del sistema de contexto (extraer, organizar, mapear) |
| **Comando `/optimize`** | Optimización del código generado |
| **Comando `/analyze-patterns`** | Análisis de patrones recurrentes en la estructura de los sitios |
| **Comando `/commit`** | Commits inteligentes |
| **Comando `/validate-repo`** | Validación de la integridad del repositorio |

### 3.3 Tabla de uso prevista

| Situación | Agente / Subagente / Comando |
|-----------|-----------------------------|
| El usuario detalla las necesidades de un nuevo sitio | **OpenAgent** recibe las necesidades |
| Se planifica la creación del sitio | **TaskManager** descompone en tareas (contenido, plantilla, compilación, despliegue, validación) |
| Se redactan los contenidos | **Copista** genera textos bajo instrucciones del usuario |
| Se preparan las imágenes | **Especialista en Imágenes** optimiza o genera imágenes |
| Se crea o adapta la plantilla | **Especialista Frontend** diseña la maquetación |
| Se genera el sitio | **Agente de Codificación** ejecuta la compilación con Hugo |
| Se despliega | **Especialista en Operaciones** configura el despliegue en Cloudflare Pages |
| Se valida | **Revisor de Código** y **Agente de Compilación** verifican el resultado |
| Se consulta documentación actualizada | **Rastreador Externo** vía Context7 |
| Se documenta el proceso | **Escritor de Documentación** |
| Se extraen patrones tras varios sitios | **Comando `/analyze-patterns`** |
| Se optimizan los recursos | **Comando `/optimize`** |

---

*Fin del documento*
