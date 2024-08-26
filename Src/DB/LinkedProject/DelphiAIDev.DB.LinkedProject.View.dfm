object DelphiAIDevDBLinkedProjectView: TDelphiAIDevDBLinkedProjectView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'IA Developer - Linked Databese With Project'
  ClientHeight = 213
  ClientWidth = 629
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
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
    Top = 174
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
    Height = 174
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 624
    object Bevel1: TBevel
      AlignWithMargins = True
      Left = 0
      Top = 170
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
      Top = 101
      Width = 79
      Height = 13
      Caption = 'Last generation:'
    end
    object lbLastGeneration: TLabel
      Left = 109
      Top = 101
      Width = 81
      Height = 13
      Caption = 'lbLastGeneration'
    end
    object cBoxDatabases: TComboBox
      Left = 24
      Top = 77
      Width = 577
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnClick = cBoxDatabasesClick
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 178
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
    ExplicitWidth = 624
    object btnSaveLink: TButton
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
      Caption = 'Save link'
      TabOrder = 0
      OnClick = btnSaveLinkClick
      ExplicitLeft = 396
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
      ExplicitLeft = 509
    end
  end
end
