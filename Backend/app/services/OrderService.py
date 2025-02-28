from app.db.database import order_collection, cart_collection
from bson import ObjectId
from typing import List, Dict, Any
import logging

logger = logging.getLogger(__name__)

class OrderService:

    @staticmethod
    async def get_all_orders() -> List[Dict[str, Any]]:
        """Lấy tất cả đơn hàng từ database"""
        orders = []
        async for order in order_collection.find():
            order["_id"] = str(order["_id"])
            order["user_id"] = str(order["user_id"])
            for item in order.get("items", []):
                item["product_id"] = str(item["product_id"])
            orders.append(order)
        return orders

    @staticmethod
    async def get_order_by_id(order_id: str) -> Dict[str, Any]:
        """Lấy đơn hàng theo ID"""
        order = await order_collection.find_one({"_id": ObjectId(order_id)})
        if order:
            order["_id"] = str(order["_id"])
            order["user_id"] = str(order["user_id"])
            for item in order.get("items", []):
                item["product_id"] = str(item["product_id"])
            return order
        return None

    @staticmethod
    async def create_order(user_id: str, order_data: Dict[str, Any]) -> Dict[str, Any]:
        """Tạo đơn hàng mới từ giỏ hàng của user"""
        try:
            # 1. Lấy giỏ hàng của user
            cart = await cart_collection.find_one({"user": ObjectId(user_id)})
            if not cart or "items" not in cart or len(cart["items"]) == 0:
                raise ValueError("Giỏ hàng trống, không thể tạo đơn hàng.")

            # 2. Tạo dữ liệu đơn hàng từ giỏ hàng
            order_data["user_id"] = ObjectId(user_id)
            order_data["items"] = cart["items"]

            # Kiểm tra và chuyển đổi 'product_id' thành ObjectId nếu cần
            for item in order_data["items"]:
                product_id = item.get("product_id")
                if not product_id:
                    raise ValueError("product_id không được để trống.")
                if isinstance(product_id, str) and ObjectId.is_valid(product_id):
                    item["product_id"] = ObjectId(product_id)  # Chuyển đổi chuỗi thành ObjectId
                elif not ObjectId.is_valid(product_id):
                    raise ValueError(f"Invalid product_id: {product_id}")

            order_data["total_price"] = sum(item["price"] * item["quantity"] for item in cart["items"])
            order_data["status"] = "pending"
            order_data["payment_status"] = "pending"

            # 3. Lưu đơn hàng vào database
            result = await order_collection.insert_one(order_data)

            # # 4. Xóa giỏ hàng sau khi tạo đơn hàng
            # await cart_collection.delete_one({"user": ObjectId(user_id)})

            # 5. Lấy đơn hàng vừa tạo
            created_order = await order_collection.find_one({"_id": result.inserted_id})
            if created_order:
                created_order["_id"] = str(created_order["_id"])
                created_order["user_id"] = str(created_order["user_id"])
                for item in created_order["items"]:
                    item["product_id"] = str(item["product_id"])

            return created_order
        except Exception as e:
            logger.error(f"Error in create_order: {str(e)}")
            raise e
