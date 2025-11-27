# ---------- Build Stage ----------
FROM python:3.11-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Tools build-only (không mang sang runtime)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential && \
    rm -rf /var/lib/apt/lists/*

# Cài dependency vào venv riêng
COPY requirements.txt .
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install --no-cache-dir -r requirements.txt

# Copy code (nếu có bước generate/compile assets thì để ở builder là hợp lý)
COPY app ./app


# ---------- Runtime ----------
FROM python:3.11-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/py/bin:$PATH"

# Curl cho healthcheck (tối thiểu)
RUN apt-get update && apt-get install -y --no-install-recommends curl \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy venv & code từ builder, gán quyền cho appuser
COPY --from=builder --chown=appuser:appuser /py /py
COPY --from=builder --chown=appuser:appuser /app ./ 

# Tạo user không phải root SAU khi copy (hoặc dùng --chown như trên)
RUN useradd -m appuser
USER appuser

EXPOSE 8000

# Healthcheck có start-period để chờ app sẵn sàng
HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 \
  CMD curl -fsS http://localhost:8000/health || exit 1

# Chạy app
# Dev / đơn giản:
# CMD ["uvicorn","app.main:app","--host","0.0.0.0","--port","8000"]
# Prod (khuyến nghị):
CMD ["gunicorn","app.main:app","-k","uvicorn.workers.UvicornWorker","-w","2","-b","0.0.0.0:8000","--timeout","60","--access-logfile","-","--error-logfile","-"]
