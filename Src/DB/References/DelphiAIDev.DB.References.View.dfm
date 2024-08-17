object DelphiAIDevDBReferencesView: TDelphiAIDevDBReferencesView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'IA Developer - Databases References'
  ClientHeight = 161
  ClientWidth = 295
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    AlignWithMargins = True
    Left = 0
    Top = 122
    Width = 295
    Height = 1
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Align = alBottom
    Shape = bsTopLine
    ExplicitLeft = -87
    ExplicitTop = 264
    ExplicitWidth = 665
  end
  object Panel1: TPanel
    Left = 0
    Top = 126
    Width = 295
    Height = 35
    Align = alBottom
    BevelEdges = [beLeft, beRight, beBottom]
    BevelOuter = bvNone
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    ParentBackground = False
    TabOrder = 0
    object btnGenerate: TButton
      AlignWithMargins = True
      Left = 67
      Top = 2
      Width = 110
      Height = 31
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alRight
      Caption = 'Generate'
      TabOrder = 0
      OnClick = btnGenerateClick
    end
    object btnClose: TButton
      AlignWithMargins = True
      Left = 180
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
  end
  object Panel9: TPanel
    Left = 0
    Top = 0
    Width = 295
    Height = 122
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object Bevel1: TBevel
      AlignWithMargins = True
      Left = 0
      Top = 118
      Width = 295
      Height = 1
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Align = alBottom
      Shape = bsTopLine
      ExplicitTop = 444
      ExplicitWidth = 676
    end
    object Label1: TLabel
      Left = 37
      Top = 22
      Width = 79
      Height = 13
      Caption = 'Last generation:'
    end
    object lbLastGeneration: TLabel
      Left = 122
      Top = 22
      Width = 81
      Height = 13
      Caption = 'lbLastGeneration'
    end
    object ckAddFieldSize: TCheckBox
      Left = 37
      Top = 53
      Width = 99
      Height = 17
      Caption = 'Add Field Length'
      TabOrder = 0
    end
    object ckCompressData: TCheckBox
      Left = 37
      Top = 78
      Width = 93
      Height = 17
      Caption = 'Compress Data'
      TabOrder = 1
    end
  end
end
