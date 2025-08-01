import datetime
from app.db.database import order_collection, cart_collection
from bson import ObjectId
from typing import List, Dict, Any
import logging

logger = logging.getLogger(__name__)

class OrderService:
    @staticmethod
    async def get_all_orders() -> List[Dict[str, Any]]:
        orders = []
        try:
            async for order in order_collection.find():
                # Đảm bảo các ID được chuyển đổi sang string
                if "_id" in order:
                    order["_id"] = str(order["_id"])
                
                # Chuyển đổi user field thành user_id nếu cần
                if "user" in order and "user_id" not in order:
                    order["user_id"] = str(order["user"])
                    del order["user"]
                elif "user_id" in order:
                    order["user_id"] = str(order["user_id"])
                
                # Đảm bảo chuyển đổi ID sản phẩm trong items
                if "items" in order and isinstance(order["items"], list):
                    for item in order["items"]:
                        if "product_id" in item and "product" not in item:
                            item["product"] = str(item["product_id"])
                            del item["product_id"]
                        elif "product" in item:
                            item["product"] = str(item["product"])
                
                # Kiểm tra và thêm các trường bắt buộc nếu thiếu
                if "payment_status" not in order:
                    order["payment_status"] = "pending"
                
                if "shipping_address" not in order:
                    order["shipping_address"] = {
                        "address": "",
                        "city": "",
                        "country": ""
                    }
                
                if "billing_address" not in order:
                    order["billing_address"] = {
                        "address": "",
                        "city": "",
                        "country": ""
                    }
                    
                orders.append(order)
            return orders
        except Exception as e:
            logger.error(f"Error in get_all_orders: {str(e)}")
            raise

    @staticmethod
    async def get_order_by_id(order_id: str) -> Dict[str, Any]:
        try:
            if not ObjectId.is_valid(order_id):
                raise ValueError("Order ID không hợp lệ")
                
            order = await order_collection.find_one({"_id": ObjectId(order_id)})
            
            if not order:
                return None
            
            # Process the order to ensure it matches the Pydantic model
            # Convert ObjectIds to strings
            order["_id"] = str(order["_id"])
            
            # Handle user_id field
            if "user" in order and "user_id" not in order:
                order["user_id"] = str(order["user"])
                del order["user"]
            elif "user_id" in order:
                order["user_id"] = str(order["user_id"])
                
            # Process items
            if "items" in order and isinstance(order["items"], list):
                for item in order["items"]:
                    if "product_id" in item and "product" not in item:
                        item["product"] = str(item["product_id"])
                        del item["product_id"]
                    elif "product" in item:
                        item["product"] = str(item["product"])
            
            # Add missing required fields
            if "payment_status" not in order:
                order["payment_status"] = "pending"
            
            if "shipping_address" not in order:
                order["shipping_address"] = {
                    "address": "",
                    "city": "",
                    "country": ""
                }
            
            if "billing_address" not in order:
                order["billing_address"] = {
                    "address": "",
                    "city": "",
                    "country": ""
                }
                
            return order
        except ValueError as e:
            logger.error(f"Invalid order ID: {str(e)}")
            raise
        except Exception as e:
            logger.error(f"Error in get_order_detail: {str(e)}")
            raise

    @staticmethod
    async def create_order(user_id: str, shipping_address: Dict[str, Any], payment_method: str) -> Dict[str, Any]:
        try:
            cart = await cart_collection.find_one({"user": ObjectId(user_id)})  # Thử tìm theo `user`
            if not cart:
                cart = await cart_collection.find_one({"user_id": ObjectId(user_id)})  # Nếu trước đó lưu bằng `user_id`

            print(cart) 
            if not cart or "items" not in cart or not cart["items"]:
                raise ValueError("Giỏ hàng trống, không thể tạo đơn hàng")
            
            
            new_order = {
                "user_id": ObjectId(user_id),
                "items": cart["items"],
                "total_price": cart['total_price'],
                "payment_method": payment_method,
                "payment_status": "pending",
                "shipping_address": shipping_address,
            }
            
            result = await order_collection.insert_one(new_order)
            new_order["_id"] = str(result.inserted_id)
            await cart_collection.delete_one({"user_id": ObjectId(user_id)})
            
            return new_order
        except Exception as e:
            logger.error(f"Lỗi khi tạo đơn hàng: {str(e)}")
            raise
