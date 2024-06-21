{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y-,Z1}
{$mode delphi}{$H+}
{$WARNINGS OFF}

/// Конструктор для электронного задачника Programming Taskbook 5.1
unit PT5TaskMaker;

//------------------------------------------------------------------------------
// Конструктор для электронного задачника Programming Taskbook 5.1
//------------------------------------------------------------------------------
// Модуль для создания динамических библиотек с группами заданий 
//   в системе Turbo Delphi и Free Pascal Lazarus
//
// Copyright (c) 2009-2024 М.Э.Абрамян
// Электронный задачник Programming Taskbook Copyright (c) М.Э.Абрамян,1998-2024
//------------------------------------------------------------------------------

interface

const

  xCenter = 0;
  xLeft   = 100;
  xRight  = 200;

  SampleError = '#ERROR?';
  MaxLineCount = 50;

  lgPascal       = $0000001; 
  lgPascalABCNET = $0000401; 
  lgPascalNET    = $0000400;
  lgPascalABCNET_flag 
                 = $0000400; // добавлено в версии 4.14
  lgVB           = $0000002;
  lgCPP          = $0000004;
  lg1C           = $0000040;
  lgPython       = $0000080; 
  lgPython3      = $1000080; // добавлено в версии 4.14
  lgPython3_flag = $1000000; // добавлено в версии 4.14
  lgCS           = $0000100;
  lgVBNET        = $0000200;
  lgJava         = $0010000; // добавлено в версии 4.11
  lgRuby         = $0020000; // добавлено в версии 4.12
  lgWithPointers = $000003D;
  lgWithObjects  = $0FFFF80; // изменено в версии 4.22
  lgNET          = $000FF00;
  lgAll          = $0FFFFFF; // изменено в версии 4.10
  lgFS           = $0000800; // добавлено в версии 4.19
  lgJulia        = $0040000; // добавлено в версии 4.22
  lgC            = $0000008; // добавлено в версии 4.23

type

/// Процедурный тип, используемый при создании групп заданий
  TInitTaskProc = procedure(N: integer); stdcall;

//2024.04>
(*
/// Указатель на узел динамической структуры
  PNode = ^TNode;

/// Узел динамической структуры
  TNode = record
    Data: integer;
    Next: PNode;
    Prev: PNode;
    Left: PNode;
    Right: PNode;
    Parent: PNode;
  end;
*)
//2024.04<

//2024.04>
// --------------------------------------------------------------------
// Функции, добавленные в конструктор версии 5

/// Устанавливает базовые настройки группы
procedure SetGroupData(topic, descr, author, key: string; n: integer);

/// Сбрасывает настройки, установленные для предыдущей группы
procedure ClearGroupData;

/// Возвращает имя группы заданий
function GetTopic: string;

/// Возвращает количество заданий в группе
function GetTaskCount: integer;

/// Устанавливает номер задания и номер теста;
/// возвращает имя текущей группы заданий в верхнем регистре
function SetTaskData(task, test: integer): string;

/// Возвращает количество тестовых испытаний для текущего задания
function GetTestCount: integer;

/// Возвращает код для текущей группы
function GetCode: string;

/// Устанавливает язык для выполняемого задания
procedure SetLanguage(n: integer);

/// Отменяет немедленное удаление файла с контрольными данными
/// после его подключения к заданию
/// (тем не менее, при вызове функции Pause, в конце формирования задания,
/// все такие файлы обязательно удаляются)
procedure NoEraseNextFile;

/// Задает количество элементов двоичного файла, отображаемых на одной строке,
/// если требуется изменить количество, определяемое по умолчанию
procedure SetFileRow(N: integer);

/// Задает количество элементов двоичного файла, отображаемых на одной строке,
/// если требуется изменить количество, определяемое по умолчанию
/// (используется для базовых групп)
procedure SetFileItemsInLine(N: integer);

/// Данная функция должна вызываться после завершения формирования задания
procedure Pause;

/// Добавляет к задачнику новую группу заданий с указанными характеристиками
/// (используется для базовых групп)
procedure Start(name, topic, author, key: string; lvl: integer);

/// Обеспечивает дополнительную настройку задания (используется для базовых групп)
procedure getVariant(code,nv1,nv2,nv3 : byte; var v1,v2,v3 : byte);

/// Возвращает порядковый номер текущего тестового запуска
/// (учитываются только успешные тестовые запуски). Если ранее успешных
/// запусков не было, то возвращает 1. Если задание уже выполнено
/// или запущено в демонстрационном режиме, то возвращает 0.
/// (синоним CurrentTest; используется для базовых групп)
function curtest: integer;

/// Задает число исходных данных, минимально необходимое
/// для нахождения правильных результирующих данных
/// (синоним SetRequiredDataCount; используется для базовых групп)
procedure SetNumberOfUsedData(n: integer);

/// Задает число тестовых испытаний (от 2 до 9), при успешном
/// прохождении которых задание будет считаться выполненным
/// (синоним SetTestCount; используется для базовых групп)
procedure SetNumberOfTests(n: integer);




// --------------------------------------------------------------------
//2024.04<


/// Добавляет к задачнику новую группу заданий с указанными характеристиками
procedure CreateGroup(GroupName, GroupDescription, GroupAuthor, GroupKey: string;
  TaskCount: integer; InitTaskProc: TInitTaskProc);

/// Добавляет к создаваемой группе задание из другой группы
procedure UseTask(GroupName: string; TaskNumber: integer); //overload; //2024.04

//2024.04>
(*
/// Добавляет к создаваемой группе задание из другой группы
procedure UseTask(GroupName: string; TaskNumber: integer; TopicDescription: string); overload;  // добавлено в версии 4.19
*)
//2024.04<

/// Должна указываться первой при определении нового задания
procedure CreateTask(SubgroupName: string); overload;

/// Должна указываться первой при определении нового задания
procedure CreateTask; overload;

/// Должна указываться первой при определении нового задания
/// (вариант для параллельного режима задачника)
procedure CreateTask(SubgroupName: string; var ProcessCount: integer); overload;

/// Должна указываться первой при определении нового задания
/// (вариант для параллельного режима задачника)
procedure CreateTask(var ProcessCount: integer); overload;

/// Позволяет определить текущий язык программирования, выбранный для задачника
/// Возвращает значения, связанные с константами lgXXX
function CurrentLanguage: integer;

//2024.04>
(*
/// Возвращает двухбуквенную строку с описанием текущей локали
/// (в даной версии возвращается либо 'ru', либо 'en')
function CurrentLocale: string;
*)
//2024.04<

/// Возвращает номер текущей версии задачника в формате 'd.dd'
/// (для версий, меньших 4.10, возвращает '4.00')
function CurrentVersion: string;  // добавлено в версии 4.10

//-----------------------------------------------------------------------------

/// Добавляет к формулировке задания строку
procedure TaskText(S: string; X, Y: integer); overload;

/// Определяет все строки формулировки задания
/// (в параметре S отдельные строки формулировки
/// должны разделяться символами #13, #10 или парой #13#10;
/// начальные и конечные пробелы в строках удаляются, 
/// пустые строки в формулировку не включаются)
procedure TaskText(S: string); overload; // добавлено в версии 4.11

//-----------------------------------------------------------------------------

/// Добавляет к исходным данным элемент логического типа с комментарием
procedure DataB(Cmt: string; B: boolean; X, Y: integer); overload;

/// Добавляет к исходным данным элемент логического типа
procedure DataB(B: boolean; X, Y: integer); overload; // добавлено в версии 4.11

/// Добавляет к исходным данным целочисленный элемент с комментарием
procedure DataN(Cmt: string; N: integer; X, Y, W: integer); overload;

/// Добавляет к исходным данным целочисленный элемент
procedure DataN(N: integer; X, Y, W: integer); overload; // добавлено в версии 4.11

/// Добавляет к исходным данным два целочисленных элемента с общим комментарием
procedure DataN2(Cmt: string; N1, N2: integer; X, Y, W: integer); overload;

/// Добавляет к исходным данным два целочисленных элемента
procedure DataN2(N1, N2: integer; X, Y, W: integer); overload; // добавлено в версии 4.11

/// Добавляет к исходным данным три целочисленных элемента с общим комментарием
procedure DataN3(Cmt: string; N1, N2, N3: integer; X, Y, W: integer); overload;

/// Добавляет к исходным данным три целочисленных элемента
procedure DataN3(N1, N2, N3: integer; X, Y, W: integer); overload; // добавлено в версии 4.11

/// Добавляет к исходным данным вещественный элемент с комментарием
procedure DataR(Cmt: string; R: real; X, Y, W: integer); overload;

/// Добавляет к исходным данным вещественный элемент
procedure DataR(R: real; X, Y, W: integer); overload; // добавлено в версии 4.11

/// Добавляет к исходным данным два вещественных элемента с общим комментарием
procedure DataR2(Cmt: string; R1, R2: real; X, Y, W: integer); overload;

/// Добавляет к исходным данным два вещественных элемента
procedure DataR2(R1, R2: real; X, Y, W: integer); overload; // добавлено в версии 4.11

/// Добавляет к исходным данным три вещественных элемента с общим комментарием
procedure DataR3(Cmt: string; R1, R2, R3: real; X, Y, W: integer); overload;

/// Добавляет к исходным данным три вещественных элемента
procedure DataR3(R1, R2, R3: real; X, Y, W: integer); overload; // добавлено в версии 4.11

/// Добавляет к исходным данным символьный элемент с комментарием
procedure DataC(Cmt: string; C: char; X, Y: integer); overload;

/// Добавляет к исходным данным символьный элемент
procedure DataC(C: char; X, Y: integer); overload; // добавлено в версии 4.11

/// Добавляет к исходным данным строковый элемент с комментарием
procedure DataS(Cmt: string; S: string; X, Y: integer); overload;

/// Добавляет к исходным данным строковый элемент
procedure DataS(S: string; X, Y: integer); overload; // добавлено в версии 4.11

(*
/// Добавляет к исходным данным элемент типа PNode с комментарием
procedure DataP(Cmt: string; NP: integer; X, Y: integer); overload;

/// Добавляет к исходным данным элемент типа PNode
procedure DataP(NP: integer; X, Y: integer); overload; // добавлено в версии 4.11
*)

/// Добавляет комментарий в область исходных данных
procedure DataComment(Cmt: string; X, Y: integer);

//-----------------------------------------------------------------------------

/// Добавляет к результирующим данным элемент логического типа с комментарием
procedure ResultB(Cmt: string; B: boolean; X, Y: integer); overload;

/// Добавляет к результирующим данным элемент логического типа
procedure ResultB(B: boolean; X, Y: integer); overload; // добавлено в версии 4.11

/// Добавляет к результирующим данным целочисленный элемент с комментарием
procedure ResultN(Cmt: string; N: integer; X, Y, W: integer); overload;

/// Добавляет к результирующим данным целочисленный элемент
procedure ResultN(N: integer; X, Y, W: integer); overload; // добавлено в версии 4.11

/// Добавляет к результирующим данным два целочисленных элемента с общим комментарием
procedure ResultN2(Cmt: string; N1, N2: integer; X, Y, W: integer); overload;

/// Добавляет к результирующим данным два целочисленных элемента
procedure ResultN2(N1, N2: integer; X, Y, W: integer); overload; // добавлено в версии 4.11

/// Добавляет к результирующим данным три целочисленных элемента с общим комментарием
procedure ResultN3(Cmt: string; N1, N2, N3: integer; X, Y, W: integer); overload;

/// Добавляет к результирующим данным три целочисленных элемента
procedure ResultN3(N1, N2, N3: integer; X, Y, W: integer); overload; // добавлено в версии 4.11

/// Добавляет к результирующим данным вещественный элемент с комментарием
procedure ResultR(Cmt: string; R: real; X, Y, W: integer); overload;

/// Добавляет к результирующим данным вещественный элемент
procedure ResultR(R: real; X, Y, W: integer); overload; // добавлено в версии 4.11

/// Добавляет к результирующим данным два вещественных элемента с общим комментарием
procedure ResultR2(Cmt: string; R1, R2: real; X, Y, W: integer); overload;

/// Добавляет к результирующим данным два вещественных элемента
procedure ResultR2(R1, R2: real; X, Y, W: integer); overload; // добавлено в версии 4.11

/// Добавляет к результирующим данным три вещественных элемента с общим комментарием
procedure ResultR3(Cmt: string; R1, R2, R3: real; X, Y, W: integer); overload;

/// Добавляет к результирующим данным три вещественных элемента
procedure ResultR3(R1, R2, R3: real; X, Y, W: integer); overload; // добавлено в версии 4.11

/// Добавляет к результирующим данным символьный элемент с комментарием
procedure ResultC(Cmt: string; C: char; X, Y: integer); overload;

/// Добавляет к результирующим данным символьный элемент
procedure ResultC(C: char; X, Y: integer); overload; // добавлено в версии 4.11

/// Добавляет к результирующим данным строковый элемент с комментарием
procedure ResultS(Cmt: string; S: string; X, Y: integer); overload;

/// Добавляет к результирующим данным строковый элемент
procedure ResultS(S: string; X, Y: integer); overload; // добавлено в версии 4.11

(*
/// Добавляет к результирующим данным элемент типа PNode с комментарием
procedure ResultP(Cmt: string; NP: integer; X, Y: integer); overload;

/// Добавляет к результирующим данным элемент типа PNode
procedure ResultP(NP: integer; X, Y: integer); overload; // добавлено в версии 4.11
*)

/// Добавляет комментарий в область результирующих данных
procedure ResultComment(Cmt: string; X, Y: integer);

//-----------------------------------------------------------------------------

/// Задает число дробных знаков при отображении вещественных чисел
procedure SetPrecision(N: integer);

/// Задает число исходных данных, минимально необходимое
/// для нахождения правильных результирующих данных
procedure SetRequiredDataCount(N: integer);

/// Задает число тестовых испытаний (от 2 до 9), при успешном
/// прохождении которых задание будет считаться выполненным
procedure SetTestCount(N: integer);

/// Возвращает горизонтальную координату, начиная с которой следует выводить I-й элемент из набора,
/// содержащего N элементов, при условии, что ширина каждого элемента равна W, а между элементами
/// надо указывать B пробелов (элементы нумеруются от 1)
function Center(I, N, W, B: integer): integer;

/// Возвращает псевдослучайное целое число, лежащее
/// в диапазоне от M до N включительно. Если указанный
/// диапазон пуст, то возвращает M.
function RandomN(M, N: integer): integer; // добавлено в версии 4.11

/// Возвращает псевдослучайное вещественное число, лежащее
/// на полуинтервале [A, B). Если указанный полуинтервал
/// пуст, то возвращает A.
function RandomR(A, B: real): real; // добавлено в версии 4.11

/// Возвращает псевдослучайное вещественное число, лежащее
/// на полуинтервале [A, B). Если указанный полуинтервал
/// пуст, то возвращает A.
function RandomR1(A, B: real): real; // добавлено в версии 4.11

/// Возвращает псевдослучайное вещественное число, лежащее
/// на полуинтервале [A, B). Если указанный полуинтервал
/// пуст, то возвращает A.
function RandomR2(A, B: real): real; // добавлено в версии 4.11

/// Возвращает порядковый номер текущего тестового запуска
/// (учитываются только успешные тестовые запуски). Если ранее успешных
/// запусков не было, то возвращает 1. Если задание уже выполнено
/// или запущено в демонстрационном режиме, то возвращает 0.
/// При использовании предыдущих версий задачника (до 4.10 включительно)
/// всегда возвращает 0.
function CurrentTest: integer; // добавлено в версии 4.11

//-----------------------------------------------------------------------------

/// Добавляет к исходным данным двоичный файл с целочисленными элементами (file of integer)
procedure DataFileN(FileName: string; Y, W: integer);

/// Добавляет к исходным данным двоичный файл с вещественными элементами (file of real)
procedure DataFileR(FileName: string; Y, W: integer);

/// Добавляет к исходным данным двоичный файл с символьными элементами (file of char)
procedure DataFileC(FileName: string; Y, W: integer);

/// Добавляет к исходным данным двоичный файл со строковыми элементами (file of ShortString)
procedure DataFileS(FileName: string; Y, W: integer);

/// Добавляет к исходным данным текстовый файл
procedure DataFileT(FileName: string; Y1, Y2: integer);

//-----------------------------------------------------------------------------

/// Добавляет к результирующим данным двоичный файл с целочисленными элементами (file of integer)
procedure ResultFileN(FileName: string; Y, W: integer);

/// Добавляет к результирующим данным двоичный файл с вещественными элементами (file of real)
procedure ResultFileR(FileName: string; Y, W: integer);

/// Добавляет к результирующим данным двоичный файл с символьными элементами (file of char)
procedure ResultFileC(FileName: string; Y, W: integer);

/// Добавляет к результирующим данным двоичный файл со строковыми элементами (file of ShortString)
procedure ResultFileS(FileName: string; Y, W: integer);

/// Добавляет к результирующим данным текстовый файл
procedure ResultFileT(FileName: string; Y1, Y2: integer);

//-----------------------------------------------------------------------------

//2024.04>
(*

/// Связывает номер NP с указателем P
procedure SetPointer(NP: integer; P: PNode);

/// Добавляет к исходным данным линейную динамическую структуру
procedure DataList(NP: integer; X, Y: integer);

/// Добавляет к результирующим данным линейную динамическую структуру
procedure ResultList(NP: integer; X, Y: integer);

/// Добавляет к исходным данным бинарное дерево
procedure DataBinTree(NP: integer; X, Y1, Y2: integer);

/// Добавляет к результирующим данным бинарное дерево
procedure ResultBinTree(NP: integer; X, Y1, Y2: integer);

/// Добавляет к исходным данным дерево общего вида
procedure DataTree(NP: integer; X, Y1, Y2: integer);

/// Добавляет к результирующим данным дерево общего вида
procedure ResultTree(NP: integer; X, Y1, Y2: integer);

/// Отображает в текущей динамической структуре указатель с номером NP
procedure ShowPointer(NP: integer);

/// Помечает в текущей результирующей динамической структуре указатель, требующий создания
procedure SetNewNode(NNode: integer);

/// Помечает в текущей исходной динамической структуре указатель, требующий удаления
procedure SetDisposedNode(NNode: integer);

*)
//2024.04<

//-----------------------------------------------------------------------------

//2024.04>
(*
/// Возвращает количество слов-образцов для языка, соответствующего текущей локали
function WordCount: integer;     //116

/// Возвращает количество предложений-образцов для языка, соответствующего текущей локали
function SentenceCount: integer; //61

/// Возвращает количество текстов-образцов для языка, соответствующего текущей локали
function TextCount: integer;     //85

/// Возвращает слово-образец с номером N (нумерация от 0) для языка, соответствующего текущей локали
function WordSample(N: integer): string;

/// Возвращает предложение-образец с номером N (нумерация от 0) для языка, соответствующего текущей локали
function SentenceSample(N: integer): string;

/// Возвращает текст-образец с номером N (нумерация от 0) для языка, соответствующего текущей локали,
/// между строками текста располагаются символы #13#10, в конце текста эти символы отсутствуют,
/// число строк не превышает MaxLineCount, между абзацами текста помещается одна пустая строка
function TextSample(N: integer): string;

*)
//2024.04<
//-----------------------------------------------------------------------------

/// Возвращает количество английских слов-образцов
function EnWordCount: integer;     //116

/// Возвращает количество английских предложений-образцов
function EnSentenceCount: integer; //61

/// Возвращает количество английских текстов-образцов
function EnTextCount: integer;     //85

/// Возвращает английское слово-образец с номером N (нумерация от 0)
function EnWordSample(N: integer): string;

/// Возвращает английское предложение-образец с номером N (нумерация от 0)
function EnSentenceSample(N: integer): string;

/// Возвращает английский текст-образец с номером N (нумерация от 0),
/// между строками текста располагаются символы #13#10, в конце текста эти символы отсутствуют,
/// число строк не превышает MaxLineCount, между абзацами текста помещается одна пустая строка
function EnTextSample(N: integer): string;

//-----------------------------------------------------------------------------

//2024.04>
(*

/// Добавляет строку комментария к текущей группе или подгруппе заданий
procedure CommentText(S: string);

/// Добавляет комментарий из другой группы заданий (или ее подгруппы,
/// если ее второй параметр не является пустой строкой)
procedure UseComment(GroupName, SubgroupName: string); overload;

/// Добавляет комментарий из другой группы заданий
procedure UseComment(GroupName: string); overload;

/// Устанавливает режим добавления комментария к подгруппе заданий
procedure Subgroup(SubgroupName: string);

//-----------------------------------------------------------------------------

/// Процедура, обеспечивающая отображение динамических структур данных
/// в "объектном стиле" при выполнении заданий в среде PascalABC.NET
/// (при использовании других сред не выполняет никаких действий)
procedure SetObjectStyle;

*)
//2024.04<

//-----------------------------------------------------------------------------

/// Процедура для внутреннего использования; должна вызываться
/// при инициализации любой динамической библиотеки с заданиями
procedure activate(DllName: string);

//-----------------------------------------------------------------------------

/// Устанавливает текущий процесс для последующей передачи ему данных 
/// числовых типов (при выполнении задания в параллельном режиме)
procedure SetProcess(ProcessRank: integer);


/// Добавляет строку комментария к текущей группе или подгруппе заданий
/// В данном конструкторе является заглушкой
procedure CommentText(S: string);

/// Устанавливает режим добавления комментария к подгруппе заданий
/// В данном конструкторе является заглушкой
procedure Subgroup(SubgroupName: string);

//-----------------------------------------------------------------------------

implementation

//uses Windows; //2024.04
















type
  TNFunc = function : integer; stdcall;
  TNFuncN4 = function (N1, N2, N3, N4: integer): integer; stdcall;
  TSFunc = function : PChar;
  TSFuncN = function (N: integer): PChar; stdcall;
  TProc = procedure; stdcall;
  TProcS = procedure (S: PChar); stdcall;
  TProcSCN2 = procedure (S: PChar; C: Char; N1, N2: integer); stdcall;
  TProcSN = procedure (S: PChar; N: integer); stdcall;
  TProcSN2 = procedure (S: PChar; N1, N2: integer); stdcall;
  TProcSN3 = procedure (S: PChar; N1, N2, N3: integer); stdcall;
  TProcSN4 = procedure (S: PChar; N1, N2, N3, N4: integer); stdcall;
  TProcSN5 = procedure (S: PChar; N1, N2, N3, N4, N5: integer); stdcall;
  TProcSN6 = procedure (S: PChar; N1, N2, N3, N4, N5, N6: integer); stdcall;
  TProcSRN3 = procedure (S: PChar; R: real; N1, N2, N3: integer); stdcall;
  TProcSR2N3 = procedure (S: PChar; R1, R2: real; N1, N2, N3: integer); stdcall;
  TProcSR3N3 = procedure (S: PChar; R1, R2, R3: real; N1, N2, N3: integer); stdcall;
  TProcS2 = procedure (S1, S2: PChar); stdcall;
  TProcS2N2 = procedure (S1, S2: PChar; N1, N2: integer); stdcall;
  TProcS4NP = procedure (S1, S2, S3, S4: PChar; N: integer; P: pointer); stdcall;
  TProcN = procedure (N: integer); stdcall;
  TProcNP = procedure (N: integer; P: pointer); stdcall;
  TProcN3 = procedure (N1, N2, N3: integer); stdcall;
  TProcN4 = procedure (N1, N2, N3, N4: integer); stdcall;
  TProcSvN = procedure (S: PChar; var N: integer); stdcall;
  TProcSNS = procedure (S1: PChar; N: integer; S2: PChar); stdcall;
//2024.04>
  TProcN2S = procedure (N1,N2: integer; S: PChar); stdcall;
  TNFuncN2 = function (N1,N2: integer): integer; stdcall;
  TRFuncR2 = function (N1,N2: real): real; stdcall;
  TProcNS = procedure (N: integer; S: PChar); stdcall;
  TProcS4N = procedure (S1, S2, S3, S4: PChar; N: integer); stdcall;
//2024.04>

var
  creategroup_: TProcS4NP;
  usetask_: TProcSN;
  createtask_: TProcS;
  currentlanguage_: TNFunc;
//  currentlocale_: TSFunc;
  tasktext_: TProcSN2;
  datab_, resultb_: TProcSN3;
  datan_, resultn_: TProcSN4;
  datan2_, resultn2_: TProcSN5;
  datan3_, resultn3_: TProcSN6;
  datar_, resultr_: TProcSRN3;
  datar2_, resultr2_: TProcSR2N3;
  datar3_, resultr3_: TProcSR3N3;
  datac_, resultc_: TProcSCN2;
  datas_, results_: TProcS2N2;
//  datap_, resultp_: TProcSN3;
  datacomment_, resultcomment_: TProcSN2;
  setprecision_, settestcount_, setrequireddatacount_: TProcN;
  center_: TNFuncN4;
  datafilen_, datafiler_, datafilec_, datafiles_, datafilet_: TProcSN2;
  resultfilen_, resultfiler_, resultfilec_, resultfiles_, resultfilet_: TProcSN2;
//  setpointer_: TProcNP;
//  datalist_, resultlist_: TProcN3;
//  databintree_, datatree_, resultbintree_, resulttree_: TProcN4;
//  showpointer_, setnewnode_, setdisposednode_: TProcN;
//  wordcount_, sentencecount_, textcount_: TNFunc;
  enwordcount_, ensentencecount_, entextcount_: TNFunc;
//  wordsample_, sentencesample_, textsample_: TSFuncN;
  enwordsample_, ensentencesample_, entextsample_: TProcNS; //2024.04 !!!!!
//  commenttext_: TProcS;
//  usecomment_: TProcS2;
//  subgroup_: TProcS;
//  setobjectstyle_: TProc;
  createtask2_: TProcSvN;
  setprocess_: TProcN;
  currentversion_: TSFunc; // добавлено в версии 4.10
  currenttest_: TNFunc; // добавлено в версии 4.11
//  usetaskex_: TProcSNS; // добавлено в версии 4.19


//2024.04> // функции, добавленные в версии 5
  cleargroupdata_: TProc;
  gettopic_: TProcS;
  gettaskcount_: TNFunc;
  settaskdata_: TProcN2S;
  gettestcount_: TNFunc;
  getcode_: TProcS;
  setlanguage_: TProcN;
  noerasenextfile_: TProc;
  pause_: TProc;
  randomn_:   TNFuncN2;
  randomr_, randomr1_, randomr2_: TRFuncR2;
  tasktext0_: TProcS;
  start_: TProcS4N;
  getvariant_: TNFuncN4;
  setfileitemsinline_: TProcN;
  setgroupdata_: TProcS4N;
//2024.04<



  FHandle: THandle;
  var cnt : integer = 0;

function GetProcAddress1(h: THandle; s: string): pointer;
begin
  result := GetProcAddress(h, s);
  if result = nil then
    writeln('Not found: ', s);
end;

procedure activate(DllName: string);
begin
  FHandle := LoadLibrary(DllName);
  creategroup_ := GetProcAddress1(FHandle, 'creategroup');
  usetask_ := GetProcAddress1(FHandle, 'usetask');
  createtask_ := GetProcAddress1(FHandle, 'createtask');
  currentlanguage_ := GetProcAddress1(FHandle, 'currentlanguage');
//  currentlocale_ := GetProcAddress1(FHandle, 'currentlocale');
  tasktext_ := GetProcAddress1(FHandle, 'tasktext');
  datab_ := GetProcAddress1(FHandle, 'datab');
  datan_ := GetProcAddress1(FHandle, 'datan');
  datan2_ := GetProcAddress1(FHandle, 'datan2');
  datan3_ := GetProcAddress1(FHandle, 'datan3');
  datar_ := GetProcAddress1(FHandle, 'datar');
  datar2_ := GetProcAddress1(FHandle, 'datar2');
  datar3_ := GetProcAddress1(FHandle, 'datar3');
  datac_ := GetProcAddress1(FHandle, 'datac');
  datas_ := GetProcAddress1(FHandle, 'datas');
//  datap_ := GetProcAddress1(FHandle, 'datap');
  datacomment_ := GetProcAddress1(FHandle, 'datacomment');
  resultb_ := GetProcAddress1(FHandle, 'resultb');
  resultn_ := GetProcAddress1(FHandle, 'resultn');
  resultn2_ := GetProcAddress1(FHandle, 'resultn2');
  resultn3_ := GetProcAddress1(FHandle, 'resultn3');
  resultr_ := GetProcAddress1(FHandle, 'resultr');
  resultr2_ := GetProcAddress1(FHandle, 'resultr2');
  resultr3_ := GetProcAddress1(FHandle, 'resultr3');
  resultc_ := GetProcAddress1(FHandle, 'resultc');
  results_ := GetProcAddress1(FHandle, 'results');
//  resultp_ := GetProcAddress1(FHandle, 'resultp');
  resultcomment_ := GetProcAddress1(FHandle, 'resultcomment');
  setprecision_ := GetProcAddress1(FHandle, 'setprecision');
  settestcount_ := GetProcAddress1(FHandle, 'settestcount');
  setrequireddatacount_ := GetProcAddress1(FHandle, 'setrequireddatacount');
  center_ := GetProcAddress1(FHandle, 'center');
  datafilen_ := GetProcAddress1(FHandle, 'datafilen');
  datafiler_ := GetProcAddress1(FHandle, 'datafiler');
  datafilec_ := GetProcAddress1(FHandle, 'datafilec');
  datafiles_ := GetProcAddress1(FHandle, 'datafiles');
  datafilet_ := GetProcAddress1(FHandle, 'datafilet');
  resultfilen_ := GetProcAddress1(FHandle, 'resultfilen');
  resultfiler_ := GetProcAddress1(FHandle, 'resultfiler');
  resultfilec_ := GetProcAddress1(FHandle, 'resultfilec');
  resultfiles_ := GetProcAddress1(FHandle, 'resultfiles');
  resultfilet_ := GetProcAddress1(FHandle, 'resultfilet');
//  setpointer_ := GetProcAddress1(FHandle, 'setpointer');
//  datalist_ := GetProcAddress1(FHandle, 'datalist');
//  resultlist_ := GetProcAddress1(FHandle, 'resultlist');
//  databintree_ := GetProcAddress1(FHandle, 'databintree');
//  datatree_ := GetProcAddress1(FHandle, 'datatree');
//  resultbintree_ := GetProcAddress1(FHandle, 'resultbintree');
//  resulttree_ := GetProcAddress1(FHandle, 'resulttree');
//  showpointer_ := GetProcAddress1(FHandle, 'showpointer');
//  setnewnode_ := GetProcAddress1(FHandle, 'setnewnode');
//  setdisposednode_ := GetProcAddress1(FHandle, 'setdisposednode');
//  wordcount_ := GetProcAddress1(FHandle, 'wordcount');
//  sentencecount_ := GetProcAddress1(FHandle, 'sentencecount');
//  textcount_ := GetProcAddress1(FHandle, 'textcount');
//  wordsample_ := GetProcAddress1(FHandle, 'wordsample');
//  sentencesample_ := GetProcAddress1(FHandle, 'sentencesample');
//  textsample_ := GetProcAddress1(FHandle, 'textsample');
  enwordcount_ := GetProcAddress1(FHandle, 'enwordcount');
  ensentencecount_ := GetProcAddress1(FHandle, 'ensentencecount');
  entextcount_ := GetProcAddress1(FHandle, 'entextcount');
  enwordsample_ := GetProcAddress1(FHandle, 'enwordsample');
  ensentencesample_ := GetProcAddress1(FHandle, 'ensentencesample');
  entextsample_ := GetProcAddress1(FHandle, 'entextsample');
//  commenttext_ := GetProcAddress1(FHandle, 'commenttext');
//  usecomment_ := GetProcAddress1(FHandle, 'usecomment');
//  subgroup_ := GetProcAddress1(FHandle, 'subgroup');
//  setobjectstyle_ := GetProcAddress1(FHandle, 'setobjectstyle');
  createtask2_ := GetProcAddress1(FHandle, 'createtask2');
  setprocess_ := GetProcAddress1(FHandle, 'setprocess');
  currentversion_ := GetProcAddress1(FHandle, 'currentversion'); // добавлено в версии 4.10
  currenttest_ := GetProcAddress1(FHandle, 'curt'); // добавлено в версии 4.11
//  usetaskex_ := GetProcAddress1(FHandle, 'usetaskex'); // добавлено в версии 4.19  //2024.04

//2024.04>
  cleargroupdata_:= GetProcAddress1(FHandle, 'cleargroupdata');
  gettopic_:= GetProcAddress1(FHandle, 'gettopic');
  gettaskcount_:= GetProcAddress1(FHandle, 'gettaskcount');
  settaskdata_:= GetProcAddress1(FHandle, 'settaskdata');
  gettestcount_:= GetProcAddress1(FHandle, 'gettestcount');
  getcode_:= GetProcAddress1(FHandle, 'getcode');
  setlanguage_:= GetProcAddress1(FHandle, 'setlanguage');
  pause_:= GetProcAddress1(FHandle, 'pause');
  randomn_:= GetProcAddress1(FHandle, 'randomn');
  randomr_:= GetProcAddress1(FHandle, 'randomr');
  randomr1_:= GetProcAddress1(FHandle, 'randomr1');
  randomr2_:= GetProcAddress1(FHandle, 'randomr2');
  tasktext0_:= GetProcAddress1(FHandle, 'tasktext0');
  start_:= GetProcAddress1(FHandle, 'start');
  getvariant_:= GetProcAddress1(FHandle, 'getvariant');
  noerasenextfile_:= GetProcAddress1(FHandle, 'noerasenextfile');
  setfileitemsinline_:= GetProcAddress1(FHandle, 'setfileitemsinline');
  setgroupdata_:= GetProcAddress1(FHandle, 'setgroupdata');
//2024.04<

end;

//=============================================================================



procedure CreateGroup(GroupName, GroupDescription, GroupAuthor, GroupKey: string;
  TaskCount: integer; InitTaskProc: TInitTaskProc);
begin
  creategroup_(PChar(GroupName), PChar(GroupDescription), PChar(GroupAuthor),
    PChar(GroupKey), TaskCount, @InitTaskProc);
  Randomize;
end;

procedure UseTask(GroupName: string; TaskNumber: integer);
begin
  usetask_(PChar(GroupName), TaskNumber);
end;

//2024.04>
(*
procedure UseTask(GroupName: string; TaskNumber: integer; TopicDescription: string);
begin
  if Assigned(usetaskex_) then
    usetaskex_(PChar(GroupName), TaskNumber, PChar(TopicDescription))
  else  
    usetask_(PChar(GroupName), TaskNumber);
end;
*)
//2024.04<

procedure CreateTask(SubgroupName: string);
begin
  createtask_(PChar(SubgroupName));
end;

procedure CreateTask;
begin
  CreateTask('');
end;

function CurrentLanguage: integer;
begin
  result := currentlanguage_;
end;

//2024.04>
(*
function CurrentLocale: string;
begin
  result := currentlocale_;
end;
*)
//2024.04<

procedure TaskText(S: string; X, Y: integer);
begin
  tasktext_(PChar(S), X, Y);
end;

function BtoN(B: boolean): integer;
begin
  if B then
    result := 1
  else
    result := 0;
end;

procedure DataB (Cmt: string; B: boolean; X, Y: integer);
begin
  datab_(PChar(Cmt), BtoN(B), X, Y);
end;

procedure DataB (B: boolean; X, Y: integer);
begin
  datab_('', BtoN(B), X, Y);
end;

procedure DataN (Cmt: string; N: integer; X, Y, W: integer);
begin
  datan_(PChar(Cmt), N, X, Y, W);
end;

procedure DataN (N: integer; X, Y, W: integer);
begin
  datan_('', N, X, Y, W);
end;

procedure DataN2(Cmt: string; N1, N2: integer; X, Y, W: integer);
begin
  datan2_(PChar(Cmt), N1, N2,  X, Y, W);
end;

procedure DataN2(N1, N2: integer; X, Y, W: integer);
begin
  datan2_('', N1, N2,  X, Y, W);
end;

procedure DataN3(Cmt: string; N1, N2, N3: integer; X, Y, W: integer);
begin
  datan3_(PChar(Cmt), N1, N2, N3, X, Y, W);
end;

procedure DataN3(N1, N2, N3: integer; X, Y, W: integer);
begin
  datan3_('', N1, N2, N3, X, Y, W);
end;

procedure DataR(Cmt: string; R: real; X, Y, W: integer);
begin
  datar_(PChar(Cmt), R, X, Y, W);
end;

procedure DataR(R: real; X, Y, W: integer);
begin
  datar_('', R, X, Y, W);
end;

procedure DataR2(Cmt: string; R1, R2: real; X, Y, W: integer);
begin
  datar2_(PChar(Cmt), R1, R2, X, Y, W);
end;

procedure DataR2(R1, R2: real; X, Y, W: integer);
begin
  datar2_('', R1, R2, X, Y, W);
end;

procedure DataR3(Cmt: string; R1, R2, R3: real; X, Y, W: integer);
begin
  datar3_(PChar(Cmt), R1, R2, R3, X, Y, W);
end;

procedure DataR3(R1, R2, R3: real; X, Y, W: integer);
begin
  datar3_('', R1, R2, R3, X, Y, W);
end;

procedure DataC(Cmt: string; C: char; X, Y: integer);
begin
  datac_(PChar(Cmt), C, X, Y);
end;

procedure DataC(C: char; X, Y: integer);
begin
  datac_('', C, X, Y);
end;

procedure DataS(Cmt: string; S: string; X, Y: integer);
begin
  datas_(PChar(Cmt), PChar(S), X, Y);
end;

procedure DataS(S: string; X, Y: integer);
begin
  datas_('', PChar(S), X, Y);
end;

(*
procedure DataP(Cmt: string; NP: integer; X, Y: integer);
begin
  datap_ (PChar(Cmt), NP, X, Y);
end;

procedure DataP(NP: integer; X, Y: integer);
begin
  datap_ ('', NP, X, Y);
end;
*)

procedure DataComment(Cmt: string; X, Y: integer);
begin
  datacomment_(PChar(Cmt), X, Y);
end;

procedure ResultB(Cmt: string; B: boolean; X, Y: integer);
begin
  resultb_(PChar(Cmt), BtoN(B), X, Y);
end;

procedure ResultB(B: boolean; X, Y: integer);
begin
  resultb_('', BtoN(B), X, Y);
end;

procedure ResultN(Cmt: string; N: integer; X, Y, W: integer);
begin
  resultn_(PChar(Cmt), N, X, Y, W);
end;

procedure ResultN(N: integer; X, Y, W: integer);
begin
  resultn_('', N, X, Y, W);
end;

procedure ResultN2(Cmt: string; N1, N2: integer; X, Y, W: integer);
begin
  resultn2_(PChar(Cmt), N1, N2, X, Y, W);
end;

procedure ResultN2(N1, N2: integer; X, Y, W: integer);
begin
  resultn2_('', N1, N2, X, Y, W);
end;

procedure ResultN3(Cmt: string; N1, N2, N3: integer; X, Y, W: integer);
begin
  resultn3_(PChar(Cmt), N1, N2, N3, X, Y, W);
end;

procedure ResultN3(N1, N2, N3: integer; X, Y, W: integer);
begin
  resultn3_('', N1, N2, N3, X, Y, W);
end;

procedure ResultR(Cmt: string; R: real; X, Y, W: integer);
begin
  resultr_(PChar(Cmt), R, X, Y, W);
end;

procedure ResultR(R: real; X, Y, W: integer);
begin
  resultr_('', R, X, Y, W);
end;

procedure ResultR2(Cmt: string; R1, R2: real; X, Y, W: integer);
begin
  resultr2_(PChar(Cmt), R1, R2, X, Y, W);
end;

procedure ResultR2(R1, R2: real; X, Y, W: integer);
begin
  resultr2_('', R1, R2, X, Y, W);
end;

procedure ResultR3(Cmt: string; R1, R2, R3: real; X, Y, W: integer);
begin
  resultr3_(PChar(Cmt), R1, R2, R3, X, Y, W);
end;

procedure ResultR3(R1, R2, R3: real; X, Y, W: integer);
begin
  resultr3_('', R1, R2, R3, X, Y, W);
end;

procedure ResultC(Cmt: string; C: char; X, Y: integer);
begin
  resultc_(PChar(Cmt), C, X, Y);
end;

procedure ResultC(C: char; X, Y: integer);
begin
  resultc_('', C, X, Y);
end;

procedure ResultS(Cmt: string; S: string; X, Y: integer);
begin
  results_(PChar(Cmt), PChar(S), X, Y);
end;

procedure ResultS(S: string; X, Y: integer);
begin
  results_('', PChar(S), X, Y);
end;

(*
procedure ResultP(Cmt: string; NP: integer; X, Y: integer);
begin
  resultp_(PChar(Cmt), NP, X, Y);
end;

procedure ResultP(NP: integer; X, Y: integer);
begin
  resultp_('', NP, X, Y);
end;
*)

procedure ResultComment(Cmt: string; X, Y: integer);
begin
  resultcomment_(PChar(Cmt), X, Y);
end;

procedure SetPrecision(N: integer);
begin
  setprecision_(N);
end;

procedure SetTestCount(N: integer);
begin
  settestcount_(N);
end;

procedure SetRequiredDataCount(N: integer);
begin
  setrequireddatacount_(N);
end;

function Center(I, N, W, B: integer): integer;
begin
  result := center_(I, N, W, B);
end;

procedure DataFileN(FileName: string; Y, W: integer);
begin
  datafilen_(PChar(FileName), Y, W);
end;

procedure DataFileR(FileName: string; Y, W: integer);
begin
  datafiler_(PChar(FileName), Y, W);
end;

procedure DataFileC(FileName: string; Y, W: integer);
begin
  datafilec_(PChar(FileName), Y, W);
end;

procedure DataFileS(FileName: string; Y, W: integer);
begin
  datafiles_(PChar(FileName), Y, W);
end;

procedure DataFileT(FileName: string; Y1, Y2: integer);
begin
  datafilet_(PChar(FileName), Y1, Y2);
end;

procedure ResultFileN(FileName: string; Y, W: integer);
begin
  resultfilen_(PChar(FileName), Y, W);
end;

procedure ResultFileR(FileName: string; Y, W: integer);
begin
  resultfiler_(PChar(FileName), Y, W);
end;

procedure ResultFileC(FileName: string; Y, W: integer);
begin
  resultfilec_(PChar(FileName), Y, W);
end;

procedure ResultFileS(FileName: string; Y, W: integer);
begin
  resultfiles_(PChar(FileName), Y, W);
end;

procedure ResultFileT(FileName: string; Y1, Y2: integer);
begin
  resultfilet_(PChar(FileName), Y1, Y2);
end;

//2024.04>
(*

procedure SetPointer(NP: integer; P: PNode);
begin
  setpointer_(NP, P);
end;

procedure DataList(NP: integer; X, Y: integer);
begin
  datalist_(NP, X, Y);
end;

procedure ResultList(NP: integer; X, Y: integer);
begin
  resultlist_(NP, X, Y);
end;

procedure DataBinTree(NP: integer; X, Y1, Y2: integer);
begin
  databintree_(NP, X, Y1, Y2);
end;

procedure ResultBinTree(NP: integer; X, Y1, Y2: integer);
begin
  resultbintree_(NP, X, Y1, Y2);
end;

procedure DataTree(NP: integer; X, Y1, Y2: integer);
begin
  datatree_(NP, X, Y1, Y2);
end;

procedure ResultTree(NP: integer; X, Y1, Y2: integer);
begin
  resulttree_(NP, X, Y1, Y2);
end;

procedure ShowPointer(NP: integer);
begin
  showpointer_(NP);
end;

procedure SetNewNode(NNode: integer);
begin
  setnewnode_(NNode);
end;

procedure SetDisposedNode(NNode: integer);
begin
  setdisposednode_(NNode);
end;

*)
//2024.04<

//2024.04>
(*

function WordCount: integer;
begin
  result := wordcount_;
end;

function SentenceCount: integer;
begin
  result := sentencecount_;
end;

function TextCount: integer;
begin
  result := textcount_;
end;

function WordSample(n: integer): string;
begin
  result := string(wordsample_(n));
end;

function SentenceSample(n: integer): string;
begin
  result := string(sentencesample_(n));
end;

function TextSample(n: integer): string;
begin
  result := string(textsample_(n));
end;

*)
//2024.04<

function EnWordCount: integer;
begin
  result := enwordcount_;
end;

function EnSentenceCount: integer;
begin
  result := ensentencecount_;
end;

function EnTextCount: integer;
begin
  result := entextcount_;
end;

function EnWordSample(n: integer): string;
var s: string;
begin
  SetLength(s, 20); // max = 14
  enwordsample_(n, PChar(s));
  result := PChar(s);
end;

function EnSentenceSample(n: integer): string;
var s: string;
begin
  SetLength(s, 100); // max = 76
  ensentencesample_(n, PChar(s));
  result := PChar(s);
end;

function EnTextSample(n: integer): string;
var s: string;
begin
  SetLength(s, 1100); // max = 1009
  entextsample_(n, PChar(s));
  result := PChar(s);
end;


//2024.04>
(*

procedure CommentText(S: string);
begin
  commenttext_(PChar(S));
end;

procedure UseComment(GroupName, SubgroupName: string);
begin
  usecomment_(PChar(GroupName), PChar(SubgroupName));
end;

procedure UseComment(GroupName: string);
begin
  UseComment(GroupName, '');
end;

procedure Subgroup(SubgroupName: string);
begin
  subgroup_(PChar(SubgroupName));
end;

procedure SetObjectStyle;
begin
  setobjectstyle_;
end;

*)
//2024.04<


procedure ShowError(S1, S2: string);
begin
  writeln(S1+#13#10'is not found '+
      'in the PT5 library.'#13#10'You should update '+
      'the Programming Taskbook to '+S2+' version.');
end;

procedure CreateTask(SubgroupName: string; var ProcessCount: integer);
begin
  if Assigned(createtask2_) then
    createtask2_(PChar(SubgroupName), ProcessCount)
  else
    ShowError('The CreateTask procedure with ProcessCount parameter', '4.9');
end;

procedure CreateTask(var ProcessCount: integer);
begin
  CreateTask('', ProcessCount);
end;

procedure SetProcess(ProcessRank: integer);
begin
  setprocess_(ProcessRank);
end;

function CurrentVersion: string;
begin
  result := currentversion_;
end;

function CurrentTest: integer;
begin
  result := currenttest_;
end;

function RandomN(M, N: integer): integer;
begin
  result := randomn_(M, N);
end;

function RandomR(A, B: real): real;
begin
  result := randomr_(A, B);
end;

function RandomR1(A, B: real): real;
begin
  result := randomr1_(A, B);
end;

function RandomR2(A, B: real): real;
begin
  result := randomr2_(A, B);
end;

//2024.04>
// -----------------------------------------------------------------

procedure SetGroupData(topic, descr, author, key: string; n: integer);
begin
  setgroupdata_(PChar(topic), PChar(descr), PChar(author), PChar(key), n);
end;

procedure ClearGroupData;
begin
  cleargroupdata_;
end;

function GetTopic: string;
var s: string;
begin
  SetLength(s, 20);
  gettopic_(PChar(s));
  result := PChar(s);
end;

function GetTaskCount: integer;
begin
  result := gettaskcount_;
end;

function SetTaskData(task, test: integer): string;
var s: string;
begin
  SetLength(s, 20);
  settaskdata_(task, test, PChar(s));
  result := PChar(s);
end;

function GetTestCount: integer;
begin
  result := gettestcount_;
end;

function GetCode: string;
var s: string;
begin
  SetLength(s, 20);
  getcode_(PChar(s));
  result := PChar(s);
end;

procedure SetLanguage(n: integer);
begin
  setlanguage_(n);
end;

procedure Pause;
begin
  pause_;
end;

procedure NoEraseNextFile;
begin
  noerasenextfile_;
end;

procedure SetFileItemsInLine(N: integer);
begin
  setfileitemsinline_(N);
end;

procedure SetFileRow(N: integer);
begin
  setfileitemsinline_(N);
end;

procedure TaskText(S: string);
begin
  tasktext0_(PChar(S));
end;

procedure SetNumberOfTests(n: integer);
begin
  settestcount_(n);
end;

procedure SetNumberOfUsedData(n: integer);
begin
  setrequireddatacount_(n);
end;

procedure Start(name, topic, author, key: string; lvl: integer);
begin
  start_(PChar(name), PChar(topic), PChar(author), PChar(key), lvl);
end;

procedure getVariant(code,nv1,nv2,nv3 : byte; var v1,v2,v3 : byte);
begin
  v1 := getvariant_(code, nv1, nv2, nv3);
  v2 := 0;
  v3 := 0;
end;

function curtest: integer;
begin
  result := currenttest_;
end;

procedure CommentText(S: string);
begin
  // ЗАГЛУШКА!!!
end;

/// Устанавливает режим добавления комментария к подгруппе заданий
procedure Subgroup(SubgroupName: string);
begin
  // ЗАГЛУШКА!!!
end;

// -----------------------------------------------------------------
//2024.04<



//{$IFNDEF FPC}
//exports activate;
//{$ENDIF}

initialization

finalization

  FreeLibrary(FHandle);

end.

