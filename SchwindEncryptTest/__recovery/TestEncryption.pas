unit TestEncryption;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, vcl.Dialogs, Encryption, System.SysUtils, DECCipherModes,
  DECFormatBase, System.Classes, DECCipherBase, Helper;

type
  // Test methods for class TClassEncryption

  TestTClassEncryption = class(TTestCase)
  strict private
    FClassEncryption: TClassEncryption;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestEncrypt128Bit;
    procedure TestEncrypt192Bit;
    procedure TestEncrypt256Bit;
    procedure TestEncryptInvalidKey;
    procedure TestEncryptFile;
    procedure TestEncryptFilePDF;
    procedure TestEncryptFileZIP;
  end;

implementation

procedure TestTClassEncryption.SetUp;
begin
  FClassEncryption := TClassEncryption.Create;
end;

procedure TestTClassEncryption.TearDown;
begin
  FClassEncryption.Free;
  FClassEncryption := nil;
end;

procedure TestTClassEncryption.TestEncrypt128Bit;
var
  ReturnValue: Integer;
  mode: Integer;
  secretkey: string;
  destination: string;
  source: string;
begin
  source := '..\..\TestSamples\WebLog.txt';
  destination := '..\..\TestSamples\EncryptMsg128.schwind';
  secretkey := '..\..\TestSamples\password128bit.txt';

  ReturnValue := FClassEncryption.Encrypt(source, destination, secretkey, mode);

  Check(ReturnValue = 0, 'Error # ' + GetExceptionMessage(ReturnValue));

end;

procedure TestTClassEncryption.TestEncrypt192Bit;
var
  ReturnValue: Integer;
  mode: Integer;
  secretkey: string;
  destination: string;
  source: string;
begin
  // TODO: Setup method call parameters
  source := '..\..\TestSamples\WebLog.txt';
  destination := '..\..\TestSamples\EncryptMsg192.schwind';
  secretkey := '..\..\TestSamples\password192bit.txt';
  ReturnValue := FClassEncryption.Encrypt(source, destination, secretkey, mode);
  Check(ReturnValue = 0, 'Error # ' + GetExceptionMessage(ReturnValue));
  // TODO: Validate method results
end;

procedure TestTClassEncryption.TestEncrypt256Bit;
var
  ReturnValue: Integer;
  mode: Integer;
  secretkey: string;
  destination: string;
  source: string;
begin
  // TODO: Setup method call parameters
  source := '..\..\TestSamples\WebLog.txt';
  destination := '..\..\TestSamples\EncryptMsg256.schwind';
  secretkey := '..\..\TestSamples\password256bit.txt';
  ReturnValue := FClassEncryption.Encrypt(source, destination, secretkey, mode);
  Check(ReturnValue = 0, 'Error # ' + GetExceptionMessage(ReturnValue));
  // TODO: Validate method results
end;

procedure TestTClassEncryption.TestEncryptInvalidKey;
var
  ReturnValue: Integer;
  mode: Integer;
  secretkey: string;
  destination: string;
  source: string;
begin
  source := '..\..\TestSamples\WebLog.txt';
  destination := '..\..\TestSamples\EncryptMsg128.schwind';
  secretkey := '..\..\TestSamples\passwordInvalid.txt';

  ReturnValue := FClassEncryption.Encrypt(source, destination, secretkey, mode);

  Check(ReturnValue = 33, 'Error # ' + GetExceptionMessage(ReturnValue));

end;

procedure TestTClassEncryption.TestEncryptFile;
var
  ReturnValue: Integer;
  mode: Integer;
  secretkey: string;
  destination: string;
  source: string;
begin
  // TODO: Setup method call parameters
  source := '..\..\TestSamples\Research(Cryptographic Algorithms & Available Libraries).docx';
  destination := '..\..\TestSamples\Research(Cryptographic Algorithms & Available Libraries).schwind';
  secretkey := '..\..\TestSamples\password256bit.txt';
  ReturnValue := FClassEncryption.EncryptFile(source, destination, secretkey, mode);
  Check(ReturnValue = 0, 'Error # ' + GetExceptionMessage(ReturnValue));
  // TODO: Validate method results
end;

procedure TestTClassEncryption.TestEncryptFilePDF;
var
  ReturnValue: Integer;
  mode: Integer;
  secretkey: string;
  destination: string;
  source: string;
begin
  // TODO: Setup method call parameters
  source := '..\..\TestSamples\final Syllabus of Economic Development.pdf';
  destination := '..\..\TestSamples\final Syllabus of Economic Development.schwind';
  secretkey := '..\..\TestSamples\password256bit.txt';
  ReturnValue := FClassEncryption.EncryptFile(source, destination, secretkey, mode);
  Check(ReturnValue = 0, 'Error # ' + GetExceptionMessage(ReturnValue));
  // TODO: Validate method results
end;

procedure TestTClassEncryption.TestEncryptFileZIP;
var
  ReturnValue: Integer;
  mode: Integer;
  secretkey: string;
  destination: string;
  source: string;
begin
  // TODO: Setup method call parameters
  source := '..\..\TestSamples\Schwind_Library-main.zip';
  destination := '..\..\TestSamples\Schwind_Library-main.schwind';
  secretkey := '..\..\TestSamples\password256bit.txt';
  ReturnValue := FClassEncryption.EncryptFile(source, destination, secretkey, mode);
  Check(ReturnValue = 0, 'Error # ' + GetExceptionMessage(ReturnValue));
  // TODO: Validate method results
end;




initialization
  // Register any test cases with the test runner
  RegisterTest(TestTClassEncryption.Suite);
end.

