FROM python:3.11-slim

WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

# Copiar archivos
COPY backend/ .

# Instalar dependencias Python
RUN pip install --no-cache-dir fastapi uvicorn sqlalchemy pydantic imapclient requests

# Crear directorio para base de datos
RUN mkdir -p /app/data

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
