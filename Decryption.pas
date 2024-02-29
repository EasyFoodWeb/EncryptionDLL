unit Decryption;

interface

uses
  System.SysUtils,
  System.IOUtils,
  vcl.Dialogs,
  System.Classes,
  Helper,
  DECCipherBase, DECFormatBase, DECCipherModes;

type
  TClassDecryption = class
  public
    function Decrypt(source, destination, secretkey: string; mode: integer = 0): integer;
    function DecryptFile(source, destination, secretkey: string; mode: integer = 0): integer;
  end;


implementation

uses
  DECBaseClass, DECFormat,
  DECCipherFormats, DECCiphers, DECUtil, DECCipherInterface;

function TClassDecryption.Decrypt(source, destination, secretkey: string; mode: integer = 0): integer;
var
  Cipher               : TDECCipherModes;
  CipherTextFormatting : TDECFormatClass;
  PlainTextFormatting  : TDECFormatClass;
  CipherTextBuffer     : TBytes;
  PlainTextBuffer      : TBytes;
  password, pwdHex, data, plainText: string;
begin
  Result := 0;
  try
    try
      ValidateSourceFile(source, data);
      ValidateDestinationFolder(destination, source, '_Decrypt');
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
      CipherTextFormatting := TDECFormat.ClassByName('TFormat_HEX');
      PlainTextFormatting := TDECFormat.ClassByName('TFormat_Copy');
      //showmessage(data);
      CipherTextBuffer := BytesOf(data);
      if CipherTextFormatting.IsValid(CipherTextBuffer) then
      begin
        //showmessage('buffer');
        PlainTextBuffer := (Cipher as TDECFormattedCipher).DecodeBytes(CipherTextFormatting.Decode(CipherTextBuffer));
        (Cipher as TDECFormattedCipher).Done;
        plainText := string(DECUtil.BytesToRawString(PlainTextFormatting.Encode(PlainTextBuffer)));
        //showmessage(cipherText);
        WriteFile(destination, plainText);
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

function TClassDecryption.DecryptFile(source, destination, secretkey: string; mode: integer = 0): integer;
var
  Cipher               : TDECCipherModes;
  CipherTextFormatting,
  PlainTextFormatting : TDECFormatClass;
  CipherTextBuffer,
  PlainTextBuffer     : TBytes;
  password, pwdHex,
  sourcePath, PlainText,
  fileExt: string;
  cipherExtBytes: TBytes;
begin
  Result := 0;
  try
    try
      sourcePath := source;
      ValidateSourceFile(sourcePath, CipherTextBuffer);
      //ValidateDestinationFolder(destination, source, '_Decrypt', 'pdf');
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

      // Extract Encrypted MetaData from File
      SetLength(cipherExtBytes, 2048);
      Move(CipherTextBuffer[length(CipherTextBuffer) - 2048], cipherExtBytes[0], 2048);

      //('format');
      // DEC
      CipherTextFormatting := TDECFormat.ClassByName('TFormat_HEX');
      PlainTextFormatting := TDECFormat.ClassByName('TFormat_Copy');
      if CipherTextFormatting.IsValid(cipherExtBytes) then
      begin
        // Decrypt MetaData
        PlainTextBuffer := (Cipher as TDECFormattedCipher).DecodeBytes(CipherTextFormatting.Decode(cipherExtBytes));
        (Cipher as TDECFormattedCipher).Done;
        plainText := string(DECUtil.BytesToRawString(PlainTextFormatting.Encode(PlainTextBuffer)));
        //showmessage(plainText);
        fileExt := copy(plainText, 2, pos('-Time-', plainText) - 2);
        //showmessage(fileExt);
        ValidateDestinationFolder(destination, source, '_Decrypt', fileExt);

        // Remove Metadata from Cipher Text File
        setLength(CipherTextBuffer, length(CipherTextBuffer) - 2048);
        TFile.WriteAllBytes(source, CipherTextBuffer);
      end;



      if true then
      begin
        (Cipher as TDECFormattedCipher).DecodeFile(sourcePath, destination);
        (Cipher as TDECFormattedCipher).Done;
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
