# 🚀 GUÍA COMPLETA: Instalación Docker Compose + Actualizaciones desde GitHub

---

## 📋 Resumen Ejecutivo

He creado **documentación completa y scripts automáticos** para:

1. ✅ **Instalar** la app en cualquier lugar con `docker-compose up -d`
2. ✅ **Actualizar** automáticamente cuando hagas cambios en GitHub
3. ✅ **Administrar** logs, backups y troubleshooting

---

## 🎯 Para Empezar AHORA (2 minutos)

### Paso 1: Clonar
```bash
git clone https://github.com/alexflcl/telegram-email-notifier-app.git
cd telegram-email-notifier-app
```

### Paso 2: Iniciar
```bash
docker-compose up -d
```

### Paso 3: Acceder
- 🌐 http://localhost - Panel web
- 📚 http://localhost:8000/docs - API docs

**¡Listo! Ya está corriendo.** ✨

---

## 🔄 Flujo de Trabajo Completo

### En TU MÁQUINA (Desarrollo)

```bash
# 1. Hacer cambios
# Edita los archivos que necesites

# 2. Ver qué cambió
git status
git diff

# 3. Guardar cambios
git add .
git commit -m "feat: describe tu cambio"

# 4. Subir a GitHub
git push origin main
```

### En EL SERVIDOR (Producción)

**Opción A - Con Script (Recomendado):**

Windows:
```powershell
.\update.ps1
```

Linux/Mac:
```bash
./update.sh
```

**Opción B - Manual:**
```bash
git pull origin main
docker-compose down
docker-compose up -d --build
```

---

## 📚 Documentación Disponible

| Documento | Propósito | Cuándo leerlo |
|-----------|-----------|---------------|
| **INSTALL_START.md** | 3 pasos para empezar | Ahora mismo ⚡ |
| **README.md** | Descripción completa | Para entender la app |
| **DOCKER_DEPLOYMENT.md** | Todo sobre Docker | Para instalación en servidor |
| **WORKFLOW_GITHUB.md** | Flujo de desarrollo | Para actualizar desde GitHub |
| **INDEX.md** | Mapa de documentación | Para navegar |

---

## 🛠️ Scripts Incluidos

### `update.ps1` - Windows PowerShell
```powershell
.\update.ps1
```
✅ Baja cambios de GitHub  
✅ Detiene contenedores  
✅ Reconstruye imágenes  
✅ Reinicia aplicación  
✅ Muestra logs  

### `update.sh` - Linux/Mac Bash
```bash
chmod +x update.sh
./update.sh
```
Mismo funcionamiento que `update.ps1`

---

## 💾 Estructura de Directorios

```
telegram-email-notifier-app/
├── docker-compose.yaml        ← Orquestación de contenedores
├── .env.example               ← Variables de ejemplo
├── update.ps1                 ← Script Windows
├── update.sh                  ← Script Linux/Mac
│
├── INSTALL_START.md           ⭐ EMPIEZA AQUÍ
├── README.md                  ← Documentación principal
├── DOCKER_DEPLOYMENT.md       ← Docker en detalle
├── WORKFLOW_GITHUB.md         ← Desarrollo y actualizaciones
├── INDEX.md                   ← Mapa de todo
│
├── backend/
│   ├── app/
│   ├── requirements.txt
│   └── Dockerfile
│
└── frontend/
    └── index.html
```

---

## ⚙️ Configuración (Opcional)

### Variables de Entorno
Copia `.env.example` a `.env` y personaliza si es necesario:
```bash
cp .env.example .env
# Edita si necesitas cambiar algo
```

### Cambiar puertos
En `docker-compose.yaml`:
```yaml
frontend:
  ports:
    - "8080:80"  # Cambiar de 80 a 8080
```

---

## 🔍 Monitoreo y Logs

### Ver estado
```bash
docker-compose ps
```

### Ver logs en tiempo real
```bash
docker-compose logs -f
```

### Ver solo logs del backend
```bash
docker-compose logs -f backend
```

### Última línea de logs
```bash
docker-compose logs --tail=20
```

---

## 🐛 Troubleshooting Común

### "No se puede acceder a http://localhost"
```bash
# Verificar que los contenedores están corriendo
docker-compose ps

# Ver logs de errores
docker-compose logs backend
```

### "Puerto 80 ya está en uso"
Cambiar en `docker-compose.yaml`:
```yaml
ports:
  - "8080:80"
```

### "Update.ps1 no se ejecuta" (Windows)
```powershell
# Cambiar política de ejecución
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Limpiar e reiniciar todo
```bash
docker-compose down -v  # Elimina volúmenes
docker system prune -a   # Limpia todo
docker-compose up -d --build
```

---

## 🚀 Deployment en Producción

### Requisitos Mínimos
- ✅ Docker & Docker Compose
- ✅ Git instalado
- ✅ Acceso SSH al servidor

### Pasos
1. SSH al servidor
2. Clone el repositorio
3. Copia `.env.example` a `.env` (personaliza si necesario)
4. Ejecuta `docker-compose up -d`
5. Configura un proxy inverso (Nginx/Apache) si es necesario

Ver **DOCKER_DEPLOYMENT.md** para más opciones de deployment.

---

## 📊 Automatización (Avanzado)

### Windows Task Scheduler
1. Abre Task Scheduler
2. Nueva tarea → "Update Telegram Notifier"
3. Acción: `powershell.exe -NoProfile -File "C:\ruta\update.ps1"`
4. Desencadenador: Cada 30 minutos (o como prefieras)

### Linux Cron
```bash
# Editar crontab
crontab -e

# Agregar (actualizar cada hora)
5 * * * * cd /ruta/proyecto && ./update.sh >> /var/log/notifier.log 2>&1
```

---

## 📝 Resumen de Comandos Frecuentes

```bash
# Instalación inicial
git clone https://github.com/alexflcl/telegram-email-notifier-app.git
cd telegram-email-notifier-app
docker-compose up -d

# Desarrollo - hacer cambios
git add .
git commit -m "tu mensaje"
git push origin main

# Servidor - actualizar
.\update.ps1              # Windows
./update.sh               # Linux/Mac

# Administración
docker-compose ps         # Ver estado
docker-compose logs -f    # Ver logs
docker-compose down       # Detener
docker-compose restart    # Reiniciar
```

---

## 🎓 Conceptos Clave

### Docker Compose
- Levanta múltiples contenedores (backend + frontend + nginx)
- Maneja networking automático
- Persiste datos en volúmenes

### Git & GitHub
- `git push` sube cambios al repositorio remoto
- `git pull` descarga cambios del repositorio
- Permite colaboración y historial de cambios

### Update Scripts
- Automatizan el proceso de `pull` + `docker down` + `docker up`
- Ahorran tiempo en actualizaciones
- Reducen errores manuales

---

## ✅ Checklist de Instalación

- [ ] Cloné el repositorio
- [ ] Tengo Docker instalado (`docker --version`)
- [ ] Tengo Docker Compose instalado (`docker-compose --version`)
- [ ] Ejecuté `docker-compose up -d`
- [ ] Accedí a http://localhost (funciona)
- [ ] Leí INSTALL_START.md
- [ ] Configuré los bots y cuentas de email

---

## 🎉 ¡Felicitaciones!

Ahora tienes:

✅ **Instalación fácil** - Un comando y ya funciona  
✅ **Actualizaciones automáticas** - Scripts listos para usar  
✅ **Documentación completa** - Para cualquier caso de uso  
✅ **Listo para producción** - Con health checks y manejo de errores  

---

## 🆘 ¿Necesitas Ayuda?

1. **Primero:** Lee [INSTALL_START.md](INSTALL_START.md)
2. **Luego:** Consulta [DOCKER_DEPLOYMENT.md](DOCKER_DEPLOYMENT.md)
3. **Flujo:** Revisa [WORKFLOW_GITHUB.md](WORKFLOW_GITHUB.md)
4. **Índice:** Usa [INDEX.md](INDEX.md) para navegar
5. **Issues:** Abre un issue en GitHub

---

**Versión:** 1.0.0 | **Fecha:** 19 de Noviembre, 2025 | **Estado:** ✅ Listo para producción
