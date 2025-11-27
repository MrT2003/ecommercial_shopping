# demo_mongo_cli.py
from mongo_query import query_drinks_from_text

if __name__ == "__main__":
    while True:
        s = input("DSL> ")
        if not s:
            break

        drinks = query_drinks_from_text(s)
        if not drinks:
            print("→ Không tìm thấy đồ uống phù hợp.\n")
            continue

        print("→ Gợi ý đồ uống:")
        for d in drinks:
            name = d.get("name")
            base = d.get("baseType")
            print(f" - {name} ({base})")
        print()
