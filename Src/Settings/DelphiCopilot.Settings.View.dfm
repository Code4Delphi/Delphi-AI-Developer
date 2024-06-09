object DelphiCopilotSettingsView: TDelphiCopilotSettingsView
  Left = 0
  Top = 0
  Caption = 'Copilot - Settings'
  ClientHeight = 516
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnBottom: TPanel
    Left = 0
    Top = 481
    Width = 632
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
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 632
    Height = 481
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnBody: TPanel
      Left = 0
      Top = 0
      Width = 632
      Height = 481
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      object gBoxGemini: TGroupBox
        Left = 0
        Top = 70
        Width = 632
        Height = 153
        Align = alTop
        Caption = ' Gemini '
        ParentBackground = False
        TabOrder = 0
        object pnGeminiBack: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 622
          Height = 130
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
            Left = 243
            Top = 5
            Width = 28
            Height = 13
            Caption = 'Model'
          end
          object Label8: TLabel
            Left = 476
            Top = 48
            Width = 38
            Height = 13
            Caption = 'Timeout'
          end
          object Label9: TLabel
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
            OnClick = lbGenerateAPIKeyClick
          end
          object Label10: TLabel
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
            OnClick = lbGenerateAPIKeyClick
          end
          object edtBaseUrlGemini: TEdit
            Left = 16
            Top = 20
            Width = 225
            Height = 21
            TabOrder = 0
            Text = 'https://generativelanguage.googleapis.com'
          end
          object edtApiKeyGemini: TEdit
            Left = 16
            Top = 64
            Width = 458
            Height = 21
            PasswordChar = '*'
            TabOrder = 1
            Text = 'sk-proj-iwJOetQ8OlplTT2WKjCZT3BlbkFJcaC4vk5zUaOLEwkXQkK6'
          end
          object cBoxModelGemini: TComboBox
            Left = 243
            Top = 20
            Width = 355
            Height = 21
            TabOrder = 2
            Items.Strings = (
              'v1/models/gemini-1.5-flash:generateContent'
              'v1beta/models/gemini-pro:generateContent'
              'v1beta/models/gemini-1.5-flash:generateContent')
          end
          object edtTimeoutGemini: TEdit
            Left = 476
            Top = 64
            Width = 122
            Height = 21
            NumbersOnly = True
            TabOrder = 3
            Text = '20'
          end
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 632
        Height = 70
        Align = alTop
        Caption = ' Preferences '
        ParentBackground = False
        TabOrder = 1
        object Label11: TLabel
          Left = 16
          Top = 19
          Width = 48
          Height = 13
          Caption = 'AI default'
        end
        object cBoxAIDefault: TComboBox
          Left = 16
          Top = 34
          Width = 201
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          Items.Strings = (
            'Gemini'
            'OpenAI (ChatGPT)')
        end
      end
      object gBoxOpenAI: TGroupBox
        Left = 0
        Top = 223
        Width = 632
        Height = 153
        Align = alTop
        Caption = ' OpenAI '
        ParentBackground = False
        TabOrder = 2
        object pnOpenAIBack: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 18
          Width = 622
          Height = 130
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
            Left = 476
            Top = 5
            Width = 28
            Height = 13
            Caption = 'Model'
          end
          object Label4: TLabel
            Left = 476
            Top = 48
            Width = 38
            Height = 13
            Caption = 'Timeout'
          end
          object lbGenerateAPIKey: TLabel
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
            OnClick = lbGenerateAPIKeyClick
          end
          object edtBaseUrlOpenAI: TEdit
            Left = 16
            Top = 21
            Width = 460
            Height = 21
            TabOrder = 0
            Text = 'https://api.openai.com/v1/chat/completions'
          end
          object edtApiKeyOpenAI: TEdit
            Left = 16
            Top = 64
            Width = 460
            Height = 21
            PasswordChar = '*'
            TabOrder = 1
            Text = 'sk-proj-iwJOetQ8OlplTT2WKjCZT3BlbkFJcaC4vk5zUaOLEwkXQkK6'
          end
          object cBoxModelOpenAI: TComboBox
            Left = 478
            Top = 21
            Width = 122
            Height = 21
            Style = csDropDownList
            TabOrder = 2
            Items.Strings = (
              'gpt-3.5-turbo'
              'gpt-3.5-turbo-16k'
              'gpt-4'
              'gpt-4-32k')
          end
          object edtTimeoutOpenAi: TEdit
            Left = 478
            Top = 64
            Width = 122
            Height = 21
            NumbersOnly = True
            TabOrder = 3
            Text = '20'
          end
        end
      end
    end
  end
end
