# 🔄 Guía de Workflow de Desarrollo y Deployment

## Flujo de Trabajo Recomendado

```
Cambios locales → Git Commit → Push a GitHub → Pull en Servidor
```

---

## 1️⃣ EN TU MÁQUINA LOCAL (Desarrollo)

### Hacer cambios
```bash
# Edita los archivos que necesites
# Ejemplo: modificar un servicio en backend/app/services/email_service.py
```

### Verificar cambios
```bash
# Ver archivos modificados
git status

# Ver diferencias
git diff

# Ver los cambios específicos
git diff backend/app/services/email_service.py
```

### Guardar cambios (Commit)
```bash
# Hacer staging de archivos específicos
git add backend/app/services/email_service.py

# O agregar todos
git add .

# Crear commit con mensaje descriptivo
git commit -m "fix: mejorar validación de correos"
```

### Subir a GitHub
```bash
# Push a rama main
git push origin main

# Ver historial
git log --oneline
```

---

## 2️⃣ EN EL SERVIDOR (Producción)

### Opción A: Actualización Manual (Más control)
```bash
cd /ruta/a/tu/proyecto
git pull origin main
docker-compose down
docker-compose up -d --build
docker-compose logs -f
```

### Opción B: Script de Actualización (Recomendado)

**En Windows PowerShell:**
```powershell
# Navega al directorio del proyecto
cd C:\ruta\del\proyecto

# Ejecutar script
.\update.ps1
```

**En Linux/Mac Bash:**
```bash
cd /ruta/del/proyecto
chmod +x update.sh
./update.sh
```

---

## 3️⃣ CONFIGURAR ACTUALIZACIÓN AUTOMÁTICA (Optional)

### Cron Job (Linux/Mac)
```bash
# Editar crontab
crontab -e

# Actualizar cada hora (ej: 5 minutos pasada la hora)
5 * * * * cd /ruta/del/proyecto && ./update.sh >> /var/log/notifier-update.log 2>&1

# Cada 30 minutos
*/30 * * * * cd /ruta/del/proyecto && ./update.sh >> /var/log/notifier-update.log 2>&1
```

### Windows Task Scheduler
1. Abre **Task Scheduler**
2. Crear tarea → General
3. Nombre: "Update Telegram Notifier"
4. Acción → Nuevo → Programa: `powershell.exe`
5. Argumentos: `-NoProfile -ExecutionPolicy Bypass -File "C:\ruta\update.ps1"`
6. Desencadenador → Nueva → Cada 30 minutos

---

## 4️⃣ VERSIONADO SEMÁNTICO

### Mensaje de commit recomendado
```
feat:      Nueva característica (v1.1.0 → v1.2.0)
fix:       Arreglo de bug (v1.0.1 → v1.0.2)
docs:      Cambios en documentación
style:     Formato, sin cambio de lógica
refactor:  Reestructuración de código
perf:      Mejoras de rendimiento
test:      Agregar/modificar tests
chore:     Tareas de mantenimiento
```

### Ejemplos
```bash
git commit -m "feat: agregar autenticación con 2FA"
git commit -m "fix: solucionar timeout en conexión IMAP"
git commit -m "docs: actualizar instrucciones de instalación"
git commit -m "perf: optimizar consultas de base de datos"
```

---

## 5️⃣ RAMAS Y BRANCHING (Avanzado)

Si trabajas en equipo o quieres estructura profesional:

```bash
# Crear rama para feature nueva
git checkout -b feature/autenticacion-2fa

# Hacer cambios y commits
git add .
git commit -m "feat: implementar 2FA"

# Push a rama
git push origin feature/autenticacion-2fa

# En GitHub: crear Pull Request
# Después de review → Merge a main

# En tu máquina
git checkout main
git pull origin main
```

---

## 6️⃣ BACKUP Y RECUPERACIÓN

### Backup de base de datos antes de actualizar
```bash
# Script en update.ps1 (puedes agregarlo)
docker-compose exec backend cp notifier.db notifier.db.backup.$(date +%Y%m%d)
```

### Rollback a versión anterior
```bash
# Ver commits anteriores
git log --oneline

# Volver a commit específico
git reset --hard abc1234

# Push forzado (cuidado!)
git push origin main --force
```

---

## 7️⃣ CHECKLIST PRE-DEPLOYMENT

- [ ] Commit realizado con mensaje descriptivo
- [ ] Push a GitHub completado
- [ ] No hay conflictos en GitHub
- [ ] Base de datos tiene backup
- [ ] Tests pasan (si existen)
- [ ] Logs del servidor se monitorizan
- [ ] Documentación actualizada

---

## 8️⃣ ESTRUCTURA DE CARPETAS RECOMENDADA

```
proyecto-raiz/
├── backend/               # Código Python/FastAPI
│   ├── app/
│   ├── requirements.txt
│   └── Dockerfile
├── frontend/              # Código HTML/CSS/JS
│   └── index.html
├── .gitignore             # Archivos a ignorar
├── docker-compose.yaml    # Orquestación
├── update.ps1            # Script actualización (Windows)
├── update.sh             # Script actualización (Linux)
├── README.md             # Documentación principal
└── .env.example          # Variables de ejemplo
```

### .gitignore
```
# Archivos a NO subir a GitHub
.env                      # Variables sensibles
notifier.db              # Base de datos
*.pyc                    # Archivos compilados
__pycache__/             # Caché Python
.DS_Store                # macOS
Thumbs.db                # Windows
node_modules/            # Node (si usas)
venv/                    # Entorno virtual
*.log                    # Archivos de log
```

---

## 9️⃣ MONITOREO POST-DEPLOYMENT

```bash
# Ver logs en tiempo real
docker-compose logs -f backend

# Ver estado de contenedores
docker-compose ps

# Verificar API en línea
curl http://localhost:8000/health

# Verificar conectividad frontend-backend
docker-compose exec frontend curl http://backend:8000/health
```

---

## 🔟 TROUBLESHOOTING

### Error: "Changes not staged for commit"
```bash
# Stash cambios sin commitear
git stash

# Luego pull
git pull origin main
```

### Error: "Please commit your changes before you merge"
```bash
# Commit los cambios
git add .
git commit -m "mensaje"

# O descarta cambios locales
git checkout -- .
```

### El servidor no actualiza
```bash
# Forzar actualización
git fetch origin
git reset --hard origin/main

# Reconstruir contenedores
docker-compose down
docker-compose up -d --build
```

---

## 📞 Resumen de Comandos Frecuentes

```bash
# Desarrollo
git status              # Ver cambios
git add .              # Agregar archivos
git commit -m "msg"    # Hacer commit
git push origin main   # Subir a GitHub

# Servidor
git pull origin main   # Descargar cambios
docker-compose down    # Detener
docker-compose up -d --build  # Iniciar

# Logs
docker-compose logs -f # Ver en tiempo real
docker-compose logs --tail=50 # Últimas 50 líneas
```

---

¡Así tienes un workflow profesional y automatizado! 🚀
