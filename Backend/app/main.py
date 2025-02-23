from fastapi import FastAPI
from app.api import api_router

app = FastAPI(title="Commercial Projects", version="1.0")

# Import API Router
app.include_router(api_router, prefix="/api")