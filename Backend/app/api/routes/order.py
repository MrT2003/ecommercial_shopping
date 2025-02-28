from app.services.OrderService import OrderService
from app.models.order import Order
from fastapi import APIRouter, Body, HTTPException, status
from typing import Any, Dict, List

router = APIRouter()

@router.get("/", response_description="Lấy tất cả đơn hàng", response_model=List[Order])
async def get_all_orders():
    try:
        orders = await OrderService.get_all_orders()
        if not orders:
            raise HTTPException(status_code=404, detail="Không tìm thấy đơn hàng nào")
        return orders
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Lỗi server: {str(e)}")

@router.get("/{order_id}", response_description="Lấy đơn hàng theo ID", response_model=Order)
async def get_order_by_id(order_id: str):
    try:
        order = await OrderService.get_order_by_id(order_id)
        if not order:
            raise HTTPException(status_code=404, detail=f"Không tìm thấy đơn hàng với ID: {order_id}")
        return order
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Lỗi server: {str(e)}")

@router.post("/create/{user_id}", response_description="Tạo đơn hàng mới")
async def create_order(user_id: str, order_data: Dict[str, Any] = Body(...)):
    try:
        created_order = await OrderService.create_order(user_id, order_data)
        if not created_order:
            raise HTTPException(status_code=500, detail="Không thể tạo đơn hàng")
        return created_order
    except ValueError as ve:
        raise HTTPException(status_code=400, detail=str(ve))
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Lỗi server: {str(e)}")
