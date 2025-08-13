# from motor.motor_asyncio import AsyncIOMotorClient
# from dotenv import load_dotenv
# import os

# load_dotenv()

# MONGO_URI = os.getenv("MONGO_URI", "mongodb://localhost:27017")
# DB_NAME = os.getenv("DB_NAME", "Ecommerce")
# print(f"MONGO_URI: {MONGO_URI}, DB_NAME: {DB_NAME}")
# client = AsyncIOMotorClient(MONGO_URI)
# db = client[DB_NAME]

# product_collection = db.get_collection("Product")
# category_collection = db.get_collection("Category")
# cart_collection = db.get_collection("Cart")
# order_collection = db.get_collection("Order")
# user_collection = db.get_collection("User")

# async def get_database():
#     return db


# app/db/database.py
from __future__ import annotations

import os
from typing import Optional

from dotenv import load_dotenv
from motor.motor_asyncio import AsyncIOMotorClient, AsyncIOMotorDatabase, AsyncIOMotorCollection

# Đọc .env (khi chạy Docker Compose, env được inject vào container)
load_dotenv()

# Dùng 'mongo' làm host mặc định khi chạy trong Docker
MONGO_URI: str = os.getenv("MONGO_URI", "mongodb://mongo:27017")
DB_NAME: str = os.getenv("DB_NAME", "Ecommerce")


class _MongoStore:
    """Lưu singleton client để tránh tạo nhiều kết nối."""
    client: Optional[AsyncIOMotorClient] = None


def get_client() -> AsyncIOMotorClient:
    """
    Lấy (hoặc tạo) AsyncIOMotorClient singleton.
    Gọi ở startup hoặc lần đầu truy cập DB/collection.
    """
    if _MongoStore.client is None:
        _MongoStore.client = AsyncIOMotorClient(MONGO_URI)
    return _MongoStore.client


def close_client() -> None:
    """Đóng kết nối MongoDB (gọi ở shutdown)."""
    if _MongoStore.client is not None:
        _MongoStore.client.close()
        _MongoStore.client = None


def get_db() -> AsyncIOMotorDatabase:
    """Lấy database theo DB_NAME hiện tại."""
    return get_client()[DB_NAME]


# ---- giữ tương thích với code cũ ----
# Code hiện tại của bạn đang `from app.db.database import get_database`.
# Hàm này trả về y như get_db(), chỉ khác là nó là async để có thể `await` nếu code cũ đang await.
async def get_database() -> AsyncIOMotorDatabase:
    return get_db()


# ---------- Collection accessors (khuyên dùng) ----------
def product_collection() -> AsyncIOMotorCollection:
    return get_db().get_collection("Product")


def category_collection() -> AsyncIOMotorCollection:
    return get_db().get_collection("Category")


def cart_collection() -> AsyncIOMotorCollection:
    return get_db().get_collection("Cart")


def order_collection() -> AsyncIOMotorCollection:
    return get_db().get_collection("Order")


def user_collection() -> AsyncIOMotorCollection:
    return get_db().get_collection("User")


# ---------- Health / tiện ích ----------
async def ping() -> None:
    """
    Ping nhẹ tới MongoDB; raise exception nếu không kết nối được.
    Dùng cho /health hoặc kiểm tra readiness.
    """
    db = get_db()
    await db.command("ping")