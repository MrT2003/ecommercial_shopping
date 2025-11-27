from app.db.database import cart_collection, product_collection
from bson import ObjectId

class CartService:
    @staticmethod
    async def get_carts():
        carts = []
        collection = cart_collection() 
        products = product_collection() 

        async for cart in collection.find():
            cart["_id"] = str(cart["_id"])
            if "user" in cart:
                cart["user"] = str(cart["user"])
            if "items" not in cart:
                cart["items"] = []

            for item in cart.get("items", []):
                if isinstance(item.get("product"), ObjectId):
                    item["product"] = str(item["product"])
                if "name" not in item:
                    item["name"] = ""
                if "image" not in item:
                    item["image"] = ""
                try:
                    product_id = item["product"]
                    if ObjectId.is_valid(product_id):
                        product = await products.find_one({"_id": ObjectId(product_id)})
                        if product:
                            item["name"] = product.get("name", item["name"])
                            if not item.get("image"):
                                item["image"] = product.get("image", "")
                except Exception as e:
                    print(f"Error fetching product {item.get('product')}: {e}")

            carts.append(cart)
        return carts
    
    @staticmethod
    async def add_to_cart(user_id: str, product_id: str, quantity: int, price: float, name: str, image: str):
        try:
            user_oid = ObjectId(user_id)
            product_oid = ObjectId(product_id)
            collection = cart_collection()
            cart = await collection.find_one({"user": user_oid})

            if cart:
                items = cart.get("items", [])
                item_found = False

                for item in items:
                    item_product = item.get("product")
                    if ((isinstance(item_product, ObjectId) and item_product == product_oid) or
                        (isinstance(item_product, str) and item_product == product_id)):
                        item["quantity"] += quantity
                        item["price"] = price
                        item["name"] = name
                        item["image"] = image
                        item_found = True
                        break

                if not item_found:
                    items.append({
                        "product": product_oid,
                        "quantity": quantity,
                        "price": price,
                        "name": name,
                        "image": image,
                    })

                total_price = sum(item["quantity"] * item["price"] for item in items)

                await collection.update_one(
                    {"_id": cart["_id"]},
                    {"$set": {
                        "items": items,
                        "total_price": total_price
                    }}
                )
            else:
                new_cart = {
                    "user": user_oid,
                    "items": [{
                        "product": product_oid,
                        "quantity": quantity,
                        "price": price,
                        "name": name,
                        "image": image,
                    }],
                    "total_price": quantity * price
                }

                await collection.insert_one(new_cart)

            return {"message": "Product added to cart successfully!"}
        except Exception as e:
            print(f"Error in add_to_cart: {e}")
            return {"error": f"Failed to add product to cart: {str(e)}"}

    @staticmethod
    async def update_cart_item(user_id: str, product_id: str, quantity: int):
        try:
            user_oid = ObjectId(user_id)
            product_oid = ObjectId(product_id)
            collection = cart_collection()
        except:
            return {"error": "Invalid user_id or product_id. Must be a 24-character hex string"}
        
        cart = await collection.find_one({"user": user_oid})
        
        if not cart:
            return {"error": "Cart not found for this user"}
        
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
            
        cart["total_price"] = sum(item["quantity"] * item["price"] for item in items)
        
        await collection.update_one(
            {"_id": cart["_id"]}, 
            {"$set": {"items": items, "total_price": cart["total_price"]}}
        )
        
        return {"message": "Cart updated successfully"}
    
    @staticmethod
    async def remove_item_from_cart(user_id: str, product_id: str):
        try:
            user_oid = ObjectId(user_id)
            product_oid = ObjectId(product_id)
            collection = cart_collection()
        except:
            return {"error": "Invalid user_id or item_id. Must be a 24-character hex string"}
        
        cart = await collection.find_one({"user": user_oid})
        
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
        
        cart["total_price"] = sum(item["quantity"] * item["price"] for item in items)
        
        await collection.update_one(
            {"_id": cart["_id"]}, 
            {"$set": {"items": items, "total_price": cart["total_price"]}}
        )
        
        return {"message": "Product removed from cart successfully"}