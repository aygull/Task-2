from DataBase.db import DataBase

try:
#вызов хранимой процедуры set_model, которая добавит строки Artem и yrllow в таблицу
    DataBase.callFunction('set_model', 'Artem', 'yellow')
#вызов хранимой процедуры, которая принимает id модели и возвращает поля: name, color
    res = DataBase.callFunction('get_model', 1)
    print(res)
except Exception as error:
    print(str(error))
