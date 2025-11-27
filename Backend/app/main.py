from fastapi import FastAPI, Request, Response
from fastapi.responses import RedirectResponse
from contextlib import asynccontextmanager
import asyncio  # <--- NEW: Cần cái này

from app.api import api_router
from app.db.database import get_db, get_client, close_client, ping
# <--- NEW: Import service mình vừa tạo
from app.monitoring import monitor_service

from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST
from starlette.middleware.base import BaseHTTPMiddleware
import time

# --- Metrics ---
REQUEST_COUNT = Counter(
    "http_requests_total",
    "Total HTTP requests",
    ["method", "path", "status"]
)

REQUEST_LATENCY = Histogram(
    "http_request_duration_seconds",
    "Request latency in seconds",
    ["method", "path"],
    buckets=(0.005, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1, 2, 5)
)


class PrometheusMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        start_time = time.perf_counter()
        response = await call_next(request)
        
        # Tính thời gian xử lý
        process_time = time.perf_counter() - start_time

        # 1. Ghi nhận cho Prometheus (Code cũ của bạn)
        REQUEST_COUNT.labels(
            method=request.method,
            path=request.url.path,
            status=str(response.status_code)
        ).inc()

        REQUEST_LATENCY.labels(
            method=request.method,
            path=request.url.path
        ).observe(process_time)

        # 2. <--- NEW: Ghi nhận cho CloudWatch (Thêm dòng này)
        # Đổi sang milliseconds cho CloudWatch
        await monitor_service.record_request(process_time * 1000)

        return response


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Database setup
    client = get_client()
    app.state.db_client = client
    app.state.db = get_db()

    # <--- NEW: Khởi động vòng lặp gửi CloudWatch ngầm
    # Nó sẽ chạy song song, không chặn ứng dụng chính
    task = asyncio.create_task(monitor_service.start_background_loop())

    try:
        yield
    finally:
        close_client()
        # (Tùy chọn) Bạn có thể cancel task ở đây nếu muốn clean up kỹ
        # task.cancel()


app = FastAPI(title="Commercial Projects", version="1.0", lifespan=lifespan)

app.add_middleware(PrometheusMiddleware)

app.include_router(api_router, prefix="/api")


@app.get("/")
async def redirect_to_docs():
    return RedirectResponse(url="/docs")


@app.get("/health")
async def health(_: Request):
    await ping()
    return {"status": "ok"}


@app.get("/metrics")
async def metrics():
    return Response(generate_latest(), media_type=CONTENT_TYPE_LATEST)