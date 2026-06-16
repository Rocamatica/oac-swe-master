Eso se refiere a lo que puedes hacer con **Cloudflare Pages Functions**, es decir, pequeñas funciones backend que corren en Cloudflare junto a tu sitio de Pages. Cloudflare las describe como una forma de añadir cosas dinámicas como autenticación, manejo de formularios y middleware a una app en Pages. ([Cloudflare Docs][1])

## 1. Procesar un formulario

Significa recibir datos que una persona escribe en una web.

Ejemplo:

```text
Nombre: Oswaldo
Email: usuario@email.com
Mensaje: Quiero más información
```

Cuando el usuario pulsa “Enviar”, esos datos tienen que ir a algún lugar. Una función puede recibirlos, validarlos y hacer algo con ellos.

Por ejemplo:

```text
Formulario de contacto
↓
Pages Function
↓
Validar datos
↓
Guardar en base de datos, enviar email o llamar a otro servicio
```

Cloudflare tiene documentación específica para crear formularios HTML con Pages Functions y también un plugin de Static Forms para interceptar envíos de formularios. ([Cloudflare Docs][2])

Ejemplos reales:

```text
Formulario de contacto
Formulario de newsletter
Formulario de soporte
Formulario de solicitud de presupuesto
```

Sin una función o servicio externo, una web estática solo muestra el formulario, pero no “procesa” realmente lo que el usuario envía.

---

## 2. Crear una API pequeña

Una **API** es una URL que devuelve datos o realiza una acción, normalmente para que la use tu propia web, app o sistema.

Ejemplo:

```text
/api/precios
/api/contacto
/api/estado
/api/productos
```

Una API pequeña en Cloudflare Pages podría hacer algo como:

```text
El frontend pide datos
↓
/api/productos
↓
Pages Function consulta o calcula algo
↓
Devuelve JSON al navegador
```

Ejemplo de respuesta JSON:

```json
{
  "producto": "Curso Hugo",
  "precio": 49,
  "disponible": true
}
```

Cloudflare tiene una guía oficial para construir una API para un frontend usando Pages Functions. ([Cloudflare Docs][3])

Esto sirve cuando tu sitio no es solo páginas estáticas, sino que necesita algo de lógica.

Ejemplos:

```text
Mostrar precios actualizados
Consultar disponibilidad
Enviar datos a un CRM
Devolver contenido personalizado
Crear endpoints para una app frontend
```

---

## 3. Autenticar usuarios

**Autenticar** significa comprobar quién es el usuario.

Por ejemplo:

```text
¿Este usuario inició sesión?
¿Tiene permiso para ver esta página?
¿Su token es válido?
¿Pertenece a mi equipo?
```

Flujo típico:

```text
Usuario entra a /admin
↓
Función revisa cookie, token o cabecera
↓
Si es válido: deja pasar
↓
Si no es válido: redirige a login o bloquea
```

Cloudflare menciona la autenticación como un caso de uso de Pages Functions, y también ofrece un plugin de Cloudflare Access para validar JWT de Cloudflare Access. ([Cloudflare Docs][1])

Ejemplos:

```text
Proteger una zona privada
Proteger documentación interna
Mostrar contenido solo a usuarios registrados
Restringir rutas como /admin o /dashboard
```

Importante: autenticación no es solo “poner una contraseña en HTML”. Tiene que validarse del lado servidor o en una capa segura, porque el código visible en el navegador se puede inspeccionar.

---

## 4. Leer o escribir datos en otros servicios

Una función puede actuar como puente entre tu web y otros servicios.

Por ejemplo:

```text
Tu web
↓
Pages Function
↓
Servicio externo
```

Servicios posibles:

```text
Base de datos
CRM
Google Sheets
API de pagos
Servicio de email
Headless CMS
Cloudflare KV / D1 / R2
```

Ejemplo práctico:

```text
Usuario envía formulario
↓
Pages Function recibe los datos
↓
Pages Function guarda el contacto en un CRM
↓
Pages Function devuelve “ok”
```

Otro ejemplo:

```text
Usuario abre /api/posts
↓
Function consulta un CMS
↓
Devuelve artículos en JSON
```

La ventaja es que puedes ocultar claves privadas o tokens en variables de entorno del servidor, en lugar de ponerlos en el JavaScript público del navegador.

---

## 5. Crear middleware

**Middleware** es código intermedio que se ejecuta antes o después de atender una petición.

Cloudflare define el middleware en Pages Functions como lógica reutilizable que puede ejecutarse antes de tu función `onRequest`; ejemplos típicos son manejo de errores, autenticación y logging. ([Cloudflare Docs][4])

Ejemplo mental:

```text
Usuario pide una página
↓
Middleware revisa algo
↓
Luego deja pasar a la página o función final
```

Casos comunes:

```text
Comprobar si el usuario está autenticado
Registrar logs
Bloquear países, bots o rutas
Añadir headers de seguridad
Gestionar errores
Medir tiempos de respuesta
Hacer A/B testing
```

Ejemplo:

```text
Todas las rutas /admin/*
↓
Middleware revisa sesión
↓
Si no hay sesión, redirige a /login
↓
Si hay sesión, continúa
```

Cloudflare también tiene ejemplos de middleware para casos como A/B testing. ([Cloudflare Docs][5])

---

## 6. Modificar respuestas antes de entregarlas

Significa interceptar lo que se va a enviar al usuario y cambiar algo antes de que llegue al navegador.

Ejemplo:

```text
Usuario pide /pagina
↓
Cloudflare obtiene o genera la respuesta
↓
Función modifica headers, status o contenido
↓
Usuario recibe la respuesta modificada
```

Puedes modificar cosas como:

```text
Headers HTTP
Código de estado
Redirecciones
Contenido HTML
Respuesta JSON
Reglas de caché
Cabeceras de seguridad
```

Ejemplo práctico:

```text
Añadir un header:
Content-Security-Policy
```

o:

```text
Cambiar una respuesta 404 por una página personalizada
```

o:

```text
Modificar JSON antes de devolverlo al frontend
```

En Workers/Pages Functions, para cambiar ciertas propiedades de una respuesta se crea una nueva `Response`; Cloudflare documenta que las propiedades de `Response` son inmutables y que, para cambiarlas, se debe construir una nueva respuesta. ([Cloudflare Docs][6])

Además, Cloudflare también tiene **Transform Rules** para modificar headers de respuesta sin escribir necesariamente una función, dependiendo del caso. ([Cloudflare Docs][7])

---

## Resumen simple

```text
Procesar formulario
= recibir datos de usuarios y hacer algo con ellos.

Crear API pequeña
= crear URLs que devuelven datos o ejecutan acciones.

Autenticar usuarios
= comprobar identidad y permisos.

Leer/escribir en otros servicios
= conectar tu web con bases de datos, CRMs, APIs, CMS, etc.

Crear middleware
= ejecutar lógica intermedia antes/después de una petición.

Modificar respuestas
= cambiar headers, contenido, estado o comportamiento antes de entregar la respuesta.
```

En una web estática normal solo sirves archivos. Con **Pages Functions**, tu sitio puede tener partes dinámicas sin montar un backend tradicional en un VPS.

[1]: https://developers.cloudflare.com/pages/functions/?utm_source=chatgpt.com "Functions · Cloudflare Pages docs"
[2]: https://developers.cloudflare.com/pages/tutorials/forms/?utm_source=chatgpt.com "Create a HTML form"
[3]: https://developers.cloudflare.com/pages/tutorials/build-an-api-with-pages-functions/?utm_source=chatgpt.com "Build an API for your front end using Pages Functions"
[4]: https://developers.cloudflare.com/pages/functions/middleware/?utm_source=chatgpt.com "Middleware · Cloudflare Pages docs"
[5]: https://developers.cloudflare.com/pages/functions/examples/ab-testing/?utm_source=chatgpt.com "A/B testing with middleware"
[6]: https://developers.cloudflare.com/workers/examples/modify-response/?utm_source=chatgpt.com "Modify response - Workers"
[7]: https://developers.cloudflare.com/rules/transform/response-header-modification/?utm_source=chatgpt.com "Response Header Transform Rules"
