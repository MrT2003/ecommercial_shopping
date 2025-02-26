import bcrypt, jwt
from motor.motor_asyncio import AsyncIOMotorDatabase
from app.models.user import UserCreate, UserDB
from app.db.database import user_collection
from bson import ObjectId
from typing import Optional
from passlib.context import CryptContext
from datetime import datetime, timedelta

class AuthService:

    #Create Account
    @staticmethod
    async def hash_password(password: str) -> str:
        salt = bcrypt.gensalt()
        return bcrypt.hashpw(password.encode("utf-8"), salt).decode("utf-8")

    @staticmethod
    async def register_user(db: AsyncIOMotorDatabase, user_data: UserCreate):
        existing_user = await user_collection.find_one({"email": user_data.email})
        if existing_user:
            return None  

        hashed_password = await AuthService.hash_password(user_data.password)

        new_user = UserDB(
            id=str(ObjectId()),  # Chuyển _id thành ObjectId
            name=user_data.name,
            email=user_data.email,
            password=hashed_password,
            phone=user_data.phone,
            address=user_data.address,
        )

        # Chuyển đổi lại `_id` về dạng ObjectId khi insert vào MongoDB
        new_user_dict = new_user.dict(by_alias=True)
        new_user_dict["_id"] = ObjectId(new_user_dict["_id"])  # Chuyển về ObjectId trước khi insert

        result = await user_collection.insert_one(new_user_dict)

        # Lấy lại user đã insert và trả về
        new_user_dict["_id"] = str(result.inserted_id)  # Convert ObjectId thành string để trả về
        return new_user_dict
    
    #Login Account and sent token
# Cấu hình mật khẩu
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Cấu hình JWT
SECRET_KEY = "your-secret-key"  # Thay thế với một khóa bí mật của bạn
ALGORITHM = "HS256"  # Thuật toán mã hóa JWT
ACCESS_TOKEN_EXPIRE_MINUTES = 30  # Thời gian hết hạn của token (ví dụ 30 phút)

class AuthService:
    @staticmethod
    async def hash_password(password: str) -> str:
        return pwd_context.hash(password)

    @staticmethod
    async def verify_password(plain_password: str, hashed_password: str) -> bool:
        return pwd_context.verify(plain_password, hashed_password)

    @staticmethod
    def create_access_token(data: dict, expires_delta: Optional[timedelta] = None) -> str:
        if expires_delta:
            expire = datetime.utcnow() + expires_delta
        else:
            expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
        
        to_encode = data.copy()
        to_encode.update({"exp": expire})  # Thêm thời gian hết hạn vào token
        encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
        return encoded_jwt

    @staticmethod
    async def authenticate_user(db: AsyncIOMotorDatabase, email: str, password: str) -> Optional[UserDB]:
        user = await db.users.find_one({"email": email})
        if not user:
            return None  # Không tìm thấy user
        if not await AuthService.verify_password(password, user["password"]):
            return None  # Mật khẩu không đúng
        return UserDB(**user)  # Trả về user nếu xác thực thành công
