from BaseHTTPServer import HTTPServer, BaseHTTPRequestHandler
from SocketServer import ThreadingMixIn
import threading

MOD = 3

class Handler(BaseHTTPRequestHandler):

    n = 0

    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        Handler.n = (Handler.n + 1) % MOD
        #message = '%d' % (Handler.n)
        message = 'X'* 100
        self.wfile.write(message)
        return

    def do_POST(self):
        content_len = int(self.headers.getheader('content-length', 0))
        post_body = self.rfile.read(content_len)
        self.send_response(200)
        self.end_headers()
        message =  threading.currentThread().getName()
        self.wfile.write('%s got: %s' % (message, post_body))
        return


class ThreadedHTTPServer(ThreadingMixIn, HTTPServer):
    """Handle requests in a separate thread."""

if __name__ == '__main__':
    server = ThreadedHTTPServer(('10.0.0.4', 5000), Handler)
    print 'Starting server, use <Ctrl-C> to stop'
    server.serve_forever()
