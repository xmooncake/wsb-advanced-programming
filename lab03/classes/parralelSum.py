import random
import threading
import time
import os


class ParralelSum():
    def __init__(self, SAMPLE_COUNT):
        self.SAMPLE_COUNT = SAMPLE_COUNT

    def __generateList(self):
        randomList = random.sample(
            range(0, (self.SAMPLE_COUNT + 1)), self.SAMPLE_COUNT,
        )
        return randomList

    def __getListSum(self, numberList):
        return sum(numberList)

    def init(self):

        # intialize data

        list1 = self.__generateList()
        list2 = self.__generateList()

        t0 = threading.Thread(target=self.__getListSum, args=(list1,))
        t1 = threading.Thread(target=self.__getListSum, args=(list1,))
        t2 = threading.Thread(target=self.__getListSum, args=(list2,))

        # single thread test
        print('First test with a single thread:\n')
        startTime0 = time.time()

        t0.start()
        print('Available CPU cores during test: ' + str(os.cpu_count()))
        t0.join()

        endTime0 = time.time() - startTime0

        print('Test1 completion time: ' + str(endTime0) + '\n')

        # dual thread test

        print('Second test with two threads:\n')
        startTime1 = time.time()

        t1.start()
        t2.start()
        print('Available CPU cores during test: ' + str(os.cpu_count()))
        t1.join()
        t2.join()

        endTime1 = time.time() - startTime1

        print('Test2 completion time: ' + str(endTime1))

        print('\nTime diff between both tests: ' +
              str(abs(endTime0 - endTime1)))
