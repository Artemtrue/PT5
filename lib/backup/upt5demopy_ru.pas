{$A+,B-,D-,E+,F-,G-,I+,L-,N+,O-,P-,Q-,R-,S-,T-,V+,X+,Y-}

unit upt5demopy_ru;

{$MODE Delphi}

interface

procedure Activate_(dllname: string);
function InitGroup_(var name, code: string; lang: integer): integer;
function InitTask_(num, test: Integer): integer;

implementation

uses SysUtils, PT5TaskMaker, Windows;

procedure Command(num, test : integer);
var
  CommandFile : TextFile;
begin
  AssignFile(CommandFile, '.pt/command.txt');
  Rewrite(CommandFile);
  WriteLn(CommandFile, num);
  WriteLn(CommandFile, test);
  WriteLN(test);
  CloseFile(CommandFile);
end;

function GetPathInterpreterPython(): string;
var
  fileStream: TextFile;
  fileName: string;
begin
  fileName := '.pt/ptpath.dat';
  AssignFile(fileStream, fileName);
  Reset(fileStream);
  ReadLn(fileStream);
  ReadLn(fileStream, Result);
  CloseFile(fileStream);
end;

procedure CallPythonScript(num, test: integer);
var
  ScriptPath, CommandFile: string;
  ProcessInfo: TProcessInformation;
  StartupInfo: TStartupInfo;
  fileStream: TextFile;
begin
  Command(num, test);

  //ScriptPath:= 'C:\PT5\lib\pt5demo_ru.py';

  AssignFile(fileStream, '.pt/ptpath.dat');
  Reset(fileStream);
  ReadLn(fileStream);
  ReadLn(fileStream);
  ReadLn(fileStream, ScriptPath);
  CloseFile(fileStream);


  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);

  if CreateProcess(nil, PChar(GetPathInterpreterPython + ' ' + ScriptPath + '"'),
    nil, nil, False, 0, nil, nil, StartupInfo, ProcessInfo) then
  begin
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
  end;
end;

function InitGroup_(var name, code: string; lang: integer): integer;
var
    GroupFile: TextFile;
    _topic, _code: string;
    _taskCount: integer;
begin
  ClearGroupData;
  SetLanguage(lang);

  CallPythonScript(1, 0);

  AssignFile(GroupFile, '.pt/groupinfo.txt');
  Reset(GroupFile);
  ReadLn(GroupFile, _topic);
  ReadLn(GroupFile, _code);
  ReadLn(GroupFile, _taskCount);
  CloseFile(GroupFile);

  result := _taskCount;

  if result > 0 then
  begin
    name := _topic;
    code := _code;
  end;
end;

function InitTask_(num, test: Integer): integer;
var
  name: string;
  _testCount: integer;
  TaskFile: TextFile;

   GroupFile: TextFile;
begin
  CallPythonScript(num, test);

  AssignFile(TaskFile, '.pt/taskinfo.txt');
  Reset(TaskFile);
  ReadLn(TaskFile,_testCount);
  CloseFile(TaskFile);

  result := _testCount;
end;

procedure Activate_(dllname: string);
var
  CommandFile: TextFile;
begin
  PT5TaskMaker.Activate(dllname);

  AssignFile(CommandFile, '.pt/dllname.txt');
  Rewrite(CommandFile);
  Write(CommandFile, dllname);
  CloseFile(CommandFile);
end;

begin
end.
