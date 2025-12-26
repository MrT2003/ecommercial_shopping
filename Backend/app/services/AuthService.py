import jwt
from motor.motor_asyncio import AsyncIOMotorDatabase
from app.models.user import UserCreate, UserDB
from bson import ObjectId
from typing import Optional
from passlib.context import CryptContext
from datetime import datetime, timedelta, timezone

class AuthService:
    pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
    SECRET_KEY = "your-secret-key"  
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
        collection = db["User"] 
        
        existing_user = await collection.find_one({"email": user_data.email})
        if existing_user:
            return None  

        hashed_password = await AuthService.hash_password(user_data.password)

        new_id = ObjectId()

        new_user = UserDB(
            id=str(new_id),
            name=user_data.name,
            email=user_data.email,
            password=hashed_password,
            phone=user_data.phone,
            address=user_data.address,
        )

        new_user_dict = new_user.dict(by_alias=True)
        new_user_dict["_id"] = new_id 
        if "id" in new_user_dict:
            del new_user_dict["id"]

        await collection.insert_one(new_user_dict)
        new_user_dict["_id"] = str(new_user_dict["_id"])
        return new_user_dict

    @staticmethod
    async def authenticate_user(db: AsyncIOMotorDatabase, email: str, password: str):
        collection = db["User"]
        
        user = await collection.find_one({"email": email})
        if not user:
            return None

        if not await AuthService.verify_password(password, user["password"]):
            return None

        return UserDB(**user)

    @staticmethod
    def create_access_token(data: dict, expires_delta: Optional[timedelta] = None) -> str:
        to_encode = data.copy()
        if expires_delta:
            expire = datetime.now(timezone.utc) + expires_delta
        else:
            expire = datetime.now(timezone.utc) + timedelta(minutes=15)
            
        to_encode.update({"exp": expire})
        encoded_jwt = jwt.encode(to_encode, AuthService.SECRET_KEY, algorithm=AuthService.ALGORITHM)
        return encoded_jwt
    
    @staticmethod
    async def update_user_profile(db: AsyncIOMotorDatabase, user_id: str, update_data: dict):
        collection = db["User"]
        
        try:
            oid = ObjectId(user_id)
        except:
            return None

        existing_user = await collection.find_one({"_id": oid})
        if not existing_user:
            return None 
            
        update_data = {k: v for k, v in update_data.items() if v is not None}
        
        if not update_data:
            return existing_user

        await collection.update_one(
            {"_id": oid},
            {"$set": update_data}
        )
        
        updated_user = await collection.find_one({"_id": oid})
        if updated_user:
            updated_user["_id"] = str(updated_user["_id"]) 
            
        return updated_user
    
    @staticmethod
    async def reset_password(db: AsyncIOMotorDatabase, email: str, new_password: str):
        """Đặt lại mật khẩu mới"""
        collection = db["User"]
        
        user = await collection.find_one({"email": email})
        if not user:
            return None 
            
        hashed_password = AuthService.pwd_context.hash(new_password)
        
        await collection.update_one(
            {"email": email},
            {"$set": {"password": hashed_password}}
        )
        return {"message": "Mật khẩu đã được đặt lại thành công"}