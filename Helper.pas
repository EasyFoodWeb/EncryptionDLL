unit Helper;

interface

uses
System.SysUtils, vcl.Dialogs, vcl.Forms, vcl.Controls, System.Classes, System.IOUtils, System.Generics.Collections;

Const
  FileException = 1;
  FileDataException = 2;
  SourceFileException = 11;
  SourceFileDataException = 12;
  EncodingMessageException = 21;
  DestinationFileException = 22;
  SecretKeyFileException = 31;
  SecretKeyException = 32;
  SecretKeySizeException = 33;

  function GetExceptionCode(ExceptionMessage: string): Integer;
  procedure ReadFile(filePath: string; var fileData: string; includeLineFeed: boolean = false);
  procedure WriteFile(filePath: string; var fileData: string);
  function ModifyFileName(filePath, addString, fileExt: string): string;
  procedure ValidateSourceFile(filePath: string; var fileData: string; includeLineFeed: boolean = false); Overload;
  procedure ValidateSourceFile(var filePath: string; var fileData: TBytes; isEncrypt: boolean = false); Overload;
  procedure ValidatePasswordFile(filePath: string; var fileData: string);
  procedure ValidateDestinationFolder(var filePath: string; sourceFile: string;
                                       padding: string = '_temp'; defaultExt: string= 'txt');
  function StringToHex(const Buffer: AnsiString): string;
  function MessageDlgEx(const AMsg: string; ADlgType: TMsgDlgType;
  AButtons: TMsgDlgButtons; AParent: TForm): TModalResult;
  function GetExceptionMessage(Value: integer): string;

var
  Exceptions: TDictionary<String, Integer>;

implementation

function GetExceptionCode(ExceptionMessage: string): Integer;
begin
  Result := 21;
  if ExceptionMessage = 'SourceFileException' then
    Result := SourceFileException
  else if ExceptionMessage = 'EncodingMessageException' then
    Result := EncodingMessageException
  else if ExceptionMessage = 'SecretKeyException' then
    Result := SecretKeyException;
end;

procedure ReadFile(filePath: string; var fileData: string; includeLineFeed: boolean = false);
var
  inputFile: TextFile;
  textLine: string;
begin
  fileData := '';
  try
    try
      AssignFile(inputFile, filePath);
      Reset(inputFile);

      while not Eof(inputFile) do
      begin
        ReadLn(inputFile, textLine);
        fileData := fileData + textLine;
        if (includeLineFeed) and (Not Eof(inputFile)) then
          fileData := fileData + #13#10;
      end;
      {if (fileData.Length < 2) then
        raise Exception.Create('SourceFileData');}
    except
      on Ex: Exception do
      begin
        raise Exception.Create(Ex.Message);
        //showMessage(Ex.Message);
      end;
    end;
  finally
    CloseFile(inputFile)
  end;
end;

procedure WriteFile(filePath: string; var fileData: string);
var
  outputFile: TextFile;
begin
  try
    try
      AssignFile(outputFile, filePath);
      //Reset(outputFile);
      Rewrite(outputFile);
      WriteLn(outputFile, fileData);

    except
      on Ex: Exception do
      begin
        raise Exception.Create(Ex.Message);
        //showMessage(Ex.Message);
      end;
    end;
  finally
    CloseFile(outputFile)
  end;
end;

function ModifyFileName(filePath, addString, fileExt: string): string;
var
  path, name, nameWithoutExt, ext: string;
begin
  Result := '';
  path := ExtractFilePath(filePath);
  //name := ExtractFileName(filePath);
  if fileExt = '' then
    ext  := ExtractFileExt(filePath)
  else
    ext := '.' + fileExt;
  nameWithoutExt := TPath.GetFileNameWithoutExtension(filePath);
  Result := path + '\' + nameWithoutExt + addString + ext;
end;

procedure ValidateSourceFile(filePath: string; var fileData: string; includeLineFeed: boolean = false);
var
  value: integer;
begin
  try
    ReadFile(filePath, fileData, includeLineFeed);
    if (fileData = '') or (fileData.Length < 2)  then
      raise Exception.create('SourceFileDataException');
  except
    on Ex: Exception do
    begin
      if Exceptions.TryGetValue(Ex.Message, value) then
        raise Exception.create(Ex.Message)
      else
        raise Exception.create('SourceFileException');
    end;
  end;
end;

procedure ValidateSourceFile(var filePath: string; var fileData: TBytes; isEncrypt: boolean = false);
var
  value, ExtSize: integer;
  ExtData, mFileName: string;
  ExtBytes: TBytes;
begin
  try
    fileData := TFile.ReadAllBytes(filePath);
    if (fileData = nil) or (Length(fileData) < 1)  then
      raise Exception.create('SourceFileDataException');

  except
    on Ex: Exception do
    begin
      if Exceptions.TryGetValue(Ex.Message, value) then
        raise Exception.create(Ex.Message)
      else
        raise Exception.create('SourceFileException');
    end;
  end;
end;

procedure ValidatePasswordFile(filePath: string; var fileData: string);
var
  value: integer;
begin
  try
    ReadFile(filePath, fileData);
    if (fileData = '') or (fileData.Length < 1)  then
      raise Exception.create('SecretKeyException');
    if Not (fileData.Length in [16, 24, 32]) then
      raise Exception.create('SecretKeySizeException');
  except
    on Ex: Exception do
    begin
      if Exceptions.TryGetValue(Ex.Message, value) then
        raise Exception.create(Ex.Message)
      else
        raise Exception.create('SecretKeyFileException');
    end;
  end;
end;

procedure ValidateDestinationFolder(var filePath: string; sourceFile: string;
                                       padding: string = '_temp'; defaultExt: string= 'txt');
var
  fileDir: string;
begin
  try
    if filePath = '' then
    begin
      filePath := ModifyFileName(sourceFile, padding, defaultExt);
      Exit;
    end;
    fileDir := ExtractFileDir(filePath);
    if Not TDirectory.Exists(fileDir) then
      raise Exception.Create('Invalid Directory');
  except
    on Ex: Exception do
    begin
        raise Exception.create('DestinationFileException');
    end;
  end;
end;

function StringToHex(const Buffer: AnsiString): string;
begin
  SetLength(Result, Length(Buffer) * 2);
  BinToHex(PAnsiChar(Buffer), PChar(Result), Length(Buffer));
end;

function MessageDlgEx(const AMsg: string; ADlgType: TMsgDlgType;
  AButtons: TMsgDlgButtons; AParent: TForm): TModalResult;
var
  MsgFrm: TForm;
begin
  MsgFrm := CreateMessageDialog(AMsg, ADlgType, AButtons);
  try
    MsgFrm.Position := poDefaultSizeOnly;
    MsgFrm.FormStyle := fsStayOnTop;
    MsgFrm.Left := 400;
    MsgFrm.Top := 800;
    Result := MsgFrm.ShowModal;
  finally
    MsgFrm.Free
  end;
end;

function GetExceptionMessage(Value: integer): string;
var
  ValueIndex, I: integer;
  ValueArray: TArray<Integer>;
begin
  Result := 'EncodingMessageException';

  if Value = 0 then
  begin
    Result := 'Success';
    Exit;
  end;

  ValueArray := Exceptions.Values.ToArray();
  for I := 0 to High(ValueArray) do
  begin
    if ValueArray[I] = Value then
    begin
     ValueIndex := I;
     break;
    end;
  end;

  Result := Exceptions.Keys.ToArray()[ValueIndex];
end;

Initialization
  Exceptions := TDictionary<String, Integer>.create;
  Exceptions.Add('FileException', 1);
  Exceptions.Add('FileDataException', 2);
  Exceptions.Add('SourceFileException', 11);
  Exceptions.Add('SourceFileDataException', 12);
  Exceptions.Add('EncodingMessageException', 21);
  Exceptions.Add('DestinationFileException', 22);
  Exceptions.Add('SecretKeyFileException', 31);
  Exceptions.Add('SecretKeyException', 32);
  Exceptions.Add('SecretKeySizeException', 33);

end.
