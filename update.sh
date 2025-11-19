#!/bin/bash
# Script de Actualización para Linux/Mac
# Actualiza el repositorio y reinicia los contenedores Docker

echo "================================"
echo "Actualizando Telegram Notifier"
echo "================================"
echo ""

# Verificar que estamos en el directorio correcto
if [ ! -f "docker-compose.yaml" ]; then
    echo "❌ Error: docker-compose.yaml no encontrado"
    echo "Asegúrate de estar en el directorio raíz del proyecto"
    exit 1
fi

# 1. Obtener cambios del repositorio
echo "📥 Descargando cambios desde GitHub..."
git pull origin main
if [ $? -ne 0 ]; then
    echo "❌ Error al hacer pull del repositorio"
    exit 1
fi

echo "✅ Cambios descargados correctamente"
echo ""

# 2. Detener contenedores
echo "🛑 Deteniendo contenedores..."
docker-compose down
if [ $? -ne 0 ]; then
    echo "❌ Error al detener contenedores"
    exit 1
fi

echo "✅ Contenedores detenidos"
echo ""

# 3. Construir e iniciar
echo "🏗️ Construyendo e iniciando aplicación..."
docker-compose up -d --build
if [ $? -ne 0 ]; then
    echo "❌ Error al iniciar contenedores"
    exit 1
fi

echo "✅ Aplicación iniciada correctamente"
echo ""

# 4. Esperar a que esté listo
echo "⏳ Esperando a que la aplicación esté lista..."
sleep 5

# 5. Verificar estado
echo ""
echo "📊 Estado de los contenedores:"
docker-compose ps

echo ""
echo "📋 Últimos logs (últimas 10 líneas):"
docker-compose logs --tail=10

echo ""
echo "================================"
echo "✅ Actualización completada"
echo "================================"
echo ""
echo "Accede a la aplicación en: http://localhost"
echo "API disponible en: http://localhost:8000"
echo "Documentación API: http://localhost:8000/docs"
