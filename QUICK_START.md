# 🎯 QUICK START - Telegram Email Notifier

## Proyecto creado en 5 minutos ⚡

### 📂 Ubicación
```
c:\Proyectos IA\Telegram notifier\telegram-email-notifier-app
```

### 🚀 Inicio Inmediato

#### Opción 1: Windows (MÁS FÁCIL)
```bash
cd "c:\Proyectos IA\Telegram notifier\telegram-email-notifier-app"
setup.bat
```

#### Opción 2: PowerShell
```powershell
cd "c:\Proyectos IA\Telegram notifier\telegram-email-notifier-app"
docker-compose up -d
Start-Sleep -Seconds 10
Start-Process "http://localhost"
```

#### Opción 3: Manual
```bash
docker-compose up -d
# Espera 10 segundos
# Abre: http://localhost
```

### 🎨 Panel Web

**URL:** http://localhost  
**Backend API:** http://localhost:8000  
**Swagger Docs:** http://localhost:8000/docs

### 📋 3 Pasos para funcionar

1. **Crea un Bot en Telegram**
   - Abre Telegram → @BotFather
   - `/newbot` → Copia el token
   - Pega el token en el panel

2. **Agrega tu Email**
   - Gmail, Outlook, OVH, etc.
   - Credenciales IMAP
   - Prueba conexión

3. **Crea un Monitor**
   - Bot + Email + Carpeta
   - Intervalo de verificación
   - ¡Listo! Recibirás notificaciones

### 🐳 Comandos Docker

```bash
# Ver logs
docker-compose logs -f

# Detener
docker-compose down

# Reiniciar
docker-compose restart

# Ver estado
docker-compose ps
```

### ❌ Solucionar problemas

**"Connection refused"**
```bash
# Asegurate que Docker está corriendo
docker ps
```

**"Port 80 in use"**
```bash
# Cambiar puerto en docker-compose.yaml
# Línea: ports: - "8080:80"
```

**Base de datos corrupta**
```bash
docker-compose down -v
docker-compose up -d
```

### 📚 Documentación Completa

- `README.md` - Guía completa
- `RESUMEN_FINAL.md` - Qué se ha creado
- `GITHUB_PUBLISH.md` - Publicar en GitHub
- `CONTRIBUTING.md` - Cómo contribuir

### ✨ Características

✅ Panel web moderno  
✅ Gestión de múltiples bots y cuentas  
✅ Monitorización de carpetas  
✅ API REST completa  
✅ Docker listo para producción  
✅ 100% personalizable  
✅ GitHub-ready  

### 🎓 Stack Tecnológico

- **Backend:** FastAPI (Python 3.11)
- **Frontend:** Vue.js 3
- **Servidor:** Nginx
- **BD:** SQLite
- **Container:** Docker

### 📞 Estructura del Código

```
backend/
  ├── services/          # Email + Telegram
  ├── routes/           # API endpoints
  ├── models/           # Base de datos
  └── main.py          # App principal

frontend/
  └── index.html       # Panel web
```

### 🌟 Próximo Paso: GitHub

```bash
# Una vez que funciona localmente

git init
git add .
git commit -m "Initial commit: Professional email notifier"
git remote add origin https://github.com/tuusuario/telegram-email-notifier
git push -u origin main
```

---

**¿Listo?** Ejecuta `setup.bat` y ¡que disfrutes! 🎉
