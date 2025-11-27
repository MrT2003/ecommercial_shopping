# app/monitoring.py
import asyncio
import boto3
import numpy as np
import os

# Cấu hình
NAMESPACE = "Custom/MyApp"
# Lấy Region từ biến môi trường hoặc mặc định Tokyo
REGION = os.environ.get("AWS_REGION", "ap-northeast-1")

class MetricUploader:
    def __init__(self):
        self.req_count = 0
        self.latencies = []
        # Khởi tạo boto3 client
        self.cloudwatch = boto3.client("cloudwatch", region_name=REGION)
        self.lock = asyncio.Lock()

    async def record_request(self, latency_ms):
        """Ghi nhận 1 request vào bộ nhớ tạm"""
        async with self.lock:
            self.req_count += 1
            self.latencies.append(latency_ms)

    async def start_background_loop(self):
        """Vòng lặp chạy ngầm để gửi data"""
        print(f"🚀 CloudWatch Monitoring Started in region {REGION}...")
        while True:
            # Gửi metric mỗi 60 giây
            await asyncio.sleep(60)
            await self.flush_metrics()

    async def flush_metrics(self):
        """Tính toán và đẩy lên CloudWatch"""
        async with self.lock:
            if self.req_count == 0:
                count = 0
                p95 = 0
            else:
                # Tính Request/Second (chia cho 60s)
                count = self.req_count / 60.0
                # Tính P95 Latency
                p95 = np.percentile(self.latencies, 95)

            # Reset bộ đếm
            self.req_count = 0
            self.latencies = []

        try:
            # Gửi dữ liệu thật lên AWS
            self.cloudwatch.put_metric_data(
                Namespace=NAMESPACE,
                MetricData=[
                    {
                        'MetricName': 'RequestCountPerSecond',
                        'Value': count,
                        'Unit': 'Count/Second',
                        'StorageResolution': 60
                    },
                    {
                        'MetricName': 'P95LatencyMs',
                        'Value': p95,
                        'Unit': 'Milliseconds',
                        'StorageResolution': 60
                    }
                ]
            )
            # Uncomment dòng dưới để debug nếu cần
            # print(f"✅ CloudWatch Sent: Req/s={count:.2f}, P95={p95:.2f}ms")
        except Exception as e:
            print(f"⚠️ CloudWatch Error: {e}")

# Tạo instance để dùng bên main.py
monitor_service = MetricUploader()