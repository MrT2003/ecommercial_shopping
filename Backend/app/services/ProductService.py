from typing import List
from app.db.database import product_collection
from bson import ObjectId
from app.models.product import Product

# Service for product CRUD operations
class ProductService:
    # @staticmethod
    # async def get_all_products():
    #     products = []
    #     async for product in product_collection.find():
    #         product["_id"] = str(product["_id"]) 
    #         products.append(product)
    #     return products
    
    # @staticmethod
    # async def get_product_by_id(product_id: str):
    #     product = await product_collection.find_one({"_id": ObjectId(product_id)})
    #     if product:
    #         product["_id"] = str(product["_id"])
    #     return product

    @staticmethod
    async def get_all_products():
        products = []
        async for product in product_collection.find():
            product["_id"] = str(product["_id"])
            product_model = Product(**product)
            products.append(product_model)
        return products

    @staticmethod
    async def get_product_by_id(product_id: str):
        product = await product_collection.find_one({"_id": ObjectId(product_id)})
        if product:
            product["_id"] = str(product["_id"])
            return Product(**product)
        return None
    
    @staticmethod
    async def search_products(query: str) -> List[Product]:
        products = []
        try:
            regex_query = {"$regex": query, "$options": "i"} 
            async for product in product_collection.find({"name": regex_query}):
                product["_id"] = str(product["_id"])
                try:
                    product_model = Product(**product)
                    products.append(product_model)
                except Exception as e:
                    print(f"Error converting product: {e}")
                    print(f"Product data: {product}")
        except Exception as e:
            print(f"Error searching products: {e}")
        return products
    

    