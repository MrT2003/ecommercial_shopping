# app/models/order.py
from typing import Annotated, Any, List, Optional
from pydantic import BaseModel, Field, BeforeValidator
from bson import ObjectId

# Hàm kiểm tra ObjectId hợp lệ
def validate_object_id(v: Any) -> str:
    if isinstance(v, ObjectId):
        return str(v)
    if isinstance(v, str) and ObjectId.is_valid(v):
        return v
    raise ValueError("Invalid ObjectId")

# Kiểu dữ liệu ObjectId cho Pydantic
PyObjectId = Annotated[str, BeforeValidator(validate_object_id)]

class Address(BaseModel):
    address: str
    city: str
    country: str

class OrderItem(BaseModel):
    product_id: PyObjectId
    quantity: int
    price: float

class Order(BaseModel):
    id: PyObjectId = Field(default_factory=lambda: str(ObjectId()), alias="_id")
    user_id: PyObjectId
    items: List[OrderItem]
    total_price: float
    status: str  # pending, completed, cancelled
    payment_method: str  # credit_card, paypal, bank_transfer, etc.
    payment_status: str  # pending, completed, failed
    shipping_address: Address
    billing_address: Address

    model_config = {
        "populate_by_name": True,
        "json_schema_extra": {
            "example": {
                "_id": "67c16c4ed87c5f25d3ae561c",
                "user_id": "67be899eabfe0be00df5b9dd",
                "items": [
                    {
                        "product_id": "67b3011e64ce74113d1500a8",
                        "quantity": 2,
                        "price": 8.99
                    }
                ],
                "total_price": 17.98,
                "status": "pending",
                "payment_method": "paypal",
                "payment_status": "pending",
                "shipping_address": {
                    "address": "123 Main St",
                    "city": "Hanoi",
                    "country": "Vietnam",
                },
                "billing_address": {
                    "address": "456 Another St",
                    "city": "Hanoi",
                    "country": "Vietnam",
                }
            }
        }
    }
