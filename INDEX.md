# 📑 Índice de Documentación

## 🚀 Inicio Rápido

**👉 [INSTALL_START.md](INSTALL_START.md)** - 3 pasos para empezar (⏱️ 2 minutos)

---

## 📖 Documentación Completa

### General
- **[README.md](README.md)** - Descripción completa del proyecto, características, API
- **[START_HERE.md](START_HERE.md)** - Guía de primeros pasos

### Instalación & Despliegue
- **[DOCKER_DEPLOYMENT.md](DOCKER_DEPLOYMENT.md)** - Guía completa de Docker Compose
  - Instalación paso a paso
  - Cómo actualizar la aplicación
  - Troubleshooting
  - Deployment en producción

### Desarrollo & Workflow
- **[WORKFLOW_GITHUB.md](WORKFLOW_GITHUB.md)** - Flujo de trabajo de desarrollo
  - Cómo hacer cambios localmente
  - Cómo subirlos a GitHub
  - Cómo actualizar en servidor
  - Scripts de automatización

### Configuración & Testing
- **[QUICK_START.md](QUICK_START.md)** - Inicio rápido alternativo
- **[TESTING.md](TESTING.md)** - Pruebas de la aplicación

### Contribución
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Cómo contribuir al proyecto
- **[CHANGELOG.md](CHANGELOG.md)** - Historial de cambios

---

## 🛠️ Scripts de Automatización

### Para Windows (PowerShell)
```powershell
# Actualizar desde GitHub
.\update.ps1
```

**Archivo:** `update.ps1`

### Para Linux / Mac (Bash)
```bash
# Actualizar desde GitHub
chmod +x update.sh
./update.sh
```

**Archivo:** `update.sh`

---

## 🎯 Por Caso de Uso

### Quiero instalar y empezar ahora
1. Lee: [INSTALL_START.md](INSTALL_START.md)
2. Ejecuta: `docker-compose up -d`
3. Accede: http://localhost

### Quiero entender cómo funciona
1. Lee: [README.md](README.md)
2. Revisa: Carpetas `backend/` y `frontend/`

### Quiero hacer cambios en el código
1. Lee: [WORKFLOW_GITHUB.md](WORKFLOW_GITHUB.md)
2. Haz cambios locales
3. Ejecuta: `git push origin main`
4. En servidor: `.\update.ps1` (Windows) o `./update.sh` (Linux)

### Quiero desplegar en producción
1. Lee: [DOCKER_DEPLOYMENT.md](DOCKER_DEPLOYMENT.md)
2. Sigue la sección "Deployment en diferentes plataformas"

### Quiero contribuir al proyecto
1. Lee: [CONTRIBUTING.md](CONTRIBUTING.md)
2. Haz un fork en GitHub
3. Crea una rama feature
4. Abre un Pull Request

---

## 📁 Estructura de Archivos

```
telegram-email-notifier-app/
├── 📄 INSTALL_START.md          ⭐ Empieza aquí
├── 📄 README.md                 📚 Documentación principal
├── 📄 DOCKER_DEPLOYMENT.md      🐳 Docker y despliegue
├── 📄 WORKFLOW_GITHUB.md        🔄 Desarrollo y actualizaciones
├── 📄 QUICK_START.md            ⚡ Alternativa rápida
├── 📄 CONTRIBUTING.md           🤝 Cómo contribuir
├── 📄 CHANGELOG.md              📝 Cambios
├── 📄 TESTING.md                🧪 Pruebas
│
├── 🔧 update.ps1                Windows PowerShell
├── 🔧 update.sh                 Linux/Mac Bash
├── 🔧 docker-compose.yaml       Orquestación de contenedores
├── 🔧 .env.example              Variables de ejemplo
│
├── 📁 backend/                  Backend FastAPI
│   ├── app/
│   ├── requirements.txt
│   └── Dockerfile
│
└── 📁 frontend/                 Frontend HTML/CSS/JS
    └── index.html
```

---

## ✨ Resumen Rápido

| Necesidad | Documento | Tiempo |
|-----------|-----------|--------|
| Empezar ahora | INSTALL_START.md | 2 min |
| Entender proyecto | README.md | 10 min |
| Instalar en servidor | DOCKER_DEPLOYMENT.md | 15 min |
| Actualizar el código | WORKFLOW_GITHUB.md | 5 min |
| Cambiar algo | CONTRIBUTING.md | 10 min |
| Probar funcionamiento | TESTING.md | 10 min |

---

## 🆘 Ayuda

**¿No encuentras lo que buscas?**
- Revisa el README.md principal
- Mira los comentarios en el código
- Abre un issue en GitHub: https://github.com/alexflcl/telegram-email-notifier-app/issues

**¿Quieres aportar?**
- Lee CONTRIBUTING.md
- Haz un fork
- Crea una rama con tu feature
- Abre un Pull Request

---

📦 **Versión:** 1.0.0  
🗓️ **Última actualización:** 19 de Noviembre, 2025  
👨‍💻 **Autor:** alexflcl  
📄 **Licencia:** MIT
