from typing import Annotated, Any, List, Optional, Dict
from pydantic import BaseModel, Field, BeforeValidator
from bson import ObjectId

def validate_object_id(v: Any) -> str:
    if isinstance(v, ObjectId):
        return str(v)
    if isinstance(v, str) and ObjectId.is_valid(v):
        return v
    raise ValueError("Invalid ObjectId")

PyObjectId = Annotated[str, BeforeValidator(validate_object_id)]

class Address(BaseModel):
    address: str
    city: str
    country: str

class OrderItem(BaseModel):
    product: PyObjectId  # Changed from product_id to match service class
    quantity: int
    price: float

class Order(BaseModel):
    id: PyObjectId = Field(default_factory=lambda: str(ObjectId()), alias="_id")
    user_id: PyObjectId = Field() 
    items: List[OrderItem]
    total_price: float
    status: str  # pending, completed, cancelled
    payment_method: str  # credit_card, paypal, bank_transfer
    payment_status: str  # pending, completed, failed
    shipping_address: Address

    model_config = {
        "populate_by_name": True,
        "json_schema_extra": {
            "example": {
                "_id": "67c16c4ed87c5f25d3ae561c",
                "user_id": "67be899eabfe0be00df5b9dd",
                "items": [
                    {
                        "product": "67b3011e64ce74113d1500a8",  # Changed from product_id
                        "quantity": 2,
                        "price": 8.99
                    }
                ],
                "total_price": 17.98,
                "payment_method": "paypal",
                "payment_status": "pending",
                "shipping_address": {
                    "address": "123 Main St",
                    "city": "Hanoi",
                    "country": "Vietnam",
                },
            }
        }
    }