object DelphiAIDevDefaultsQuestionsAddEditView: TDelphiAIDevDefaultsQuestionsAddEditView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'IA Developer - Defaults questions - [action]'
  ClientHeight = 350
  ClientWidth = 674
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
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    AlignWithMargins = True
    Left = 0
    Top = 311
    Width = 674
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
    Top = 315
    Width = 674
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
    object btnConfirm: TButton
      AlignWithMargins = True
      Left = 446
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
      Left = 559
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
    Width = 674
    Height = 311
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      674
      311)
    object Label1: TLabel
      Left = 35
      Top = 54
      Width = 43
      Height = 13
      Caption = 'Question'
    end
    object Bevel1: TBevel
      AlignWithMargins = True
      Left = 0
      Top = 307
      Width = 674
      Height = 1
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Align = alBottom
      Shape = bsTopLine
      ExplicitTop = 444
      ExplicitWidth = 676
    end
    object Label4: TLabel
      Left = 35
      Top = 191
      Width = 28
      Height = 13
      Caption = 'Order'
    end
    object Label9: TLabel
      Left = 34
      Top = 13
      Width = 62
      Height = 13
      Caption = 'Menu master'
    end
    object edtOrder: TEdit
      Left = 35
      Top = 206
      Width = 126
      Height = 21
      MaxLength = 4
      NumbersOnly = True
      TabOrder = 0
      Text = '0'
    end
    object UpDown1: TUpDown
      Left = 161
      Top = 206
      Width = 17
      Height = 21
      Cursor = crHandPoint
      Associate = edtOrder
      Max = 9999
      TabOrder = 1
    end
    object ckVisible: TCheckBox
      Left = 35
      Top = 238
      Width = 53
      Height = 17
      Cursor = crHandPoint
      Caption = 'Visible'
      TabOrder = 2
    end
    object ckCodeOnly: TCheckBox
      Left = 35
      Top = 261
      Width = 70
      Height = 17
      Cursor = crHandPoint
      Caption = 'Code Only'
      TabOrder = 3
    end
    object cBoxMenuMaster: TComboBox
      Left = 34
      Top = 28
      Width = 597
      Height = 21
      Margins.Left = 10
      Margins.Top = 15
      Margins.Right = 0
      Margins.Bottom = 0
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      DropDownCount = 30
      TabOrder = 4
    end
    object mmQuestion: TMemo
      Left = 34
      Top = 70
      Width = 599
      Height = 116
      ScrollBars = ssVertical
      TabOrder = 5
    end
  end
end
