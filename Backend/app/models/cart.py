from typing import List
from pydantic import BaseModel, Field
from bson import ObjectId

class PyObjectId(str):
    @classmethod
    def __get_validators__(cls):
        yield cls.validate

    @classmethod
    def validate(cls, v):
        if not ObjectId.is_valid(v):
            raise ValueError("Invalid ObjectId")
        return str(v)

class OrderItem(BaseModel):
    product_id: PyObjectId = Field(..., alias="product")  # Tham chiếu đến Product
    quantity: int
    price: float

class Order(BaseModel):
    cart_id: PyObjectId = Field(default_factory=PyObjectId, alias="_id")
    user_id: PyObjectId = Field(..., alias="user")  
    items: List[OrderItem]  
    total_price: float

    class Config:
        populate_by_name = True
        json_encoders = {ObjectId: str}
