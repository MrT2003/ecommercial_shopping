# mongo_query.py
from pymongo import MongoClient
from drink_semantics import parse_request, DrinkPreference


def build_mongo_query(pref: DrinkPreference) -> dict:
    """Chuyển DrinkPreference -> Mongo filter."""
    query: dict = {}

    # 1. baseType
    if pref.baseType:
        query["baseType"] = pref.baseType  # vd: "tea", "coffee", "milk_tea"

    # 2. temperature
    if pref.temperature:
        temp_map = {
            "hot": "temperatureOptions.hot",
            "warm": "temperatureOptions.warm",
            "cold": "temperatureOptions.cold",
            "iced": "temperatureOptions.iced",
        }
        field = temp_map.get(pref.temperature.lower())
        if field:
            query[field] = True

    # 3. sweetness
    if pref.sweetness:
        # "no sugar" -> "no_sugar"
        sweetness_code = pref.sweetness.strip().replace(" ", "_").lower()
        query["allowedSweetness"] = sweetness_code

    # 4. caffeine
    if pref.caffeine:
        text = pref.caffeine.lower()
        if "no caffeine" in text or "without caffeine" in text:
            query["caffeineFree"] = True
        elif "with caffeine" in text:
            query["caffeineFree"] = False

    # 5. size
    if pref.size:
        # availableSizes: ["small", "medium", ...]
        query["availableSizes"] = pref.size.lower()

    return query


def get_menu_collection():
    client = MongoClient("mongodb://localhost:27017")  # local MongoDB
    db = client["drinkbot"]
    return db["menu"]


def query_drinks_from_text(user_text: str):
    """
    1. Parse DSL -> DrinkPreference
    2. Build Mongo query
    3. Query MongoDB
    """
    pref = parse_request(user_text)
    print("Parsed preference:", pref)

    query = build_mongo_query(pref)
    print("Mongo query:", query)

    menu = get_menu_collection()
    results = list(menu.find(query))
    return results
