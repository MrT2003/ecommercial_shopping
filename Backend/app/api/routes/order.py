from app.services.OrderService import OrderService
# from app.models.cart import cart
from fastapi import APIRouter, HTTPException

router = APIRouter()

#http://127.0.0.1:8000/api/orders/
@router.get("/", response_model=list)  # Should return a list of Category
async def get_all_order():
    orders = await OrderService.get_all_orders()  # Must return a list of Category
    if not orders:
        raise HTTPException(status_code=404, detail="No orders found")
    return orders
