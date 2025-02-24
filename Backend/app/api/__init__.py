from fastapi import APIRouter
from app.api.routes.product import router as product_router
from app.api.routes.category import router as category_router

api_router = APIRouter()
api_router.include_router(product_router, prefix="/products", tags=["Products"])
api_router.include_router(category_router, prefix="/categories", tags=["Categories"])
