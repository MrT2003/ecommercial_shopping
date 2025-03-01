from typing import Optional, List, Any, Annotated
from pydantic import BaseModel, EmailStr, Field, BeforeValidator
from bson import ObjectId

def validate_object_id(v):
    if not ObjectId.is_valid(v):
        raise ValueError("Invalid ObjectId")
    return str(v)

PyObjectId = Annotated[str, BeforeValidator(validate_object_id)]

class UserCreate(BaseModel):
    name: str = Field(..., min_length=2, max_length=50)
    email: EmailStr = Field(...)
    password: str = Field(..., min_length=6)
    phone: Optional[str] = None
    address: Optional[str] = None

class UserDB(UserCreate):
    id: PyObjectId = Field(default_factory=lambda: str(ObjectId()), alias="_id")
    role: str = "customer"
    orders: List = []

    model_config = {
        "populate_by_alias": True,
        "json_schema_extra": {
            "example": {
                "_id": "507f1f77bcf86cd799439011",
                "name": "John Doe",
                "email": "johndoe@example.com",
                "password": "secret123",
                "phone": "0123456789",
                "address": "123 Main St",
                "role": "customer",
                "orders": []
            }
        }
    }