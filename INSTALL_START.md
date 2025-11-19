# ⚡ Guía Rápida de Instalación

## 3 Pasos para Empezar

### 1️⃣ Clonar el Repositorio
```bash
git clone https://github.com/alexflcl/telegram-email-notifier-app.git
cd telegram-email-notifier-app
```

### 2️⃣ Iniciar con Docker Compose
```bash
docker-compose up -d
```

### 3️⃣ Acceder a la Aplicación
- **Panel Web**: http://localhost
- **API**: http://localhost:8000/docs

---

## ✅ Verificar que Funciona

```bash
# Ver estado de los contenedores
docker-compose ps

# Ver logs
docker-compose logs -f
```

---

## 🔄 Actualizar Cuando Hay Cambios

**Windows:**
```powershell
.\update.ps1
```

**Linux/Mac:**
```bash
./update.sh
```

**Manual (Todos los sistemas):**
```bash
git pull origin main
docker-compose down
docker-compose up -d --build
```

---

## 📚 Documentación Completa

- **[README.md](README.md)** - Documentación principal
- **[DOCKER_DEPLOYMENT.md](DOCKER_DEPLOYMENT.md)** - Detalles de Docker
- **[WORKFLOW_GITHUB.md](WORKFLOW_GITHUB.md)** - Flujo de trabajo y actualizaciones

---

## ❓ Problemas Comunes

### El servidor no responde
```bash
docker-compose logs backend
```

### Puerto 80 está en uso
Edita `docker-compose.yaml` y cambia:
```yaml
ports:
  - "8080:80"  # Usa puerto 8080
```

### Limpiar e reiniciar completamente
```bash
docker-compose down -v
docker-compose up -d --build
```

---

¡Listo! Ya está corriendo. 🚀
