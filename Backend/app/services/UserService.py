from app.db.database import user_collection
from bson import ObjectId
# from app.models.cart import cart

class CartService:

    @staticmethod
    async def get_carts():
        users = []
        async for cart in user_collection.find():
            cart["_id"] = str(cart["_id"])  
            carts.append(cart)
        return carts  