import os
from dotenv import load_dotenv
from typing import Optional
from motor.motor_asyncio import (
    AsyncIOMotorClient,
    AsyncIOMotorDatabase,
    AsyncIOMotorCollection,
)

load_dotenv(".env")
running_in_docker = os.getenv("RUNNING_IN_DOCKER") == "1"

MONGODB_URI = (
    os.getenv("MONGODB_URI_DOCKER") if running_in_docker else os.getenv("MONGODB_URI_LOCAL")
)
MONGODB_DB = os.getenv("MONGODB_DB") or "Ecommerce"

class _Store:
    client: Optional[AsyncIOMotorClient] = None

def get_client() -> AsyncIOMotorClient:
    if _Store.client is None:
        _Store.client = AsyncIOMotorClient(
            MONGODB_URI,
            serverSelectionTimeoutMS=3000,
            connectTimeoutMS=3000,
        )
    return _Store.client

def close_client() -> None:
    if _Store.client is not None:
        _Store.client.close()
        _Store.client = None

def get_db() -> AsyncIOMotorDatabase:
    return get_client()[MONGODB_DB]

async def get_database() -> AsyncIOMotorDatabase:
    return get_db()

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

async def ping() -> None:
    await get_client().admin.command("ping")

