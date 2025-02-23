from fastapi import APIRouter, Depends, HTTPException
from app.services.ProductService import ProductService
from app.models.product import Product

router = APIRouter()

@router.get("/", response_model=list)
async def get_products():
    """API lấy danh sách tất cả sản phẩm"""
    products = await ProductService.get_all_products()
    return products

@router.post("/", response_model=Product)
async def create_product(product: Product):
    """API tạo sản phẩm mới"""
    new_product = await ProductService.create_product(product)
    return new_product
