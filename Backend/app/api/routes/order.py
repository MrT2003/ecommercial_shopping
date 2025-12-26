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

@router.get("/{order_id}", response_description="Xem chi tiết đơn hàng", response_model=Order)
async def get_order_detail(order_id: str):
    try:
        order = await OrderService.get_order_by_id(order_id)
        
        if not order:
            raise HTTPException(status_code=404, detail="Không tìm thấy đơn hàng")
            
        return order
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Lỗi server: {str(e)}")


@router.post("/", response_description="Tạo đơn hàng mới", response_model=Order)
async def create_order(
    user_id: str,
    shipping_address: Dict[str, Any] = Body(...),
    payment_method: str = Body(...)
):
    try:
        order = await OrderService.create_order(
            user_id=user_id,
            shipping_address=shipping_address,
            payment_method=payment_method
        )
        return order
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Lỗi server: {str(e)}")