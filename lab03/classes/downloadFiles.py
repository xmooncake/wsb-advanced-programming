from pytube import YouTube
import threading
import os
import time
from queue import Queue

NUM_THREADS = 10
# q = Queue()
urls = [
        'https://www.youtube.com/watch?v=dQw4w9WgXcQ', 
        'https://www.youtube.com/watch?v=k85mRPqvMbE',
        'https://www.youtube.com/watch?v=sXYnORjJSXw',
        'https://www.youtube.com/watch?v=MSxeCVt0ZBE',
        'https://www.youtube.com/watch?v=VOhkIjCMVXo',
    ]


def __downloadVideo(url):
        youtubeObject = YouTube(url)
        youtubeObject = youtubeObject.streams.get_highest_resolution()
        try:
            currentPath = os.getcwd()
            youtubeObject.download(output_path= currentPath + '/downloads')
            print('Available CPU cores during test: ' + str(os.cpu_count()))
        except:
            print("An error has occurred")
        
        print("Download completed successfully")
        
def multithreadDownloadingExample():
    startTime = time.time()
    
    for url in urls:

        worker = threading.Thread(target=__downloadVideo, args=(url,))
        # worker.daemon = True
        worker.start()
        worker.join()

    
    
    

    
    endTime = time.time() - startTime
    print('Test completion time: ' + str(endTime) + '\n') 

