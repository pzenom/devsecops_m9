import http.server
from prometheus_client import start_http_server, Counter

REQUESTS = Counter('ucam_devsecops_total',
        'Numero de peticiones DevSecOps.')

class MyHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        REQUESTS.inc()
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"DevSecOps")

if __name__ == "__main__":
    start_http_server(8000)
    server = http.server.HTTPServer(('', 8001), MyHandler)
    server.serve_forever()