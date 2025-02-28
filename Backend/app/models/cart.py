from typing import Annotated, Any, List
from pydantic import BaseModel, Field, BeforeValidator
from bson import ObjectId

# Define the validator function
def validate_object_id(v: Any) -> str:
    if isinstance(v, ObjectId):
        return str(v)
    if isinstance(v, str) and ObjectId.is_valid(v):
        return v
    raise ValueError("Invalid ObjectId")

# Create a type with validation
PyObjectId = Annotated[str, BeforeValidator(validate_object_id)]

class CartItem(BaseModel):
    product: PyObjectId = Field(..., alias="product")
    quantity: int
    price: float

class Cart(BaseModel):
    cart_id: PyObjectId = Field(default_factory=lambda: str(ObjectId()), alias="_id")
    user_id: PyObjectId = Field(..., alias="user")
    items: List[CartItem] = []
    total_price: float | int = 0.0

    model_config = {
        "populate_by_name": True,
        "json_schema_extra": {
            "example": {
                "_id": "507f1f77bcf86cd799439011",
                "user": "507f1f77bcf86cd799439012",
                "items": [
                    {
                        "product": "507f1f77bcf86cd799439013",
                        "quantity": 2,
                        "price": 29.99
                    }
                ],
                "total_price": 59.98
            }
        }
    }