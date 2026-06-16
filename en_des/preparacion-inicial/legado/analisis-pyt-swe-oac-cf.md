<!-- Context: analysis/pyt-swe-oac-cf | Priority: high | Version: 1.0 | Updated: 2026-06-15 -->
# Análisis y Recomendación: Proyecto de Sitios Web Estáticos con OpenAgentsControl y Cloudflare

**Propósito**: Documentar el análisis del nuevo proyecto (PYT) de creación de sitios web estáticos (SWE) alojados en Cloudflare Pages (CFPG) con gestión de dominios en Cloudflare (CF), utilizando OpenAgentsControl (OAC) como orquestador. Se identifican los componentes de OAC que aplican a cada necesidad confirmada, se señala lo que está pendiente, y se ofrece una recomendación de perfil de instalación.

**Fecha**: 2026-06-15
**Fuentes**:
- `temp/reporte-openagentscontrol-oac.md` — Informe completo de la arquitectura, agentes, subagentes, comandos, habilidades y contexto de OAC
- `temp/recomendacion-instalacion-oac-pyt.md` — Recomendación previa de perfil para otro proyecto (usado como modelo de estructura)
- Conversación del 2026-06-14/15 con el usuario (requisitos, respuestas, correcciones)
- `reglas-abreviaciones.txt` — Reglas de estilo y abreviaciones del proyecto

**Generado por**: OpenAgent

---

## Índice

- [1. Resumen ejecutivo](#1-resumen-ejecutivo)
- [2. Requisitos confirmados del proyecto](#2-requisitos-confirmados-del-proyecto)
  - [2.1 Naturaleza y alcance](#21-naturaleza-y-alcance)
  - [2.2 Flujo de trabajo descrito por el usuario](#22-flujo-de-trabajo-descrito-por-el-usuario)
- [3. Mapa de necesidades del proyecto contra componentes de OAC](#3-mapa-de-necesidades-del-proyecto-contra-componentes-de-oac)
  - [3.1 Agentes y subagentes que aplican](#31-agentes-y-subagentes-que-aplican)
  - [3.2 Habilidades (skills) necesarias](#32-habilidades-skills-necesarias)
  - [3.3 Comandos útiles](#33-comandos-útiles)
  - [3.4 Sistema de contexto](#34-sistema-de-contexto)
- [4. Lo confirmado y lo pendiente](#4-lo-confirmado-y-lo-pendiente)
  - [4.1 Tabla de estado](#41-tabla-de-estado)
- [5. Perfiles de instalación de OAC: análisis](#5-perfiles-de-instalación-de-oac-análisis)
  - [5.1 Composición de cada perfil](#51-composición-de-cada-perfil)
  - [5.2 Cobertura de necesidades por perfil](#52-cobertura-de-necesidades-por-perfil)
- [6. Nueva recomendación de perfil](#6-nueva-recomendación-de-perfil)
  - [6.1 Perfil recomendado: completo](#61-perfil-recomendado-completo)
  - [6.2 Qué incluye que sirve para este proyecto](#62-qué-incluye-que-sirve-para-este-proyecto)
  - [6.3 Tabla de uso prevista](#63-tabla-de-uso-prevista)
- [7. Habilidades a crear o incorporar](#7-habilidades-a-crear-o-incorporar)
- [8. Próximos pasos lógicos](#8-próximos-pasos-lógicos)
- [9. Notas importantes](#9-notas-importantes)
- [10. Resumen ejecutivo de la recomendación](#10-resumen-ejecutivo-de-la-recomendación)

---

## 1. Resumen ejecutivo

Se inicia un proyecto nuevo, en repositorio independiente, para la creación de **sitios web estáticos** alojados en **Cloudflare Pages** con **dominios gestionados en Cloudflare**. Los sitios son de tipo corporativo (entre 5 y 10 páginas) con blog y formularios. Los formularios delegan su ejecución a APIs externas o a Cloudflare Workers, según el caso. El blog puede generarse mediante inteligencia artificial (bajo instrucciones del usuario y con un rol adaptado al estilo) o escribirse manualmente.

**OpenAgentsControl** actúa como orquestador: el usuario detalla las necesidades de cada sitio y OAC coordina entre subagentes, habilidades, tareas y validaciones con el usuario.

Las necesidades confirmadas hasta ahora requieren componentes de OAC que **ningún perfil por debajo de "completo" (full) cubre por completo**, debido a que se necesitan simultáneamente agentes de ejecución técnica (planificador de tareas, codificador, especialista en operaciones) y agentes de contenido (copista, especialista en imágenes).

El análisis detallado y la recomendación se presentan a continuación.

---

## 2. Requisitos confirmados del proyecto

### 2.1 Naturaleza y alcance

| Aspecto | Valor | Fuente |
|---------|-------|--------|
| **Tipo de proyecto** | Nuevo, repositorio independiente | Respuesta 7 del usuario |
| **Relación con otros proyectos** | Ninguna (independiente de generador y de migración WordPress) | Respuesta 8 del usuario |
| **Tipo de sitio** | Estático (SWE) | Respuesta 2 del usuario |
| **Contenido del sitio** | Corporativo (5-10 páginas) + blog + formularios | Confirmado por el usuario |
| **Formularios** | Ejecución delegada a APIs externas o Cloudflare Workers (según el proyecto) | Respuesta A del usuario |
| **Blog** | Contenido generado por inteligencia artificial (Copista bajo instrucciones del usuario y rol adaptado al blog/estilo) o contenido propio | Respuesta B del usuario |
| **Alojamiento** | Cloudflare Pages | Enunciado inicial del usuario |
| **Gestión de dominios** | Cloudflare DNS | Enunciado inicial del usuario |
| **Generador de sitio estático** | Pendiente de decidir: Hugo o Astro | Respuesta 1 del usuario |
| **Origen de los sitios** | Creación desde cero basada en plantillas base de apariencia | Respuestas 3 y 4 del usuario |
| **Orquestador** | OpenAgentsControl | Enunciado inicial del usuario |

### 2.2 Flujo de trabajo descrito por el usuario

Según indicó textualmente: "el usuario detallará necesidades y OAC orquestará entre subagentes, habilidades, tareas, comprobaciones con usuario".

El proceso descrito es:

1. **Usuario** define las necesidades de cada sitio
2. **OAC** (a través de OpenAgent/OpenCoder) recibe las necesidades
3. **OAC orquesta**: despliega subagentes, carga habilidades, ejecuta tareas, realiza comprobaciones con el usuario
4. La **inteligencia artificial** participa en múltiples facetas: redacción (Copista), generación de estructura, imágenes (Especialista en Imágenes), asesoría de diseño, etc.

---

## 3. Mapa de necesidades del proyecto contra componentes de OAC

### 3.1 Agentes y subagentes que aplican

A continuación se listan los componentes de OAC documentados en `temp/reporte-openagentscontrol-oac.md` que aplican a las necesidades confirmadas del proyecto.

| Necesidad del proyecto | Componente de OAC | Presente en informe OAC |
|-----------------------|-------------------|------------------------|
| **Orquestación general** del flujo: recibir necesidades, coordinar subagentes, tareas y validaciones | **OpenAgent** (agente universal) | Sección 3.1: "Agente universal para preguntas, tareas y coordinación de workflows". Flujo: Analyze → Approve → Execute → Validate → Summarize → Confirm |
| **Orquestación compleja** con batches paralelos cuando se crean múltiples sitios | **OpenCoder** (orquestador de desarrollo) | Sección 3.2: "Especialista en implementación compleja... ejecución paralela de tareas por batches usando BatchExecutor" |
| **Descomposición** de la creación de cada sitio en tareas atómicas verificables | **TaskManager** | Sección 4.1: "Descomposición de features en subtareas atómicas JSON con dependencias" |
| **Redacción de contenidos** del sitio (páginas, blog, SEO) | **Copista (Copywriter)** | Sección 3.3: "Redacción de marketing y contenido" |
| **Tratamiento de imágenes** (optimización, generación, adaptación) | **Especialista en Imágenes (Image Specialist)** | Sección 4.4: Subagente en categoría `subagents/utils/` |
| **Creación de plantillas y diseño visual** de los sitios | **Especialista Frontend (OpenFrontendSpecialist)** | Sección 4.3: "UI/UX con flujo de 4 etapas: Layout → Theme → Animation → Implementation" |
| **Generación de código** HTML/CSS/JS, configuración de Hugo/Astro | **Agente de Codificación (CoderAgent)** | Sección 4.2: "Implementación de subtareas de código individuales" |
| **Configuración de despliegue automatizado** (CI/CD para Cloudflare Pages) | **Especialista en Operaciones (OpenDevopsSpecialist)** | Sección 4.3: "CI/CD, infraestructura como código" |
| **Validación** de que el sitio se ha generado y desplegado correctamente | **Revisor de Código (CodeReviewer)** | Sección 4.2: "Code review + análisis de seguridad" |
| **Validación de compilación** (asegurar que Hugo/Astro compila sin errores) | **Agente de Compilación (BuildAgent)** | Sección 4.2: "Type checking + build validation" |
| **Descubrimiento de contexto** del proyecto (configuraciones, plantillas, dominios) | **Rastreador de Contexto (ContextScout)** | Sección 4.1: "Descubrimiento inteligente de archivos de contexto" |
| **Documentación actualizada** de Hugo/Astro/Cloudflare Pages y sus APIs | **Rastreador Externo (ExternalScout)** vía Context7 | Sección 4.1: "Documentación viva de librerías externas (vía Context7 API)" |
| **Documentación** del proceso de creación de cada sitio y del proyecto en general | **Escritor de Documentación (DocWriter)** | Sección 4.1: "Generación de documentación" |

### 3.2 Habilidades (skills) necesarias

| Habilidad | Estado | Nota |
|-----------|--------|------|
| **Habilidad de gestión de tareas (task-management)** | Ya incluida en OAC (skill oficial) | Según sección 7 del informe OAC: "CLI de gestión de tareas: SKILL.md + router.sh + scripts/task-cli.ts" |
| **Habilidad de documentación actualizada (context7)** | Ya incluida en OAC (skill oficial) | Según sección 7 del informe OAC: "Documentación actualizada de librerías vía API Context7" |
| **Cloudflare Pages** (despliegue, configuración de compilación, dominios personalizados) | Pendiente de crear | Habilidad especializada propuesta por el usuario para mejor uso de herramientas |
| **Hugo o Astro** (según el que se elija) | Pendiente de crear | Habilidad especializada propuesta por el usuario para mejor uso del generador |
| **Redacción SEO** | Pendiente de crear | Habilidad especializada propuesta por el usuario |
| **Traducción i18n** | Pendiente de crear | Habilidad especializada propuesta por el usuario |
| **Estructura de sitio web estático** | Pendiente de crear | Habilidad especializada propuesta por el usuario |
| **Otras habilidades** | Según se necesiten | El usuario indicó que se usarán "roles o skills disponibles en internet o creados a través de OAC" |

### 3.3 Comandos útiles

| Comando de OAC | Aplicación en el proyecto |
|----------------|--------------------------|
| **`/add-context`** | Configurar el contexto del proyecto: definir el stack tecnológico (Hugo/Astro, Cloudflare Pages, Cloudflare DNS), convenciones de plantillas, requisitos de SEO y traducción |
| **`/context`** | Gestionar el sistema de contexto: extraer conocimiento de las primeras creaciones, organizar patrones de sitios |
| **`/commit`** | Commits inteligentes con formato convencional |
| **`/optimize`** | Posible optimización del código generado (HTML, CSS, JS) |
| **`/analyze-patterns`** | Analizar patrones recurrentes en la estructura de los sitios creados |
| **`/validate-repo`** | Validar la integridad del repositorio |

### 3.4 Sistema de contexto

De las 11 categorías de contexto de OAC (sección 5.2 del informe), las que aplicarían a este proyecto son:

| Categoría | Aplicación |
|-----------|-----------|
| **core/** | Estándares universales y flujos de trabajo |
| **development/** | Patrones de desarrollo web para Hugo/Astro |
| **ui/** | Diseño visual de las plantillas y los sitios |
| **content-creation/** | Creación de contenido, redacción SEO |
| **project-intelligence/** | Stack tecnológico, patrones y convenciones del proyecto de sitios estáticos |

Las habilidades (skills) que se creen para Cloudflare Pages, Hugo/Astro, SEO, i18n y estructura SWE se almacenarían en `.opencode/skills/` siguiendo el formato SKILL.md que describe el informe OAC.

---

## 4. Lo confirmado y lo pendiente

### 4.1 Tabla de estado

| Aspecto | Estado | Detalle |
|---------|--------|---------|
| Repositorio nuevo e independiente | ✅ Confirmado | Sin relación con generador |
| Sitios web estáticos | ✅ Confirmado | Corporativos 5-10 págs + blog + formularios |
| Cloudflare Pages como alojamiento | ✅ Confirmado | 100 % del alojamiento |
| Cloudflare DNS | ✅ Confirmado | Gestión de dominios |
| OAC como orquestador | ✅ Confirmado | Orquesta subagentes, habilidades, tareas y validaciones |
| Copywriter necesario | ✅ Confirmado | Para redacción de contenidos |
| Image Specialist necesario | ✅ Confirmado | Para tratamiento de imágenes |
| Contenido por IA con roles adaptados | ✅ Confirmado | Bajo instrucciones del usuario |
| Formularios: API externa o Workers | ✅ Confirmado | Según el proyecto concreto |
| Skills de herramientas (CF Pages, Hugo/Astro, SEO, i18n, estructura SWE) | ✅ Confirmado | Como objetivo a crear/incorporar |
| Roles/skills de internet o creados con OAC | ✅ Confirmado | Mecanismo de obtención |
| --- | --- | --- |
| Generador (Hugo o Astro) | ❌ Pendiente | Decisión del usuario |
| Perfil de OAC | ❌ Pendiente | Se aborda en la recomendación de este documento |
| Habilidades concretas a crear | ❌ Pendiente | Se detallarán cuando se defina el generador |
| Modelo de inteligencia artificial | ❌ Pendiente | DeepSeek u otro |
| Origen de las plantillas base | ❌ Pendiente | Creación propia o adaptación |
| Framework CSS | ❌ Pendiente | Por decidir |
| Despliegue automatizado o manual | ❌ Pendiente | GitHub + Cloudflare Pages es posible pero no está decidido |
| Nombre del repositorio | ❌ Pendiente | Por decidir |

---

## 5. Perfiles de instalación de OAC: análisis

### 5.1 Composición de cada perfil

Según los datos extraídos del registro de OAC (`registry.json`) documentados en `temp/recomendacion-instalacion-oac-pyt.md`, los 5 perfiles tienen la siguiente composición:

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

### 5.2 Cobertura de necesidades por perfil

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

## 6. Nueva recomendación de perfil

### 6.1 Perfil recomendado: completo (full)

**Razones:**

1. **Cubre todas las necesidades confirmadas**: el perfil completo incluye tanto los componentes de ejecución técnica (OpenCoder, Agente de Codificación, Especialista Frontend, Especialista en Operaciones, Revisor, Agente de Compilación) como los componentes de contenido (Copista, Especialista en Imágenes).

2. **No existe un perfil menor que cubra ambos grupos**: el perfil desarrollador tiene la parte técnica pero carece de Copista y Especialista en Imágenes. El perfil negocio tiene contenido e imágenes pero carece de ejecución técnica y orquestación compleja.

3. **Incluye comandos adicionales útiles**: `/optimize` (para optimizar el HTML/CSS/JS generado) y `/analyze-patterns` (para identificar patrones recurrentes en los sitios creados) solo están disponibles en completo y avanzado.

4. **Incluye el lote completo de contextos**: todas las categorías de contexto (core, ui, development, content-creation, etc.) están disponibles sin limitaciones, lo que permite definir patrones específicos de sitios estáticos, SEO, traducción y estructura SWE.

5. **50 componentes frente a 68 del avanzado**: el perfil avanzado añade el Generador de Sistemas (SystemBuilder) que, aunque podría ser útil, no está confirmado como necesario en este momento. Completar tiene todo lo necesario sin el peso del generador de sistemas.

**Contra el perfil avanzado (advanced)**: añade el Generador de Sistemas (SystemBuilder) y 18 componentes adicionales. No se ha confirmado que el Generador de Sistemas sea necesario para este proyecto. Se puede instalar más adelante si se necesita.

**Contra el perfil desarrollador (developer)**: no incluye Copista ni Especialista en Imágenes, ambos confirmados como necesarios. Aunque se podrían añadir manualmente como habilidades personalizadas, el perfil completo los incluye de serie con sus dependencias resueltas.

### 6.2 Qué incluye que sirve para este proyecto

| Componente | Aplicación en el proyecto |
|------------|--------------------------|
| **OpenAgent** | Coordinación general del proyecto y orquestación del flujo de creación de cada sitio |
| **OpenCoder** | Orquestación de la creación de múltiples sitios, ejecución por lotes paralelos |
| **TaskManager** | Descomposición de cada sitio en tareas atómicas verificables |
| **Copista** | Redacción de contenidos para páginas corporativas y blog, con instrucciones del usuario y rol adaptado al estilo |
| **Especialista en Imágenes** | Optimización, generación y tratamiento de imágenes para los sitios |
| **Especialista Frontend** | Creación de plantillas base, diseño visual, maquetación de los sitios |
| **Agente de Codificación** | Generación de código HTML/CSS/JS, configuración de Hugo/Astro |
| **Especialista en Operaciones** | Configuración de despliegue automatizado (GitHub Actions + Cloudflare Pages), gestión de CI/CD |
| **Revisor de Código** | Validación del código generado antes del despliegue |
| **Agente de Compilación** | Verificación de que Hugo/Astro compila sin errores |
| **Rastreador de Contexto** | Descubrimiento automático de configuraciones, plantillas y patrones |
| **Rastreador Externo** | Documentación actualizada de Hugo/Astro, Cloudflare Pages y otras herramientas |
| **Escritor de Documentación** | Documentación del proceso de creación de cada sitio |
| **Comando `/add-context`** | Definición del contexto del proyecto (stack, convenciones, requisitos) |
| **Comando `/context`** | Gestión del sistema de contexto (extraer, organizar, mapear) |
| **Comando `/optimize`** | Optimización del código generado |
| **Comando `/analyze-patterns`** | Análisis de patrones recurrentes en la estructura de los sitios |
| **Comando `/commit`** | Commits inteligentes |
| **Comando `/validate-repo`** | Validación de la integridad del repositorio |

### 6.3 Tabla de uso prevista

| Situación | Agente/Subagente/Comando |
|-----------|-------------------------|
| El usuario detalla las necesidades de un nuevo sitio | **OpenAgent** recibe las necesidades |
| Se planifica la creación del sitio | **TaskManager** descompone en tareas (contenido, plantilla, compilación, despliegue, validación) |
| Se redactan los contenidos | **Copista** genera textos bajo instrucciones del usuario |
| Se preparan las imágenes | **Especialista en Imágenes** optimiza/genera imágenes |
| Se crea o adapta la plantilla | **Especialista Frontend** diseña la maquetación |
| Se genera el sitio | **Agente de Codificación** ejecuta la compilación con Hugo/Astro |
| Se despliega | **Especialista en Operaciones** configura el despliegue en Cloudflare Pages |
| Se valida | **Revisor de Código** y **Agente de Compilación** verifican el resultado |
| Se consulta documentación actualizada | **Rastreador Externo** vía Context7 |
| Se documenta el proceso | **Escritor de Documentación** |
| Se extraen patrones tras varios sitios | **Comando `/analyze-patterns`** |
| Se optimizan los recursos | **Comando `/optimize`** |

---

## 7. Habilidades a crear o incorporar

Según lo confirmado por el usuario, las habilidades necesarias se obtendrán de dos formas:

1. **Disponibles en internet**: roles o habilidades existentes que se puedan incorporar al proyecto
2. **Creadas a través de OAC**: habilidades personalizadas desarrolladas específicamente para este proyecto

Las áreas identificadas hasta ahora son:

| Habilidad | Propósito previsto |
|-----------|-------------------|
| **Cloudflare Pages** | Despliegue, configuración de compilación, dominios personalizados, gestión de proyectos |
| **Hugo o Astro** (según elección) | Generación de sitios, configuración, temas/plantillas, optimización de compilación |
| **Redacción SEO** | Optimización de contenidos para motores de búsqueda |
| **Traducción i18n** | Internacionalización de los sitios |
| **Estructura de sitio web estático** | Arquitectura, organización de secciones, mejores prácticas |

El momento de crear estas habilidades y su prioridad relativa se determinarán cuando se definan el generador y las primeras necesidades concretas de creación de sitios.

---

## 8. Próximos pasos lógicos

Los siguientes pasos se enumeran en orden lógico, pero su ejecución queda pendiente de la decisión del usuario:

1. **Decidir el generador**: Hugo o Astro. Es la decisión más crítica porque condiciona las habilidades, el tipo de plantillas y la configuración de Cloudflare Pages.

2. **Crear el repositorio** en GitHub con el nombre que elija.

3. **Instalar OAC con perfil completo** en el repositorio del proyecto.

4. **Configurar el modelo de inteligencia artificial** (DeepSeek u otro).

5. **Ejecutar `/add-context`** para definir el contexto del proyecto (stack, convenciones, requisitos de SEO, traducción, estructura SWE).

6. **Crear o incorporar las habilidades** necesarias: Cloudflare Pages, Hugo/Astro, redacción SEO, traducción i18n, estructura SWE.

7. **Crear la primera plantilla base** y un sitio de prueba para validar el flujo completo.

8. **Documentar el proceso** con el Escritor de Documentación.

---

## 9. Notas importantes

1. **El perfil completo incluye 50 componentes**. Aunque es más que el perfil desarrollador (41), la diferencia son principalmente los agentes de contenido (Copista, Especialista en Imágenes) y comandos adicionales (optimizar, analizar patrones) que sí se van a utilizar. El sistema de carga diferida (lazy loading MVI) de OAC garantiza que solo se cargue lo necesario en cada operación.

2. **El perfil avanzado (68 componentes) no es necesario en este momento**. Añade el Generador de Sistemas, 5 subagentes de generación de sistemas, contextos de plantillas de sistemas y más contextos. Si en el futuro se necesita generar workflows completos de creación de sitios, se podría migrar, pero ahora no está justificado.

3. **Las habilidades personalizadas** se almacenan en `.opencode/skills/` siguiendo el formato SKILL.md con frontmatter, descripción y scripts asociados. Se pueden crear manualmente o con herramientas de OAC.

4. **Cloudflare Workers para formularios**: si se opta por Workers, el Especialista en Operaciones (DevOps) podría encargarse de su despliegue. Si se opta por APIs externas, el Agente de Codificación configuraría la integración en el HTML.

5. **Este análisis se basa exclusivamente en información verificada** del informe de OAC, de las reglas abreviadas y de las respuestas del usuario. Todo lo marcado como pendiente está señalado explícitamente.

---

## 10. Resumen ejecutivo de la recomendación

| Aspecto | Decisión |
|---------|----------|
| **Perfil recomendado** | **Completo (full)** — 50 componentes |
| **Razón principal** | Es el único perfil que cubre simultáneamente las necesidades de ejecución técnica (OpenCoder, Agente de Codificación, Especialista Frontend, Especialista en Operaciones, Revisor) y de contenido (Copista, Especialista en Imágenes) |
| **Por qué no esencial** | Carece de Copista, Especialista en Imágenes, Agente de Codificación, Especialista Frontend y OpenCoder |
| **Por qué no desarrollador** | Carece de Copista y Especialista en Imágenes (necesarios para contenidos e imágenes) |
| **Por qué no negocio** | Carece de OpenCoder, Agente de Codificación, Especialista Frontend, Especialista en Operaciones y Revisor (necesarios para generación de código, CI/CD y validación) |
| **Por qué no avanzado** | Añade el Generador de Sistemas (18 componentes extra) sin que esté confirmada su necesidad. Se podría añadir después si hiciera falta |
| **Agente principal** | OpenAgent |
| **Para orquestación compleja** | OpenCoder |
| **Para contenidos** | Copista |
| **Para imágenes** | Especialista en Imágenes |
| **Para plantillas y diseño** | Especialista Frontend |
| **Para código y compilación** | Agente de Codificación + Agente de Compilación |
| **Para despliegue** | Especialista en Operaciones |
| **Para validación** | Revisor de Código |
| **Para contexto** | Rastreador de Contexto + Rastreador Externo |
| **Para documentación** | Escritor de Documentación |
| **Habilidades a crear** | Cloudflare Pages, Hugo/Astro, redacción SEO, traducción i18n, estructura SWE |

**Conclusión**: El perfil **completo (full)** es la opción correcta para este proyecto porque proporciona, de serie y con dependencias resueltas, todos los componentes necesarios para cubrir el flujo completo de creación de sitios web estáticos: desde la redacción de contenidos y el tratamiento de imágenes hasta la generación del sitio, el despliegue en Cloudflare Pages y la validación del resultado.

---

*Fin del documento*
