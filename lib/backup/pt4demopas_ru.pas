unit PT4DemoPas_ru;

{$MODE Delphi}

interface


procedure InitTask(num: integer); stdcall;
procedure inittaskgroup;


implementation


uses SysUtils, PT5TaskMaker, Windows, Process, ShellAPI, Classes;

const
  DataInfoPath = 'datainfo.txt';
  ResultInfoPath = 'resinfo.txt';
  TaskInfoPath = 'taskinfo.txt';
  GroupInfoPath = 'groupinfo.txt';
  CommandPath = 'command.txt';

procedure Command(num : integer);
var
  CommandFile : TextFile;
begin
  AssignFile(CommandFile, CommandPath);
  Rewrite(CommandFile);
  Write(CommandFile, num);
  CloseFile(CommandFile);
end;

procedure CreateGroupFile;
var
  GroupFile : TextFile;
  GroupName, GroupDescription, GroupAuthor, GroupKey : string;
  TaskCount : Integer;
begin
  AssignFile(GroupFile, GroupInfoPath); 
  Reset(GroupFile); 
  ReadLn(GroupFile, GroupName);
  ReadLn(GroupFile, GroupDescription);
  ReadLn(GroupFile, GroupAuthor);
  ReadLn(GroupFile, GroupKey);
  ReadLn(GroupFile, TaskCount);
  CloseFile(GroupFile); 

  CreateGroup(GroupName, GroupDescription, GroupAuthor, GroupKey, TaskCount, InitTask);
  WriteLn('CreateGroupFile completed');
end;

procedure TaskTextFile(var TaskFile : TextFile);
var
  Line : string;
  x,y : integer;
begin
  ReadLn(TaskFile, Line);
  ReadLn(TaskFile, x);
  ReadLn(TaskFile, y);

  TaskText(Line, x, y);
  WriteLn('TaskTextFile completed');
end;

procedure CreateTaskFile;
var
  TaskFile : TextFile;
  Line : string;
begin
  AssignFile(TaskFile, TaskInfoPath); // пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅ пїЅпїЅ пїЅпїЅпїЅпїЅ TaskInfoPath
  Reset(TaskFile); 
  ReadLn(TaskFile, Line);
  Writeln(Line);
  CreateTask(Line);
  while not Eof(TaskFile) do
  begin
    TaskTextFile(TaskFile);
  end;
  CloseFile(TaskFile); // пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅ

  WriteLn('CreateTaskFile completed');
end;

procedure DataBFile(var DataFile: TextFile);
var
  comm: string;
  n: Integer;
  b: Boolean;
  x,y: Integer;
begin
  ReadLn(DataFile, comm);
  ReadLn(DataFile, n);
  if (n = 0) then b := false else b := true;
  ReadLn(DataFile, x);
  ReadLn(DataFile, y);
  DataB(comm, b, x, y);
end;

procedure DataNFile(var DataFile: TextFile);
var
  comm: string;
  n: Integer;
  x,y,w: Integer;
begin                     
  ReadLn(DataFile, comm);
  ReadLn(DataFile, n); 
  ReadLn(DataFile, x);
  ReadLn(DataFile, y);
  ReadLn(DataFile, w);
  DataN(comm, n, x, y, w);
  WriteLn('DataN completed');
end;

procedure DataRFile(var DataFile: TextFile);
var
  comm: string;
  r: Real;
  x,y,w: Integer;
begin
  ReadLn(DataFile, comm);
  ReadLn(DataFile, r);
  ReadLn(DataFile, x);
  ReadLn(DataFile, y);
  ReadLn(DataFile, w);
  DataR(comm, r, x, y, w);
end;

procedure DataCFile(var DataFile: TextFile);
var
  comm: string;
  c: Char;
  x,y: Integer;
begin
  ReadLn(DataFile, comm);
  ReadLn(DataFile, c);
  ReadLn(DataFile, x);
  ReadLn(DataFile, y);
  DataC(comm, c, x, y);
end;

procedure DataSFile(var DataFile: TextFile);
var
  comm: string;
  s: string;
  x,y: Integer;
begin
  ReadLn(DataFile, comm);
  ReadLn(DataFile, s);
  ReadLn(DataFile, x);
  ReadLn(DataFile, y);
  DataS(comm, s, x, y);
end;

procedure DataFile;
var
  DataFile: TextFile;
  Line: string;
begin
  AssignFile(DataFile, DataInfoPath); // пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅ пїЅпїЅ пїЅпїЅпїЅпїЅ DataInfoPath
  Reset(DataFile); // пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅ пїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ

  // пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ, пїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅ пїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅ
  while not Eof(DataFile) do
  begin
    ReadLn(DataFile, Line); // пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ

    // пїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅ пїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ
    WriteLn(Line[1]);
    case Line[1] of
      'b': DataBFile(DataFile);
      'n': DataNFile(DataFile);
      'r': DataRFile(DataFile);
      'c': DataCFile(DataFile);
      's': DataSFile(DataFile);
    end;
  end;

  CloseFile(DataFile); // пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅ
  WriteLn('DataFile completed');
end;

procedure ResultBFile(var ResultFile: TextFile);
var
  comm: string;
  n: Integer;
  b: Boolean;
  x,y: Integer;
begin
  ReadLn(ResultFile, comm);
  ReadLn(ResultFile, n);
  if (n = 0) then b := false else b := true;
  ReadLn(ResultFile, x);
  ReadLn(ResultFile, y);
  ResultB(comm, b, x, y);
end;

procedure ResultNFile(var ResultFile: TextFile);
var
  comm: string;
  n: Integer;
  x,y,w: Integer;
begin
  ReadLn(ResultFile, comm);
  ReadLn(ResultFile, n);
  ReadLn(ResultFile, x);
  ReadLn(ResultFile, y);
  ReadLn(ResultFile, w);
  ResultN(comm, n, x, y, w);
end;

procedure ResultRFile(var ResultFile: TextFile);
var
  comm: string;
  r: Real;
  x,y,w: Integer;
begin
  ReadLn(ResultFile, comm);
  ReadLn(ResultFile, r);
  ReadLn(ResultFile, x);
  ReadLn(ResultFile, y);
  ReadLn(ResultFile, w);
  ResultR(comm, r, x, y, w);
end;

procedure ResultCFile(var ResultFile: TextFile);
var
  comm: string;
  c: Char;
  x,y: Integer;
begin
  ReadLn(ResultFile, comm);
  ReadLn(ResultFile, c);
  ReadLn(ResultFile, x);
  ReadLn(ResultFile, y);
  ResultC(comm, c, x, y);
end;

procedure ResultSFile(var ResultFile: TextFile);
var
  comm: string;
  s: string;
  x,y: Integer;
begin
  ReadLn(ResultFile, comm);
  ReadLn(ResultFile, s);
  ReadLn(ResultFile, x);
  ReadLn(ResultFile, y);
  ResultS(comm, s, x, y);
end;

procedure ResultFile;
var
  ResultFile: TextFile;
  Line: string;
begin
  AssignFile(ResultFile, ResultInfoPath); // пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅ пїЅпїЅ пїЅпїЅпїЅпїЅ ResultInfoPath
  Reset(ResultFile); // пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅ пїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ

  // пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ, пїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅ пїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅ
  while not Eof(ResultFile) do
  begin
    ReadLn(ResultFile, Line); // пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ

    // пїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅ пїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ
    case Line[1] of
      'b': ResultBFile(ResultFile);
      'n': ResultNFile(ResultFile);
      'r': ResultRFile(ResultFile);
      'c': ResultCFile(ResultFile);
      's': ResultSFile(ResultFile);
    end;
  end;

  CloseFile(ResultFile); // пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅ
end;
//пїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ пїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅ

// пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅ пїЅ python.exe
function GetCurrentUser: string;
var
  UserName: array [0..255] of Char;
  UserNameLen: DWORD;
begin
  UserNameLen := Length(UserName);
  if GetUserName(UserName, UserNameLen) then
    Result := UserName
  else
    Result := 'Unknown';
end;

//пїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ пїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅ
procedure CallPythonScript(num: integer);
var
  ScriptPath, CommandFile: string;
  ProcessInfo: TProcessInformation;
  StartupInfo: TStartupInfo;   
begin
  Command(num); // пїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅ пїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅ
  //TODO пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ

  // пїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅ пїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅ Python
  ScriptPath := ExtractFilePath(ParamStr(0)) + 'lib\pt5demo.py';

  // пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);

  // if CreateProcess(nil, PChar('"C:\Users\artem\AppData\Local\Programs\Python\Python311-32\python.exe" "' + ScriptPath + '"'),
  if CreateProcess(nil, PChar('"C:\Users\' + GetCurrentUser + '\AppData\Local\Programs\Python\Python311-32\python.exe" "' + ScriptPath + '"'),
    nil, nil, False, 0, nil, nil, StartupInfo, ProcessInfo) then
  begin
    // пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅ Python
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
    WriteLn('пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ');
    //пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ, пїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ
    CreateTaskFile;
    DataFile;
    ResultFile;
  end;

end;


procedure MakerDemo3;
var
  a, b: real;
begin
  CreateTask('пїЅпїЅпїЅпїЅ пїЅ пїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ, пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ');
  TaskText('пїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ~{a} пїЅ~{b}.', 0, 2);
  TaskText('пїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅ {S}~=~{a}\*{b} пїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ {P}~=~2\*({a}\;+\;{b}).', 0, 4);
  a := RandomN(1, 99) / 10;
  b := RandomN(1, 99) / 10;
  DataR('a = ', a, xLeft, 3, 4);
  DataR('b = ', b, xRight, 3, 4);
  ResultR('S = ', a * b, 0, 2, 4);
  ResultR('P = ', 2 * (a + b), 0, 4, 4);
  SetTestCount(3);
end;

procedure InitTask(num: integer); stdcall;
begin
  CallPythonScript(num);

  //CreateTaskFile;
  //DataFile;
  //ResultFile;

  //MakerDemo3

  //case num of
  //1..2: UseTask('Begin', num);
  //3: MakerDemo3;
  //end;
end;

procedure inittaskgroup;
//var
//  n: integer;
begin
  CallPythonScript(0);
  CreateGroupFile;
  //n := 3;
  //CreateGroup('DemoPas', 'пїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅ (пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅ Pascal)',
  //  'пїЅ. пїЅ. пїЅпїЅпїЅпїЅпїЅпїЅпїЅ, 2014', 'qwqfsdf13dfttd', n, InitTask);
end;


begin
end.
