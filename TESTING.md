# 🧪 TESTING GUIDE - Telegram Email Notifier

## Verificar que Todo Funciona

### 1. Verifica Docker

```bash
# Verificar que Docker está corriendo
docker ps

# Debe mostrar: 2 contenedores activos (backend + frontend)
```

### 2. Verificar Backend

```bash
# Ver logs
docker-compose logs backend

# Debe mostrar: "Uvicorn running on 0.0.0.0:8000"
```

### 3. Verificar Frontend

```bash
# Ver logs
docker-compose logs frontend

# Debe mostrar: "nginx running" o similar
```

### 4. Test de Conectividad

```bash
# Probar backend
curl http://localhost:8000/health

# Respuesta esperada:
# {"status":"ok"}

# Probar frontend
curl http://localhost/

# Respuesta esperada: HTML del panel
```

### 5. Pruebas en el Panel Web

#### A. Crear un Bot Telegram

1. Abre http://localhost
2. Ve a la pestaña "🤖 Bots Telegram"
3. Rellena:
   - **Nombre del Bot:** "Test Bot"
   - **Bot Token:** Tu token real de @BotFather
   - **Chat ID:** Tu chat ID
4. Haz clic en "Crear Bot"
5. Resultado esperado: ✓ Mensaje de éxito

#### B. Crear Cuenta de Email

1. Ve a la pestaña "📧 Cuentas de Email"
2. Rellena datos de un email de prueba
3. Haz clic en "Agregar Cuenta"
4. Si falla:
   - Verifica credenciales
   - Abre puerto 993 (IMAP)
   - Para Gmail: usa contraseña de aplicación

#### C. Ver Carpetas

1. En la pestaña "📧 Cuentas de Email"
2. Haz clic en "Ver Carpetas"
3. Resultado esperado: Lista de carpetas de tu email

#### D. Crear Monitor

1. Ve a "👁️ Monitores"
2. Selecciona bot y email
3. Especifica carpeta (ej: INBOX)
4. Intervalo: 60 segundos
5. Haz clic en "Crear Monitor"
6. Resultado: Monitor aparece en la lista

### 6. Test Completo de Flujo

```bash
# 1. Envía un email a la carpeta monitoreada
# 2. Espera 60 segundos (o menos según tu intervalo)
# 3. Verifica que recibiste notificación en Telegram
```

## Tests de API (curl)

### Health Check

```bash
curl http://localhost:8000/health
```

Respuesta:
```json
{"status":"ok"}
```

### Listar Bots

```bash
curl http://localhost:8000/bots/
```

Respuesta:
```json
[]
```

### Crear Bot

```bash
curl -X POST http://localhost:8000/bots/ \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test",
    "bot_token": "123456:ABC-DEF...",
    "chat_id": "-1001234567890"
  }'
```

### Listar Cuentas

```bash
curl http://localhost:8000/accounts/
```

### Crear Cuenta

```bash
curl -X POST http://localhost:8000/accounts/ \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Gmail",
    "email": "test@gmail.com",
    "password": "app_password",
    "imap_server": "imap.gmail.com",
    "imap_port": 993
  }'
```

### Obtener Carpetas

```bash
curl http://localhost:8000/accounts/1/folders
```

## Troubleshooting

### Error: "Connection refused"

```bash
# Reinicia los contenedores
docker-compose restart

# O inicia desde cero
docker-compose down
docker-compose up -d
```

### Error: "Certificate verify failed"

Esto es esperado en algunos servidores IMAP. La app ya lo maneja.
Si aún falla:
- Verifica credenciales
- Prueba con un email diferente
- Asegurate de desactivar 2FA si lo tienes

### Error: "Port 80 already in use"

```bash
# En docker-compose.yaml, cambia:
# De: ports: - "80:80"
# A: ports: - "8080:80"

# Luego accede a: http://localhost:8080
```

### Error: "Bot token is invalid"

- Copia el token completo de @BotFather
- No incluyas espacios
- El bot debe estar activo

### Base de datos corrupta

```bash
# Elimina y reinicia
docker-compose down -v
docker-compose up -d
```

## Performance Testing

### Carga de Datos

```bash
# Crear 10 bots
for i in {1..10}; do
  curl -X POST http://localhost:8000/bots/ \
    -H "Content-Type: application/json" \
    -d "{\"name\":\"Bot$i\",\"bot_token\":\"token$i\",\"chat_id\":\"$i\"}"
done
```

### Ver Logs en Tiempo Real

```bash
# Todos los servicios
docker-compose logs -f

# Solo backend
docker-compose logs -f backend

# Solo frontend
docker-compose logs -f frontend
```

## Checklist de QA

- [ ] Docker containers están corriendo
- [ ] Panel web accesible en http://localhost
- [ ] API responsive en http://localhost:8000
- [ ] Swagger docs en http://localhost:8000/docs
- [ ] Puedo crear un bot
- [ ] Puedo crear una cuenta de email
- [ ] Puedo ver las carpetas
- [ ] Puedo crear un monitor
- [ ] Monitor verifica emails
- [ ] Recibo notificación en Telegram
- [ ] Puedo eliminar entidades
- [ ] No hay errores en logs

## Test de Producción

Si planeas deployar:

```bash
# 1. Crea un archivo .env con datos reales
cp .env.example .env
# Edita .env con valores reales

# 2. Construye imagen
docker build -t telegram-notifier ./backend

# 3. Ejecuta en producción
docker run -d \
  -p 8000:8000 \
  --env-file .env \
  telegram-notifier

# 4. Nginx va delante (ya incluido en docker-compose)
```

## Métricas de Éxito

✅ App está arriba y corriendo  
✅ Panel web es accesible  
✅ API funciona correctamente  
✅ Base de datos persiste datos  
✅ Bots se crean y prueban  
✅ Cuentas se validan  
✅ Carpetas se listan  
✅ Monitores funcionan  
✅ Notificaciones se envían  
✅ No hay errores SSL  
✅ Logs son claros  
✅ Performance es aceptable  

---

¡Si todos los tests pasan, tu app está lista para producción! 🚀
