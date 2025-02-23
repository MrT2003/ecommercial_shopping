from fastapi import APIRouter
from app.api.routes.product import router as product_router

api_router = APIRouter()
api_router.include_router(product_router, prefix="/products", tags=["Products"])
