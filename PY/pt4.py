# ver.4.22
import ctypes, sys, os

try:
  _pt4dll = ctypes.WinDLL('PT4.dll')
except:
  _pt4dll = ctypes.WinDLL(os.environ['WINDIR'] + '\\xPT4.dll')

_Nodes = {}

_Precision = 2

_Width = 0

_stdin, _stdout = sys.stdin, sys.stdout # ver.4.14

_line_break = False

_space_count = 0

class Node(object):
  _a_wait = 0

  def __init__(self, data = 0, next = None, prev = None):
    if Node._a_wait == 0:
      p = ctypes.c_int(0)
      if type(data) != int:
        raise ValueError("Node: wrong value for the Data property")
      p_next = 0
      if isinstance(next, Node):
        p_next = next._a
      elif next != None:
        raise ValueError("Node: wrong value for the Next property")
      p_prev = 0
      if isinstance(prev, Node):
        p_prev = prev._a
      elif prev != None:
        raise ValueError("Node: wrong value for the Prev property")
      _pt4dll.nodenew(ctypes.byref(p), data, p_next, p_prev, 0, 0, 0)
      self._a = p.value
    else:
      self._a = Node._a_wait
      Node._a_wait = 0
    _Nodes[self._a] = self
    self.__disposed = False

  @property
  def Data(self):
    if self.__disposed:
      raise ReferenceError("Node: cannot access a disposed Node")
    val = ctypes.c_int(0)
    err = ctypes.c_int(0)
    _pt4dll.nodegetf(self._a, 0, ctypes.byref(val), ctypes.byref(err))
    if err.value != 0:
      raise ReferenceError("Node: cannot get the Data property")
    return val.value

  @Data.setter
  def Data(self,value):
    if self.__disposed:
      raise ReferenceError("Node: cannot access a disposed Node")
    if type(value) != int:
      raise ValueError("Node: wrong value for the Data property")
    err = ctypes.c_int(0)
    _pt4dll.nodesetf(self._a, 0, value, ctypes.byref(err))
    if err.value != 0:
      raise ReferenceError("Node: cannot set the Data property")

  def _getNodeProp(self,n,name):
    if self.__disposed:
      raise ReferenceError("Node: cannot access a disposed Node")
    val = ctypes.c_int(0)
    err = ctypes.c_int(0)
    _pt4dll.nodegetf(self._a, n, ctypes.byref(val), ctypes.byref(err))
    if err.value != 0:
      raise ReferenceError("Node: cannot get the "+name+" property")
    p = val.value
    if p == 0:
      return None
    elif p in _Nodes:
      return _Nodes[p]
    else:
      Node._a_wait = p
      return Node()

  def _setNodeProp(self,n,name,value):
    if self.__disposed:
      raise ReferenceError("Node: cannot access a disposed Node")
    err = ctypes.c_int(0)
    if value == None:
      _pt4dll.nodesetf(self._a, n, 0, ctypes.byref(err))
    elif isinstance(value, Node):
      _pt4dll.nodesetf(self._a, n, value._a, ctypes.byref(err))
    else:
      raise ValueError("Node: wrong value for the "+name+" property")
    if err.value != 0:
      raise ReferenceError("Node: cannot set the "+name+" property")

  @property
  def Next(self):
    return self._getNodeProp(1,"Next")

  @Next.setter
  def Next(self, value):
    self._setNodeProp(1,"Next",value)

  @property
  def Prev(self):
    return self._getNodeProp(2,"Prev")

  @Prev.setter
  def Prev(self, value):
    self._setNodeProp(2,"Prev",value)

  @property
  def Left(self):
    return self._getNodeProp(3,"Left")

  @Left.setter
  def Left(self, value):
    self._setNodeProp(3,"Left",value)

  @property
  def Right(self):
    return self._getNodeProp(4,"Right")

  @Right.setter
  def Right(self, value):
    self._setNodeProp(4,"Right",value)

  @property
  def Parent(self):
    return self._getNodeProp(5,"Parent")

  @Parent.setter
  def Parent(self, value):
    self._setNodeProp(5,"Parent",value)

  def dispose(self):
    if self.__disposed:
      return
    err = ctypes.c_int(0)
    _pt4dll.nodedispose(self._a, ctypes.byref(err))
    if err.value != 0:
      raise ValueError("Node: cannot dispose the Node instance")
    self.__disposed = True

  @staticmethod
  def for_tree(data = 0, left = None, right = None, parent = None):
    a = Node(data)
    a.Left = left
    a.Right = right
    a.Parent = parent
    return a

def resetio():  # ver.4.14
    global _stdin, _stdout
    if sys.stdin != _stdin:
        sys.stdin.close()
        sys.stdin = _stdin
    if sys.stdout != _stdout:
        sys.stdout.close()
        sys.stdout = _stdout

def _check():
  resetio()  # ver.4.14
  arg1 = ctypes.create_string_buffer(300)
  arg2 = ctypes.c_int(0)
  _pt4dll.checkpt(arg1,ctypes.byref(arg2))
  res = _pt4dll.finishpt()
  if res == 1:
    if sys.version[0] == '2':
      print(arg1.value.decode('CP1251').replace('\r', ''))
    else:
      print(arg1.value.decode('CP1251').replace('\r', ''))
  _pt4dll.freept()
  return res

def start(solve):
  global _Nodes
  for i in range(10):
    opt = 262144
    if sys.version[0] == '2':
      opt += 4194304
    _pt4dll.startpt(opt)
    _Nodes = {}
    try:
      solve()
    except Exception as ex:
      if sys.version[0] == '2':
        _pt4dll.raisept(ex.__class__.__name__, str(ex))
      else:
        _pt4dll.raisept(ex.__class__.__name__.encode('CP1251'), str(ex).encode('CP1251'))
      _check()
      raise
    if _check() == 1:
      break

def task(s):
  if sys.version[0] == '2':
    _pt4dll.task(s)
  else:
    _pt4dll.task(s.encode('CP1251'))

def get_bool():
  arg = ctypes.c_int(0)
  _pt4dll.getb(ctypes.byref(arg))
  return bool(arg.value)

def get_int():
  arg = ctypes.c_int(0)
  _pt4dll.getn(ctypes.byref(arg))
  return arg.value

def get_float():
  arg = ctypes.c_double(0.0)
  _pt4dll.getr(ctypes.byref(arg))
  return arg.value

def get_str():
  arg = ctypes.create_string_buffer(80)
  _pt4dll.gets(ctypes.byref(arg))
  if sys.version[0] == '2':
    return arg.value
  else:
    return arg.value.decode('CP1251')

def get_Node():
  arg = ctypes.c_int(0)
  _pt4dll.nodegetp(ctypes.byref(arg))
  p = arg.value
  if p == 0:
    return None
  elif p in _Nodes:
    return _Nodes[p]
  else:
    Node._a_wait = p
    return Node()

def get():
  n = _pt4dll.nextdatatype()
  if n == 0:
    return get_int()
  elif n == 1:
    return get_float()
  elif n == 2:
    return get_bool()
  elif n == 5:
    return get_Node()
  else:
    return get_str()

def get2():  # ver.4.19
  return (get(), get())

def get3():
  return (get(), get(), get())

def get4():  # ver.4.19
  return (get(), get(), get(), get())

def get5():  # ver.4.19
  return (get(), get(), get(), get(), get())

def get_list(n = -1):  # ver.4.19
  if type(n) != int:
    raise ValueError("get_list(n): wrong value for the n parameter (" + str(n) + ")")
  if (n < 0):
    n = get_int()
  return [get() for i in range(n)]

def get_matr(m = -1, n = -1):  # ver.4.19
  if type(m) != int:
    raise ValueError("get_matr(m,n): wrong value for the m parameter (" + str(m) + ")")
  if type(n) != int:
    raise ValueError("get_matr(m,n): wrong value for the n parameter (" + str(n) + ")")
  if (n < 0):
    n = m
  if (m < 0):
    m, n = get_int(), get_int()
  return [[get() for j in range(n)] for i in range(m)]

def put(a, *b):
  if isinstance(a, float):
    _pt4dll.putr(ctypes.c_double(a))
  elif type(a) == int:
    _pt4dll.putn(ctypes.c_int(a))
  elif a == None:
    _pt4dll.nodeputp(ctypes.c_int(0))
  elif isinstance(a, Node):
    _pt4dll.nodeputp(ctypes.c_int(a._a))
  elif type(a) == bool:
    _pt4dll.putb(ctypes.c_int(int(a)))
  elif isinstance(a, str):
    if sys.version[0] == '2':
      _pt4dll.puts(ctypes.c_char_p(a))
    else:
      _pt4dll.puts(ctypes.c_char_p(a.encode('CP1251')))
  elif type(a) == tuple or type(a) == list:
    for e in a:
      put(e)
  else:
    raise ValueError("the put function has an argument of invalid type: "\
      + a.__class__.__name__)
  for e in b:
    put(e)

def show_str(a):
  if sys.version[0] == '2':
    _pt4dll.show(str(a))
  else:
    _pt4dll.show(str(a).encode('utf-8'))
  
def show(a, *b): # ver.4.19
  global _Width
  global _Precision
  global _line_break
  global _space_count
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
  for e in b:
    show(e)

def show_line(*a): # ver.4.19
  global _line_break
  _line_break = False
  if a != ():
    for e in a:
      show(e)
  if not _line_break:    
    show_str('\n')

def hide_task():
  _pt4dll.hidetask()

def set_precision(d):
  global _Precision
  if type(d) == int:
    _Precision = d
  
def set_width(w):
  global _Width
  if type(w) == int and w >= 0:
    _Width = w
  
