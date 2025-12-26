# ---------- Build Stage ----------
FROM python:3.11-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install --no-cache-dir -r requirements.txt

COPY app ./app

# ---------- Runtime ----------
FROM python:3.11-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/py/bin:$PATH"

RUN apt-get update && apt-get install -y --no-install-recommends curl \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=builder --chown=appuser:appuser /py /py
COPY --from=builder --chown=appuser:appuser /app ./ 

RUN useradd -m appuser
USER appuser

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 \
  CMD curl -fsS http://localhost:8000/health || exit 1

CMD ["gunicorn","app.main:app","-k","uvicorn.workers.UvicornWorker","-w","2","-b","0.0.0.0:8000","--timeout","60","--access-logfile","-","--error-logfile","-"]
