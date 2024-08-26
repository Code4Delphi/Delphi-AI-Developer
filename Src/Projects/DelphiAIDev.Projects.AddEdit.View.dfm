object DelphiAIDevProjectsAddEditView: TDelphiAIDevProjectsAddEditView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'IA Developer - Project Config'
  ClientHeight = 230
  ClientWidth = 629
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    AlignWithMargins = True
    Left = 0
    Top = 191
    Width = 629
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
  object pnBody: TPanel
    Left = 0
    Top = 0
    Width = 629
    Height = 191
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object Bevel1: TBevel
      AlignWithMargins = True
      Left = 0
      Top = 187
      Width = 629
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
      Left = 24
      Top = 135
      Width = 79
      Height = 13
      Caption = 'Last generation:'
    end
    object lbLastGeneration: TLabel
      Left = 109
      Top = 135
      Width = 81
      Height = 13
      Caption = 'lbLastGeneration'
    end
    object Label2: TLabel
      Left = 24
      Top = 43
      Width = 55
      Height = 13
      Caption = 'Nickname'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 24
      Top = 95
      Width = 84
      Height = 13
      Caption = 'Database Default'
    end
    object cBoxDatabaseDefault: TComboBox
      Left = 24
      Top = 111
      Width = 577
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      OnClick = cBoxDatabaseDefaultClick
    end
    object edtNickname: TEdit
      Left = 24
      Top = 59
      Width = 577
      Height = 21
      TabOrder = 0
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 195
    Width = 629
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
    object btnConfirm: TButton
      AlignWithMargins = True
      Left = 401
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
      Left = 514
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
end
