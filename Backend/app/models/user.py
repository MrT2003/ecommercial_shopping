from typing import List, Optional
from pydantic import BaseModel, Field, EmailStr
from bson import ObjectId

# Helper để chuyển ObjectId thành str
class PyObjectId(str):
    @classmethod
    def __get_validators__(cls):
        yield cls.validate

    @classmethod
    def validate(cls, v):
        if not ObjectId.is_valid(v):
            raise ValueError("Invalid ObjectId")
        return str(v)

# Schema chính cho User
class User(BaseModel):
    user_id: PyObjectId = Field(default_factory=PyObjectId, alias="_id")  # ID của User
    name: str = Field(..., min_length=2, max_length=50)  # Tên người dùng
    email: EmailStr = Field(...)  # Email hợp lệ
    password: str = Field(..., min_length=6)  # Mật khẩu (Nên hash trước khi lưu)
    phone: str = Field(..., min_length=10, max_length=15)  # Số điện thoại
    address: str = Field(..., max_length=255)  # Địa chỉ
    role: str = Field(default="customer")  # Vai trò (customer, admin,...)
    orders: List[PyObjectId] = Field(default=[])  # Danh sách đơn hàng (Mảng chứa ID đơn hàng)

    class Config:
        populate_by_name = True
        json_encoders = {ObjectId: str}
