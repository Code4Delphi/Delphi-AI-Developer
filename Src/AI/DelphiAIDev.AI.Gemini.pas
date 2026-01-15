unit DelphiAIDev.AI.Gemini;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Classes,
  RESTRequest4D,
  DelphiAIDev.Consts,
  DelphiAIDev.Utils,
  DelphiAIDev.Settings,
  DelphiAIDev.AI.Interfaces,
  System.StrUtils,
  System.Character,
  ToolsAPI,
  DelphiAIDev.AI.Response;

type
  TDelphiAIDevAIGemini = class(TInterfacedObject, IDelphiAIDevAI)
  private
    FSettings: TDelphiAIDevSettings;
    FResponse: IDelphiAIDevAIResponse;
  protected
    function GetResponse(const AQuestion: string): IDelphiAIDevAIResponse;
  public
    constructor Create(const ASettings: TDelphiAIDevSettings; const AResponse: IDelphiAIDevAIResponse);
  end;

implementation

uses
  System.IOUtils,
  System.DateUtils;

// ЛОГ UTF-8 c BOM

function _LogDir: string;
begin
  Result := TPath.Combine(TPath.GetDocumentsPath, 'DelphiAIDev\logs');
end;

function _LogFile: string;
begin
  Result := TPath.Combine(_LogDir, Format('completion-%s.log', [FormatDateTime('yyyymmdd', Now)]));
end;

procedure _EnsureUtf8BomFile(const Fn: string);
var
  fs: TFileStream;
  head: array[0..2] of Byte;
  hasBom: Boolean;
begin
  TDirectory.CreateDirectory(TPath.GetDirectoryName(Fn));

  if not TFile.Exists(Fn) then
  begin
    fs := TFileStream.Create(Fn, fmCreate or fmShareDenyNone);
    try
      if Length(TEncoding.UTF8.GetPreamble) > 0 then
        fs.WriteBuffer(TEncoding.UTF8.GetPreamble[0], Length(TEncoding.UTF8.GetPreamble));
    finally
      fs.Free;
    end;
    Exit;
  end;

  hasBom := False;
  fs := TFileStream.Create(Fn, fmOpenReadWrite or fmShareDenyNone);
  try
    if fs.Size >= 3 then
    begin
      fs.ReadBuffer(head, 3);
      hasBom := (head[0] = $EF) and (head[1] = $BB) and (head[2] = $BF);
    end;
    if not hasBom then
    begin
      var bytes := TFile.ReadAllBytes(Fn);
      fs.Size := 0;
      if Length(TEncoding.UTF8.GetPreamble) > 0 then
        fs.WriteBuffer(TEncoding.UTF8.GetPreamble[0], Length(TEncoding.UTF8.GetPreamble));
      if Length(bytes) > 0 then
        fs.WriteBuffer(bytes[0], Length(bytes));
    end;
  finally
    fs.Free;
  end;
end;

procedure _AppendUtf8WithBom(const Fn, Line: string);
var
  fs: TFileStream;
  bytes: TBytes;
  s: string;
begin
  _EnsureUtf8BomFile(Fn);
  fs := TFileStream.Create(Fn, fmOpenReadWrite or fmShareDenyNone);
  try
    fs.Seek(0, soEnd);
    s := FormatDateTime('hh:nn:ss.zzz', Now) + ' ' + Line + sLineBreak;
    bytes := TEncoding.UTF8.GetBytes(s);
    if Length(bytes) > 0 then
      fs.WriteBuffer(bytes[0], Length(bytes));
  finally
    fs.Free;
  end;
end;

procedure _Log(const S: string); overload;
begin
  try
    _AppendUtf8WithBom(_LogFile, S);
  except
  end;
end;

procedure _Log(const Fmt: string; const Args: array of const); overload;
begin
  _Log(Format(Fmt, Args));
end;

// Утилиты

function JoinUrl(const BaseUrl, Path: string): string;
var
  B, P: string;
begin
  B := Trim(BaseUrl);
  P := Trim(Path);
  while (B <> '') and B.EndsWith('/') do Delete(B, Length(B), 1);
  while (P <> '') and P.StartsWith('/') do Delete(P, 1, 1);
  if (B <> '') and (P <> '') then Result := B + '/' + P else Result := B + P;
end;

function _Trunc(const S: string; MaxLen: Integer = 800): string;
begin
  if Length(S) <= MaxLen then
    Result := S
  else
    Result := Copy(S, 1, MaxLen) + '…';
end;

function LastPosEx(const SubStr, S: string): Integer;
var
  p, i: Integer;
begin
  Result := 0;
  if (SubStr = '') or (S = '') then Exit;
  i := 1;
  repeat
    p := PosEx(SubStr, S, i);
    if p = 0 then Break;
    Result := p;
    i := p + 1;
  until False;
end;

function JsonEscapesToReadable(const S: string): string;
  function Hex4ToChar(const h4: string): Char;
  var v, i: Integer;
  begin
    v := 0;
    for i := 1 to 4 do
    begin
      v := v shl 4;
      case h4[i] of
        '0'..'9' : v := v + Ord(h4[i]) - Ord('0');
        'A'..'F' : v := v + 10 + Ord(h4[i]) - Ord('A');
        'a'..'f' : v := v + 10 + Ord(h4[i]) - Ord('a');
      else
        Exit('?');
      end;
    end;
    Result := Char(v);
  end;
var
  i, n: Integer;
begin
  Result := '';
  i := 1; n := Length(S);
  while i <= n do
  begin
    if (S[i] = '\') and (i < n) then
    begin
      Inc(i);
      case S[i] of
        '"':  Result := Result + '"';
        '\':  Result := Result + '\';
        '/':  Result := Result + '/';
        'b':  Result := Result + #8;
        'f':  Result := Result + #12;
        'n':  Result := Result + #10;
        'r':  Result := Result + #13;
        't':  Result := Result + #9;
        'u':
          if i + 4 <= n then
          begin
            Result := Result + Hex4ToChar(Copy(S, i+1, 4));
            Inc(i, 4);
          end
          else
            Result := Result + '\u';
      else
        Result := Result + '\' + S[i];
      end;
    end
    else
      Result := Result + S[i];
    Inc(i);
  end;
end;

function MakeRelativePath(const BaseDir, AbsPath: string): string;
var
  B, A: string;
begin
  B := IncludeTrailingPathDelimiter(ExpandFileName(BaseDir));
  A := ExpandFileName(AbsPath);

  if SameText(Copy(A, 1, Length(B)), B) then
    Result := Copy(A, Length(B) + 1, MaxInt)
  else
    Result := A;
end;

// Основа

constructor TDelphiAIDevAIGemini.Create(const ASettings: TDelphiAIDevSettings; const AResponse: IDelphiAIDevAIResponse);
begin
  FSettings := ASettings;
  FResponse := AResponse;
end;

function _OsUser: string;
begin
  Result := GetEnvironmentVariable('USERNAME');
  if Result = '' then
    Result := GetEnvironmentVariable('USER');
end;

function TDelphiAIDevAIGemini.GetResponse(const AQuestion: string): IDelphiAIDevAIResponse;
const
  MAX_PREFIX = 8000;
  MAX_SUFFIX = 4000;
var
  LUrl: string;
  LResponse: IResponse;
  Root, ChoicesVal, TextVal: TJSONValue;
  Choices: TJSONArray;
  I: Integer;
  LResult, BodyJson, RespPreview, TokenPreview: string;
  Tag: string;
  TagPos: Integer;
  PrefixRaw, SuffixRaw, PrefixWin, SuffixWin: string;
  Body, Segments: TJSONObject;
  OsUser, CurrentFileAbs, CurrentFileRel, GitRoot: string;

  function FindGitRoot(const StartDir: string): string;
  var
    Dir, Parent: string;
  begin
    Dir := ExcludeTrailingPathDelimiter(StartDir);
    repeat
      if TDirectory.Exists(TPath.Combine(Dir, '.git')) then
        Exit(Dir);
      Parent := TDirectory.GetParent(Dir);
      if (Parent = '') or (Parent = Dir) then
        Break;
      Dir := Parent;
    until False;
    Result := '';
  end;

begin
  Result := FResponse;

  // подготовка prefix/suffix
  Tag := TConsts.TAG_CODE_COMPLETION;
  TagPos := LastPosEx(Tag, AQuestion);
  if TagPos > 0 then
  begin
    PrefixRaw := Copy(AQuestion, 1, TagPos - 1);
    SuffixRaw := Copy(AQuestion, TagPos + Tag.Length, MaxInt);

    if Length(PrefixRaw) > MAX_PREFIX then
      PrefixWin := Copy(PrefixRaw, Length(PrefixRaw) - MAX_PREFIX + 1, MAX_PREFIX)
    else
      PrefixWin := PrefixRaw;

    if Length(SuffixRaw) > MAX_SUFFIX then
      SuffixWin := Copy(SuffixRaw, 1, MAX_SUFFIX)
    else
      SuffixWin := SuffixRaw;
  end
  else
  begin
    PrefixWin := AQuestion;
    SuffixWin := '';
  end;

  // endpoint + тело запроса
  LUrl := JoinUrl(FSettings.BaseUrlGemini, 'v1/completions');

  Body := TJSONObject.Create;
  Segments := TJSONObject.Create;
  try
    Segments.AddPair('prefix', PrefixWin);
    Segments.AddPair('suffix', SuffixWin);
    Body.AddPair('language', 'pascal');
    Body.AddPair('segments', Segments);

    OsUser := _OsUser;
    if OsUser <> '' then
      Body.AddPair('user', OsUser);

    CurrentFileAbs := '';
    CurrentFileRel := '';
    try
      if Assigned(BorlandIDEServices) then
      begin
        var EditorServices: IOTAEditorServices := nil;
        if Supports(BorlandIDEServices, IOTAEditorServices, EditorServices) then
        begin
          if Assigned(EditorServices.TopBuffer) then
            CurrentFileAbs := EditorServices.TopBuffer.FileName;
        end;
      end;
    except
      CurrentFileAbs := '';
    end;

    if CurrentFileAbs <> '' then
    begin
      GitRoot := FindGitRoot(ExtractFilePath(CurrentFileAbs));
      if (GitRoot <> '') and CurrentFileAbs.StartsWith(GitRoot, True) then
        CurrentFileRel := MakeRelativePath(GitRoot, CurrentFileAbs)
      else
        CurrentFileRel := CurrentFileAbs;

      Body.AddPair('filepath', CurrentFileRel);
    end;

    BodyJson := Body.ToJSON;
  finally
    Body.Free;
  end;

  if FSettings.ApiKeyGemini.Length > 6 then
    TokenPreview := Copy(FSettings.ApiKeyGemini, 1, 3) + '...' +
                    Copy(FSettings.ApiKeyGemini, Length(FSettings.ApiKeyGemini)-2, 3)
  else
    TokenPreview := '<short>';

  _Log('DEBUG CurrentFileAbs=%s GitRoot=%s Rel=%s', [CurrentFileAbs, GitRoot, CurrentFileRel]);
  _Log('Prefix.len=%d Suffix.len=%d', [Length(PrefixWin), Length(SuffixWin)]);
  _Log('Prefix.head = "%s"', [_Trunc(PrefixWin, 200)]);
  _Log('Suffix.head = "%s"', [_Trunc(SuffixWin, 200)]);
  _Log('REQ -> URL=%s', [LUrl]);
  _Log('REQ Token(Bearer)=%s', [TokenPreview]);
  _Log('REQ BODY HUMAN (first 800)=%s', [_Trunc(JsonEscapesToReadable(BodyJson), 800)]);

  LResponse := TRequest.New
    .BaseURL(LUrl)
    .Accept(TConsts.APPLICATION_JSON)
    .ContentType(TConsts.APPLICATION_JSON)
    .TokenBearer(FSettings.ApiKeyGemini)
    .AddBody(BodyJson)
    .Post;

  FResponse.SetStatusCode(LResponse.StatusCode);
  RespPreview := Copy(LResponse.Content, 1, 1000);

  _Log('RESP -> STATUS=%d', [LResponse.StatusCode]);
  _Log('RESP -> BODY HUMAN (first 800)=%s', [_Trunc(JsonEscapesToReadable(LResponse.Content), 800)]);

  if LResponse.StatusCode <> 200 then
  begin
    FResponse.SetContentText('Question cannot be answered' + sLineBreak +
                             'Return: ' + LResponse.Content);
    Exit;
  end;

  if LResponse.StatusCode = 200 then
  begin
    FResponse.SetContentText(LResponse.Content);
    Exit;
  end;

  Root := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LResponse.Content), 0);
  try
    if not (Root is TJSONObject) then
    begin
      FResponse.SetContentText('Invalid response JSON: ' + LResponse.Content);
      Exit;
    end;

    ChoicesVal := TJSONObject(Root).GetValue('choices');
    if not (ChoicesVal is TJSONArray) then
    begin
      FResponse.SetContentText('Invalid response: choices not found' + sLineBreak +
                               'Return: ' + LResponse.Content);
      Exit;
    end;

    Choices := TJSONArray(ChoicesVal);
    if Choices.Count = 0 then
    begin
      FResponse.SetContentText('Invalid response: choices is empty' + sLineBreak +
                               'Return: ' + LResponse.Content);
      Exit;
    end;

    LResult := '';
    for I := 0 to Choices.Count - 1 do
    begin
      TextVal := TJSONObject(Choices.Items[I]).GetValue('text');
      if TextVal is TJSONString then
        LResult := LResult + TJSONString(TextVal).Value;
    end;

    LResult := LResult.Trim([#10, #13]);

    FResponse.SetContentText(LResult);

  finally
    Root.Free;
  end;
end;

end.
