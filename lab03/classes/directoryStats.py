from os import walk
import os
import time
from hurry.filesize import size
import classes.taskQueue as taskQueue


userDir = os.path.expanduser('~')
paths = [

    userDir + '\Desktop',
    userDir + '\Downloads',

]



def __getFilenames(path):

    print('Zawartość aktualnego folderu: \n')

    for f in os.listdir(path=path):

        print(f'- {f}')



def __getDirectorySize(path):

    total = 0

    with os.scandir(path) as cd:

        for entry in cd:
            if entry.is_file():

                total += entry.stat().st_size
            elif entry.is_dir():

                total += __getDirectorySize(entry.path)
    return total

def __directoryScan(path):
    print(f'Aktualny folder: {path}\n')
    __getFilenames(path)
    print(f'\n Zajmowane miejsce na dysku: {size(__getDirectorySize(path))}')

def multiThreadDirectoryStatsExample():
    startTime = time.time()
    q = taskQueue.TaskQueue(num_workers=len(paths))
    

    print('\n=^..^=   =^..^=   =^..^=    =^..^=\n')
    
    for path in paths:
        
        q.add_task(__directoryScan(path))
        print('\n=^..^=   =^..^=   =^..^=    =^..^=\n')
    
    q.start_workers()
    q.join()
    
    endTime = time.time() - startTime
    print(f'Czas trwania: {str(endTime)}\n') 
        

