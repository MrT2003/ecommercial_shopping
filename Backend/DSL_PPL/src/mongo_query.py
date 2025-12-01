from .drink_semantics import DrinkPreference


def build_mongo_query(pref: DrinkPreference) -> dict:
    """
    Chuyển DrinkPreference -> MongoDB filter cho collection Product.

    Schema Product (drink):
      - category: "Drink"
      - drinkCategory: "Milk tea", "Coffee", ...
      - temperatures: ["Iced", "Hot", ...]
      - sweetnessLevel: "No sugar" | "Low" | "Medium" | "Extra" ...
    """
    query: dict = {}

    # Luôn lọc đúng loại "Drink"
    query["category"] = "Drink"

    # 1. baseType -> drinkCategory
    # pref.baseType có thể là: "coffee", "tea", "juice", "milk_tea"/"milk tea"/"milktea", "yogurt"
    if pref.baseType:
        base = pref.baseType.lower()

        # normalize "milk tea"
        if base in ("milktea", "milk_tea"):
            base = "milk tea"

        base_map = {
            "coffee": "Coffee",
            "tea": "Tea",
            "juice": "Juice",
            "milk tea": "Milk tea",
            "yogurt": "Yogurt",
        }
        drink_cat = base_map.get(base)
        if drink_cat:
            query["drinkCategory"] = drink_cat

    # 2. temperature -> temperatures (mảng string)
    # DSL: hot / warm / cold / iced
    if pref.temperature:
        t = pref.temperature.lower()
        temp_map = {
            "hot": "Hot",
            "warm": "Warm",
            "cold": "Cold",
            "iced": "Iced",
        }
        temp_value = temp_map.get(t)
        if temp_value:
            # Mongo: { temperatures: "Iced" } match document có "Iced" trong mảng
            query["temperatures"] = temp_value

    # 3. sweetness -> sweetnessLevel
    # DSL: "no sugar" / "low sugar" / "medium sugar" / "high sugar"
    if pref.sweetness:
        s = pref.sweetness.strip().lower()

        sweet_map = {
            "no sugar": "No sugar",
            "low sugar": "Low",
            "medium sugar": "Medium",
            # Bạn có thể đổi "Extra" thành "High" nếu DB dùng giá trị khác
            "high sugar": "Extra",
        }
        sweetness_value = sweet_map.get(s)
        if sweetness_value:
            query["sweetnessLevel"] = sweetness_value

    # 4. caffeine, size: schema hiện tại chưa có field tương ứng → tạm thời bỏ qua

    return query
