from ctypes import c_int, c_char_p, c_char, c_double, c_float, c_bool
import ctypes
import random

def activate_core():
    with open('.pt/dllname.txt', 'r') as file:
        path_to_core = file.read().strip()
        core = ctypes.windll.LoadLibrary(path_to_core)
    return core

core = activate_core()

xCenter = 0
xLeft = 100
xRight = 200

SampleError = "#ERROR?"
MaxLineCount = 50

lgPascal = 0x0000001 
lgPascalABCNET = 0x0000401 
lgPascalNET = 0x0000400
lgPascalABCNET_flag = 0x0000400  
lgVB = 0x0000002
lgCPP = 0x0000004
lg1C = 0x0000040
lgPython = 0x0000080 
lgPython3 = 0x1000080 
lgPython3_flag = 0x1000000 
lgCS = 0x0000100
lgVBNET = 0x0000200
lgJava = 0x0010000  
lgRuby = 0x0020000  
lgWithPointers = 0x000003D
lgWithObjects = 0x0FFFF80  
lgNET = 0x000FF00
lgAll = 0x0FFFFFF  
lgFS = 0x0000800 
lgJulia = 0x0040000
lgC = 0x0000008 

def SetGroupData(GroupName, GroupDescription, GroupAuthor, GroupKey, TaskCount):
    core.setgroupdata(
        c_char_p(GroupName.encode('windows-1251')),
        c_char_p(GroupDescription.encode('windows-1251')),
        c_char_p(GroupAuthor.encode('windows-1251')),
        c_char_p(GroupKey.encode('windows-1251')),
        c_int(TaskCount)) 

def SetTaskData(num, test):
    s = ctypes.create_string_buffer(21)
    core.settaskdata(c_int(num), c_int(test), s)
    return s.value.decode('windows-1251')

def CreateTask(SubgroupName=''):
    core.createtask(c_char_p(SubgroupName.encode('windows-1251')))

def TaskText(S, X, Y):
    core.tasktext(c_char_p(S.encode('windows-1251')), c_int(X), c_int(Y))

def Pause():
    core.pause()

def GetTopic():
    s = ctypes.create_string_buffer(21)
    core.gettopic(s)
    return s.value.decode('windows-1251')

def GetCode():
    s = ctypes.create_string_buffer(21)
    core.getcode(s)
    return s.value.decode('windows-1251')

def GetTaskCount():
    return core.gettaskcount()

def ShowError(S1, S2):
    print(f"{S1}\nis not found in the PT5 library.\nYou should update the Programming Taskbook to {S2} version.")

def UseTask(GroupName, TaskNumber):
    core.usetask(c_char_p(GroupName.encode('windows-1251')), c_int(TaskNumber))    

def CurrentLanguage():
    return core.currentlanguage()

def BtoN(B):
    if B:
        return 1
    else:
        return 0

def DataC(Cmt, C, X, Y):
    core.datac(c_char_p(Cmt.encode('windows-1251')), c_char(C.encode('windows-1251')), c_int(X), c_int(Y))

def DataN(Cmt, N, X, Y, W):
    core.datan(c_char_p(Cmt.encode('windows-1251')), c_int(N), c_int(X), c_int(Y), c_int(W))

def DataB(Cmt, B, X, Y):  
    core.datab(c_char_p(Cmt.encode('windows-1251')), c_int(BtoN(B)), c_int(X), c_int(Y))  
     
def DataR(Cmt, R, X, Y, W):
    core.datar(c_char_p(Cmt.encode('windows-1251')), c_double(R), c_int(X), c_int(Y), c_int(W))

def DataS(Cmt, S, X, Y):
    core.datas(c_char_p(Cmt.encode('windows-1251')), c_char_p(S.encode('windows-1251')), c_int(X), c_int(Y))

def DataComment(Cmt, X, Y):
    core.datacomment(c_char_p(Cmt.encode('windows-1251')), c_int(X), c_int(Y))

def ResultN(Cmt, R, X, Y, W):
    core.resultn(c_char_p(Cmt.encode('windows-1251')), c_int(R), c_int(X), c_int(Y), c_int(W))

def ResultB(Cmt, B, X, Y): 
    core.resultb(c_char_p(Cmt.encode('windows-1251')), c_int(BtoN(B)), c_int(X), c_int(Y))   

def ResultR(Cmt, R, X, Y, W):
    core.resultr(c_char_p(Cmt.encode('windows-1251')), c_double(R), c_int(X), c_int(Y), c_int(W))

def ResultS(Cmt, S, X, Y):
    core.results(c_char_p(Cmt.encode('windows-1251')), c_char_p(S.encode('windows-1251')), c_int(X), c_int(Y))

def ResultComment(Cmt, X, Y):
    core.resultcomment(c_char_p(Cmt.encode('windows-1251')), c_int(X), c_int(Y))

def SetPrecision(N):
    core.setprecision(c_int(N))

def SetTestCount(N): 
    clear_file("taskinfo.txt")
    to_file("taskinfo.txt", N)
    core.settestcount(c_int(N))

def SetRequiredDataCount(N):
    core.setrequireddatacount(c_int(N))

def Center(I, N, W, B):
    return core.center(c_int(I), c_int(N), c_int(W), c_int(B))

def DataFileN(FileName, Y, W):
    core.datafilen(c_char_p(FileName.encode('windows-1251')), c_int(Y), c_int(W))

def DataFileR(FileName, Y, W):
    core.datafiler(c_char_p(FileName.encode('windows-1251')), c_int(Y), c_int(W))

def DataFileC(FileName, Y, W):
    core.datafilec(c_char_p(FileName.encode('windows-1251')), c_int(Y), c_int(W))

def DataFileS(FileName, Y, W):
    core.datafiles(c_char_p(FileName.encode('windows-1251')), c_int(Y), c_int(W))

def DataFileT(FileName, Y1, Y2):
    core.datafilet(c_char_p(FileName.encode('windows-1252')), c_int(Y1), c_int(Y2))

def ResultFileT(FileName, Y1, Y2):
    core.resultfilet(c_char_p(FileName.encode('windows-1252')), c_int(Y1), c_int(Y2))

def ResultFileN(FileName, Y, W):
    core.resultfilen(c_char_p(FileName.encode('windows-1251')), c_int(Y), c_int(W))

def ResultFileR(FileName, Y, W):
    core.resultfiler(c_char_p(FileName.encode('windows-1251')), c_int(Y), c_int(W))

def ResultFileC(FileName, Y, W): # ERangeError: Range check error
    core.resultfilec(c_char_p(FileName.encode('windows-1251')), c_int(Y), c_int(W))

def ResultFileS(FileName, Y, W):
    core.resultfiles(c_char_p(FileName.encode('windows-1251')), c_int(Y), c_int(W))

def EnWordCount():
    return core.enwordcount()

def EnSentenceCount():
    return core.ensentencecount()

def EnTextCount():
    return core.entextcount()

def EnWordSample(n):
    s = ctypes.create_string_buffer(20)  # max = 14
    core.enwordsample(n, s)
    return s.value.decode('windows-1251')

def EnSentenceSample(n):
    s = ctypes.create_string_buffer(100)  # max = 76
    core.ensentencesample(n, s)
    return s.value.decode('windows-1251')

def EnTextSample(n):
    s = ctypes.create_string_buffer(1100)  # max = 1009
    core.entextsample(n, s)
    return s.value.decode('windows-1251')

def SetProcess(ProcessRank): 
    core.setprocess(c_int(ProcessRank))

def CurrentVersion(): # OSError: exception: access violation writing 0x00001100
    return core.currentversion().decode('windows-1251')

def CurrentTest(): 
    return core.curt()

def RandomN(M, N):
    return core.randomn(c_int(M), c_int(N))

def RandomR(A, B):
    return random.uniform(A, B)

def RandomR1(A, B):
    return round(random.uniform(A, B), 1)

def RandomR2(A, B):
    return round(random.uniform(A, B), 2)

def ClearGroupData():
    core.cleargroupdata()

def GetTaskCount():
    return core.gettaskcount()

def SetLanguage(n):
    core.setlanguage(n)

def NoEraseNextFile():
    core.noerasenextfile()

def SetFileItemsInLine(N):
    core.setfileitemsinline(N)

def SetFileRow(N):
    core.setfilerow(N)

def SetNumberOfTests(n):
    core.settestcount(n)

def SetNumberOfUsedData(n):
    core.setrequireddatacount(n)

def getVariant(code, nv1, nv2, nv3):
    v1 = core.getvariant(code, nv1, nv2, nv3)
    v2 = 0
    v3 = 0
    return v1, v2, v3

def curtest():
    return core.currenttest()

### Вспомогательные функции ### 

def clear_file(filename):
    with open('.pt/' + filename, 'w', encoding='windows-1251') as file:
        file.write('') 

def to_file(filename, *lines):
    with open('.pt/' + filename, 'a', encoding='windows-1251') as file:
        for line in lines:
            file.write(f"{line}\n")

def print_file_content(file_path):
    print("СОДЕРЖИМОЕ ФАЙЛА: " + str(file_path))
    try:
        with open(file_path, 'r') as file:
            content = file.read()
            print(content)
    except FileNotFoundError:
        print(f"Файл '{file_path}' не найден.")
    except IOError:
        print(f"Ошибка ввода-вывода при чтении файла '{file_path}'.")