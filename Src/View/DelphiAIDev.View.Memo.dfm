object DelphiAIDevViewMemo: TDelphiAIDevViewMemo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Delphi AI Developer'
  ClientHeight = 351
  ClientWidth = 839
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
  PixelsPerInch = 96
  TextHeight = 13
  object pnMemo: TPanel
    Left = 0
    Top = 0
    Width = 839
    Height = 316
    Align = alClient
    BevelKind = bkTile
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object mmMensagem: TMemo
      AlignWithMargins = True
      Left = 10
      Top = 10
      Width = 815
      Height = 292
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      BorderStyle = bsNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnKeyDown = mmMensagemKeyDown
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 316
    Width = 839
    Height = 35
    Align = alBottom
    BevelEdges = [beLeft, beRight, beBottom]
    BevelKind = bkTile
    BevelOuter = bvNone
    Color = clWindow
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    ParentBackground = False
    TabOrder = 1
    object btnOK: TButton
      Left = 723
      Top = 2
      Width = 110
      Height = 29
      Cursor = crHandPoint
      Align = alRight
      Caption = 'OK'
      TabOrder = 0
      OnClick = btnOKClick
    end
  end
end
