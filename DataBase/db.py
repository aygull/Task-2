from threading import Lock
import mysql.connector
from functions import getFunctions
import numpy
import logging
import datetime
class _DataBase:
    def __connect(self):
#создание подключения к бд
        self.__db = mysql.connector.connect(host='localhost', database='tmp_new',
                                           user='root', password='')
        if self.__db.is_connected():
            self.__cursor = self.__db.cursor()

    def __init__(self):
        self.__connect()
#создание мьютекса
        self.__mutex = Lock()
#этого на паре не было, новый способ обращения к хранимым процедурам
        self.__functions = getFunctions(self.decorate())

#свойство, которое возвращает набор хранимок
    @property
    def Functions(self):
        return self.__functions

#### этого небыло на паре
    def decorate(self):
        def getFuncDecorator(storedFunction):
            def callProcedure(*args):
                self.__mutex.acquire()
                result = None
                try:

                    if not (self.__db.is_connected()):
                        self.__connect()

                    self.__cursor.callproc(storedFunction.__name__, args)
                    result = []

                    for item in self.__cursor.stored_results():
                        for item2 in item.fetchall():
                            result.append(item2)

                    self.__db.commit()

                finally:
                    self.__mutex.release()
                return result

            return callProcedure

        return getFuncDecorator
######

#функция, котороя принимает название хранимой процедуры и аргументы, которые она принимает
    def callFunction(self, nameFunction: str, *args):
#блокировка мьютекса
        self.__mutex.acquire()
        result = None
        try:
#проверка подключения, если не подключены, то востанавливаем соединение
            if not (self.__db.is_connected()):
                self.__connect()
#вызов хранимой процедуры
            self.__cursor.callproc(nameFunction, args)
            result = []
#получение результата вызова хранимой процедуры
            for item in self.__cursor.stored_results():
                for item2 in item.fetchall():
                    result.append(item2)
#коммит необходим, если мы добовляем что-то в бд, чтобы сохранить изменения
            self.__db.commit()

        finally:
#разблокирование мьютекса
            self.__mutex.release()
        return result

print('Enter name...', end=' ')
nameFile=input()
i=x=0
data=[]
res=[]
try:
    file = open (nameFile)
except IOError as error:
    print(str(error))
else:
    with file:
        for line in file:
            tmp = []
            line = line.replace('\n', '')
            line = line.replace(';', '')
            numbers = line.split(' ')
            if numbers[len(numbers) - 1] == '':
                numbers.pop()
            for c in range(len(numbers)):
                if numbers[c].isdigit() :
                    if c == len(numbers) - 1:#добавить условие для св членов
                        res.append(float(numbers[c]))
                    else:
                        tmp.append(float(numbers[c]))
            data.append(tmp)
    #try:
    tmpK = numpy.linalg.solve(data, res)
    print(tmpK)
    DataBase = _DataBase()
    DataBase.callFunction('set_model', str(data),  str(res))
    a=datetime.datetime.today()
    DataBase.callFunction('get_model',str(a), str(logging.info), str(data), str(res), str(tmpK))