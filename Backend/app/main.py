from fastapi import FastAPI, Request, Response
from fastapi.responses import RedirectResponse
from contextlib import asynccontextmanager
import asyncio 

from app.api import api_router
from app.db.database import get_db, get_client, close_client, ping
from app.monitoring import monitor_service

from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST
from starlette.middleware.base import BaseHTTPMiddleware
import time

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
        
        process_time = time.perf_counter() - start_time

        REQUEST_COUNT.labels(
            method=request.method,
            path=request.url.path,
            status=str(response.status_code)
        ).inc()

        REQUEST_LATENCY.labels(
            method=request.method,
            path=request.url.path
        ).observe(process_time)
        await monitor_service.record_request(process_time * 1000)

        return response


@asynccontextmanager
async def lifespan(app: FastAPI):
    client = get_client()
    app.state.db_client = client
    app.state.db = get_db()

    task = asyncio.create_task(monitor_service.start_background_loop())

    try:
        yield
    finally:
        close_client()


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