unit FMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFormMain = class(TForm)
    BtnEncrypt: TButton;
    PanelEncryption: TPanel;
    edSourceFile: TEdit;
    edDestinationFile: TEdit;
    edPasswordFile: TEdit;
    BtnSource: TButton;
    BtnDest: TButton;
    BtnSecret: TButton;
    Panel1: TPanel;
    BtnDecrypt: TButton;
    edEncrypted: TEdit;
    edDecrypted: TEdit;
    edPasswordFile2: TEdit;
    BtnEncrpted: TButton;
    BtnDecrypted: TButton;
    BtnSecret2: TButton;
    dlgOpen: TOpenDialog;
    pgMain: TPageControl;
    tsEncryption: TTabSheet;
    tsEncoding: TTabSheet;
    panelEncode: TPanel;
    btnEncode: TButton;
    edEnSource: TEdit;
    edEnEncoded: TEdit;
    Edit3: TEdit;
    btnEnSource: TButton;
    btnEnEncoded: TButton;
    panelDecode: TPanel;
    btnDecode: TButton;
    edDeEncoded: TEdit;
    edDeDecoded: TEdit;
    Edit6: TEdit;
    btnDeEncoded: TButton;
    btnDeDecoded: TButton;
    Button8: TButton;
    Button4: TButton;
    procedure BtnEncryptClick(Sender: TObject);
    procedure BtnDecryptClick(Sender: TObject);
    procedure BtnSourceClick(Sender: TObject);
    procedure BtnDestClick(Sender: TObject);
    procedure BtnSecretClick(Sender: TObject);
    procedure BtnEncrptedClick(Sender: TObject);
    procedure BtnDecryptedClick(Sender: TObject);
    procedure BtnSecret2Click(Sender: TObject);
    procedure btnEncodeClick(Sender: TObject);
    procedure btnEnSourceClick(Sender: TObject);
    procedure btnEnEncodedClick(Sender: TObject);
    procedure btnDecodeClick(Sender: TObject);
    procedure btnDeEncodedClick(Sender: TObject);
    procedure btnDeDecodedClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

function encodefile(sourcefile, destinationfile, secretkey: PChar): integer; external 'SchwindEncrypt.dll';
function decodefile(sourcefile, destinationfile, secretkey: PChar): integer; external 'SchwindEncrypt.dll';
function encodetextfile(sourcefile, destinationfile, secretkey: PChar): integer; external 'SchwindEncrypt.dll';
function decodetextfile(sourcefile, destinationfile, secretkey: PChar): integer; external 'SchwindEncrypt.dll';
function encodebase64file(sourcefile, destinationfile: PChar): integer; external 'SchwindEncrypt.dll';
function decodebase64file(sourcefile, destinationfile: PChar): integer; external 'SchwindEncrypt.dll';

implementation

{$R *.dfm}

procedure TFormMain.btnDecodeClick(Sender: TObject);
var
  Decoded: integer;
begin
  Decoded := decodebase64file(PChar(edDeEncoded.Text),
                                PChar(edDeDecoded.Text));
  if Decoded = 0 then
    showmessage('Message Decoded Successfully!!')
  else
    showmessage('Exception: ' + inttostr(Decoded));
end;

procedure TFormMain.BtnDecryptClick(Sender: TObject);
var
  Decoded: integer;
begin
  Decoded := decodefile(PChar(edEncrypted.Text),
                                PChar(edDecrypted.Text),
                                  PChar(edPasswordFile2.Text));
  if Decoded = 0 then
    showmessage('Message Decoded Successfully!!')
  else
    showmessage('Exception: ' + inttostr(Decoded));
end;

procedure TFormMain.BtnDecryptedClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    edDecrypted.Text := dlgOpen.FileName;
end;

procedure TFormMain.btnDeDecodedClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    edDeDecoded.Text := dlgOpen.FileName;
end;

procedure TFormMain.btnDeEncodedClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    edDeEncoded.Text := dlgOpen.FileName;
end;

procedure TFormMain.BtnDestClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    edDestinationFile.Text := dlgOpen.FileName;
end;

procedure TFormMain.btnEncodeClick(Sender: TObject);
var
  Encoded: integer;
begin
  Encoded := encodebase64file(PChar(edEnSource.Text),
                                PChar(edEnEncoded.Text));
  if Encoded = 0 then
    showmessage('Message Encoded Successfully!!')
  else
    showmessage('Exception: ' + inttostr(Encoded));
end;

procedure TFormMain.BtnEncrptedClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    edEncrypted.Text := dlgOpen.FileName;
end;

procedure TFormMain.BtnEncryptClick(Sender: TObject);
var
  Encoded: integer;
begin
  Encoded := encodefile(PChar(edSourceFile.Text),
                                PChar(edDestinationFile.Text),
                                  PChar(edPasswordFile.Text));
  if Encoded = 0 then
    showmessage('Message Encoded Successfully!!')
  else
    showmessage('Exception: ' + inttostr(Encoded));

end;

procedure TFormMain.btnEnEncodedClick(Sender: TObject);
begin
  if dlgOpen.Execute then
      edEnEncoded.Text := dlgOpen.FileName;
end;

procedure TFormMain.btnEnSourceClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    edEnSource.Text := dlgOpen.FileName;
end;

procedure TFormMain.BtnSecret2Click(Sender: TObject);
begin
  if dlgOpen.Execute then
    edPasswordFile2.Text := dlgOpen.FileName;
end;

procedure TFormMain.BtnSecretClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    edPasswordFile.Text := dlgOpen.FileName;
end;

procedure TFormMain.BtnSourceClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    edSourceFile.Text := dlgOpen.FileName;
end;

end.
