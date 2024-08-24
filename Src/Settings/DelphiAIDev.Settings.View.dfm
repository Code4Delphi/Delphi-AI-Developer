object DelphiAIDevSettingsView: TDelphiAIDevSettingsView
  Left = 0
  Top = 0
  Caption = 'Delphi AI Developer - Settings'
  ClientHeight = 647
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
    Height = 647
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnBody: TPanel
      Left = 0
      Top = 0
      Width = 632
      Height = 612
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 0
        Top = 608
        Width = 632
        Height = 1
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Align = alBottom
        Shape = bsTopLine
        ExplicitTop = 158
        ExplicitWidth = 441
      end
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 0
        Top = 475
        Width = 632
        Height = 1
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Align = alTop
        Shape = bsTopLine
      end
      object Bevel3: TBevel
        AlignWithMargins = True
        Left = 0
        Top = 347
        Width = 632
        Height = 1
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Align = alTop
        Shape = bsTopLine
      end
      object Bevel4: TBevel
        AlignWithMargins = True
        Left = 0
        Top = 218
        Width = 632
        Height = 1
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Align = alTop
        Shape = bsTopLine
      end
      object Bevel5: TBevel
        AlignWithMargins = True
        Left = 0
        Top = 90
        Width = 632
        Height = 1
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Align = alTop
        Shape = bsTopLine
      end
      object gBoxGemini: TGroupBox
        Left = 0
        Top = 94
        Width = 632
        Height = 124
        Align = alTop
        Caption = ' Gemini (Google) '
        ParentBackground = False
        TabOrder = 1
        object pnGeminiBack: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 622
          Height = 101
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
            Top = 44
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
            Top = 83
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
            Top = 83
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
            Top = 59
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
            Top = 83
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
            Top = 60
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
        Height = 90
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
          Top = 63
          Width = 133
          Height = 22
          TabOrder = 3
        end
        object ckColorHighlightCodeDelphiUse: TCheckBox
          Left = 21
          Top = 65
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
        Top = 222
        Width = 632
        Height = 125
        Align = alTop
        Caption = ' ChatGPT (OpenAI)'
        ParentBackground = False
        TabOrder = 2
        object pnOpenAIBack: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 622
          Height = 102
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
            Top = 44
            Width = 37
            Height = 13
            Caption = 'API key'
          end
          object Label2: TLabel
            Left = 374
            Top = 5
            Width = 28
            Height = 13
            Caption = 'Model'
          end
          object lbLinkGpt01: TLabel
            Left = 16
            Top = 84
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
            Top = 59
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
            Top = 84
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
            Width = 356
            Height = 21
            TabOrder = 0
          end
          object edtApiKeyOpenAI: TEdit
            Left = 16
            Top = 60
            Width = 563
            Height = 21
            PasswordChar = '*'
            TabOrder = 2
          end
          object cBoxModelOpenAI: TComboBox
            Left = 374
            Top = 21
            Width = 226
            Height = 21
            TabOrder = 1
            Items.Strings = (
              'gpt-3.5-turbo'
              'gpt-3.5-turbo-16k'
              'gpt-4'
              'gpt-4o-2024-05-13'
              'gpt-4o-2024-08-06')
          end
        end
      end
      object gBoxGroq: TGroupBox
        Left = 0
        Top = 351
        Width = 632
        Height = 124
        Align = alTop
        Caption = ' Groq '
        ParentBackground = False
        TabOrder = 3
        object pnGroqBack: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 622
          Height = 101
          Align = alClient
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 0
          object Label8: TLabel
            Left = 16
            Top = 5
            Width = 45
            Height = 13
            Caption = 'Base URL'
          end
          object Label9: TLabel
            Left = 16
            Top = 44
            Width = 37
            Height = 13
            Caption = 'API key'
          end
          object Label10: TLabel
            Left = 374
            Top = 5
            Width = 28
            Height = 13
            Caption = 'Model'
          end
          object lbLinkGroq01: TLabel
            Left = 16
            Top = 84
            Width = 86
            Height = 13
            Cursor = crHandPoint
            Hint = 'https://console.groq.com/keys'
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
          object btnApiKeyGroqView: TSpeedButton
            Left = 582
            Top = 59
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
            OnClick = btnApiKeyGroqViewClick
          end
          object lbLinkGroq02: TLabel
            Left = 128
            Top = 84
            Width = 72
            Height = 13
            Cursor = crHandPoint
            Hint = 'https://console.groq.com/docs/quickstart'
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
          object lbLinkGroq03: TLabel
            Left = 232
            Top = 84
            Width = 59
            Height = 13
            Cursor = crHandPoint
            Hint = 'https://console.groq.com/docs/models'
            Caption = 'Groq Models'
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
          object edtBaseUrlGroq: TEdit
            Left = 16
            Top = 21
            Width = 356
            Height = 21
            TabOrder = 0
          end
          object edtApiKeyGroq: TEdit
            Left = 16
            Top = 60
            Width = 563
            Height = 21
            PasswordChar = '*'
            TabOrder = 2
          end
          object cBoxModelGroq: TComboBox
            Left = 374
            Top = 21
            Width = 226
            Height = 21
            TabOrder = 1
            Items.Strings = (
              'llama3-8b-8192'
              'llama3-70b-8192'
              'llama3-groq-8b-8192-tool-use-preview'
              'llama3-groq-70b-8192-tool-use-preview'
              'mixtral-8x7b-32768'
              'gemma-7b-it'
              'gemma2-9b-it'
              'whisper-large-v3')
          end
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 479
        Width = 632
        Height = 129
        Align = alClient
        Caption = ' Ollama (offline) '
        ParentBackground = False
        TabOrder = 4
        object Panel1: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 622
          Height = 106
          Align = alClient
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 0
          object Label12: TLabel
            Left = 16
            Top = 5
            Width = 45
            Height = 13
            Caption = 'Base URL'
          end
          object Label13: TLabel
            Left = 16
            Top = 44
            Width = 29
            Height = 13
            Caption = 'Token'
          end
          object Label14: TLabel
            Left = 374
            Top = 5
            Width = 28
            Height = 13
            Caption = 'Model'
          end
          object btnApiKeyOllamaView: TSpeedButton
            Left = 582
            Top = 59
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
            OnClick = btnApiKeyOllamaViewClick
          end
          object lbLinkOllama02: TLabel
            Left = 128
            Top = 84
            Width = 72
            Height = 13
            Cursor = crHandPoint
            Hint = 'https://github.com/ollama/ollama/blob/main/docs/api.md'
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
          object lbLinkOllama03: TLabel
            Left = 232
            Top = 84
            Width = 68
            Height = 13
            Cursor = crHandPoint
            Hint = 'https://ollama.com/library'
            Caption = 'Ollama Models'
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
          object lbLinkOllama01: TLabel
            Left = 16
            Top = 84
            Width = 82
            Height = 13
            Cursor = crHandPoint
            Hint = 'https://ollama.com/'
            Caption = 'Ollama Download'
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
          object edtBaseUrlOllama: TEdit
            Left = 16
            Top = 21
            Width = 356
            Height = 21
            TabOrder = 0
          end
          object edtApiKeyOllama: TEdit
            Left = 16
            Top = 60
            Width = 563
            Height = 21
            PasswordChar = '*'
            TabOrder = 2
          end
          object cBoxModelOllama: TComboBox
            Left = 374
            Top = 21
            Width = 226
            Height = 21
            TabOrder = 1
            Items.Strings = (
              'llama2'
              'llama3'
              'llama3.1'
              'codellama'
              'tinyllama'
              'mistral')
          end
        end
      end
    end
    object pnBottom: TPanel
      Left = 0
      Top = 612
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
        Top = 7
        Width = 80
        Height = 13
        Cursor = crHandPoint
        Margins.Left = 16
        Margins.Top = 5
        Margins.Bottom = 5
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
      end
      object lbOpenDataFolder: TLabel
        AlignWithMargins = True
        Left = 115
        Top = 7
        Width = 85
        Height = 13
        Cursor = crHandPoint
        Margins.Left = 16
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alLeft
        Caption = 'Open Data Folder'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Layout = tlCenter
        OnClick = lbOpenDataFolderClick
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
