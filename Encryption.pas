unit Encryption;

interface

uses
  System.SysUtils, System.IOUtils,
  vcl.Dialogs,
  System.Classes,
  Helper,
  DECCipherBase, DECFormatBase, DECCipherModes;

type
  TClassEncryption = class
  public
    function Encrypt(source, destination, secretkey: string; mode: integer = 0): integer;
    function EncryptFile(source, destination, secretkey: string; mode: integer = 0): integer;
  end;

implementation

uses
  DECBaseClass, DECFormat,
  DECCipherFormats, DECCiphers, DECUtil, DECCipherInterface;

function TClassEncryption.Encrypt(source, destination, secretkey: string; mode: integer = 0): integer;
var
  Cipher           : TDECCipherModes;
  InputFormatting  : TDECFormatClass;
  OutputFormatting : TDECFormatClass;
  InputBuffer      : TBytes;
  OutputBuffer     : TBytes;
  password, pwdHex, data, cipherText: string;
begin
  Result := 0;
  //showmessage('start');
  try
    try
      ValidateSourceFile(source, data, true);
      ValidateDestinationFolder(destination, source, '_Encrypt', 'schwind');
      ValidatePasswordFile(secretkey, password);
      pwdHex := StringToHex(password);
      //showmessage('Password in Hex: ' + pwdHex);

      if TFormat_HEXL.IsValid(RawByteString(pwdHex.ToLower())) and
        TFormat_HEXL.IsValid(RawByteString(LowerCase('7E892875A52C59A3B588306B13C31FBD'))) then
      begin
        //showmessage('valid');
        Cipher := TDECCipher.ClassByName('TCipher_AES').Create as TDECCipherModes;
        Cipher.Mode := TCipherMode.cmCTSx;
        Cipher.Init(BytesOf(TFormat_HexL.Decode(RawByteString(pwdHex.ToLower()))),
                    BytesOf(TFormat_HexL.Decode(RawByteString(LowerCase('7E892875A52C59A3B588306B13C31FBD')))),
                    0);
      end;
      //showmessage('format');
      // DEC
      InputFormatting := TDECFormat.ClassByName('TFormat_Copy');
      OutputFormatting := TDECFormat.ClassByName('TFormat_HEX');

      InputBuffer := BytesOf(data);
      if InputFormatting.IsValid(InputBuffer) then
      begin
        //showmessage('buffer');
        OutputBuffer := (Cipher as TDECFormattedCipher).EncodeBytes(InputFormatting.Decode(InputBuffer));
        (Cipher as TDECFormattedCipher).Done;

        cipherText := string(DECUtil.BytesToRawString(OutputFormatting.Encode(OutputBuffer)));
        //MessageDlgEx('Cipher: ' + cipherText, mtWarning, [mbOK], nil);
        WriteFile(destination, cipherText);

      end;

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

function TClassEncryption.EncryptFile(source, destination, secretkey: string; mode: integer = 0): integer;
var
  Cipher           : TDECCipherModes;
  InputFormatting,
  OutputFormatting  : TDECFormatClass;
  InputBuffer, OutputBuffer: TBytes;
  password, pwdHex, sourcePath: string;
  ExtData: string;
  ExtBytes, outputExtBytes: TBytes;
begin
  Result := 0;
  //showmessage('start');
  try
    try
      sourcePath := source;
      ValidateSourceFile(sourcePath, InputBuffer, true);
      //showmessage('Buffer Read!!');
      ValidateDestinationFolder(destination, source, '_Encrypt', 'schwind');
      ValidatePasswordFile(secretkey, password);
      pwdHex := StringToHex(password);
      //showmessage('Password in Hex: ' + pwdHex);

      if TFormat_HEXL.IsValid(RawByteString(pwdHex.ToLower())) and
        TFormat_HEXL.IsValid(RawByteString(LowerCase('7E892875A52C59A3B588306B13C31FBD'))) then
      begin
        //showmessage('valid');
        Cipher := TDECCipher.ClassByName('TCipher_AES').Create as TDECCipherModes;
        Cipher.Mode := TCipherMode.cmCTSx;
        Cipher.Init(BytesOf(TFormat_HexL.Decode(RawByteString(pwdHex.ToLower()))),
                    BytesOf(TFormat_HexL.Decode(RawByteString(LowerCase('7E892875A52C59A3B588306B13C31FBD')))),
                    0);
      end;
      //showmessage('format');
      // DEC
      InputFormatting := TDECFormat.ClassByName('TFormat_Copy');
      OutputFormatting := TDECFormat.ClassByName('TFormat_HEX');

      // Encrypt File
      if InputFormatting.IsValid(InputBuffer) then
      begin
        (Cipher as TDECFormattedCipher).EncodeFile(sourcePath, destination);
        (Cipher as TDECFormattedCipher).Done;
      end;

      // Combine source file MetaData
      ExtData := TPath.GetExtension(source);
      ExtData := ExtData + '-Time-' + DateTimeToStr(Now);
      ExtData := ExtData.PadRight(1024, '*');

      ExtBytes := TEncoding.UTF8.GetBytes(ExtData);

      // Encrypt MetaData and Append to CipherText File
      if InputFormatting.IsValid(ExtBytes) then
      begin
        OutputBuffer := (Cipher as TDECFormattedCipher).EncodeBytes(InputFormatting.Decode(ExtBytes));
        (Cipher as TDECFormattedCipher).Done;

        outputExtBytes := OutputFormatting.Encode(OutputBuffer);
        //ShowMessage('Ext C Length: ' + IntToStr(Length(outputExtBytes)));
        //ShowMessage('Cipher Length: ' + IntToStr(Length(InputBuffer)));
        InputBuffer := TFile.ReadAllBytes(destination);
        InputBuffer := InputBuffer + outputExtBytes;
        //ShowMessage('New Cipher Length: ' + IntToStr(Length(InputBuffer)));
        TFile.WriteAllBytes(destination, InputBuffer);
      end;


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
