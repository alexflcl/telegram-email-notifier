# 🐳 Guía de Despliegue con Docker Compose

## Instalación Rápida

### Requisitos
- Docker (v20.10+)
- Docker Compose (v2.0+)
- Git

### Pasos de Instalación

#### 1. Clonar el repositorio
```bash
git clone https://github.com/alexflcl/telegram-email-notifier-app.git
cd telegram-email-notifier-app
```

#### 2. Configurar variables de entorno
```bash
# Copiar archivo de ejemplo
cp .env.example .env

# Editar .env si es necesario (opcional, usa valores por defecto)
# nano .env (Linux/Mac) o notepad .env (Windows)
```

#### 3. Iniciar la aplicación
```bash
docker-compose up -d
```

#### 4. Verificar que todo funciona
```bash
# Ver estado de los contenedores
docker-compose ps

# Ver logs del backend
docker-compose logs backend

# Ver logs del frontend (Nginx)
docker-compose logs frontend
```

#### 5. Acceder a la aplicación
- **Frontend**: http://localhost
- **API Backend**: http://localhost:8000
- **API Docs**: http://localhost:8000/docs

---

## 🛠️ Gestión de la Aplicación

### Detener la aplicación
```bash
docker-compose down
```

### Reiniciar
```bash
docker-compose restart
```

### Ver logs en tiempo real
```bash
docker-compose logs -f
```

### Ejecutar migraciones o comandos específicos
```bash
docker-compose exec backend python -m alembic upgrade head
```

---

## 🔄 Actualizar desde GitHub

### Método 1: Script automático (Windows PowerShell)
```powershell
# update.ps1
git pull origin main
docker-compose down
docker-compose up -d --build
docker-compose logs -f backend
```

Ejecutar:
```powershell
.\update.ps1
```

### Método 2: Script automático (Linux/Mac Bash)
```bash
#!/bin/bash
# update.sh
git pull origin main
docker-compose down
docker-compose up -d --build
docker-compose logs -f backend
```

Ejecutar:
```bash
chmod +x update.sh
./update.sh
```

### Método 3: Manual
```bash
git pull origin main
docker-compose down
docker-compose up -d --build
```

---

## 📦 Estructura de volúmenes

Los datos persistentes se almacenan en:
- `notifier.db` - Base de datos SQLite
- `./backend/app` - Código fuente (sincronizado)
- `./frontend` - Archivos estáticos web

### Para persistencia en servidor

Si quieres persistencia duradora, modifica `docker-compose.yaml`:

```yaml
volumes:
  db_data:
  app_data:

services:
  backend:
    # ... resto de config ...
    volumes:
      - app_data:/app/data
      - ./backend/app:/app/app
```

---

## 🔐 Seguridad en Producción

### Cambiar puerto del frontend
```yaml
# docker-compose.yaml
frontend:
  ports:
    - "3000:80"  # Acceso en puerto 3000
```

### Agregar HTTPS (con Nginx inverso)
```bash
# Usa Let's Encrypt con Certbot
certbot certonly --standalone -d tu-dominio.com
```

### Variables de entorno sensibles
```bash
# En .env
DEBUG=false
ALLOWED_HOSTS=tu-dominio.com,www.tu-dominio.com
```

---

## 🐛 Troubleshooting

### El frontend no se conecta al backend
```bash
# Verificar conectividad
docker-compose exec frontend curl http://backend:8000/health

# Ver logs del backend
docker-compose logs backend
```

### Puerto 80 ya en uso
```bash
# Cambiar puerto en docker-compose.yaml
ports:
  - "8080:80"  # Usa puerto 8080
```

### Base de datos corrupta
```bash
# Hacer backup y reiniciar
cp notifier.db notifier.db.backup
rm notifier.db
docker-compose down
docker-compose up -d
```

### Limpiar todo y empezar de cero
```bash
docker-compose down -v  # -v elimina volúmenes
docker system prune -a  # Limpia imágenes no usadas
docker-compose up -d --build
```

---

## 📊 Monitoreo

### Ver métricas del contenedor
```bash
docker stats
```

### Ver uso de recursos
```bash
docker-compose ps
```

### Logs persistentes
```bash
# Los logs se guardan en:
docker-compose logs --tail=100 backend > logs.txt
```

---

## 🚀 Deployment en diferentes plataformas

### AWS EC2
1. Instala Docker en tu instancia Ubuntu
2. Clone el repo
3. Abre puerto 80 en Security Group
4. Ejecuta `docker-compose up -d`

### DigitalOcean App Platform
1. Conecta tu repo GitHub
2. Usa Dockerfile del backend
3. Configure variables de entorno en el dashboard

### Heroku (usando buildpack)
```bash
heroku create tu-app-name
heroku config:set DOCKER_BUILDKIT=1
git push heroku main
```

### Docker Hub
```bash
# Hacer push de imagen personalizada
docker build -t tu-usuario/telegram-notifier ./backend
docker push tu-usuario/telegram-notifier
```

---

## 📝 Tips y Mejores Prácticas

✅ **Hacer backup regularmente**
```bash
docker-compose exec backend cp notifier.db notifier.db.backup
```

✅ **Usar secretos en producción**
```bash
# En lugar de .env, usa Docker Secrets
# docker secret create db_password <(echo 'contraseña')
```

✅ **Health checks**
```bash
# El docker-compose.yaml ya incluye healthcheck
docker-compose ps  # Verifica status "healthy"
```

✅ **Logs centralizados**
```yaml
# docker-compose.yaml
logging:
  driver: "json-file"
  options:
    max-size: "10m"
    max-file: "3"
```

---

## ❓ Soporte

Para problemas, consulta:
- [Issues GitHub](https://github.com/alexflcl/telegram-email-notifier-app/issues)
- README.md principal
- CONTRIBUTING.md para contribuir
