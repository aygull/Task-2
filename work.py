from DB import _DataBase
import mysql.connector
import numpy
print('Enter name...', end=' ')
nameFile=input()
i=x=0
data=[]
res=[]
a=b=c=''
try:
    file = open (nameFile)
except IOError as error:
    c=(str(error))
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
                if numbers[c].isdigit():
                    if c == len(numbers) - 1:
                        res.append(float(numbers[c]))
                    else:
                        tmp.append(float(numbers[c]))
                elif not numbers[c][0] in 'x+-*/=':
                    b="x is empty"
                    break
            data.append(tmp)
try:
    tmpK = numpy.linalg.solve(data, res)
    print(tmpK)
    DataBase = _DataBase()
    try:
        DataBase.callFunction('set_model', str(data), str(res))
        DataBase.callFunction('add_log', str(tmpK))
    except mysql.connector.errors.IntegrityError:
        DataBase.callFunction('add_past_log', str(tmpK), str(data))
except  numpy.linalg.LinAlgError as error:
    a=str(error)
    print(a,"\n", b)
    DataBase = _DataBase()
    try:
        DataBase.callFunction('set_model', str(data), str(res))
        DataBase.callFunction('add_log', str(a))
    except mysql.connector.errors.IntegrityError:
        DataBase.callFunction('add_past_log', str(a), str(data))
