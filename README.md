# Telegram Email Notifier

Una aplicación profesional para monitorizar carpetas de correo y enviar notificaciones a través de Telegram.

## Características

✨ **Features principales:**
- 🤖 Gestión de múltiples bots de Telegram
- 📧 Soporte para múltiples cuentas de correo
- 👁️ Monitorización simultánea de múltiples carpetas
- 🌐 Panel de control web elegante e intuitivo
- 🔌 API REST completa
- 📦 Deployable con Docker Compose
- 🔐 Gestión segura de credenciales

## Requisitos

- Docker y Docker Compose
- O Python 3.11+ si ejecutas sin Docker

## Instalación Rápida

### Con Docker (Recomendado) ⭐

```bash
# 1. Clonar el repositorio
git clone https://github.com/alexflcl/telegram-email-notifier-app.git
cd telegram-email-notifier-app

# 2. Iniciar la aplicación
docker-compose up -d

# 3. Verificar que funciona
docker-compose ps
```

✅ **Accede a:**
- Panel de control: http://localhost
- API: http://localhost:8000
- Documentación API: http://localhost:8000/docs

📖 **Para más detalles**, consulta [DOCKER_DEPLOYMENT.md](DOCKER_DEPLOYMENT.md)

### Sin Docker

**Backend:**
```bash
cd backend
pip install -r requirements.txt
python -m uvicorn app.main:app --host 0.0.0.0 --port 8000
```

**Frontend:**
Sirve el archivo `frontend/index.html` con un servidor web:
```bash
# Con Python
python -m http.server 8000

# O usa Nginx, Apache, etc.
```

## Configuración

### 1. Agregar un Bot Telegram

1. Crea un bot en BotFather (@BotFather en Telegram)
2. Obtén el **Bot Token**
3. En el panel, ve a "🤖 Bots Telegram"
4. Rellena los datos y haz clic en "Crear Bot"
5. El panel te pedirá que hagas un chat con el bot para obtener el **Chat ID**

### 2. Agregar una Cuenta de Email

1. Ve a "📧 Cuentas de Email"
2. Rellena los datos de tu cuenta
3. Ejemplo para Gmail:
   - Email: tu@gmail.com
   - Contraseña: Contraseña de aplicación (no la contraseña normal)
   - Servidor IMAP: imap.gmail.com
   - Puerto: 993

4. Haz clic en "Probar Conexión" para verificar

### 3. Crear un Monitor

1. Ve a "👁️ Monitores"
2. Selecciona un bot y una cuenta de email
3. Especifica la carpeta a monitorizar (ej: INBOX, "ONLINE SALES")
4. Define el intervalo de verificación en segundos
5. ¡Listo! El monitor comenzará a funcionar

## 🔄 Actualizar la Aplicación

### Desde GitHub (Recomendado)

Cuando hagamos cambios y los subamos a GitHub, puedes actualizar tu instalación:

**Windows (PowerShell):**
```bash
cd ruta\del\proyecto
.\update.ps1
```

**Linux / Mac (Bash):**
```bash
cd /ruta/del/proyecto
chmod +x update.sh
./update.sh
```

**Manual (Cualquier sistema):**
```bash
git pull origin main
docker-compose down
docker-compose up -d --build
```

📖 **Para más detalles sobre workflow**, consulta [WORKFLOW_GITHUB.md](WORKFLOW_GITHUB.md)

## Estructura del Proyecto

```
telegram-email-notifier/
├── backend/
│   ├── app/
│   │   ├── models/
│   │   │   ├── models.py       # Modelos de base de datos
│   │   │   └── schemas.py      # Esquemas Pydantic
│   │   ├── routes/
│   │   │   ├── bots.py         # API de bots
│   │   │   ├── accounts.py     # API de cuentas
│   │   │   └── monitors.py     # API de monitores
│   │   ├── services/
│   │   │   ├── email_service.py    # Servicio IMAP
│   │   │   └── telegram_service.py # Servicio Telegram
│   │   ├── config.py           # Configuración
│   │   ├── database.py         # Conexión a BD
│   │   └── main.py            # App principal
│   ├── Dockerfile
│   └── requirements.txt
├── frontend/
│   └── index.html             # Panel de control
├── docker-compose.yaml
├── nginx.conf
└── README.md
```

## API REST

### Bots

- `POST /bots/` - Crear bot
- `GET /bots/` - Listar bots
- `GET /bots/{id}` - Obtener bot
- `PUT /bots/{id}` - Actualizar bot
- `DELETE /bots/{id}` - Eliminar bot
- `POST /bots/{id}/test` - Probar conexión

### Cuentas de Email

- `POST /accounts/` - Crear cuenta
- `GET /accounts/` - Listar cuentas
- `GET /accounts/{id}` - Obtener cuenta
- `PUT /accounts/{id}` - Actualizar cuenta
- `DELETE /accounts/{id}` - Eliminar cuenta
- `POST /accounts/{id}/test` - Probar conexión
- `GET /accounts/{id}/folders` - Listar carpetas
- `GET /accounts/{id}/{folder}/unread` - Contar no leídos

### Monitores

- `POST /monitors/` - Crear monitor
- `GET /monitors/` - Listar monitores
- `GET /monitors/{id}` - Obtener monitor
- `PUT /monitors/{id}` - Actualizar monitor
- `DELETE /monitors/{id}` - Eliminar monitor

## Ejemplos

### Crear un bot

```bash
curl -X POST http://localhost:8000/bots/ \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Mi Bot",
    "bot_token": "123456:ABC-DEF...",
    "chat_id": "-1001234567890"
  }'
```

### Crear una cuenta

```bash
curl -X POST http://localhost:8000/accounts/ \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Mi Correo",
    "email": "mi@gmail.com",
    "password": "app_password",
    "imap_server": "imap.gmail.com",
    "imap_port": 993
  }'
```

### Crear un monitor

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

## Variables de Entorno

Crea un archivo `.env` en la raíz del proyecto:

```env
DATABASE_URL=sqlite:///./notifier.db
API_TITLE=Telegram Email Notifier API
API_VERSION=1.0.0
```

## Desarrollo

### Estructura de carpetas esperada en Docker

```
.
├── backend/
├── frontend/
├── docker-compose.yaml
└── nginx.conf
```

### Logs

Ver logs del backend:
```bash
docker-compose logs backend -f
```

Ver logs del frontend:
```bash
docker-compose logs frontend -f
```

## Troubleshooting

### "Connection refused"
- Asegúrate de que Docker está corriendo
- Verifica que los puertos 80 y 8000 estén disponibles

### "Certificate verify failed"
- Es normal con algunos servidores IMAP
- La app ya maneja esto automáticamente
- Si aún tienes problemas, verifica las credenciales

### "Invalid bot token"
- Verifica que el token sea correcto
- Asegúrate de que el bot está activo en BotFather

## Licencia

MIT License - Libre para usar y modificar

## Contribuciones

¡Las contribuciones son bienvenidas! Abre un issue o un pull request.

## Soporte

Si tienes problemas, abre un issue en GitHub.

---

Hecho con ❤️ para automatizar notificaciones de correo
