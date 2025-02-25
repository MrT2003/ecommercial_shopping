from app.db.database import cart_collection
from bson import ObjectId
# from app.models.cart import cart

class CartService:

    @staticmethod
    async def get_carts():
        carts = []
        async for cart in cart_collection.find():
            cart["_id"] = str(cart["_id"])  
            carts.append(cart)
        return carts  