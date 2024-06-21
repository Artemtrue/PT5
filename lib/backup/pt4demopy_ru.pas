//unit PT4DemoPy_ru;
//
//{$MODE Delphi}
//
//interface
//
//procedure InitTask(num: integer); stdcall;
//procedure inittaskgroup;
//
//implementation
//
//uses SysUtils, PT5TaskMaker, Windows;
//
//const
//  DataInfoPath = 'datainfo.txt';
//  ResultInfoPath = 'resinfo.txt';
//  TaskInfoPath = 'taskinfo.txt';
//  GroupInfoPath = 'groupinfo.txt';
//  CommandPath = 'command.txt';
//
//procedure Command(num : integer);
//var
//  CommandFile : TextFile;
//begin
//  AssignFile(CommandFile, CommandPath);
//  Rewrite(CommandFile);
//  Write(CommandFile, num);
//  CloseFile(CommandFile);
//end;
//
//procedure CreateGroupFile;
//var
//  GroupFile : TextFile;
//  GroupName, GroupDescription, GroupAuthor, GroupKey : string;
//  TaskCount : Integer;
//begin
//  AssignFile(GroupFile, GroupInfoPath); 
//  Reset(GroupFile); 
//  ReadLn(GroupFile, GroupName);
//  ReadLn(GroupFile, GroupDescription);
//  ReadLn(GroupFile, GroupAuthor);
//  ReadLn(GroupFile, GroupKey);
//  ReadLn(GroupFile, TaskCount);
//  CloseFile(GroupFile); 
//
//  CreateGroup(GroupName, GroupDescription, GroupAuthor, GroupKey, TaskCount, InitTask);
//end;
//
//procedure TaskTextFile(var TaskFile : TextFile);
//var
//  Line : string;
//  x,y : integer;
//begin
//  ReadLn(TaskFile, Line);
//  ReadLn(TaskFile, x);
//  ReadLn(TaskFile, y);
//
//  TaskText(Line, x, y);
//end;
//
//procedure CreateTaskFile;
//var
//  TaskFile : TextFile;
//  Line : string;
//begin
//  AssignFile(TaskFile, TaskInfoPath); 
//  Reset(TaskFile); 
//  ReadLn(TaskFile, Line);
//  Writeln(Line);
//  CreateTask(Line);
//  while not Eof(TaskFile) do
//  begin
//    TaskTextFile(TaskFile);
//  end;
//  CloseFile(TaskFile);
//end;
//
//procedure DataBFile(var DataFile: TextFile);
//var
//  comm: string;
//  n: Integer;
//  b: Boolean;
//  x,y: Integer;
//begin
//  ReadLn(DataFile, comm);
//  ReadLn(DataFile, n);
//  if (n = 0) then b := false else b := true;
//  ReadLn(DataFile, x);
//  ReadLn(DataFile, y);
//  DataB(comm, b, x, y);
//end;
//
//procedure DataNFile(var DataFile: TextFile);
//var
//  comm: string;
//  n: Integer;
//  x,y,w: Integer;
//begin                     
//  ReadLn(DataFile, comm);
//  ReadLn(DataFile, n); 
//  ReadLn(DataFile, x);
//  ReadLn(DataFile, y);
//  ReadLn(DataFile, w);
//  DataN(comm, n, x, y, w);
//end;
//
//procedure DataRFile(var DataFile: TextFile);
//var
//  comm: string;
//  r: Real;
//  x,y,w: Integer;
//begin
//  ReadLn(DataFile, comm);
//  ReadLn(DataFile, r);
//  ReadLn(DataFile, x);
//  ReadLn(DataFile, y);
//  ReadLn(DataFile, w);
//  DataR(comm, r, x, y, w);
//end;
//
//procedure DataCFile(var DataFile: TextFile);
//var
//  comm: string;
//  c: Char;
//  x,y: Integer;
//begin
//  ReadLn(DataFile, comm);
//  ReadLn(DataFile, c);
//  ReadLn(DataFile, x);
//  ReadLn(DataFile, y);
//  DataC(comm, c, x, y);
//end;
//
//procedure DataSFile(var DataFile: TextFile);
//var
//  comm: string;
//  s: string;
//  x,y: Integer;
//begin
//  ReadLn(DataFile, comm);
//  ReadLn(DataFile, s);
//  ReadLn(DataFile, x);
//  ReadLn(DataFile, y);
//  DataS(comm, s, x, y);
//end;
//
//procedure DataFile;
//var
//  DataFile: TextFile;
//  Line: string;
//begin
//  AssignFile(DataFile, DataInfoPath);
//  Reset(DataFile);
//
//  while not Eof(DataFile) do
//  begin
//    ReadLn(DataFile, Line); 
//
//    //WriteLn(Line[1]);
//    // Добавить проверку, что Line[1] состоит из 1 символа, иначе это что-то другое
//    case Line[1] of
//      'b': DataBFile(DataFile);
//      'n': DataNFile(DataFile);
//      'r': DataRFile(DataFile);
//      'c': DataCFile(DataFile);
//      's': DataSFile(DataFile);
//    end;
//  end;
//
//  CloseFile(DataFile);
//end;
//
//procedure ResultBFile(var ResultFile: TextFile);
//var
//  comm: string;
//  n: Integer;
//  b: Boolean;
//  x,y: Integer;
//begin
//  ReadLn(ResultFile, comm);
//  ReadLn(ResultFile, n);
//  if (n = 0) then b := false else b := true;
//  ReadLn(ResultFile, x);
//  ReadLn(ResultFile, y);
//  ResultB(comm, b, x, y);
//end;
//
//procedure ResultNFile(var ResultFile: TextFile);
//var
//  comm: string;
//  n: Integer;
//  x,y,w: Integer;
//begin
//  ReadLn(ResultFile, comm);
//  ReadLn(ResultFile, n);
//  ReadLn(ResultFile, x);
//  ReadLn(ResultFile, y);
//  ReadLn(ResultFile, w);
//  ResultN(comm, n, x, y, w);
//end;
//
//procedure ResultRFile(var ResultFile: TextFile);
//var
//  comm: string;
//  r: Real;
//  x,y,w: Integer;
//begin
//  ReadLn(ResultFile, comm);
//  ReadLn(ResultFile, r);
//  ReadLn(ResultFile, x);
//  ReadLn(ResultFile, y);
//  ReadLn(ResultFile, w);
//  ResultR(comm, r, x, y, w);
//end;
//
//procedure ResultCFile(var ResultFile: TextFile);
//var
//  comm: string;
//  c: Char;
//  x,y: Integer;
//begin
//  ReadLn(ResultFile, comm);
//  ReadLn(ResultFile, c);
//  ReadLn(ResultFile, x);
//  ReadLn(ResultFile, y);
//  ResultC(comm, c, x, y);
//end;
//
//procedure ResultSFile(var ResultFile: TextFile);
//var
//  comm: string;
//  s: string;
//  x,y: Integer;
//begin
//  ReadLn(ResultFile, comm);
//  ReadLn(ResultFile, s);
//  ReadLn(ResultFile, x);
//  ReadLn(ResultFile, y);
//  ResultS(comm, s, x, y);
//end;
//
//procedure ResultFile;
//var
//  ResultFile: TextFile;
//  Line: string;
//begin
//  AssignFile(ResultFile, ResultInfoPath);
//  Reset(ResultFile);
//
//  while not Eof(ResultFile) do
//  begin
//    ReadLn(ResultFile, Line);
//
//    case Line[1] of
//      'b': ResultBFile(ResultFile);
//      'n': ResultNFile(ResultFile);
//      'r': ResultRFile(ResultFile);
//      'c': ResultCFile(ResultFile);
//      's': ResultSFile(ResultFile);
//    end;
//  end;
//
//  CloseFile(ResultFile);
//end;
//
//function GetPathPython(): string;
//var
//  fileStream: TextFile;
//  fileName: string;
//begin
//  fileName := '.pt/ptpath.dat';
//  AssignFile(fileStream, fileName);
//  Reset(fileStream);
//  ReadLn(fileStream);
//  ReadLn(fileStream);
//  ReadLn(fileStream, Result);
//  CloseFile(fileStream);
//end;
//
//procedure CallPythonScript(num: integer);
//var
//  ScriptPath, CommandFile: string;
//  ProcessInfo: TProcessInformation;
//  StartupInfo: TStartupInfo;   
//begin
//  Command(num);
//
//  ScriptPath := ExtractFilePath(ParamStr(0)) + 'lib\pt5demo.py';
//  //ScriptPath := 'C:\PT5\lib\pt5demo.py';
//
//  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
//  StartupInfo.cb := SizeOf(StartupInfo);
//
//  Writeln(GetPathPython);
//  Write('(PT4DemoPu_ru.pas) Текущий язык: ');
//  WriteLn(CurrentLanguage());
//
//  if CreateProcess(nil, PChar(GetPathPython + ' ' + ScriptPath + '"'),
//    nil, nil, False, 0, nil, nil, StartupInfo, ProcessInfo) then
//  begin   
//    WaitForSingleObject(ProcessInfo.hProcess, INFINITE); // Дожидаемся завершения работы скрипта Python
//    //Загрузка задания из файлов, когда питон завершил работу
//
//    //CreateTaskFile;
//    //DataFile;
//    //ResultFile;
//
//  end;
//end;
//
//procedure MakerDemo3;
//var
//  a, b: real;
//begin
//  CreateTask('Ввод и вывод данных, оператор присваивания');
//  TaskText('Даны стороны прямоугольника~{a} и~{b}.', 0, 2);
//  TaskText('Найти его площадь {S}~=~{a}\*{b} и периметр {P}~=~2\*({a}\;+\;{b}).', 0, 4);
//  a := RandomN(1, 99) / 10;
//  b := RandomN(1, 99) / 10;
//  DataR('a = ', a, xLeft, 3, 4);
//  DataR('b = ', b, xRight, 3, 4);
//  ResultR('S = ', a * b, 0, 2, 4);
//  ResultR('P = ', 2 * (a + b), 0, 4, 4);
//  SetTestCount(3);
//end;
//
//procedure InitTask(num: integer); stdcall;
//begin
//  CallPythonScript(num);
//end;
//
//procedure inittaskgroup;
//begin
//  CallPythonScript(0);
//  //CreateGroupFile;
//end;
//
//begin
//end.
