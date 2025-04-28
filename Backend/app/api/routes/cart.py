from typing import List
from pydantic import BaseModel
from app.models.cart import Cart
from app.services.CartService import CartService
from fastapi import APIRouter, HTTPException
from pprint import pprint


router = APIRouter()

# http://127.0.0.1:8000/api/carts/
@router.get("/", response_model=List[Cart])
async def get_carts():
    carts = await CartService.get_carts()

    if not carts:
        raise HTTPException(status_code=404, detail="No cart found")
    return carts

# http://127.0.0.1:8000/api/cart/add
class AddToCartRequest(BaseModel):
    user_id: str
    product_id: str
    quantity: int
    price: float
    name: str
    image: str
    
@router.post("/add")
async def add_to_cart(request: AddToCartRequest):
    response = await CartService.add_to_cart(
        request.user_id, request.product_id, request.quantity, request.price, request.name, request.image
    )
    return response

# http://127.0.0.1:8000/api/cart/update
class UpdateCartRequest(BaseModel):
    user_id: str
    product_id: str
    quantity: int

@router.put("/update")
async def update_cart(request: UpdateCartRequest):
    response = await CartService.update_cart_item(
        request.user_id, request.product_id, request.quantity
    )
    
    if "error" in response:
        raise HTTPException(status_code=400, detail=response["error"])
        
    return response

# http://127.0.0.1:8000/api/cart/remove/{item_id}
@router.delete("/remove/{item_id}")
async def remove_item_from_cart(product_id: str, user_id: str):
    response = await CartService.remove_item_from_cart(user_id, product_id)
    if "error" in response:
        raise HTTPException(status_code=400, detail=response["error"])
    return response