# Interacción dinámica — Inicializar Hugo (pasos 1-3)

**Propósito**: Definir el árbol de preguntas adaptativas, el artefacto OAC y la lógica de ejecución para los pasos 1 a 3 del flujo Hugo.

**Fecha**: 2026-06-16

**Depende de**: `recursos/flujos/triada-usuario-oac-hugo.md`

---

## B1 — Árbol de preguntas adaptativas

### Estructura general

Cada pregunta se hace **una a la vez**. La siguiente pregunta se determina según la respuesta anterior. No hay un orden fijo total — el árbol se recorre dinámicamente.

### Nodo raíz: Nombre del proyecto

```
PREGUNTA: "¿Qué nombre quieres para el proyecto?"

RESPUESTA: <nombre>
  │
  ├── Válido (solo letras, números, guiones)
  │     └── Se registra como nombre del proyecto
  │
  └── Vacío / inválido
        └── "El nombre debe contener solo letras, números o guiones.
             ¿Puedes indicar otro?"
```

### Nodo 2: Título del sitio

```
PREGUNTA: "¿Cuál será el título del sitio web?"
           (el que aparece en la pestaña del navegador)

RESPUESTA: <título>
  │
  └── Se registra como title en hugo.toml
```

### Nodo 3: Base URL (con rama condicional)

```
PREGUNTA: "¿Tienes ya un dominio donde publicar el sitio?"
           (por ejemplo: https://midominio.com)

RESPUESTA: <URL>
  │
  ├── URL completa (https://...)
  │     └── Se registra como baseURL
  │
  ├── "No tengo / todavía no"
  │     └── "Lo dejamos con un valor por defecto:
  │          https://ejemplo.com/ — puedes cambiarlo después."
  │     └── Se registra baseURL = 'https://ejemplo.com/'
  │
  └── Dominio suelto (midominio.com)
        └── "Lo completo: https://midominio.com/"
        └── Se registra como baseURL
```

### Nodo 4: Idioma (con dependencia)

```
PREGUNTA: "¿Idioma principal del sitio?"

RESPUESTA: <idioma>
  │
  ├── "Español / Español de España"
  │     └── locale = 'es-es'
  │
  ├── "Inglés"
  │     └── locale = 'en'
  │
  ├── Otro (especifica)
  │     └── locale = <lo que indique>
  │
  └── "No lo sé"
        └── "Lo dejamos en español de España (es-es).
             Puedes cambiarlo después."
        └── locale = 'es-es'
```

### Nodo 5: Descripción SEO (con opcional)

```
PREGUNTA: "¿Quieres añadir una descripción breve para SEO?"
           (la que aparece en los resultados de búsqueda)

RESPUESTA: <texto>
  │
  ├── Descripción proporcionada
  │     └── Se registra como params.description
  │
  └── "No / más tarde"
        └── Se omite (campo vacío)
```

### Nodo 6: Autor (con opcional)

```
PREGUNTA: "¿Nombre del autor o del sitio?"

RESPUESTA: <nombre_autor>
  │
  ├── Nombre proporcionado
  │     └── Se registra como params.author
  │
  └── "No / más tarde"
        └── Se omite (campo vacío)
```

### Nodo 7: Redes sociales (con rama condicional)

```
PREGUNTA: "¿Quieres añadir enlaces a redes sociales?"
           (Twitter/X, GitHub, LinkedIn...)

RESPUESTA: <sí / no>
  │
  ├── "Sí"
  │     └── "¿Cuál? (twitter, github, linkedin, youtube...)"
  │           └── "¿Cuál es tu usuario/URL?"
  │                 └── Se registra en params.social.<red>
  │                 └── "¿Alguna más?" → loop hasta que diga "no"
  │
  └── "No"
        └── Se omite
```

### Nodo 8: Estilo (opcional avanzado)

```
PREGUNTA: "¿Prefieres algún tema o estilo visual?"
           (Por defecto iremos con HTML/CSS limpio)

RESPUESTA: <tema / no>
  │
  ├── Tema conocido (definir)
  │     └── Se tomará en cuenta en pasos 4-5 (layouts + pipes)
  │
  └── "No / por defecto"
        └── Se usa configuración base de los layouts
```

---

## B2 — Artefacto OAC concreto

### Decisión: **Workflow ejecutado por OpenAgent directamente**

| Criterio | Por qué esto y no otro |
|----------|------------------------|
| **Naturaleza interactiva** | Las preguntas adaptativas requieren diálogo en tiempo real. Solo OpenAgent puede mantener una conversación viva con el usuario |
| **Un solo interlocutor** | El usuario habla con un único agente. Delegar a un subagente rompe la fluidez |
| **Complejidad ajustada** | No es una tarea tan compleja como para necesitar TaskManager. Tampoco tan simple como un comando |
| **Reutilización** | El comportamiento se define en este documento de flujo, que puede ser referenciado desde cualquier prompt |

### ¿Cómo funciona?

```
1. Usuario lanza 01-P-iniciar-sitio-hugo.md
     │
2. OpenAgent carga:
     ├── .opencode/external-context/hugo/  (contexto técnico)
     ├── recursos/flujos/triada-usuario-oac-hugo.md  (arquitectura)
     └── recursos/flujos/interaccion-dinamica-inicializar-hugo.md  (este documento)
     │
3. OpenAgent ejecuta el árbol de preguntas:
     ├── Una pregunta a la vez
     ├── Cada respuesta determina la siguiente
     └── Sin adelantarse, sin información no solicitada
     │
4. OpenAgent recopila toda la información
     │
5. OpenAgent ejecuta:
     ├── hugo new site <nombre>
     └── Escribe hugo.toml con todos los datos
     │
6. OpenAgent verifica y confirma
```

---

## B3 — Implementación de la lógica de preguntas condicionales

### Pseudocódigo del flujo de interacción

```
INICIO
  ├── Verificar/instalar Hugo  (Fase 1)
  │
  ├── ─── INICIO INTERACCIÓN DINÁMICA ───
  │
  ├── 1. Preguntar: nombre_proyecto
  │     └── validar → si inválido, repetir
  │
  ├── 2. Preguntar: titulo_sitio
  │
  ├── 3. Preguntar: base_url
  │     └── si "no tengo" → valor por defecto
  │     └── si dominio suelto → completar con https://
  │
  ├── 4. Preguntar: idioma
  │     └── si "no sé" → valor por defecto (es-es)
  │
  ├── 5. Preguntar: descripcion_seo (opcional)
  │     └── si "no" → omitir
  │
  ├── 6. Preguntar: autor (opcional)
  │     └── si "no" → omitir
  │
  ├── 7. Preguntar: redes_sociales (opcional)
  │     └── si "sí" → loop: preguntar red + usuario/URL
  │     └── si "no" → omitir
  │
  ├── 8. Preguntar: tema_estilo (opcional avanzado)
  │     └── si "no" → continuar con defaults
  │
  ├── ─── FIN INTERACCIÓN DINÁMICA ───
  │
  ├── Confirmar resumen con el usuario:
  │     "Voy a crear el proyecto con estos datos:
  │      - Nombre: <nombre>
  │      - Título: <título>
  │      - URL: <baseURL>
  │      - Idioma: <locale>
  │      - Descripción: <description>
  │      - Autor: <author>
  │      ¿Confirmamos?"
  │
  ├── Usuario confirma → ejecutar
  │     ├── hugo new site <nombre>
  │     └── escribir hugo.toml con datos
  │
  └── Usuario rechaza → permitir corrección
        └── volver al punto que quiere cambiar
```

### Reglas de la interacción

| Regla | Descripción |
|-------|-------------|
| **Una pregunta a la vez** | Nunca mostrar dos preguntas juntas |
| **Adaptabilidad** | Cada pregunta se elige según la respuesta anterior |
| **Opcionales claros** | Los campos opcionales se ofrecen como "¿Quieres añadir X?" con opción a saltar |
| **Valores por defecto** | Si el usuario no sabe, se propone un valor sensato (siempre cambiable después) |
| **Confirmación final** | Antes de ejecutar nada, se muestra un resumen de todo lo recopilado y se pide confirmación |
| **Sin adelantos** | No explicar lo que viene después. Solo la pregunta actual |
| **Tono tutorial** | Explicar brevemente cada campo si es necesario (1 frase max) |

---

## Integración con el prompt 01-P

El prompt `01-P-iniciar-sitio-hugo.md` debe actualizarse para:

1. Referenciar este documento de flujo como la guía a seguir
2. Indicar que la interacción sigue el árbol de preguntas definido aquí
3. Incluir la regla de versiones corregida

---

*Documento de diseño de interacción dinámica para inicialización de Hugo con OAC*
