import bcrypt, jwt
from motor.motor_asyncio import AsyncIOMotorDatabase
from app.models.user import UserCreate, UserDB
from app.db.database import user_collection
from bson import ObjectId
from typing import Optional
from passlib.context import CryptContext
from datetime import datetime, timedelta

class AuthService:
    pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
    SECRET_KEY = "your-secret-key"  # Thay thế với một khóa bí mật của bạn
    ALGORITHM = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES = 30

    @staticmethod
    async def hash_password(password: str) -> str:
        return AuthService.pwd_context.hash(password)

    @staticmethod
    async def verify_password(plain_password: str, hashed_password: str) -> bool:
        return AuthService.pwd_context.verify(plain_password, hashed_password)

    @staticmethod
    async def register_user(db: AsyncIOMotorDatabase, user_data: UserCreate):
        existing_user = await user_collection.find_one({"email": user_data.email})
        if existing_user:
            return None  

        hashed_password = await AuthService.hash_password(user_data.password)

        new_user = UserDB(
            id=str(ObjectId()),
            name=user_data.name,
            email=user_data.email,
            password=hashed_password,
            phone=user_data.phone,
            address=user_data.address,
        )

        new_user_dict = new_user.dict(by_alias=True)
        new_user_dict["_id"] = ObjectId(new_user_dict["_id"])

        result = await user_collection.insert_one(new_user_dict)

        new_user_dict["_id"] = str(result.inserted_id)
        return new_user_dict

    @staticmethod
    async def authenticate_user(db: AsyncIOMotorDatabase, email: str, password: str):
        user = await user_collection.find_one({"email": email})
        if not user:
            return None

        if not await AuthService.verify_password(password, user["password"]):
            return None

        return UserDB(**user)

    @staticmethod
    def create_access_token(data: dict, expires_delta: Optional[timedelta] = None) -> str:
        to_encode = data.copy()
        expire = datetime.utcnow() + (expires_delta if expires_delta else timedelta(minutes=30))
        to_encode.update({"exp": expire})
        encoded_jwt = jwt.encode(to_encode, AuthService.SECRET_KEY, algorithm=AuthService.ALGORITHM)
        return encoded_jwt
    

    @staticmethod
    async def update_user_profile(user_id: str, update_data: dict):
        existing_user = await user_collection.find_one({"_id": ObjectId(user_id)})
        if not existing_user:
            return None 
        # Loại bỏ các giá trị None để tránh cập nhật rỗng
        update_data = {k: v for k, v in update_data.items() if v is not None}
        # Cập nhật dữ liệu
        await user_collection.update_one(
            {"_id": ObjectId(user_id)},
            {"$set": update_data}
        )
        # Lấy lại user sau khi cập nhật và chuyển `_id` thành string
        updated_user = await user_collection.find_one({"_id": ObjectId(user_id)})
        updated_user["_id"] = str(updated_user["_id"]) 
        return updated_user
    
    @staticmethod
    async def reset_password(email: str, new_password: str):
        """Đặt lại mật khẩu mới"""
        user = await user_collection.find_one({"email": email})
        if not user:
            return None 
        # Hash mật khẩu mới
        hashed_password = AuthService.pwd_context.hash(new_password)
        # Cập nhật mật khẩu trong database
        await user_collection.update_one(
            {"email": email},
            {"$set": {"password": hashed_password}}
        )
        return {"message": "Mật khẩu đã được đặt lại thành công"}

