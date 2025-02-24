from pydantic import BaseModel, Field, validator
from bson import ObjectId
from typing import Any, List, Optional, Annotated
from pydantic_core import core_schema

class PyObjectId(ObjectId):
    @classmethod
    def __get_validators__(cls):
        yield cls.validate

    @classmethod
    def validate(cls, v):
        if not ObjectId.is_valid(v):
            raise ValueError("Invalid ObjectId")
        return ObjectId(v)

    @classmethod
    def __get_pydantic_json_schema__(cls, schema_generator, schema):
        # Thêm tham số schema và trả về schema cho OpenAPI
        return {"type": "string"}
    
    @classmethod
    def __get_pydantic_core_schema__(cls, source_type, handler):
        return core_schema.json_or_python_schema(
            json_schema=core_schema.str_schema(),
            python_schema=core_schema.union_schema([
                core_schema.is_instance_schema(ObjectId),
                core_schema.str_schema(),
            ]),
            serialization=core_schema.plain_serializer_function_ser_schema(  # Sửa tên phương thức này
                lambda x: str(x)
            ),
        )

class Category(BaseModel):
    id: Optional[PyObjectId] = Field(alias="_id", default=None)
    name: str
    description: str
    product_ids: List[str] = []

    model_config = {
        "arbitrary_types_allowed": True,
        "json_encoders": {
            PyObjectId: str
        }
    }