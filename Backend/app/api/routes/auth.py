from fastapi import APIRouter, HTTPException, Depends
from motor.motor_asyncio import AsyncIOMotorClient, AsyncIOMotorDatabase
from app.models.user import UserCreate, UserDB
from app.services.AuthService import AuthService
from app.db.database import get_database
from pydantic import BaseModel

router = APIRouter()

# Schema yêu cầu đầu vào cho login
class LoginRequest(BaseModel):
    email: str
    password: str

# Schema trả về JWT token
class TokenResponse(BaseModel):
    access_token: str
    token_type: str

#http://127.0.0.1:8000/api/auth/signup
@router.post("/signup", response_model=UserDB)
async def signup(user_data: UserCreate, db: AsyncIOMotorClient = Depends(get_database)):
    """Đăng ký tài khoản mới"""
    new_user = await AuthService.register_user(db, user_data)
    if not new_user:
        raise HTTPException(status_code=400, detail="Email đã tồn tại")
    return new_user

# Route đăng nhập và trả về JWT token
@router.post("/login", response_model=TokenResponse)
async def login(login_data: LoginRequest, db: AsyncIOMotorDatabase = Depends(get_database)):
    """Đăng nhập và trả về JWT token"""
    user = await AuthService.authenticate_user(db, login_data.email, login_data.password)
    if not user:
        raise HTTPException(status_code=401, detail="Sai email hoặc mật khẩu")

    # Tạo access token
    access_token = AuthService.create_access_token(data={"sub": user.email})

    return TokenResponse(access_token=access_token, token_type="bearer")