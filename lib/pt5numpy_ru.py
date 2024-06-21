import os
from pt5taskmaker import *
import random
import numpy as np

def Task1(test):
    CreateTask("Изучение библиотеки Numpy: умножение матриц")
    TaskText("Даны две матрицы размеров~{M1}\\;\\x\\;{N1} и~{M2}\\;\\x\\;{N2}, где~{N1}~=~{M2}.", 0, 2)
    TaskText("Найдите произведение этих матриц.", 0, 4)
    SetPrecision(2)
    m1 = RandomN(2, 4)
    n1 = RandomN(2, 4)
    m2 = n1
    n2 = RandomN(2, 4)
    DataN("M1 = ", m1, 3, 1, 1)
    DataN("N1 = ", n1, 10, 1, 1)
    DataN("N2 = ", n2, 17, 1, 1)
    a = np.random.uniform(-0.99, 1.99, (m1, n1)) 
    b = np.random.uniform(-0.99, 1.99, (m2, n2)) 
    DataComment("Матрица A", Center(0, 0, 5, 1), 2)
    for i in range(m1):
        for j in range(n1):
            DataR('', a[i, j], Center(j+1, n1, 6, 2) , i+3, 5)
    DataComment("Матрица B", Center(0, 0, 5, 1), 30)
    for i in range(m2):
        for j in range(n2):
            DataR('', b[i, j], Center(j+1, n2, 6, 2), i+31, 5)
    product = np.dot(a, b)
    for i in range(m1):
        for j in range(n2):
            ResultR('', product[i, j], Center(j+1, n2, 6, 1), i + 1 , 5)
    SetTestCount(5)
    Pause()

def Task2(test):
    CreateTask("Изучение библиотеки Numpy: транспонирование матриц")
    TaskText("Дана матрица размера~{M}\\;\\x\\;{N}. Найдите транспонированную к ней матрицу.", 0, 2)
    SetPrecision(2)
    m = RandomN(2, 5)
    n = RandomN(4, 8)
    DataN("M = ", m, 3, 1, 1)
    DataN("N = ", n, 10, 1, 1)
    a = np.random.uniform(-9.99, 9.99, (m, n))  
    for i in range(m):
        for j in range(n):
            DataR('', a[i, j], Center(j+1, n, 6, 1), i+2, 5)
    a_transposed = np.transpose(a)
    for i in range(n):
        for j in range(m):
            ResultR('', a_transposed[i, j], Center(j+1, m, 6, 1), i + 1, 5)
    SetTestCount(5)
    Pause()

def Task3(test):
    CreateTask("Изучение библиотеки Numpy: операции со списками") 
    TaskText("Дан список размера~{N}. Выполните следующие операции:", 0, 2)
    TaskText("Найдите сумму элементов списка.", 0, 4)
    TaskText("Найдите среднее значение элементов списка.", 0, 6)
    TaskText("Найдите медиану элементов списка.", 0, 8)
    TaskText("Найдите стандартное отклонение элементов списка.", 0, 10)
    SetPrecision(2)
    n = RandomN(2, 9)
    DataN("N = ", n, Center(1, 1, 5, 1), 1, 1)
    arr = np.random.uniform(-9.99, 9.99, n)  
    for i in range(n):
        DataR('', arr[i], Center(i, n, 6, 1) + 5, 5, 3)
    total_sum = np.sum(arr)
    mean_value = np.mean(arr)
    median_value = np.median(arr)
    std_dev = np.std(arr)
    ResultR("Сумма:      ", total_sum, 0, 5, 5)
    ResultR("Среднее:    ", mean_value, 0, 15, 5)
    ResultR("Медиана:    ", median_value, 0, 25, 5)
    ResultR("Отклонение: ", std_dev, 0, 35, 5)
    SetTestCount(5)
    Pause()

def Task4(test):
    CreateTask("Изучение библиотеки Numpy: нахождение обратной матрицы")
    TaskText("Дана матрица размера~{N}\\;\\x\\;{N}. Найдите обратную матрицу.", 0, 2)
    SetPrecision(2)
    n = RandomN(3, 5)  
    DataN("N = ", n, 3, 1, 1)
    a = np.random.uniform(-9.99, 9.99, (n, n))  
    while np.linalg.det(a) == 0:  # Проверка, чтобы матрица была невырожденной
        a = np.random.uniform(-9.99, 9.99, (n, n))
    for i in range(n):
        for j in range(n):
            DataR('', a[i, j], Center(j+1, n, 6, 1), i+3, 5)
    a_inv = np.linalg.inv(a)
    for i in range(n):
        for j in range(n):
            ResultR('', a_inv[i, j], Center(j+1, n, 6, 1), i+1 , 5)
    SetTestCount(5)
    Pause()

def Task5(test):
    CreateTask("Изучение библиотеки Numpy: решение СЛУ")
    TaskText("Дана СЛУ с коэффициентами в матрице размера ~{N}\\;\\x\\;{N} и список свободных членов.", 0, 2)
    TaskText("Найдите решение этой системы.", 0, 4)
    SetPrecision(2)
    n = RandomN(3, 4)  
    DataN("N = ", n, 3, 1, 1)
    a = np.random.uniform(-9.99, 9.99, (n, n))  
    while np.linalg.det(a) == 0:  
        a = np.random.uniform(-9.99, 9.99, (n, n))
    b = np.random.uniform(-9.99, 9.99, n)
    DataComment("Матрица ", Center(0, 0, 5, 0)+2, 1) 
    for i in range(n):
        for j in range(n):
            DataR('', a[i, j], Center(j+1, n, 6, 1), i+2, 5)
    DataComment("Cписок свободных членов ", Center(-1, 0, 5, 1), 6)        
    for i in range(n):
        DataR(' ', b[i], Center(i+1, 0, 6, 1) - 12,n+7, 5)
    x = np.linalg.solve(a, b)
    for i in range(n):
        ResultR("x{} = ".format(i), x[i], Center(0, n, 0, 1) - 3, i+1 , 5)
    SetTestCount(5)
    Pause()

def Task6(test):
    CreateTask("Изучение библиотеки Numpy: вычисление собственных значений")
    TaskText("Дана квадратная матрица размера~{N}\\;\\x\\;{N}.", 0, 2)
    TaskText("Найдите её собственные значения", 0, 4)
    SetPrecision(2)
    n = RandomN(2, 5)  
    DataN("N = ", n, 3, 1, 1)
    a = np.random.uniform(-9.99, 9.99, (n, n))  
    for i in range(n):
        for j in range(n):
            DataR('', a[i, j], Center(j+1, n, 6, 1), i+4, 5)
    eigenvalues = np.linalg.eigvals(a).real
    for i in range(n):
        ResultR("l{} = ".format(i), eigenvalues[i], Center(0, n, 2, 0), i + 1 , 5)
    SetTestCount(5)
    Pause()

def inittaskgroup():
    SetGroupData("Numpy", "My description", "Artem", "qwqfsdf13dfttd", 6)  
    topic = GetTopic()
    code = GetCode()
    taskCount = GetTaskCount()
    clear_file("groupinfo.txt")
    to_file("groupinfo.txt", topic, code, str(taskCount))

def InitTask(num, test):
    inittaskgroup()
    if (num == 1):
        SetTaskData(num, test)
        Task1(test)
    elif (num == 2):
        SetTaskData(num, test)
        Task2(test)
    elif (num == 3):
        SetTaskData(num, test)
        Task3(test)
    elif (num == 4):
        SetTaskData(num, test)
        Task4(test)
    elif (num == 5):
        SetTaskData(num, test)
        Task5(test)
    elif (num == 6):
        SetTaskData(num, test)
        Task6(test)
    else:
        raise ValueError("Задание с номером {} не существует".format(num))

def Run():
    with open('.pt/command.txt', 'r') as file:
        n = int(file.readline().strip())
        test = int(file.readline().strip())
    InitTask(n, test)

activate_core()
Run()