# models_ppl.py (ví dụ)
from pydantic import BaseModel
from typing import Optional

class ParseRequest(BaseModel):
    text: str

class RecommendRequest(BaseModel):
    temperature: Optional[str] = None
    baseType: Optional[str] = None
    sweetness: Optional[str] = None
    caffeine: Optional[str] = None
    size: Optional[str] = None
