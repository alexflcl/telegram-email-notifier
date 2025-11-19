# Script de Actualización para Windows PowerShell
# Actualiza el repositorio y reinicia los contenedores Docker

Write-Host "================================" -ForegroundColor Cyan
Write-Host "Actualizando Telegram Notifier" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Verificar que estamos en el directorio correcto
if (-not (Test-Path "docker-compose.yaml")) {
    Write-Host "❌ Error: docker-compose.yaml no encontrado" -ForegroundColor Red
    Write-Host "Asegúrate de estar en el directorio raíz del proyecto" -ForegroundColor Red
    exit 1
}

# 1. Obtener cambios del repositorio
Write-Host "📥 Descargando cambios desde GitHub..." -ForegroundColor Yellow
git pull origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error al hacer pull del repositorio" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Cambios descargados correctamente" -ForegroundColor Green
Write-Host ""

# 2. Detener contenedores
Write-Host "🛑 Deteniendo contenedores..." -ForegroundColor Yellow
docker-compose down
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error al detener contenedores" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Contenedores detenidos" -ForegroundColor Green
Write-Host ""

# 3. Construir e iniciar
Write-Host "🏗️ Construyendo y iniciando aplicación..." -ForegroundColor Yellow
docker-compose up -d --build
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error al iniciar contenedores" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Aplicación iniciada correctamente" -ForegroundColor Green
Write-Host ""

# 4. Esperar a que esté listo
Write-Host "⏳ Esperando a que la aplicación esté lista..." -ForegroundColor Cyan
Start-Sleep -Seconds 5

# 5. Verificar estado
Write-Host ""
Write-Host "📊 Estado de los contenedores:" -ForegroundColor Cyan
docker-compose ps

Write-Host ""
Write-Host "📋 Últimos logs (últimas 10 líneas):" -ForegroundColor Cyan
docker-compose logs --tail=10

Write-Host ""
Write-Host "================================" -ForegroundColor Green
Write-Host "✅ Actualización completada" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green
Write-Host ""
Write-Host "Accede a la aplicación en: http://localhost" -ForegroundColor Green
Write-Host "API disponible en: http://localhost:8000" -ForegroundColor Green
Write-Host "Documentación API: http://localhost:8000/docs" -ForegroundColor Green
