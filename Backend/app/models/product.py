from typing import List, Optional, Union
from bson import ObjectId
from pydantic import BaseModel, Field, field_validator
from pydantic_core.core_schema import ValidationInfo
from pydantic import GetCoreSchemaHandler

# --- Giữ nguyên PyObjectId của bạn ---
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
    description: Optional[str] = ""
    category: Union[List[str], str, None] = None 
    rates: Optional[float] = None
    price: Optional[float] = 0.0
    distance: Optional[Union[float, str]] = None 
    calories: Optional[Union[int, str]] = None  
    preparationTime: Optional[str] = None
    tags: Optional[List[str]] = [] 
    imageURL: Optional[str] = None

    class Config:
        arbitrary_types_allowed = True
        json_encoders = {ObjectId: str}
        populate_by_name = True

    @field_validator('category', mode='before')
    @classmethod
    def parse_category(cls, v):
        if isinstance(v, str):
            return [v] 
        return v