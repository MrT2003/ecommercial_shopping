# from fastapi import FastAPI
# from fastapi.responses import RedirectResponse
# from app.api import api_router
# from app.db.mongo import lifespan 

# app = FastAPI(title="Commercial Projects", version="1.0", lifespan=lifespan)

# # Import API Router
# app.include_router(api_router, prefix="/api")

# @app.get("/")
# async def redirect_to_docs():
#     return RedirectResponse(url="/docs")


# @app.get("/health")
# def health():
#     return {"status": "ok"}

# app/main.py
from fastapi import FastAPI, Request
from fastapi.responses import RedirectResponse
from contextlib import asynccontextmanager

from app.api import api_router
from app.db.database import get_db, get_client, close_client, ping


@asynccontextmanager
async def lifespan(app: FastAPI):
    """
    Mở kết nối Mongo khi app start, gắn vào app.state; đóng khi app shutdown.
    """
    client = get_client()
    app.state.db_client = client
    app.state.db = get_db()
    try:
        yield
    finally:
        close_client()


app = FastAPI(title="Commercial Projects", version="1.0", lifespan=lifespan)

# Import API Router
app.include_router(api_router, prefix="/api")


@app.get("/")
async def redirect_to_docs():
    return RedirectResponse(url="/docs")


@app.get("/health")
async def health(_: Request):
    # Ping tới Mongo để bảo đảm DB đang sẵn sàng
    await ping()
    return {"status": "ok"}
