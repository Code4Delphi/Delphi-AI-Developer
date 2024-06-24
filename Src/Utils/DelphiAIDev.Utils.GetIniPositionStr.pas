unit DelphiAIDev.Utils.GetIniPositionStr;

interface

uses
  System.SysUtils,
  System.StrUtils;

type
  IDelphiAIDevUtilsGetIniPositionStr = interface
    ['{09DF37CF-FC90-49E9-8EB4-2105793B8432}']
    function WholeWordOnly(Value: Boolean): IDelphiAIDevUtilsGetIniPositionStr;
    function CaseSensitive(Value: Boolean): IDelphiAIDevUtilsGetIniPositionStr;
    function TextIgnore(Value: string): IDelphiAIDevUtilsGetIniPositionStr;
    function GetInitialPosition(const AStrOriginal, AStrToLocate: string; const APosIni: Longint): Longint;
  end;

  TDelphiAIDevUtilsGetIniPositionStr = class(TInterfacedObject, IDelphiAIDevUtilsGetIniPositionStr)
  private
    FFound: Boolean;
    FColCurrent: Longint;
    FStrOriginal: string;
    FStrToLocate: string;
    FWholeWordOnly: Boolean;
    FCaseSensitive: Boolean;
    FTextIgnore: string;
    procedure CheckWholeWord;
    function GetWholeWord: string;
    procedure CheckWordIgnore;
  protected
    function WholeWordOnly(Value: Boolean): IDelphiAIDevUtilsGetIniPositionStr;
    function CaseSensitive(Value: Boolean): IDelphiAIDevUtilsGetIniPositionStr;
    function TextIgnore(Value: string): IDelphiAIDevUtilsGetIniPositionStr;
    function GetInitialPosition(const AStrOriginal, AStrToLocate: string; const APosIni: Longint): Longint;
  public
    class function New: IDelphiAIDevUtilsGetIniPositionStr;
    constructor Create;
  end;

implementation

{$WARNINGS OFF}


class function TDelphiAIDevUtilsGetIniPositionStr.New: IDelphiAIDevUtilsGetIniPositionStr;
begin
  Result := Self.Create;
end;

constructor TDelphiAIDevUtilsGetIniPositionStr.Create;
begin
  FWholeWordOnly := False;
  FCaseSensitive := False;
  FTextIgnore := '';
end;

function TDelphiAIDevUtilsGetIniPositionStr.WholeWordOnly(Value: Boolean): IDelphiAIDevUtilsGetIniPositionStr;
begin
  Result := Self;
  FWholeWordOnly := Value;
end;

function TDelphiAIDevUtilsGetIniPositionStr.CaseSensitive(Value: Boolean): IDelphiAIDevUtilsGetIniPositionStr;
begin
  Result := Self;
  FCaseSensitive := Value;
end;

function TDelphiAIDevUtilsGetIniPositionStr.TextIgnore(Value: string): IDelphiAIDevUtilsGetIniPositionStr;
begin
  Result := Self;
  FTextIgnore := Value;
end;

//ESTA ROTINA CONFERE DE A LETRA ANTERIOR/POSTERIOR A PALAVRA FECHA COM VAZIO OU NÃO LETRA NEM NUMERO
procedure TDelphiAIDevUtilsGetIniPositionStr.CheckWholeWord;
begin
  if((IfThen(FColCurrent = 0, '', Copy(FStrOriginal, FColCurrent - 1, 1)) <> '')and(Copy(FStrOriginal, FColCurrent - 1, 1)[1] in ['0'..'9', 'A'..'Z', 'a'..'z']))
    or((IfThen(FColCurrent = 0, '', Copy(FStrOriginal, FColCurrent + Length(FStrToLocate), 1)) <> '')and(Copy(FStrOriginal, FColCurrent + Length(FStrToLocate), 1)[1] in ['0'..'9', 'A'..'Z', 'a'..'z']))
  then
    FFound := False;
end;

function TDelphiAIDevUtilsGetIniPositionStr.GetWholeWord: string;
var
  LColIni: Integer;
  LColEnd: Integer;
  LLastColLine: Integer;
  LChar: Char;
begin
  Result := '';
  if(FStrToLocate = ' ')then
    Exit;

  Result := FStrOriginal[FColCurrent];

  LColIni := FColCurrent;
  if(LColIni > 0)then
  begin
    Dec(LColIni);
    LChar := FStrOriginal[LColIni];
    while(LChar in ['0'..'9', 'A'..'Z', 'a'..'z'])do
    begin
      Result := LChar + Result;
      Dec(LColIni);
      LChar := FStrOriginal[LColIni];
    end;
  end;

  LColEnd := FColCurrent;
  LLastColLine := FStrOriginal.Length;
  if(LColEnd < LLastColLine)then
  begin
    Inc(LColEnd);
    LChar := FStrOriginal[LColEnd];
    while(LChar in ['0'..'9', 'A'..'Z', 'a'..'z'])do
    begin
      Result := Result + LChar;
      Inc(LColEnd);
      LChar := FStrOriginal[LColEnd];
    end;
  end;
end;

procedure TDelphiAIDevUtilsGetIniPositionStr.CheckWordIgnore;
var
  LStrValidate: string;
  LStrIgnore: string;
begin
  if(FTextIgnore.Trim.IsEmpty)then
    Exit;

  LStrValidate := Self.GetWholeWord;
  if(LStrValidate.Trim.IsEmpty)then
    Exit;

  LStrIgnore := FTextIgnore;
  if(not FCaseSensitive)then
  begin
    LStrValidate := LStrValidate.ToLower;
    LStrIgnore := LStrIgnore.ToLower;
  end;

  if(LStrValidate.Contains(LStrIgnore))then
    FFound := False;
end;

function TDelphiAIDevUtilsGetIniPositionStr.GetInitialPosition(const AStrOriginal, AStrToLocate: string; const APosIni: Longint): Longint;
var
  LColCurrent: Longint;
begin
  Result := -1;
  FFound := False;
  FStrOriginal := AStrOriginal;
  FStrToLocate := AStrToLocate;
  for LColCurrent := APosIni to (Length(FStrOriginal) - Length(FStrToLocate) + 1) do
  begin
    FColCurrent := LColCurrent;

    if(FCaseSensitive)then
      FFound := FStrToLocate = Copy(FStrOriginal, FColCurrent, Length(FStrToLocate))
    else
      FFound := AnsiUpperCase(FStrToLocate) = AnsiUpperCase(Copy(FStrOriginal, FColCurrent, Length(FStrToLocate)));

    if(FFound)and(FWholeWordOnly)then
      Self.CheckWholeWord;

    if(FFound)then
      Self.CheckWordIgnore;

    if(FFound)then
    begin
      Result := FColCurrent - 1;
      if(Result < 0)then
        Result := 0;
      Break;
    end;
  end;
end;

end.
