# Telegram Email Notifier

# Telegram Email Notifier - API de Notificaciones

<div align="center">

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![Python](https://img.shields.io/badge/python-3.11+-green.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

Una aplicación profesional para monitorizar carpetas de correo electrónico y enviar notificaciones automáticas a través de Telegram.

[Features](#features) • [Instalación](#instalación) • [Documentación](#documentación) • [API](#api-rest)

</div>

## 🌟 Features

- ✨ **Múltiples Bots**: Gestiona varios bots de Telegram simultáneamente
- 📧 **Múltiples Cuentas**: Conecta diferentes cuentas de email
- 👁️ **Monitorización Avanzada**: Vigila carpetas específicas con intervalo configurable
- 🌐 **Panel Web Intuitivo**: Interfaz moderna y fácil de usar
- 🔌 **API REST Completa**: Control total vía API
- 🐳 **Docker Ready**: Despliegue simple con Docker Compose
- 🔐 **Seguro**: Manejo seguro de credenciales
- 📱 **Responsive**: Funciona en móvil y escritorio

## 🚀 Inicio Rápido

### Con Docker (Recomendado)

```bash
# Clonar el repositorio
git clone https://github.com/tuusuario/telegram-email-notifier.git
cd telegram-email-notifier

# Iniciar con Docker Compose
docker-compose up -d

# Acceder al panel
# Frontend: http://localhost
# API: http://localhost:8000
# Swagger docs: http://localhost:8000/docs
```

### Sin Docker

```bash
# Backend
cd backend
pip install -r requirements.txt
python -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload

# Frontend
# Abre frontend/index.html en tu navegador (o usa cualquier servidor web)
```

## 📋 Requisitos Previos

- Docker y Docker Compose (o Python 3.11+)
- Bot de Telegram (obten uno en @BotFather)
- Credenciales IMAP de tu cuenta de email

## 📖 Documentación

### 1️⃣ Crear un Bot Telegram

1. Abre Telegram y busca `@BotFather`
2. Envía `/newbot` y sigue las instrucciones
3. Obtén el **Bot Token** (parecido a: `123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11`)
4. Envía un mensaje a tu bot para obtener el **Chat ID**

Para obtener el Chat ID:
```bash
# O en el panel de control después de crear el bot
curl "https://api.telegram.org/bot[BOT_TOKEN]/getUpdates"
```

### 2️⃣ Agregar una Cuenta de Email

Ejemplos de configuración para proveedores populares:

**Gmail:**
- Email: `tu@gmail.com`
- Contraseña: [Contraseña de aplicación](https://support.google.com/accounts/answer/185833)
- IMAP Server: `imap.gmail.com`
- Puerto: `993`

**Microsoft Outlook:**
- Email: `tu@outlook.com`
- Contraseña: Tu contraseña de Outlook
- IMAP Server: `outlook.office365.com`
- Puerto: `993`

**OVH:**
- Email: `tu@tudominio.es`
- IMAP Server: `ex4.mail.ovh.net`
- Puerto: `993`

### 3️⃣ Crear un Monitor

El monitor es lo que realmente hace el trabajo:
- Selecciona un bot de Telegram
- Selecciona una cuenta de email
- Especifica la carpeta a monitorizar (ej: INBOX)
- Define cada cuántos segundos verificar

## 🏗️ Estructura del Proyecto

```
telegram-email-notifier/
├── backend/                    # FastAPI backend
│   ├── app/
│   │   ├── models/
│   │   │   ├── models.py      # Modelos de BD (SQLAlchemy)
│   │   │   └── schemas.py     # Esquemas (Pydantic)
│   │   ├── routes/
│   │   │   ├── bots.py        # Endpoints de bots
│   │   │   ├── accounts.py    # Endpoints de cuentas
│   │   │   └── monitors.py    # Endpoints de monitores
│   │   ├── services/
│   │   │   ├── email_service.py     # Lógica IMAP
│   │   │   └── telegram_service.py  # Lógica Telegram
│   │   ├── config.py          # Configuración
│   │   ├── database.py        # Setup de BD
│   │   └── main.py           # App principal FastAPI
│   ├── Dockerfile
│   └── requirements.txt
├── frontend/                   # Web UI (Vue.js)
│   └── index.html
├── docker-compose.yaml        # Orquestación
├── nginx.conf                 # Config del servidor web
└── README.md
```

## 📚 API REST

### Documentación Interactiva

Una vez que la app está corriendo, accede a:
- **Swagger UI**: http://localhost:8000/docs
- **ReDoc**: http://localhost:8000/redoc

### Endpoints

#### Bots Telegram

```
POST   /bots/              # Crear bot
GET    /bots/              # Listar todos
GET    /bots/{id}          # Obtener uno
PUT    /bots/{id}          # Actualizar
DELETE /bots/{id}          # Eliminar
POST   /bots/{id}/test     # Probar conexión
```

#### Cuentas de Email

```
POST   /accounts/                    # Crear cuenta
GET    /accounts/                    # Listar todas
GET    /accounts/{id}               # Obtener una
PUT    /accounts/{id}               # Actualizar
DELETE /accounts/{id}               # Eliminar
POST   /accounts/{id}/test          # Probar conexión
GET    /accounts/{id}/folders       # Listar carpetas
GET    /accounts/{id}/{folder}/unread  # Contar no leídos
```

#### Monitores

```
POST   /monitors/          # Crear monitor
GET    /monitors/          # Listar todos
GET    /monitors/{id}      # Obtener uno
PUT    /monitors/{id}      # Actualizar
DELETE /monitors/{id}      # Eliminar
```

### Ejemplos de Uso

**Crear un bot:**
```bash
curl -X POST http://localhost:8000/bots/ \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Mi Bot",
    "bot_token": "123456:ABC-DEF...",
    "chat_id": "-1001234567890"
  }'
```

**Crear una cuenta:**
```bash
curl -X POST http://localhost:8000/accounts/ \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Gmail",
    "email": "mi@gmail.com",
    "password": "app_password_aqui",
    "imap_server": "imap.gmail.com",
    "imap_port": 993
  }'
```

**Crear un monitor:**
```bash
curl -X POST http://localhost:8000/monitors/ \
  -H "Content-Type: application/json" \
  -d '{
    "bot_id": 1,
    "email_account_id": 1,
    "folder_name": "INBOX",
    "check_interval": 60
  }'
```

## ⚙️ Variables de Entorno

Crea un archivo `.env`:

```env
# Base de datos
DATABASE_URL=sqlite:///./notifier.db

# API
API_TITLE=Telegram Email Notifier
API_VERSION=1.0.0
```

## 🐳 Docker

### Ver logs

```bash
# Backend
docker-compose logs backend -f

# Frontend
docker-compose logs frontend -f

# Todo
docker-compose logs -f
```

### Detener

```bash
docker-compose down

# Con limpieza de volúmenes
docker-compose down -v
```

## 🔧 Desarrollo

### Estructura esperada

```
.
├── .env
├── backend/
├── frontend/
├── docker-compose.yaml
└── nginx.conf
```

### Ejecutar en modo desarrollo

```bash
# Backend con auto-reload
docker-compose up backend

# Frontend con live-server o similar
cd frontend
python -m http.server 8080
```

## 🐛 Troubleshooting

### "Connection refused"
- Verifica que Docker está corriendo: `docker ps`
- Asegúrate que los puertos 80 y 8000 estén disponibles
- Espera 10 segundos a que los servicios se inicien

### "Certificate verify failed"
- Es un problema común con IMAP SSL
- La app ya maneja esto automáticamente
- Verifica que las credenciales sean correctas

### "Invalid bot token"
- Asegúrate de copiar el token completo de BotFather
- No incluyas espacios antes o después
- El bot debe estar activo

### La BD está corrupta
```bash
docker-compose down -v
docker-compose up -d
```

## 📦 Tecnologías

- **Backend**: FastAPI, SQLAlchemy, Pydantic
- **Frontend**: Vue.js 3, HTML5, CSS3
- **Email**: IMAPClient
- **Telegram**: Requests
- **Servidor**: Nginx
- **BD**: SQLite
- **Contenedorización**: Docker

## 🤝 Contribuir

¡Las contribuciones son bienvenidas!

1. Fork el proyecto
2. Crea una rama: `git checkout -b feature/AmazingFeature`
3. Commit: `git commit -m 'Add AmazingFeature'`
4. Push: `git push origin feature/AmazingFeature`
5. Abre un Pull Request

## 📝 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo LICENSE para detalles.

## 💡 Ideas para el Futuro

- [ ] Notificaciones en tiempo real con WebSockets
- [ ] Filtros por remitente o asunto
- [ ] Soporte para otros servicios de mensajería (Discord, Slack)
- [ ] Interfaz de configuración más avanzada
- [ ] Base de datos PostgreSQL
- [ ] Autenticación y autorización
- [ ] Rate limiting
- [ ] Soporte para OAuth2

## 📞 Soporte

- Abre un issue en GitHub
- Consulta la documentación en `/docs`
- Revisa los logs: `docker-compose logs -f`

---

<div align="center">

Hecho con ❤️ para automatizar notificaciones de correo

[⬆ Volver arriba](#telegram-email-notifier---api-de-notificaciones)

</div>
