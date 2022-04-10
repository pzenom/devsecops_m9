import http.server
import time
from prometheus_client import start_http_server, Gauge

INPROGRESS = Gauge('ucam_devsecops_inprogress',
        'Numero de peticiones devsecops en progreso.')
EXIT = Gauge('ucam_devsecops_last_time_seconds',
        'Tiempo de la última vez que se servio devsecops.')

class MyHandler(http.server.BaseHTTPRequestHandler):
    @INPROGRESS.track_inprogress()
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"DevSecOps")
        time.sleep(4)
        EXIT.set_to_current_time()

if __name__ == "__main__":
    start_http_server(8000)
    server = http.server.HTTPServer(('', 8001), MyHandler)
    server.serve_forever()