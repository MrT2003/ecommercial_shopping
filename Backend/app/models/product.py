from typing import List, Optional
from pydantic import BaseModel, Field
from bson import ObjectId

# Custom ObjectId class
class PyObjectId(ObjectId):
    @classmethod
    def __get_validators__(cls):
        yield cls.validate

    @classmethod
    def validate(cls, v):
        if not ObjectId.is_valid(v):
            raise ValueError("Invalid ObjectId")
        return ObjectId(v)
    
# Product model with Pydantic
class Product(BaseModel):
    id: Optional[PyObjectId] = Field(alias="_id", default=None)
    name: str
    description: str
    category: str
    rates: float
    price: float
    distance: float
    calories: int
    preparationTime: str
    tags: List[str]
    imageURL: str

    class Config:
        arbitrary_types_allowed = True
        json_encoders = {ObjectId: str}