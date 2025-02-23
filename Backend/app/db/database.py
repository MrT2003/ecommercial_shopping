from motor.motor_asyncio import AsyncIOMotorClient
from dotenv import load_dotenv
import os

load_dotenv()

MONGO_URI = os.getenv("MONGO_URI", "mongodb://localhost:27017")
DB_NAME = os.getenv("DB_NAME", "Ecommerce")
print(f"MONGO_URI: {MONGO_URI}, DB_NAME: {DB_NAME}")
client = AsyncIOMotorClient(MONGO_URI)
db = client[DB_NAME]

product_collection = db.get_collection("Product")

async def get_database():
    return db
