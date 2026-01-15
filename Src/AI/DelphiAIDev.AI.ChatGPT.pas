unit DelphiAIDev.AI.ChatGPT;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Classes,
  RESTRequest4D,
  DelphiAIDev.Consts,
  DelphiAIDev.Utils,
  DelphiAIDev.Settings,
  DelphiAIDev.AI.Interfaces;

type
  TDelphiAIDevAIChatGPT = class(TInterfacedObject, IDelphiAIDevAI)
  private
    FSettings: TDelphiAIDevSettings;
    FResponse: IDelphiAIDevAIResponse;
  protected
    function GetResponse(const AQuestion: string): IDelphiAIDevAIResponse;
  public
    constructor Create(const ASettings: TDelphiAIDevSettings; const AResponse: IDelphiAIDevAIResponse);
  end;

implementation

const
  API_JSON_BODY_BASE = '{"model": "%s", "messages": [{"role": "user", "content": "%s"}], "stream": false, "max_tokens": 2048}';

constructor TDelphiAIDevAIChatGPT.Create(const ASettings: TDelphiAIDevSettings; const AResponse: IDelphiAIDevAIResponse);
begin
  FSettings := ASettings;
  FResponse := AResponse;
end;

function TDelphiAIDevAIChatGPT.GetResponse(const AQuestion: string): IDelphiAIDevAIResponse;

  // --- ЛОКАЛЬНАЯ ФУНКЦИЯ ДОЛЖНА БЫТЬ ДО ПЕРВЫХ ОПЕРАТОРОВ! ---
  function ParseSSEToText(const AContent: string): string;
  var
    Lines: TArray<string>;
    Line, JsonText: string;
    V, ChoicesVal, DeltaVal, MsgVal, TextVal: TJSONValue;
    O, ChoiceObj, DeltaObj, MsgObj: TJSONObject;
    Choices: TJSONArray;
  begin
    Result := '';
    Lines := AContent.Replace(#13, '').Split([#10]);

    for Line in Lines do
    begin
      if not Line.StartsWith('data: ') then
        Continue;

      JsonText := Trim(Copy(Line, 7, MaxInt));
      if (JsonText = '') or (SameText(JsonText, '[DONE]')) then
        Continue;

      V := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JsonText), 0);
      try
        if not (V is TJSONObject) then
          Continue;

        O := TJSONObject(V);
        ChoicesVal := O.GetValue('choices');
        if not (ChoicesVal is TJSONArray) then
          Continue;

        Choices := TJSONArray(ChoicesVal);
        if (Choices.Count = 0) or not (Choices.Items[0] is TJSONObject) then
          Continue;

        ChoiceObj := TJSONObject(Choices.Items[0]);

        // chat/completions -> delta.content
        DeltaVal := ChoiceObj.GetValue('delta');
        if (DeltaVal is TJSONObject) then
        begin
          DeltaObj := TJSONObject(DeltaVal);
          if DeltaObj.GetValue('content') is TJSONString then
            Result := Result + TJSONString(DeltaObj.GetValue('content')).Value;
          Continue;
        end;

        // иногда приходит message.content
        MsgVal := ChoiceObj.GetValue('message');
        if (MsgVal is TJSONObject) then
        begin
          MsgObj := TJSONObject(MsgVal);
          if MsgObj.GetValue('content') is TJSONString then
            Result := Result + TJSONString(MsgObj.GetValue('content')).Value;
          Continue;
        end;

        // completions -> text
        TextVal := ChoiceObj.GetValue('text');
        if TextVal is TJSONString then
          Result := Result + TJSONString(TextVal).Value;
      finally
        V.Free;
      end;
    end;

    Result := Result.Trim;
  end;

var
  LResponse: IResponse;
  Body: TJSONObject;
  Arr: TJSONArray;
  Msg: TJSONObject;
  LJsonValueAll, LJsonValueChoices, LJsonValueMessage, LJsonValueText: TJSONValue;
  LJsonArrayChoices: TJSONArray;
  LJsonObjChoices, LJsonObjMessage: TJSONObject;
  LItemChoices: Integer;
  LResult: string;
begin
  Result := FResponse;

  // --- сборка тела запроса ---
  Body := TJSONObject.Create;
  try
    if FSettings.ModelOpenAI.Trim <> '' then
      Body.AddPair('model', FSettings.ModelOpenAI);

    Arr := TJSONArray.Create;
    Msg := TJSONObject.Create;
    Msg.AddPair('role', 'user');
    Msg.AddPair('content', AQuestion);
    Arr.AddElement(Msg);
    Body.AddPair('messages', Arr);

    // если хотите получать один объект без стрима — раскомментируйте:
    // Body.AddPair('stream', TJSONBool.Create(False));

    LResponse := TRequest.New
      .BaseURL(FSettings.BaseUrlOpenAI)         // например: http://192.168.110.24:6560
      .Resource('/v1/chat/completions')
      .ContentType('application/json')
      .Accept('application/json')
      .TokenBearer(FSettings.ApiKeyOpenAI)      // "auth_..."
      .AddBody(Body.ToJSON)
      .Post;
  finally
    Body.Free;
  end;

  FResponse.SetStatusCode(LResponse.StatusCode);
  if LResponse.StatusCode <> 200 then
  begin
    FResponse.SetContentText('Question cannot be answered' + sLineBreak + 'Return: ' + LResponse.Content);
    Exit;
  end;

  // --- поддержка стриминга (SSE) ---
  if (LResponse.Content.StartsWith('data:')) or
     (LResponse.Content.IndexOf('chat.completion.chunk') >= 0) then
  begin
    LResult := ParseSSEToText(LResponse.Content);
    if LResult <> '' then
      FResponse.SetContentText(LResult)
    else
      FResponse.SetContentText('The question cannot be answered, empty SSE stream.');
    Exit;
  end;

  // --- обычный (нестримовый) JSON ---
  LJsonValueAll := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LResponse.Content), 0);
  try
    if not (LJsonValueAll is TJSONObject) then
    begin
      FResponse.SetContentText('The question cannot be answered, return object not found.' + sLineBreak +
        'Return: ' + LResponse.Content);
      Exit;
    end;

    LJsonValueChoices := TJSONObject(LJsonValueAll).GetValue('choices');
    if not (LJsonValueChoices is TJSONArray) then
    begin
      FResponse.SetContentText('The question cannot be answered, choices not found.' + sLineBreak +
        'Return: ' + LResponse.Content);
      Exit;
    end;

    LJsonArrayChoices := TJSONArray(LJsonValueChoices);
    for LItemChoices := 0 to Pred(LJsonArrayChoices.Count) do
      if LJsonArrayChoices.Items[LItemChoices] is TJSONObject then
      begin
        LJsonObjChoices := TJSONObject(LJsonArrayChoices.Items[LItemChoices]);

        // chat/completions -> choices[].message.content
        LJsonValueMessage := LJsonObjChoices.GetValue('message');
        if (LJsonValueMessage is TJSONObject) then
        begin
          LJsonObjMessage := TJSONObject(LJsonValueMessage);
          if LJsonObjMessage.GetValue('content') is TJSONString then
            LResult := LResult + TJSONString(LJsonObjMessage.GetValue('content')).Value.Trim + sLineBreak;
          Continue;
        end;

        // completions -> choices[].text
        LJsonValueText := LJsonObjChoices.GetValue('text');
        if LJsonValueText is TJSONString then
          LResult := LResult + TJSONString(LJsonValueText).Value.Trim + sLineBreak;
      end;
  finally
    LJsonValueAll.Free;
  end;

  FResponse.SetContentText(LResult.Trim);
end;

end.
