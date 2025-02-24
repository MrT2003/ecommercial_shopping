from typing import List
from fastapi import APIRouter, Depends, HTTPException, Query
from app.services.ProductService import ProductService
from app.models.product import Product

router = APIRouter()

#http://127.0.0.1:8000/api/products/
@router.get("/", response_model=list)
async def get_products():
    """API lấy danh sách tất cả sản phẩm"""
    products = await ProductService.get_all_products()
    if not products:
        raise HTTPException(status_code=404, detail="No products found")
    return products

#http://127.0.0.1:8000/api/products/search?query=burger
@router.get("/search", response_model=List[Product])
async def search_products(query: str = Query(..., min_length=1)):
    """API tìm kiếm sản phẩm theo tên"""
    products = await ProductService.search_products(query)
    if not products:
        raise HTTPException(status_code=404, detail="No products found")
    return products

#http://127.0.0.1:8000/api/products/{product_id}
@router.get("/{product_id}", response_model=Product)
async def get_product_by_id(product_id: str):
    """API lấy thông tin sản phẩm bằng ID"""
    product = await ProductService.get_product_by_id(product_id)
    if product is None:
        raise HTTPException(status_code=404, detail="Product not found")
    return product




# @router.post("/", response_model=Product)
# async def create_product(product: Product):
#     """API tạo sản phẩm mới"""
#     new_product = await ProductService.create_product(product)
#     return new_product
