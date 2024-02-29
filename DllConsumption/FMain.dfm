object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'FormMain'
  ClientHeight = 477
  ClientWidth = 665
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object pgMain: TPageControl
    Left = 0
    Top = 1
    Width = 657
    Height = 467
    ActivePage = tsEncryption
    TabOrder = 0
    object tsEncryption: TTabSheet
      Caption = 'Encryption'
      object Panel1: TPanel
        Left = 333
        Top = 64
        Width = 305
        Height = 281
        TabOrder = 0
        object BtnDecrypt: TButton
          Left = 112
          Top = 240
          Width = 75
          Height = 25
          Caption = 'Decrypt'
          TabOrder = 0
          OnClick = BtnDecryptClick
        end
        object edEncrypted: TEdit
          Left = 16
          Top = 32
          Width = 193
          Height = 23
          TabOrder = 1
        end
        object edDecrypted: TEdit
          Left = 16
          Top = 80
          Width = 193
          Height = 23
          TabOrder = 2
        end
        object edPasswordFile2: TEdit
          Left = 16
          Top = 130
          Width = 193
          Height = 23
          TabOrder = 3
        end
        object BtnEncrpted: TButton
          Left = 215
          Top = 32
          Width = 82
          Height = 23
          Caption = 'Encrypted File'
          TabOrder = 4
          OnClick = BtnEncrptedClick
        end
        object BtnDecrypted: TButton
          Left = 215
          Top = 80
          Width = 82
          Height = 23
          Caption = 'Decrypted File'
          TabOrder = 5
          OnClick = BtnDecryptedClick
        end
        object BtnSecret2: TButton
          Left = 215
          Top = 130
          Width = 82
          Height = 23
          Caption = 'Secret Key'
          TabOrder = 6
          OnClick = BtnSecret2Click
        end
      end
      object PanelEncryption: TPanel
        Left = 8
        Top = 64
        Width = 305
        Height = 281
        TabOrder = 1
        object BtnEncrypt: TButton
          Left = 112
          Top = 240
          Width = 75
          Height = 25
          Caption = 'Encrypt'
          TabOrder = 0
          OnClick = BtnEncryptClick
        end
        object edSourceFile: TEdit
          Left = 16
          Top = 32
          Width = 193
          Height = 23
          TabOrder = 1
        end
        object edDestinationFile: TEdit
          Left = 16
          Top = 80
          Width = 193
          Height = 23
          TabOrder = 2
        end
        object edPasswordFile: TEdit
          Left = 16
          Top = 130
          Width = 193
          Height = 23
          TabOrder = 3
        end
        object BtnSource: TButton
          Left = 215
          Top = 32
          Width = 82
          Height = 23
          Caption = 'Source File'
          TabOrder = 4
          OnClick = BtnSourceClick
        end
        object BtnDest: TButton
          Left = 215
          Top = 80
          Width = 82
          Height = 23
          Caption = 'Encrypted File'
          TabOrder = 5
          OnClick = BtnDestClick
        end
        object BtnSecret: TButton
          Left = 215
          Top = 130
          Width = 82
          Height = 23
          Caption = 'Secret Key'
          TabOrder = 6
          OnClick = BtnSecretClick
        end
      end
    end
    object tsEncoding: TTabSheet
      Caption = 'Encoding'
      ImageIndex = 1
      object panelEncode: TPanel
        Left = 3
        Top = 40
        Width = 305
        Height = 281
        TabOrder = 0
        object btnEncode: TButton
          Left = 112
          Top = 240
          Width = 75
          Height = 25
          Caption = 'Encode'
          TabOrder = 0
          OnClick = btnEncodeClick
        end
        object edEnSource: TEdit
          Left = 16
          Top = 32
          Width = 193
          Height = 23
          TabOrder = 1
        end
        object edEnEncoded: TEdit
          Left = 16
          Top = 80
          Width = 193
          Height = 23
          TabOrder = 2
        end
        object Edit3: TEdit
          Left = 16
          Top = 130
          Width = 193
          Height = 23
          TabOrder = 3
          Visible = False
        end
        object btnEnSource: TButton
          Left = 215
          Top = 32
          Width = 82
          Height = 23
          Caption = 'Source File'
          TabOrder = 4
          OnClick = btnEnSourceClick
        end
        object btnEnEncoded: TButton
          Left = 215
          Top = 80
          Width = 82
          Height = 23
          Caption = 'Encoded File'
          TabOrder = 5
          OnClick = btnEnEncodedClick
        end
        object Button4: TButton
          Left = 215
          Top = 130
          Width = 82
          Height = 23
          Caption = 'Secret Key'
          TabOrder = 6
          Visible = False
          OnClick = BtnSecret2Click
        end
      end
      object panelDecode: TPanel
        Left = 333
        Top = 40
        Width = 305
        Height = 281
        TabOrder = 1
        object btnDecode: TButton
          Left = 112
          Top = 240
          Width = 75
          Height = 25
          Caption = 'Decode'
          TabOrder = 0
          OnClick = btnDecodeClick
        end
        object edDeEncoded: TEdit
          Left = 16
          Top = 32
          Width = 193
          Height = 23
          TabOrder = 1
        end
        object edDeDecoded: TEdit
          Left = 16
          Top = 80
          Width = 193
          Height = 23
          TabOrder = 2
        end
        object Edit6: TEdit
          Left = 16
          Top = 130
          Width = 193
          Height = 23
          TabOrder = 3
          Visible = False
        end
        object btnDeEncoded: TButton
          Left = 215
          Top = 32
          Width = 82
          Height = 23
          Caption = 'Encoded File'
          TabOrder = 4
          OnClick = btnDeEncodedClick
        end
        object btnDeDecoded: TButton
          Left = 215
          Top = 80
          Width = 82
          Height = 23
          Caption = 'Decoded File'
          TabOrder = 5
          OnClick = btnDeDecodedClick
        end
        object Button8: TButton
          Left = 215
          Top = 130
          Width = 82
          Height = 23
          Caption = 'Secret Key'
          TabOrder = 6
          Visible = False
          OnClick = BtnSecret2Click
        end
      end
    end
  end
  object dlgOpen: TOpenDialog
    Left = 8
    Top = 16
  end
end
