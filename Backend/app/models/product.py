from typing import List, Optional
from bson import ObjectId
from pydantic import BaseModel, Field
from pydantic_core.core_schema import ValidationInfo
from pydantic import GetCoreSchemaHandler

class PyObjectId(ObjectId):
    @classmethod
    def __get_pydantic_core_schema__(cls, source, handler: GetCoreSchemaHandler):
        def validate(value, info: ValidationInfo):
            if not ObjectId.is_valid(value):
                raise ValueError("Invalid ObjectId")
            return ObjectId(value)
        
        return handler(source).copy(update={"function": validate})

class Product(BaseModel):
    id: Optional[str] = Field(alias="_id", default=None) 
    name: str
    description: str
    category: List[str] 
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
