import time
from random import randint
from threading import Lock

class SynchronizedList:
    def __init__(self):
        self._list = []
        self._lock = Lock()

    def add(self, element):
        with self._lock:
            self._list.append(element)

normal_collection = []
synchronized_collection = SynchronizedList()


start_time = time.time()
for _ in range(1000000):
    normal_collection.append(randint(1, 1000))
end_time = time.time()
normal_time = (end_time - start_time) * 1000  


start_time = time.time()
for _ in range(1000000):
    synchronized_collection.add(randint(1, 1000))
end_time = time.time()
synchronized_time = (end_time - start_time) * 1000  

print("Czas dodawania 1 000 000 elementów:")
print("Zwykła kolekcja: {:.2f} ms".format(normal_time))
print("Zsynchronizowana kolekcja: {:.2f} ms".format(synchronized_time))
