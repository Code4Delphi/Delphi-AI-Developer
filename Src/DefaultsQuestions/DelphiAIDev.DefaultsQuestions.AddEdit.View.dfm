object DelphiAIDevDefaultsQuestionsAddEditView: TDelphiAIDevDefaultsQuestionsAddEditView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'IA Developer - Defaults questions - [action]'
  ClientHeight = 389
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
    Top = 350
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
    Top = 354
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
    TabOrder = 1
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
    Height = 350
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = -2
    DesignSize = (
      674
      350)
    object Label1: TLabel
      Left = 35
      Top = 102
      Width = 43
      Height = 13
      Caption = 'Question'
    end
    object Bevel1: TBevel
      AlignWithMargins = True
      Left = 0
      Top = 346
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
      Top = 239
      Width = 28
      Height = 13
      Caption = 'Order'
    end
    object Label9: TLabel
      Left = 183
      Top = 13
      Width = 62
      Height = 13
      Caption = 'Menu master'
    end
    object Label2: TLabel
      Left = 35
      Top = 12
      Width = 20
      Height = 13
      Caption = 'Kind'
    end
    object Label3: TLabel
      Left = 35
      Top = 56
      Width = 37
      Height = 13
      Caption = 'Caption'
    end
    object edtOrder: TEdit
      Left = 35
      Top = 254
      Width = 126
      Height = 21
      MaxLength = 4
      NumbersOnly = True
      TabOrder = 4
      Text = '0'
    end
    object UpDown1: TUpDown
      Left = 161
      Top = 254
      Width = 17
      Height = 21
      Cursor = crHandPoint
      Associate = edtOrder
      Max = 9999
      TabOrder = 5
    end
    object ckVisible: TCheckBox
      Left = 35
      Top = 286
      Width = 53
      Height = 17
      Cursor = crHandPoint
      Caption = 'Visible'
      TabOrder = 6
    end
    object ckCodeOnly: TCheckBox
      Left = 35
      Top = 309
      Width = 70
      Height = 17
      Cursor = crHandPoint
      Caption = 'Code Only'
      TabOrder = 7
    end
    object cBoxMenuMaster: TComboBox
      Left = 183
      Top = 28
      Width = 450
      Height = 21
      Margins.Left = 10
      Margins.Top = 15
      Margins.Right = 0
      Margins.Bottom = 0
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      DropDownCount = 30
      TabOrder = 1
    end
    object mmQuestion: TMemo
      Left = 34
      Top = 118
      Width = 599
      Height = 116
      ScrollBars = ssVertical
      TabOrder = 3
    end
    object cBoxKind: TComboBox
      Left = 35
      Top = 28
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = cBoxKindChange
    end
    object edtCaption: TEdit
      Left = 35
      Top = 72
      Width = 598
      Height = 21
      TabOrder = 2
    end
  end
end
