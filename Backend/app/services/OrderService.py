from app.db.database import order_collection
from bson import ObjectId
# from app.models.cart import cart

class OrderService:

    @staticmethod
    async def get_all_orders():
        orders = []
        async for order in order_collection.find():
            order["_id"] = str(order["_id"])  
            orders.append(order)
        return orders  