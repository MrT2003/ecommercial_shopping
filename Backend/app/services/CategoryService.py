from app.db.database import category_collection
from bson import ObjectId
from app.models.category import Category

class CategoryService:
    @staticmethod
    async def create_category(category: Category):
        collection = category_collection() 
        category_dict = category.dict(by_alias=True)
        if category_dict.get("_id") is None:
            category_dict["_id"] = ObjectId() 
        result = await collection.insert_one(category_dict)
        category_dict["_id"] = str(result.inserted_id)
        return category_dict

    @staticmethod
    async def get_category_by_name(category_name: str):
        collection = category_collection()
        category = await collection.find_one({"name": category_name})
        if category:
            return Category(**category)  
        return None

    @staticmethod
    async def get_all_categories():
        collection = category_collection() 
        categories = []
        async for category in collection.find():
            category["_id"] = str(category["_id"]) 
            categories.append(category)
        return categories  
