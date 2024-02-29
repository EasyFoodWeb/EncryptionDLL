unit Base64;

interface

uses
  System.SysUtils,
  vcl.Dialogs,
  System.Classes,
  Helper,
  System.NetEncoding;

function Encode(source, destination: string): integer;
function Decode(source, destination: string): integer;

implementation

function Encode(source, destination: string): integer;
var
  data, encodedData: string;
begin
  Result := 0;

  try
    try
      ValidateSourceFile(source, data);
      ValidateDestinationFolder(destination, source, '_Encoded');

      encodedData := TNetEncoding.Base64.Encode(data);
      //showmessage(encodedData);
      WriteFile(destination, encodedData);


    except
      on Ex: Exception do
      begin
       //showmessage(Ex.Message);
       if Not Exceptions.TryGetValue(Ex.Message, Result) then
          Result := 21;
      end;
    end;
  finally

  end;
end;

function decode(source, destination: string): integer;
var
  decodeddata, encodedData: string;
begin
  Result := 0;

  try
    try
      ValidateSourceFile(source, encodedData);
      ValidateDestinationFolder(destination, source, '_Decoded');

      decodedData := TNetEncoding.Base64.Decode(encodedData);
      //showmessage(encodedData);
      WriteFile(destination, decodedData);


    except
      on Ex: Exception do
      begin
       //showmessage(Ex.Message);
       if Not Exceptions.TryGetValue(Ex.Message, Result) then
          Result := 21;
      end;
    end;
  finally

  end;
end;

end.
