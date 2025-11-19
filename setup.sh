#!/bin/bash

# Telegram Email Notifier - Setup Script

echo "🚀 Configurando Telegram Email Notifier..."
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker no está instalado. Por favor, instala Docker primero."
    exit 1
fi

echo "✓ Docker encontrado"

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose no está instalado. Por favor, instala Docker Compose primero."
    exit 1
fi

echo "✓ Docker Compose encontrado"
echo ""

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creando archivo .env..."
    cp .env.example .env
    echo "✓ Archivo .env creado"
else
    echo "✓ Archivo .env ya existe"
fi

echo ""
echo "🐳 Iniciando contenedores..."
docker-compose up -d

echo ""
echo "⏳ Esperando a que los servicios se inicien..."
sleep 10

echo ""
echo "✅ ¡Configuración completada!"
echo ""
echo "📊 Panel de control: http://localhost"
echo "📡 API Backend: http://localhost:8000"
echo "📚 Documentación API: http://localhost:8000/docs"
echo ""
echo "🎯 Próximos pasos:"
echo "1. Abre http://localhost en tu navegador"
echo "2. Crea un bot en @BotFather (en Telegram)"
echo "3. Agrega tus cuentas de email"
echo "4. Crea monitores para tus carpetas"
echo ""
echo "📖 Para más ayuda, consulta README.md"
