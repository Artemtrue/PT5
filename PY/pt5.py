import os
import os.path
import sys
import shutil

class TData:
    def __init__(self, id, r, s):
        self.id = id
        self.r = r
        self.s = s

def removefile(f):
  if os.path.isfile(f):
    os.remove(f)

_NoInputMsg = "Data are not input.\n"
_NotAllInputMsg = "Some required data are not input.\n"
_TooManyInputMsg = "An attempt to input superfluous data.\n"
_WrongTypeInputMsg = "Invalid type is used for an input data item.\n"
_NoTaskCallMsg = "ERROR: the Task function is not called at beginning of the program"

_UTFTextMark = "[[!UTF8MARK!]]"

_idata = list()

_Precision = 2
_Width = 0
_Width1 = -1


_line_break = False
_space_count = 0

_psize = -1
_prank = -1
_useddata = 0 
_nidata = 0
_idatacount = 0


_InfoS = ""
_indat = ".pt\\pt5in0.dat"
_outdat = ".pt\\pt5out0.dat"
_errdat = ".pt\\pt5err0.dat"
_showdat = ".pt\\pt5sh0.dat"


def error_(msg, id):
  print(msg + " " + id)
  f = open(_errdat, "w")
  f.write(msg)
  f.write(id)
  f.close()


def init_():
  global _prank
  global _indat
  global _outdat
  global _errdat
  global _showdat
  global _idata
  global _nidata
  global _idatacount
  global _useddata

  _prank = 0

  # shutil.copy(_indat, "C:\\Users\\artem\\Desktop\\1pt5in0.dat")

  removefile(_outdat)
  removefile(_errdat)
  removefile(_showdat)
  try:
    f = open(_indat, "r")
    id = f.readline()
    while id != "": # reading all input data
                    # and determing data size
      val = f.readline()
      id = id[0]     
      val = val.rstrip('\n')
      if id == 'i':
        dataitem = TData(id, int(val), "")
      elif id == 'r':
        dataitem = TData(id, float(val), "") 
      elif id == 'b':
        dataitem = TData(id, int(val), "")
      elif id == 'c':
        dataitem = TData(id, 0, val[0])
      elif id == 's':
        dataitem = TData(id, 0, val)

      _idata.append(dataitem)

      id = f.readline()
    f.close()
  except Exception as e:
    show_line("An error occurred:", e)
  error_(_NoInputMsg, "3")
  _nidata = len(_idata)
  if _useddata == 0 or _prank > 0: # for slave processes,
                                   # we do not take useddata into account;
                                   # all input data are required to input
    _useddata = _nidata
  _idatacount = 0

_addchar = False

def show_str(s):
  global _addchar
  if _psize < 1:
    sys.exit(_NoTaskCallMsg)
  f = open(_showdat, "a")
  if _addchar:
    f.write(" ")
  f.write(str(s))
  f.close()
  _addchar = True

def show(a, *b): # ver.4.19
  global _Width
  global _Precision
  global _line_break
  global _space_count
  global _addchar
  b0 = False
  is_struct = False
  if isinstance(a, float):
    if _Precision >= 0:
       a = format(a, str(_Width)+"."+str(_Precision)+"f")
    else:   
       a = format(a, str(_Width)+"."+str(-_Precision)+"e")
  elif type(a) == int:
    a = format(a, str(_Width)+"d")
  elif type(a) != tuple and type(a) != list and type(a) != set and type(a) != dict:
    if a != '\n' and a != '\r' and a != '\r\n':
      a = format(str(a), "<"+str(_Width)+"s")
  else:
    is_struct = True
  if not is_struct:  
    _line_break = False
    show_str(a)
  elif type(a) == tuple:
    _line_break = False
    show_str("(")
    for e in a:
      if b0:
        show_str(",")
      else:
        b0 = True
      show(e)
    show_str(")")
  elif type(a) == dict:
    if _line_break:
      for i in range(_space_count):
        show_str(" ")
    show_str("{")
    _line_break = False
    for e in a.items():
      if b0:
        if not _line_break:
          show_str(",")
      else:
        b0 = True
      _space_count += 1
      _line_break = False
      show_str("(") 
      show(e[0]) 
      show_str(":") 
      show(e[1]) 
      show_str(")")
      _space_count -= 1
    if _line_break:
      for i in range(_space_count):
        show_str(" ")
    show_str("}\n")
    _line_break = True
    _addchar = False
  elif type(a) == list or type(a) == set:
    if _line_break:
      for i in range(_space_count):
        show_str(" ")
    if type(a) == list:    
      show_str("[")
    else:  
      show_str("{")
    _line_break = False
    for e in a:
      if b0:
        if not _line_break:
          show_str(",")
      else:
        b0 = True
      _space_count += 1
      show(e)
      _space_count -= 1
    if _line_break:
      for i in range(_space_count):
        show_str(" ")
    if type(a) == list:    
      show_str("]\n")
    else:  
      show_str("}\n")
    _line_break = True
    _addchar = False
  for e in b:
    show(e)

def show_line(*a): # ver.4.19
  global _line_break
  global _addchar
  _line_break = False
  if a != ():
    for e in a:
      show(e)
  if not _line_break:    
    show_str('\n')
    _addchar = False

def runloader_(name):
    ptpath = ""
    try:
        with open(".pt\\ptpath.dat", "r") as f:
            ptpath = f.readline().strip()
    except FileNotFoundError:
        print("LOADER ERROR: file .pt\\ptpath.dat not found")
        exit(3)
    
    if not ptpath:
        print("LOADER ERROR: path to pt5run.exe not found")
        exit(3)
    
    ptpath = ptpath.rstrip('\n').rstrip(' ')
    command = f"{ptpath} {name} py -Eptprj.exe"
    os.system(command)
    exit(0)

def task(name):
  global _psize
  global _useddata
  if _psize != -1:
    return
  try:
    f = open(".pt\\pt5inf0.dat", "r")
    ver = int(f.readline())
    if ver == 20:
      _psize = int(f.readline())
      _useddata = int(f.readline())
      f.close()
      init_()
    else:
      f.close()
      print("ERROR: wrong version of Programming Taskbook")
    removefile(".pt\\pt5inf0.dat")
  except:
    runloader_(name)


#void raisePT(const char *msg, const char *addInfo)
#{
#   string s = "Run-time error: ";
#   s += msg;
#   error_((s + "\n").c_str(), "E");
#}

#raisept(ex.__class__.__name__, str(ex))


def get():
    global _idatacount
    res = 0

    if _psize < 1:
        print(_NoTaskCallMsg)
        sys.exit(1)
    
    if _idatacount == _nidata:
        error_(_TooManyInputMsg, "4")
        sys.exit(1)
    
    data = _idata[_idatacount]

    if data.id in ['b', 'i']:
        res = int(data.r)
    elif data.id == 'r':
        res = data.r
    elif data.id == 'c':
        res = data.s[0]
    elif data.id == 's':
        res = data.s
    
    _idatacount += 1
    
    if _idatacount < _useddata:
       error_(_NotAllInputMsg, "3")
    elif _idatacount >= _useddata:
       os.remove(_errdat)
    return res

def get_data(expected_type):
    if expected_type != _idata[_idatacount].id:
        error_(_WrongTypeInputMsg, "5")
        sys.exit(1)
    return get()

def get_bool():
    return get_data('b')

def get_int():
    return get_data('i')

def get_float():
    return get_data('r')

def get_str():
    return get_data('s')

def get_char():
    return get_data('c')

def get2():  # ver.4.19
  return (get(), get())

def get3():
  return (get(), get(), get())

def get4():  # ver.4.19
  return (get(), get(), get(), get())

def get5():  # ver.4.19
  return (get(), get(), get(), get(), get())

def get_list(n = -1):
  if type(n) != int:
    raise ValueError("get_list(n): wrong value for the n parameter (" + str(n) + ")")
  if (n < 0):
    n = get_int()
  return [get() for i in range(n)]

def get_matr(m = -1, n = -1):  
  if type(m) != int:
    raise ValueError("get_matr(m,n): wrong value for the m parameter (" + str(m) + ")")
  if type(n) != int:
    raise ValueError("get_matr(m,n): wrong value for the n parameter (" + str(n) + ")")
  if (n < 0):
    n = m
  if (m < 0):
    m, n = get_int, get_int()
  return [[get() for j in range(n)] for i in range(m)]

def get_Node():
   pass

def put(a, *b):
    if _psize < 1:
        print(_NoTaskCallMsg)
        sys.exit(1)
    
    with open(_outdat, "a") as f:
        def write_type_and_value(val):
            if isinstance(val, (int, bool)):
                f.write(f"{'i' if isinstance(val, int) else 'b'}\n{int(val)}\n")
            elif isinstance(val, float):
                f.write(f"r\n{float(val)}\n")
            elif isinstance(val, str):
                f.write(f"s\n{val}\n")
            elif isinstance(val, (list, tuple)):
                for e in val:
                    put(e)
            else:
                raise ValueError("Unsupported type")
        
        write_type_and_value(a)
        for item in b:
            write_type_and_value(item)

    # shutil.copy(_outdat, "C:\\Users\\artem\\Desktop\\1pt5out0.dat")

def SetPrecision(n):
    global _Precision
    if abs(n) <= 16:
        _Precision = n

def SetWidth(n):
    global _Width
    if 0 <= n <= 100:
        _Width = n

def SetW(n):
    global _Width1
    if 0 <= n <= 100:
        _Width1 = n


def start(solve):
    try:
      solve()
    except Exception as ex:
      error_(ex.__class__.__name__ + ': ' + str(ex) + '\n', "E") 
      raise
