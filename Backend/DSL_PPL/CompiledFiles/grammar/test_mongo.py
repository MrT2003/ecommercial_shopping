from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017")
db = client["drinkbot"]
menu = db["menu"]

print("Số lượng documents:", menu.count_documents({}))

for d in menu.find():
    print("-", d.get("name"))
