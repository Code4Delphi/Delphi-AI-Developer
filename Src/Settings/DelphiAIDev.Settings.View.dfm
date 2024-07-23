object DelphiAIDevSettingsView: TDelphiAIDevSettingsView
  Left = 0
  Top = 0
  Caption = 'Delphi AI Developer - Settings'
  ClientHeight = 537
  ClientWidth = 632
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
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnBackAll: TPanel
    Left = 0
    Top = 0
    Width = 632
    Height = 537
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnBody: TPanel
      Left = 0
      Top = 0
      Width = 632
      Height = 502
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      object gBoxGemini: TGroupBox
        Left = 0
        Top = 110
        Width = 632
        Height = 163
        Align = alTop
        Caption = ' Gemini (Google) '
        ParentBackground = False
        TabOrder = 1
        object pnGeminiBack: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 622
          Height = 140
          Align = alClient
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 0
          object Label5: TLabel
            Left = 16
            Top = 5
            Width = 45
            Height = 13
            Caption = 'Base URL'
          end
          object Label6: TLabel
            Left = 16
            Top = 48
            Width = 37
            Height = 13
            Caption = 'API key'
          end
          object Label7: TLabel
            Left = 267
            Top = 5
            Width = 28
            Height = 13
            Caption = 'Model'
          end
          object lbLinkGemini01: TLabel
            Left = 16
            Top = 103
            Width = 86
            Height = 13
            Cursor = crHandPoint
            Hint = 'https://aistudio.google.com/app/apikey'
            Caption = 'Generate API Key'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = lbLinkGpt01Click
          end
          object lbLinkGemini02: TLabel
            Left = 128
            Top = 103
            Width = 72
            Height = 13
            Cursor = crHandPoint
            Hint = 'https://ai.google.dev/gemini-api/docs/api-overview#curl_1'
            Caption = 'Documentation'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = lbLinkGpt01Click
          end
          object btnApiKeyGeminiView: TSpeedButton
            Left = 582
            Top = 63
            Width = 23
            Height = 22
            Cursor = crHandPoint
            Hint = 'Show/Hide API Key'
            Flat = True
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FF4A667C
              BE9596FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FF6B9CC31E89E84B7AA3C89693FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4BB4FE51B5FF
              2089E94B7AA2C69592FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FF51B7FE51B3FF1D87E64E7AA0CA9792FF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              51B7FE4EB2FF1F89E64E7BA2B99497FF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF52B8FE4BB1FF2787D95F6A76FF
              00FFB0857FC09F94C09F96BC988EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF55BDFFB5D6EDBF9D92BB9B8CE7DAC2FFFFE3FFFFE5FDFADAD8C3
              B3B58D85FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCEA795FD
              EEBEFFFFD8FFFFDAFFFFDBFFFFE6FFFFFBEADDDCAE837FFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFC1A091FBDCA8FEF7D0FFFFDBFFFFE3FFFFF8FFFF
              FDFFFFFDC6A99CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC1A091FEE3ACF1
              C491FCF2CAFFFFDDFFFFE4FFFFF7FFFFF7FFFFE9EEE5CBB9948CFF00FFFF00FF
              FF00FFFF00FFFF00FFC2A191FFE6AEEEB581F7DCAEFEFDD8FFFFDFFFFFE3FFFF
              E4FFFFE0F3ECD2BB968EFF00FFFF00FFFF00FFFF00FFFF00FFBC978CFBE7B7F4
              C791F2C994F8E5B9FEFCD8FFFFDDFFFFDCFFFFE0E2D2BAB68E86FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFD9C3A9FFFEE5F7DCB8F2C994F5D4A5FAE8BDFDF4
              C9FDFBD6B69089FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB58D85E8
              DEDDFFFEF2F9D8A3F4C48CF9D49FFDEAB8D0B49FB89086FF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFAD827FC9AA9EEFE0B7EFDFB2E7CEACB890
              86B89086FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFBA968ABB988CB79188FF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnApiKeyGeminiViewClick
          end
          object lbLinkGemini03: TLabel
            Left = 232
            Top = 103
            Width = 67
            Height = 13
            Cursor = crHandPoint
            Hint = 'https://ai.google.dev/gemini-api/docs/models/gemini?hl=pt-br'
            Caption = 'Gemini Models'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = lbLinkGpt01Click
          end
          object edtBaseUrlGemini: TEdit
            Left = 16
            Top = 20
            Width = 249
            Height = 21
            TabOrder = 0
          end
          object edtApiKeyGemini: TEdit
            Left = 16
            Top = 64
            Width = 563
            Height = 21
            PasswordChar = '*'
            TabOrder = 2
          end
          object cBoxModelGemini: TComboBox
            Left = 267
            Top = 20
            Width = 333
            Height = 21
            TabOrder = 1
            Items.Strings = (
              'v1/models/gemini-1.5-flash:generateContent'
              'v1beta/models/gemini-pro:generateContent'
              'v1beta/models/gemini-1.5-flash:generateContent')
          end
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 632
        Height = 110
        Align = alTop
        Caption = ' Preferences '
        ParentBackground = False
        TabOrder = 0
        object Label11: TLabel
          Left = 272
          Top = 23
          Width = 48
          Height = 13
          Caption = 'AI default'
        end
        object Label4: TLabel
          Left = 21
          Top = 23
          Width = 133
          Height = 13
          Caption = 'Language used in questions'
        end
        object cBoxAIDefault: TComboBox
          Left = 272
          Top = 38
          Width = 333
          Height = 21
          Style = csDropDownList
          TabOrder = 1
          Items.Strings = (
            '')
        end
        object ColorBoxColorHighlightCodeDelphi: TColorBox
          Left = 218
          Top = 72
          Width = 133
          Height = 22
          TabOrder = 3
        end
        object ckColorHighlightCodeDelphiUse: TCheckBox
          Left = 21
          Top = 74
          Width = 194
          Height = 17
          Caption = 'Color to highlight Delphi/Pascal code'
          TabOrder = 2
          OnClick = ckColorHighlightCodeDelphiUseClick
        end
        object cBoxLanguageQuestions: TComboBox
          Left = 21
          Top = 38
          Width = 249
          Height = 21
          Hint = 'What is the standard language for questions?'
          Style = csDropDownList
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
      end
      object gBoxOpenAI: TGroupBox
        Left = 0
        Top = 273
        Width = 632
        Height = 163
        Align = alTop
        Caption = ' ChatGPT (OpenAI)'
        ParentBackground = False
        TabOrder = 2
        object pnOpenAIBack: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 622
          Height = 140
          Align = alClient
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 0
          object Label1: TLabel
            Left = 16
            Top = 5
            Width = 45
            Height = 13
            Caption = 'Base URL'
          end
          object Label3: TLabel
            Left = 16
            Top = 48
            Width = 37
            Height = 13
            Caption = 'API key'
          end
          object Label2: TLabel
            Left = 478
            Top = 5
            Width = 28
            Height = 13
            Caption = 'Model'
          end
          object lbLinkGpt01: TLabel
            Left = 16
            Top = 103
            Width = 86
            Height = 13
            Cursor = crHandPoint
            Hint = 'https://platform.openai.com/api-keys'
            Caption = 'Generate API Key'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = lbLinkGpt01Click
          end
          object btnApiKeyOpenAIView: TSpeedButton
            Left = 582
            Top = 63
            Width = 23
            Height = 22
            Cursor = crHandPoint
            Hint = 'Show/Hide API Key'
            Flat = True
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FF4A667C
              BE9596FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FF6B9CC31E89E84B7AA3C89693FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4BB4FE51B5FF
              2089E94B7AA2C69592FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FF51B7FE51B3FF1D87E64E7AA0CA9792FF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              51B7FE4EB2FF1F89E64E7BA2B99497FF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF52B8FE4BB1FF2787D95F6A76FF
              00FFB0857FC09F94C09F96BC988EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF55BDFFB5D6EDBF9D92BB9B8CE7DAC2FFFFE3FFFFE5FDFADAD8C3
              B3B58D85FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCEA795FD
              EEBEFFFFD8FFFFDAFFFFDBFFFFE6FFFFFBEADDDCAE837FFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFC1A091FBDCA8FEF7D0FFFFDBFFFFE3FFFFF8FFFF
              FDFFFFFDC6A99CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC1A091FEE3ACF1
              C491FCF2CAFFFFDDFFFFE4FFFFF7FFFFF7FFFFE9EEE5CBB9948CFF00FFFF00FF
              FF00FFFF00FFFF00FFC2A191FFE6AEEEB581F7DCAEFEFDD8FFFFDFFFFFE3FFFF
              E4FFFFE0F3ECD2BB968EFF00FFFF00FFFF00FFFF00FFFF00FFBC978CFBE7B7F4
              C791F2C994F8E5B9FEFCD8FFFFDDFFFFDCFFFFE0E2D2BAB68E86FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFD9C3A9FFFEE5F7DCB8F2C994F5D4A5FAE8BDFDF4
              C9FDFBD6B69089FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB58D85E8
              DEDDFFFEF2F9D8A3F4C48CF9D49FFDEAB8D0B49FB89086FF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFAD827FC9AA9EEFE0B7EFDFB2E7CEACB890
              86B89086FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFBA968ABB988CB79188FF00FFFF00FFFF00FFFF00FF}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnApiKeyOpenAIViewClick
          end
          object lbLinkGpt02: TLabel
            Left = 128
            Top = 103
            Width = 72
            Height = 13
            Cursor = crHandPoint
            Hint = 'https://platform.openai.com/docs/api-reference/making-requests'
            Caption = 'Documentation'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = lbLinkGpt01Click
          end
          object edtBaseUrlOpenAI: TEdit
            Left = 16
            Top = 21
            Width = 460
            Height = 21
            TabOrder = 0
          end
          object edtApiKeyOpenAI: TEdit
            Left = 16
            Top = 64
            Width = 563
            Height = 21
            PasswordChar = '*'
            TabOrder = 2
          end
          object cBoxModelOpenAI: TComboBox
            Left = 478
            Top = 21
            Width = 122
            Height = 21
            Style = csDropDownList
            TabOrder = 1
            Items.Strings = (
              'gpt-3.5-turbo'
              'gpt-3.5-turbo-16k'
              'gpt-4'
              'gpt-4-32k')
          end
        end
      end
      object gboxData: TGroupBox
        Left = 0
        Top = 436
        Width = 632
        Height = 58
        Align = alTop
        Caption = ' Data '
        Padding.Left = 2
        Padding.Top = 5
        Padding.Bottom = 3
        TabOrder = 3
        object btnOpenDataFolder: TButton
          Left = 4
          Top = 20
          Width = 122
          Height = 33
          Cursor = crHandPoint
          Align = alLeft
          Caption = 'Open Data Folder'
          TabOrder = 0
          OnClick = btnOpenDataFolderClick
        end
      end
    end
    object pnBottom: TPanel
      Left = 0
      Top = 502
      Width = 632
      Height = 35
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alBottom
      BevelEdges = [beLeft, beRight, beBottom]
      BevelOuter = bvNone
      Padding.Top = 2
      Padding.Right = 2
      Padding.Bottom = 2
      ParentBackground = False
      TabOrder = 1
      object lbRestoreDefaults: TLabel
        AlignWithMargins = True
        Left = 16
        Top = 12
        Width = 80
        Height = 18
        Cursor = crHandPoint
        Margins.Left = 16
        Margins.Top = 10
        Align = alLeft
        Caption = 'Restore defaults'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Layout = tlCenter
        OnClick = lbRestoreDefaultsClick
        ExplicitHeight = 13
      end
      object btnConfirm: TButton
        AlignWithMargins = True
        Left = 404
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
        Left = 517
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
end
