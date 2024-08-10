object DelphiAIDevDatabasesAddEditView: TDelphiAIDevDatabasesAddEditView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'IA Developer - Databases - [action]'
  ClientHeight = 307
  ClientWidth = 657
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    AlignWithMargins = True
    Left = 0
    Top = 268
    Width = 657
    Height = 1
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Align = alBottom
    Shape = bsTopLine
    ExplicitLeft = -5
    ExplicitTop = 476
    ExplicitWidth = 676
  end
  object Panel1: TPanel
    Left = 0
    Top = 272
    Width = 657
    Height = 35
    Align = alBottom
    BevelEdges = [beLeft, beRight, beBottom]
    BevelOuter = bvNone
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = 282
    object btnConfirm: TButton
      AlignWithMargins = True
      Left = 429
      Top = 2
      Width = 110
      Height = 31
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alRight
      Caption = 'Confirm'
      TabOrder = 0
      OnClick = btnConfirmClick
    end
    object btnClose: TButton
      AlignWithMargins = True
      Left = 542
      Top = 2
      Width = 110
      Height = 31
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alRight
      Caption = 'Close'
      TabOrder = 1
      OnClick = btnCloseClick
    end
    object btnTestConnection: TButton
      AlignWithMargins = True
      Left = 2
      Top = 2
      Width = 110
      Height = 31
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = 'Test Connection'
      TabOrder = 2
      OnClick = btnTestConnectionClick
      ExplicitLeft = 429
    end
  end
  object Panel9: TPanel
    Left = 0
    Top = 0
    Width = 657
    Height = 268
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    ExplicitHeight = 279
    object Bevel1: TBevel
      AlignWithMargins = True
      Left = 0
      Top = 264
      Width = 657
      Height = 1
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Align = alBottom
      Shape = bsTopLine
      ExplicitTop = 444
      ExplicitWidth = 676
    end
    object Label2: TLabel
      Left = 31
      Top = 25
      Width = 43
      Height = 13
      Caption = 'Driver ID'
    end
    object Label3: TLabel
      Left = 31
      Top = 71
      Width = 53
      Height = 13
      Caption = 'Description'
    end
    object Label1: TLabel
      Left = 234
      Top = 71
      Width = 22
      Height = 13
      Caption = 'Host'
    end
    object Label5: TLabel
      Left = 437
      Top = 71
      Width = 22
      Height = 13
      Caption = 'User'
    end
    object Label6: TLabel
      Left = 31
      Top = 120
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object Label7: TLabel
      Left = 234
      Top = 120
      Width = 20
      Height = 13
      Caption = 'Port'
    end
    object Label4: TLabel
      Left = 437
      Top = 120
      Width = 46
      Height = 13
      Caption = 'Database'
    end
    object Label8: TLabel
      Left = 31
      Top = 168
      Width = 47
      Height = 13
      Caption = 'VendorLib'
    end
    object lbAddLocalDatabase: TLabel
      Left = 262
      Top = 71
      Width = 99
      Height = 13
      Cursor = crHandPoint
      Caption = '[Add local database]'
      OnClick = lbAddLocalDatabaseClick
    end
    object cBoxDriverID: TComboBox
      Left = 31
      Top = 41
      Width = 200
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
    object edtDescription: TEdit
      Left = 31
      Top = 87
      Width = 200
      Height = 21
      TabOrder = 1
    end
    object edtHost: TEdit
      Left = 234
      Top = 87
      Width = 200
      Height = 21
      TabOrder = 2
    end
    object edtUser: TEdit
      Left = 437
      Top = 87
      Width = 200
      Height = 21
      TabOrder = 3
    end
    object edtPassword: TEdit
      Left = 31
      Top = 136
      Width = 164
      Height = 21
      PasswordChar = '*'
      TabOrder = 4
    end
    object edtPort: TEdit
      Left = 234
      Top = 136
      Width = 200
      Height = 21
      NumbersOnly = True
      TabOrder = 5
    end
    object edtDatabase: TEdit
      Left = 437
      Top = 136
      Width = 200
      Height = 21
      TabOrder = 6
    end
    object edtVendorLib: TEdit
      Left = 31
      Top = 184
      Width = 606
      Height = 21
      PasswordChar = '*'
      TabOrder = 7
    end
    object ckVisible: TCheckBox
      Left = 31
      Top = 216
      Width = 53
      Height = 17
      Cursor = crHandPoint
      Caption = 'Visible'
      TabOrder = 8
    end
    object Button1: TButton
      Left = 197
      Top = 135
      Width = 34
      Height = 23
      Cursor = crHandPoint
      Caption = 'View'
      TabOrder = 9
      OnClick = Button1Click
    end
  end
end
