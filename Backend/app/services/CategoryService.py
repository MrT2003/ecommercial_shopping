from app.db.database import category_collection
from bson import ObjectId
from app.models.category import Category

class CategoryService:
    @staticmethod
    async def create_category(category: Category):
        category_dict = category.dict(by_alias=True)
        if category_dict.get("_id") is None:
            category_dict["_id"] = ObjectId()  # Tạo ObjectId mới cho danh mục nếu không có sẵn
        result = await category_collection.insert_one(category_dict)
        category_dict["_id"] = str(result.inserted_id)
        return category_dict

    @staticmethod
    async def get_category_by_name(category_name: str):
        category = await category_collection.find_one({"name": category_name})
        if category:
            return Category(**category)  # Chuyển đổi dict thành Category object
        return None

    @staticmethod
    async def get_all_categories():
        categories = []
        async for category in category_collection.find():
            category["_id"] = str(category["_id"])  # Convert ObjectId to str
            categories.append(category)
        return categories  # Thêm categories vào return