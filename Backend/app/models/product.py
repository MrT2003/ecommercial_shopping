from typing import List, Optional
from bson import ObjectId
from pydantic import BaseModel, Field
from pydantic_core.core_schema import ValidationInfo
from pydantic import GetCoreSchemaHandler

# Custom ObjectId class
class PyObjectId(ObjectId):
    @classmethod
    def __get_pydantic_core_schema__(cls, source, handler: GetCoreSchemaHandler):
        def validate(value, info: ValidationInfo):
            if not ObjectId.is_valid(value):
                raise ValueError("Invalid ObjectId")
            return ObjectId(value)
        
        return handler(source).copy(update={"function": validate})

# Product model with Pydantic
class Product(BaseModel):
    id: Optional[str] = Field(alias="_id", default=None)  # Đổi PyObjectId -> str
    name: str
    description: str
    category_id: str
    rates: float
    price: float
    distance: float
    calories: int
    preparationTime: str
    tags: List[str]
    imageURL: str

    class Config:
        arbitrary_types_allowed = True
        json_encoders = {ObjectId: str}  # Chuyển ObjectId thành string khi JSON serialize
