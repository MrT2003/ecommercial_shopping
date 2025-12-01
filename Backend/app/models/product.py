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
    description: Optional[str] = "" # Nên để optional phòng khi thiếu
    
    # SỬA LỖI 1: Category
    # Cho phép nhận vào cả List hoặc String. 
    # Nếu DB trả về string "Drink", code vẫn chạy.
    category: Union[List[str], str, None] = None 

    # SỬA LỖI 2, 3, 4, 5: Các trường bị thiếu
    # Thêm "Optional" và "default=None" (hoặc 0)
    rates: Optional[float] = None
    price: Optional[float] = 0.0
    distance: Optional[Union[float, str]] = None # Có thể DB lưu string "5km" hoặc float 5.0
    calories: Optional[Union[int, str]] = None   # Có thể DB lưu string "500 cal"
    preparationTime: Optional[str] = None
    tags: Optional[List[str]] = [] # Mặc định là list rỗng thay vì None để dễ xử lý Frontend
    imageURL: Optional[str] = None

    class Config:
        arbitrary_types_allowed = True
        json_encoders = {ObjectId: str}
        populate_by_name = True # Cho phép dùng cả _id hoặc id đều được

    # --- NÂNG CAO (OPTIONAL) ---
    # Đoạn code này giúp chuẩn hóa dữ liệu cho Frontend.
    # Ví dụ: DB là "Drink" (str) -> Tự động đổi thành ["Drink"] (list)
    @field_validator('category', mode='before')
    @classmethod
    def parse_category(cls, v):
        if isinstance(v, str):
            return [v] # Đổi string thành list
        return v