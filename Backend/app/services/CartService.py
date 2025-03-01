from app.db.database import cart_collection
from bson import ObjectId

class CartService:
    @staticmethod
    async def get_carts():
        carts = []
        async for cart in cart_collection.find():
            cart["_id"] = str(cart["_id"])
            for item in cart.get("items", []):
                if "product" in item and isinstance(item["product"], ObjectId):
                    item["product"] = str(item["product"])
            carts.append(cart)
        return carts
    
    @staticmethod
    async def add_to_cart(user_id: str, product_id: str, quantity: int, price: float):
        user_oid = ObjectId(user_id)
        product_oid = ObjectId(product_id)

        cart = await cart_collection.find_one({"user": user_oid})

        if cart:
            item_found = False
            for item in cart["items"]:
                if isinstance(item["product"], ObjectId) and item["product"] == product_oid:
                    item["quantity"] += quantity
                    item["price"] = price
                    item_found = True
                    break
                elif isinstance(item["product"], str) and item["product"] == product_id:
                    item["quantity"] += quantity
                    item["price"] = price
                    item_found = True
                    break
            
            if not item_found:
                cart["items"].append({"product": product_oid, "quantity": quantity, "price": price})
        else:
            cart = {
                "user": user_oid,
                "items": [{"product": product_oid, "quantity": quantity, "price": price}],
                "total_price": quantity * price
            }

        # Update total price
        cart["total_price"] = sum(item["quantity"] * item["price"] for item in cart["items"])

        # Save to database
        if "_id" in cart:
            await cart_collection.update_one({"_id": cart["_id"]}, {"$set": cart})
        else:
            await cart_collection.insert_one(cart)

        return {"message": "Product added to cart successfully!"}
    
    @staticmethod
    async def update_cart_item(user_id: str, product_id: str, quantity: int):
        try:
            user_oid = ObjectId(user_id)
            product_oid = ObjectId(product_id)
        except:
            return {"error": "Invalid user_id or product_id. Must be a 24-character hex string"}
        
        # Tìm giỏ hàng của user
        cart = await cart_collection.find_one({"user": user_oid})
        
        if not cart:
            return {"error": "Cart not found for this user"}
        
        # Tìm sản phẩm trong giỏ hàng
        item_found = False
        items = cart["items"]
        
        for item in items:
            product_in_cart = item.get("product")
            if (isinstance(product_in_cart, ObjectId) and product_in_cart == product_oid) or \
               (isinstance(product_in_cart, str) and product_in_cart == product_id):
                if quantity > 0:
                    item["quantity"] = quantity
                else:
                    items.remove(item)
                item_found = True
                break
                
        if not item_found:
            return {"error": "Product not found in cart"}
            
        # Tính lại tổng giá trị giỏ hàng
        cart["total_price"] = sum(item["quantity"] * item["price"] for item in items)
        
        await cart_collection.update_one(
            {"_id": cart["_id"]}, 
            {"$set": {"items": items, "total_price": cart["total_price"]}}
        )
        
        return {"message": "Cart updated successfully"}
    
    @staticmethod
    async def remove_item_from_cart(user_id: str, product_id: str):
        try:
            user_oid = ObjectId(user_id)
            product_oid = ObjectId(product_id)
        except:
            return {"error": "Invalid user_id or item_id. Must be a 24-character hex string"}
        
        cart = await cart_collection.find_one({"user": user_oid})
        
        if not cart:
            return {"error": "Cart not found for this user"}
        
        items = cart["items"]
        item_to_remove = None
        
        for item in items:
            product_in_cart = item.get("product")
            if (isinstance(product_in_cart, ObjectId) and product_in_cart == product_oid) or \
               (isinstance(product_in_cart, str) and product_in_cart == product_id):
                item_to_remove = item
                break
        
        if item_to_remove:
            items.remove(item_to_remove)
        else:
            return {"error": "Product not found in cart"}
        
        # Cập nhật lại tổng giá trị giỏ hàng
        cart["total_price"] = sum(item["quantity"] * item["price"] for item in items)
        
        # Cập nhật giỏ hàng trong database
        await cart_collection.update_one(
            {"_id": cart["_id"]}, 
            {"$set": {"items": items, "total_price": cart["total_price"]}}
        )
        
        return {"message": "Product removed from cart successfully"}