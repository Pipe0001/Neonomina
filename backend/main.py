import os
import psycopg2
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title="Neonómina - Backend", version="0.1")

# CORS: el frontend en el contenedor (nginx) hará proxy /api al backend,
# pero dejamos CORS abierto para pruebas iniciales.
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/api/hello")
def hello():
    return {"message": "Hola desde el backend (Neonómina)!"}

@app.get("/api/health")
def health():
    return {"status": "ok"}

@app.get("/api/test-db")
def test_db():
    host = os.getenv("DATABASE_HOST", "localhost")
    port = os.getenv("DATABASE_PORT", "5432")
    user = os.getenv("DATABASE_USER", "neonuser")
    password = os.getenv("DATABASE_PASSWORD", "neonpass")
    dbname = os.getenv("DATABASE_NAME", "neonomina")

    conn_str = f"host={host} port={port} dbname={dbname} user={user} password={password}"
    try:
        conn = psycopg2.connect(conn_str)
        cur = conn.cursor()
        cur.execute("SELECT 1;")
        res = cur.fetchone()
        cur.close()
        conn.close()
        return {"db_ok": bool(res)}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
