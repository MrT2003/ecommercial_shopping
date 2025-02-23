from app.db.database import product_collection
from bson import ObjectId
from app.models.product import Product

# Service for product CRUD operations
class ProductService:
    @staticmethod
    async def get_all_products():
        products = []
        async for product in product_collection.find():
            product["_id"] = str(product["_id"])  # Convert ObjectId to str
            products.append(product)
        return products

    @staticmethod
    async def create_product(product: Product):
        product_dict = product.dict(by_alias=True)
        if product_dict.get("_id") is None:
            product_dict["_id"] = ObjectId()  # Create new ObjectId if not present

        # Insert product into the database
        result = await product_collection.insert_one(product_dict)
        
        # Add the inserted _id to the product_dict and convert it to string
        product_dict["_id"] = str(result.inserted_id)
        
        # Return the product dictionary with the inserted _id
        return product_dict  # Return the full product with its new _id

    # @staticmethod
    # async def get_product_by_id(product_id: str):
    #     """
    #     Lấy thông tin sản phẩm bằng ID.
    #     """
    #     product = await product_collection.find_one({"_id": ObjectId(product_id)})
    #     if product:
    #         product["_id"] = str(product["_id"])
    #     return product
    # @staticmethod
    # async def update_product(product_id: str, product: Product):
    #     """
    #     Cập nhật thông tin sản phẩm bằng ID.
    #     """
    #     product_dict = product.dict()
    #     result = await product_collection.update_one(
    #         {"_id": ObjectId(product_id)},
    #         {"$set": product_dict}
    #     )
    #     if result.modified_count == 1:
    #         updated_product = await product_collection.find_one({"_id": ObjectId(product_id)})
    #         updated_product["_id"] = str(updated_product["_id"])
    #         return updated_product
    #     return None

    # @staticmethod
    # async def delete_product(product_id: str):
    #     """
    #     Xóa sản phẩm bằng ID.
    #     """
    #     result = await product_collection.delete_one({"_id": ObjectId(product_id)})
    #     return result.deleted_count > 0