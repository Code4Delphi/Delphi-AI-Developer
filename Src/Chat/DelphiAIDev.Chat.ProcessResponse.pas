unit DelphiAIDev.Chat.ProcessResponse;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes,
  Winapi.Windows,
  Winapi.Messages,
  Vcl.ComCtrls,
  Vcl.Graphics,
  DelphiAIDev.Consts,
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA,
  DelphiAIDev.Settings;

type
  TDelphiAIDevChatProcessResponse = class
  private
    FRichEdit: TRichEdit;
    FSettings: TDelphiAIDevSettings;
    FCurrentColor: TColor;
    procedure AddResponseLine(const ALineStr: string);
    procedure BoldInWordsBetweenBacktick(const ALineStr: string);
    procedure BoldInWordsBetweenTwoAsterisk(const ALineStr: string);
  public
    constructor Create(const ARichEdit: TRichEdit);
    procedure AddResponseComplete(const AStrings: TStrings);
  end;

implementation

const
  BACKTICK = '`';
  ASTERISK = '*';

constructor TDelphiAIDevChatProcessResponse.Create(const ARichEdit: TRichEdit);
begin
  FRichEdit := ARichEdit;
  FSettings := TDelphiAIDevSettings.GetInstance;
end;

//Add line-by-line response to color where Delphi code is
procedure TDelphiAIDevChatProcessResponse.AddResponseComplete(const AStrings: TStrings);
var
  LLineNum: Integer;
  LLineStr: string;
  LCodeStarted: Boolean;
begin
  FRichEdit.Lines.Clear;
  FCurrentColor := TUtilsOTA.ActiveThemeColorDefault;
  FRichEdit.SelAttributes.Color := FCurrentColor;
  FRichEdit.SelAttributes.Style := [];

  LCodeStarted := False;
  for LLineNum := 0 to Pred(AStrings.Count) do
  begin
    LLineStr := AStrings[LLineNum].TrimRight;

    if not LCodeStarted then
    begin
      if TUtils.CodeIdMarkBeginCode(LLineStr) then
      begin
        LCodeStarted := True;
        Continue;
      end;
    end;

    if LLineStr.Trim = TConsts.MARK_END then
    begin
      LCodeStarted := False;
      FCurrentColor := TUtilsOTA.ActiveThemeColorDefault;
      FRichEdit.SelAttributes.Color := FCurrentColor;
      Continue;
    end;

    if LCodeStarted then
    begin
      if (FSettings.ColorHighlightCodeDelphiUse) and (FSettings.ColorHighlightCodeDelphi <> clNone) then
        FCurrentColor := FSettings.ColorHighlightCodeDelphi
      else
        FCurrentColor := TUtilsOTA.ActiveThemeForCode;
    end
    else
      FCurrentColor := TUtilsOTA.ActiveThemeColorDefault;

    FRichEdit.SelAttributes.Color := FCurrentColor;

    //Optional use of one of the following lines
    //FRichEdit.Lines.Add(LLineStr);
    Self.AddResponseLine(LLineStr);
  end;
  //Self.Last;
end;

procedure TDelphiAIDevChatProcessResponse.AddResponseLine(const ALineStr: string);
begin
  if ALineStr.Contains(BACKTICK) then
    Self.BoldInWordsBetweenBacktick(ALineStr)
  else if ALineStr.Contains(ASTERISK + ASTERISK) then
    Self.BoldInWordsBetweenTwoAsterisk(ALineStr)
  else
    FRichEdit.Lines.Add(IfThen(ALineStr.IsEmpty, ' ', ALineStr));
end;

procedure TDelphiAIDevChatProcessResponse.BoldInWordsBetweenBacktick(const ALineStr: string);
var
  LPosLetter: Integer;
  LCurrentLetter: Char;
  LNextLetter: Char;
  LLineStarted: Boolean;
  LCodeStarted: Boolean;
begin
  LLineStarted := False;
  LCodeStarted := False;
  for LPosLetter := 0 to ALineStr.Length do
  begin
    LCurrentLetter := ALineStr[LPosLetter];
    LNextLetter := ALineStr[Succ(LPosLetter)];

    if not LCodeStarted then
    begin
      if (LCurrentLetter = BACKTICK) and (LNextLetter <> BACKTICK) then
      begin
        LCodeStarted := True;
        Continue;
      end;
    end;

    if (LCurrentLetter = BACKTICK) and (LNextLetter <> BACKTICK) then
    begin
      LCodeStarted := False;
      FRichEdit.SelAttributes.Style := [];
      Continue;
    end;

    SendMessage(FRichEdit.Handle, WM_VSCROLL, SB_BOTTOM, 0);
    if LCodeStarted then
      FRichEdit.SelAttributes.Style := [fsBold]
    else
      FRichEdit.SelAttributes.Style := [];

    FRichEdit.SelAttributes.Color := FCurrentColor;

    if LLineStarted then
      FRichEdit.SelText := LCurrentLetter
    else
    begin
      FRichEdit.Lines.Add('');
      FRichEdit.SelText := LCurrentLetter;

      LLineStarted := True;
    end;
    SendMessage(FRichEdit.Handle, WM_VSCROLL, SB_BOTTOM, 0);
  end;
  FRichEdit.SelText := ' ';
  SendMessage(FRichEdit.Handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure TDelphiAIDevChatProcessResponse.BoldInWordsBetweenTwoAsterisk(const ALineStr: string);
var
  LPosLetter: Integer;
  LCurrentLetter: Char;
  LNextLetter: Char;
  LLineStarted: Boolean;
  LCodeStarted: Boolean;
begin
  LLineStarted := False;
  LCodeStarted := False;

  LPosLetter := 0;
  while LPosLetter <= ALineStr.Length do
  begin
    LCurrentLetter := ALineStr[LPosLetter];
    LNextLetter := ALineStr[Succ(LPosLetter)];

    if not LCodeStarted then
    begin
      if (LCurrentLetter = ASTERISK) and (LNextLetter = ASTERISK) then
      begin
        LCodeStarted := True;
        Inc(LPosLetter, 2);
        Continue;
      end;
    end;

    if (LCurrentLetter = ASTERISK) and (LNextLetter = ASTERISK) then
    begin
      LCodeStarted := False;
      FRichEdit.SelAttributes.Style := [];
      Inc(LPosLetter, 2);
      Continue;
    end;

    SendMessage(FRichEdit.Handle, WM_VSCROLL, SB_BOTTOM, 0);
    if LCodeStarted then
      FRichEdit.SelAttributes.Style := [fsBold]
    else
      FRichEdit.SelAttributes.Style := [];

    FRichEdit.SelAttributes.Color := FCurrentColor;

    if LLineStarted then
      FRichEdit.SelText := LCurrentLetter
    else
    begin
      FRichEdit.Lines.Add('');
      FRichEdit.SelText := LCurrentLetter;

      LLineStarted := True;
    end;
    SendMessage(FRichEdit.Handle, WM_VSCROLL, SB_BOTTOM, 0);
    Inc(LPosLetter);
  end;
  FRichEdit.SelText := ' ';
  SendMessage(FRichEdit.Handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

end.
