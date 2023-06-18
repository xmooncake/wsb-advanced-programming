import threading
import time
from ping3 import ping, verbose_ping

class PingChecker(threading.Thread):
    def __init__(self, server_url):
        threading.Thread.__init__(self)
        self.server_url = server_url
        self.requests = 0
        self.total_ping_time = 0

    def run(self):
        try:
            start_time = time.time()
            response_time = ping(self.server_url, timeout=2)
            end_time = time.time()

            if response_time is not None:
                ping_time = response_time * 1000
                print(f"Ping to {self.server_url} is successful. Ping: {ping_time:.2f} ms")
            else:
                print(f"Ping to {self.server_url} failed")
                ping_time = 0
        except Exception as e:
            print(f"Error occurred while pinging {self.server_url}: {str(e)}")
            ping_time = 0

        self.requests += 1
        self.total_ping_time += ping_time

server_urls = ["google.com", "facebook.com", "pralnia77.pl"]

threads = []
for url in server_urls:
    thread = PingChecker(url)
    thread.start()
    threads.append(thread)

for thread in threads:
    thread.join()

total_requests = 0
total_ping_time = 0
for thread in threads:
    total_requests += thread.requests
    total_ping_time += thread.total_ping_time

average_ping_time = total_ping_time / total_requests if total_requests > 0 else 0
print(f"Average ping across all threads: {average_ping_time:.2f} ms")
