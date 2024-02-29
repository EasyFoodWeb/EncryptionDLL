library SchwindEncrypt;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters.

  Important note about VCL usage: when this DLL will be implicitly
  loaded and this DLL uses TWicImage / TImageCollection created in
  any unit initialization section, then Vcl.WicImageInit must be
  included into your library's USES clause. }

uses
  System.SysUtils,
  vcl.Dialogs,
  System.Classes,
  Helper in 'Helper.pas',
  Encryption in 'Encryption.pas',
  Decryption in 'Decryption.pas',
  Formatter in 'Formatter.pas',
  Base64 in 'Base64.pas';

var
  Encryption: TClassEncryption;
  Decryption: TClassDecryption;

{$R *.res}

function encodefile(sourcefile, destinationfile, secretkey: PChar): integer; export;
var
  sourceData: string;
begin
  Result := 0;
  try
    try
      Encryption := TClassEncryption.Create;

      Result := Encryption.EncryptFile(sourcefile, destinationfile, secretkey);

    except
      on Ex:Exception do
      begin
        //        Result := PChar(PAnsiChar(Ex.Message));
        Result := GetExceptionCode(Ex.Message);
        //showmessage(Ex.Message);
      end;
    end;
  finally

  end;
end;

function decodefile(sourcefile, destinationfile, secretkey: PChar): integer; export;
var
  sourceData: string;
begin
  Result := 0;
  try
    try
      Decryption := TClassDecryption.Create;
      Result := Decryption.DecryptFile(sourcefile, destinationfile, secretkey);

    except
      on Ex:Exception do
      begin
        //        Result := PChar(PAnsiChar(Ex.Message));
        Result := GetExceptionCode(Ex.Message);
        //showmessage(Ex.Message);
      end;
    end;
  finally

  end;
end;

function encodetextfile(sourcefile, destinationfile, secretkey: PChar): integer; export;
var
  sourceData: string;
begin
  Result := 0;
  try
    try
      Encryption := TClassEncryption.Create;

      Result := Encryption.Encrypt(sourcefile, destinationfile, secretkey);

    except
      on Ex:Exception do
      begin
        //        Result := PChar(PAnsiChar(Ex.Message));
        Result := GetExceptionCode(Ex.Message);
        //showmessage(Ex.Message);
      end;
    end;
  finally

  end;
end;

function decodetextfile(sourcefile, destinationfile, secretkey: PChar): integer; export;
begin
  Result := 0;
  try
    Decryption := TClassDecryption.Create;

    Result := Decryption.Decrypt(sourcefile, destinationfile, secretkey);
  except
    on Ex:Exception do
      Result := GetExceptionCode(Ex.Message);
  end;
end;

function encodebase64file(sourcefile, destinationfile, secretkey: PChar): integer; export;
var
  sourceData: string;
begin
  Result := 0;
  try
    try

      Result := Encode(sourcefile, destinationfile);

    except
      on Ex:Exception do
      begin
        //        Result := PChar(PAnsiChar(Ex.Message));
        Result := GetExceptionCode(Ex.Message);
        //showmessage(Ex.Message);
      end;
    end;
  finally

  end;
end;

function decodebase64file(sourcefile, destinationfile, secretkey: PChar): integer; export;
var
  sourceData: string;
begin
  Result := 0;
  try
    try

      Result := decode(sourcefile, destinationfile);

    except
      on Ex:Exception do
      begin
        //        Result := PChar(PAnsiChar(Ex.Message));
        Result := GetExceptionCode(Ex.Message);
        //showmessage(Ex.Message);
      end;
    end;
  finally

  end;
end;

exports encodefile;
exports decodefile;
exports encodetextfile;
exports decodetextfile;
exports encodebase64file;
exports decodebase64file;

begin
end.
