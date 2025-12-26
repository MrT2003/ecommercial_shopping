from app.services.CartService import CartService
# from app.models.cart import cart
from fastapi import APIRouter, HTTPException

router = APIRouter()

#http://127.0.0.1:8000/api/users/
@router.get("/", response_model=list)  
async def get_users():
    carts = await CartService.get_carts()  
    if not carts:
        raise HTTPException(status_code=404, detail="No cart found")
    return carts
