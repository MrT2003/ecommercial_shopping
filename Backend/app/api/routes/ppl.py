from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import List, Optional

from DSL_PPL.src.drink_semantics import DrinkPreference, PreferenceVisitor
from DSL_PPL.src.syntax_checker import check_syntax   # 👈 TẬN DỤNG file này
from DSL_PPL.src.mongo_query import build_mongo_query
from app.db.database import product_collection


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
    # 1) Check syntax bằng syntax_checker
    ok, errs, tree = check_syntax(body.text)

    if not ok:
        # Sai grammar: ví dụ chỉ nói "I want a", "Give me a", hoặc lung tung
        # Bạn có thể log thêm errs nếu cần debug
        # print("DSL errors:", errs)

        raise HTTPException(
            status_code=400,
            detail={
                "message": (
                    "Cú pháp không hợp lệ.\n"
                    "Ví dụ đúng:\n"
                    "- \"I want a cold coffee\"\n"
                    "- \"Give me a iced tea with low sugar\""
                )
            },
        )

    # 2) Grammar OK → dùng visitor để lấy meaning
    visitor = PreferenceVisitor()
    pref: DrinkPreference = visitor.visit(tree)  # tree = program

    # 3) Nếu tất cả field đều None → coi như user không nói rõ đồ uống
    if all(
        getattr(pref, field) is None
        for field in ("temperature", "baseType", "sweetness", "caffeine", "size")
    ):
        raise HTTPException(
            status_code=400,
            detail={
                "message": (
                    "Thiếu thông tin đồ uống.\n"
                    "Bạn cần nói rõ hơn, ví dụ:\n"
                    "- \"I want a cold coffee\"\n"
                    "- \"Give me a warm tea without caffeine\""
                )
            },
        )

    # 4) Trả kết quả như cũ
    return PreferenceOut(
        temperature=pref.temperature,
        baseType=pref.baseType,
        sweetness=pref.sweetness,
        caffeine=pref.caffeine,
        size=pref.size,
    )


@router.post("/recommend", response_model=List[ProductOut])
async def recommend_products(body: RecommendRequest):
    # 1) Map sang DrinkPreference
    pref = DrinkPreference(
        temperature=body.temperature,
        baseType=body.baseType,
        sweetness=body.sweetness,
        caffeine=body.caffeine,
        size=body.size,
    )
    if pref.caffeine is not None:
        return []
    
    print("PREF:", pref)  # ✅ đặt ở đây

    # 2) Build filter Mongo
    mongo_filter = build_mongo_query(pref)

    print("MONGO FILTER:", mongo_filter)  # ✅ đặt ở đây

    # 3) Query DB
    coll = product_collection()
    docs = await coll.find(mongo_filter).to_list(length=50)

    print("DOCS COUNT:", len(docs))  # (tuỳ chọn) để biết có match không

    # 4) Map sang ProductOut
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
