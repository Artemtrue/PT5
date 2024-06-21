import os
from pt5taskmaker import *
import random
import numpy as np

def Task1(test):
    CreateTask("Ввод и вывод данных, оператор присваивания") 
    TaskText("Даны два числа a и b. ", 0 , 2)
    TaskText("Найти их произведение a * b", 0 , 4)
    a = RandomN(1,10)
    b = RandomN(1,10)
    DataN("a = ", a, xLeft, 3, 4)
    DataN("b = ", b, xRight, 3, 4)
    ResultN(("a * b = "), a * b, 0, 2, 4)
    SetTestCount(1)
    Pause()

def Task2(test):
    CreateTask("Ввод и вывод данных, оператор присваивания") 
    TaskText("Даны два вещественных числа a и b. ", 0 , 2)
    TaskText("Найти их сумму a + b", 0 , 4)
    a = RandomR(-5.0,5.0)
    b = RandomR2(-5.0,5.0) 
    SetPrecision(5)
    DataR("a = ", a, xLeft, 3, 4)
    DataR("b = ", b, xRight, 3, 4)
    ResultR(("a + b = "), a + b, 0, 2, 4)
    SetTestCount(3)
    Pause()

def Task4(test):
    CreateTask("Двумерные массивы (матрицы): вывод элементов")
    TaskText("Дана матрица размера~{M}\\;\\x\\;{N} и целое число~{K} (1~\\l~{K}~\\l~{M}).", 0, 2)
    TaskText("Вывести элементы {K}-й строки данной матрицы.", 0, 4)
    m = RandomN(2, 5)
    n = RandomN(4, 8)
    k = 1
    if m == 5:
        k = 0
    DataN("M = ", m, 3, 1, 1)
    DataN("N = ", n, 10, 1, 1)
    a = [[0 for _ in range(n)] for _ in range(m)]
    for i in range(m):
        for j in range(n):
            a[i][j] = RandomR(-9.99, 9.99)
            DataR('', a[i][j], Center(j+1, n, 5, 1), i + k + 1, 5)
    k = RandomN(1, m)
    DataN("K = ", k, 68, 5, 1)
    for j in range(n):
        ResultR('', a[k-1][j], Center(j+1, n, 5, 1), 3, 5)   
    SetTestCount(5)
    Pause()

def Task5(test):
    CreateTask("Символы и строки: основные операции")
    TaskText("Дана непустая строка~{S}.", 0, 2)
    TaskText("Вывести ее первый и последний символ.", 0, 4)
    s = EnWordSample(RandomN(0, EnWordCount() - 1))
    if (CurrentTest() == 3):
        while (s[0] == s[len(s)-1]):
            s = EnWordSample(RandomN(0, EnWordCount() - 1))
    DataS("S = ", s, 0, 3)
    ResultS("Первый символ: ", s[0], xLeft, 3)
    ResultS("Последний символ: ", s[len(s)-1], xRight, 3)
    SetTestCount(5)
    Pause()


c = "0123456789abcdefghijklmnopqrstuvwxyz"

def FileName(Len):
    result = ""
    for i in range(Len):
        result += random.choice(c)
    return result

def Task6(test):  
    CreateTask("Текстовые файлы: основные операции")
    TaskText("Дан текстовый файл.", 0, 2)
    TaskText("Удалить из него все пустые строки.", 0, 4)
    s1 = FileName(6) + ".tst"
    s2 = "#" + FileName(6) + ".tst"
    s = EnTextSample(random.randint(0, EnTextCount() - 1))
    with open(s2, 'w') as t2:
        t2.write(s + '\n')
    s_lines = s.splitlines()
    s_lines = [line for line in s_lines if line.strip() != '']
    s = '\n'.join(s_lines)
    with open(s1, 'w') as t1:
        t1.write(s + '\n')
    ResultFileT(s1, 1, 5)
    os.rename(s2, s1)
    DataFileT(s1, 2, 5)
    DataS("Имя файла: ", s1, 0, 1)
    SetTestCount(5)
    Pause()

def inittaskgroup():
    SetGroupData("DemoPy", "My description", "Artem", "qwqfsdf13dfttd", 6)  
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
        SetTaskData(3, test)
        UseTask("Begin", num)
        Pause()
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