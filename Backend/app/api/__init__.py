from fastapi import APIRouter
from app.api.routes.product import router as product_router
from app.api.routes.category import router as category_router
from app.api.routes.cart import router as cart_router
from app.api.routes.order import router as order_router
from app.api.routes.auth import router as auth_router


api_router = APIRouter()
api_router.include_router(product_router, prefix="/products", tags=["Products"])
api_router.include_router(category_router, prefix="/categories", tags=["Categories"])
api_router.include_router(cart_router, prefix="/carts", tags=["Carts"])
api_router.include_router(order_router, prefix="/orders", tags=["Orders"])
api_router.include_router(auth_router, prefix="/auth", tags=["Auth"])
