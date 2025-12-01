from fastapi import APIRouter
from pydantic import BaseModel
from typing import List, Optional

from DSL_PPL.src.drink_semantics import DrinkPreference, parse_request
from DSL_PPL.src.mongo_query import build_mongo_query
from app.db.database import product_collection  # <-- dùng Product

router = APIRouter(
    prefix="/ppl",
    tags=["ppl"],
)


class ParseRequest(BaseModel):
  text: str


class PreferenceOut(BaseModel):
  temperature: Optional[str] = None
  baseType: Optional[str] = None
  sweetness: Optional[str] = None
  caffeine: Optional[str] = None
  size: Optional[str] = None


class RecommendRequest(BaseModel):
  """
  Request body cho /ppl/recommend
  Giống hệt PreferenceOut để nhận JSON từ Flutter
  """
  temperature: Optional[str] = None
  baseType: Optional[str] = None
  sweetness: Optional[str] = None
  caffeine: Optional[str] = None
  size: Optional[str] = None


class ProductOut(BaseModel):
  id: str
  name: str
  description: Optional[str] = None
  category: Optional[str] = None          # "Drink"
  drinkCategory: Optional[str] = None     # "Milk tea", "Coffee", ...
  temperatures: Optional[List[str]] = None
  sweetnessLevel: Optional[str] = None
  price: Optional[float] = None
  imageURL: Optional[str] = None


@router.post("/parse", response_model=PreferenceOut)
def parse_text(body: ParseRequest):
  """
  Nhận text DSL -> trả về semantic (PreferenceOut) để Flutter hiển thị.
  """
  pref: DrinkPreference = parse_request(body.text)
  return PreferenceOut(
      temperature=pref.temperature,
      baseType=pref.baseType,
      sweetness=pref.sweetness,
      caffeine=pref.caffeine,
      size=pref.size,
  )


@router.post("/recommend", response_model=List[ProductOut])
async def recommend_products(body: RecommendRequest):
  """
  Nhận semantic (đã parse sẵn từ Flutter) -> build query -> trả về list Product.
  """
  # 1. Map RecommendRequest -> DrinkPreference (cho hàm build_mongo_query)
  pref = DrinkPreference(
      temperature=body.temperature,
      baseType=body.baseType,
      sweetness=body.sweetness,
      caffeine=body.caffeine,
      size=body.size,
  )

  # 2. Build filter Mongo theo schema Product
  mongo_filter = build_mongo_query(pref)

  # 3. Collection Product (Motor async)
  coll = product_collection()

  # 4. Query async
  docs = await coll.find(mongo_filter).to_list(length=50)

  # 5. Map sang ProductOut
  products: List[ProductOut] = []
  for doc in docs:
      products.append(
          ProductOut(
              id=str(doc.get("_id")),
              name=doc.get("name", ""),
              description=doc.get("description"),
              category=doc.get("category"),
              drinkCategory=doc.get("drinkCategory"),
              temperatures=doc.get("temperatures"),
              sweetnessLevel=doc.get("sweetnessLevel"),
              price=doc.get("price"),
              imageURL=doc.get("imageURL"),
          )
      )

  return products
