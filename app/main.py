from fastapi import FastAPI, Response
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST
import time, os

app = FastAPI(title="Azure DevOps Demo App", version="1.0.0")

REQUEST_COUNT = Counter("http_requests_total", "Total HTTP requests", ["method", "endpoint"])
REQUEST_LATENCY = Histogram("http_request_duration_seconds", "Request latency", ["endpoint"])

@app.get("/healthz")
def healthz():
    REQUEST_COUNT.labels(method="GET", endpoint="/healthz").inc()
    return {"status": "ok"}

@app.get("/readyz")
def readyz():
    REQUEST_COUNT.labels(method="GET", endpoint="/readyz").inc()
    return {"ready": True}

@app.get("/")
def root():
    start = time.time()
    try:
        REQUEST_COUNT.labels(method="GET", endpoint="/").inc()
        return {"message": "Hello from Azure DevOps Demo 🚀", "env": os.getenv("APP_ENV", "dev")}
    finally:
        REQUEST_LATENCY.labels(endpoint="/").observe(time.time() - start)

@app.get("/metrics")
def metrics():
    return Response(generate_latest(), media_type=CONTENT_TYPE_LATEST)
