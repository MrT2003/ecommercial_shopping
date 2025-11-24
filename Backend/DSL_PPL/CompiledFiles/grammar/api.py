# api.py
from fastapi import FastAPI
from pydantic import BaseModel
from typing import List

from pymongo import MongoClient

from drink_semantics import parse_request, DrinkPreference
from mongo_query import build_mongo_query

# ---------- MongoDB setup ----------
client = MongoClient("mongodb://localhost:27017")
db = client["drinkbot"]
menu = db["menu"]

# ---------- FastAPI app ----------
app = FastAPI()


class RequestBody(BaseModel):
    text: str


class DrinkOut(BaseModel):
    name: str
    baseType: str | None = None


@app.post("/recommend", response_model=List[DrinkOut])
def recommend(body: RequestBody):
    """
    Body: { "text": "hot tea no sugar" }
    Return: list đồ uống match
    """
    # 1. Parse DSL -> DrinkPreference
    pref: DrinkPreference = parse_request(body.text)

    # 2. Build Mongo query
    query = build_mongo_query(pref)

    # 3. Query DB
    results = list(menu.find(query))

    # 4. Map -> DrinkOut
    return [
        DrinkOut(
            name=doc.get("name", ""),
            baseType=doc.get("baseType")
        )
        for doc in results
    ]
