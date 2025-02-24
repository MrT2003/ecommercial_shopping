from app.services.CategoryService import CategoryService
from app.models.category import Category
from fastapi import APIRouter, HTTPException

router = APIRouter()

#http://127.0.0.1:8000/api/categories/
@router.get("/", response_model=list)  # Should return a list of Category
async def get_all_categories():
    """API lấy danh sách tất cả danh mục"""
    categories = await CategoryService.get_all_categories()  # Must return a list of Category
    if not categories:
        raise HTTPException(status_code=404, detail="No categories found")
    return categories

#http://127.0.0.1:8000/api/categories/{category_id}
@router.get("/{category_name}", response_model=Category)
async def get_category_by_name(category_name: str):
    """API lấy thông tin danh mục bằng tên"""
    category = await CategoryService.get_category_by_name(category_name)
    if category is None:
        raise HTTPException(status_code=404, detail="Category not found")
    return category
