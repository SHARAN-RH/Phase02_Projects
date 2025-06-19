from flask import Flask
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)
REQ_COUNT = Counter('service_a_requests', 'Total requests')

@app.route('/')
def index():
    REQ_COUNT.inc()
    return "Hello from Service A"

@app.route('/metrics')
def metrics():
    return generate_latest(), 200, {'Content-Type': CONTENT_TYPE_LATEST}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)  # or port=80 with elevated permissions

