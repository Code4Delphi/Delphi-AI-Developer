object DelphiAIDevWaitingScreenView: TDelphiAIDevWaitingScreenView
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Wait for loading'
  ClientHeight = 68
  ClientWidth = 431
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnBody: TPanel
    Left = 0
    Top = 0
    Width = 431
    Height = 68
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object lbMsg: TLabel
      Left = 0
      Top = 0
      Width = 28
      Height = 17
      Align = alClient
      Alignment = taCenter
      Caption = 'xxxx'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
  end
end
