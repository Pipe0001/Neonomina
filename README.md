# Neonómina - Monorepo (Entrega 2)

## Tecnologías principales
- Backend: Python 3.11 + FastAPI
- Frontend: Nginx (static HTML) — demo "Hola Mundo"
- Base de datos: PostgreSQL 15
- Orquestación: Docker Compose
- Documentación API: Swagger/OpenAPI (FastAPI -> /docs)

## Requisitos
- Docker (v20+) y Docker Compose
- (Opcional) Cuenta en DockerHub para subir imágenes

## Cómo ejecutar local (con docker-compose)
1. Clonar repo:
git clone <URL_REPO>
cd neonomina-monorepo

2. Construir y ejecutar:
docker-compose up --build

3. Abrir en navegador:
- Frontend: http://localhost:8080
- Backend Swagger: http://localhost:8000/docs
- Endpoint prueba DB: http://localhost:8000/api/test-db

## Publicar imágenes a DockerHub (ejemplo)
1. `docker login`
2. Backend:
docker build -t DOCKERHUB_USER/neon-backend:0.1 ./backend
docker push DOCKERHUB_USER/neon-backend:0.1

3. Frontend:
docker build -t DOCKERHUB_USER/neon-frontend:0.1 ./frontend
docker push DOCKERHUB_USER/neon-frontend:0.1

## Branches y commits iniciales
- Crear rama principal:
git init
git branch -M main
git add .
git commit -m "chore: inicializar monorepo - hola mundo frontend & backend"
git remote add origin <URL>
git push -u origin main