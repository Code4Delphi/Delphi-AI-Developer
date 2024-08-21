unit DelphiAIDev.AI.Ollama;

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
  TDelphiAIDevAIOllama = class(TInterfacedObject, IDelphiAIDevAI)
  private
    FSettings: TDelphiAIDevSettings;
  protected
    function GetResponse(const AQuestion: string): string;
  public
    class function New(const ASettings: TDelphiAIDevSettings): IDelphiAIDevAI;
    constructor Create(const ASettings: TDelphiAIDevSettings);
  end;

implementation

const
  API_JSON_BODY_BASE = //'{"messages": [{"role": "user", "content": "%s"}], "model": "%s"}';
    '{"model": "%s", '+
    '"messages": [{"role": "user", "content": "%s"}], '+
    '"stream": false}';

class function TDelphiAIDevAIOllama.New(const ASettings: TDelphiAIDevSettings): IDelphiAIDevAI;
begin
  Result := Self.Create(ASettings);
end;

constructor TDelphiAIDevAIOllama.Create(const ASettings: TDelphiAIDevSettings);
begin
  FSettings := ASettings;
end;

function TDelphiAIDevAIOllama.GetResponse(const AQuestion: string): string;
var
  LResponse: IResponse;
  LJsonValueAll: TJSONVALUE;
  LJsonArrayChoices: TJsonArray;
  LJsonObjMessage: TJsonObject;
  LContent: string;
  LItemChoices: Integer;
begin
  Result := '';

  TUtils.ShowMsgSynchronize(Format(API_JSON_BODY_BASE, [FSettings.ModelOllama, AQuestion]));

  LResponse := TRequest.New
    .BaseURL(FSettings.BaseUrlOllama)
    .ContentType(TConsts.APPLICATION_JSON)
    .Accept(TConsts.APPLICATION_JSON)
    //.Token('Bearer ' + FSettings.ApiKeyOllama)
    .AddBody(Format(API_JSON_BODY_BASE, [FSettings.ModelOllama, AQuestion]))
    .Post;

  if LResponse.StatusCode <> 200 then
    Exit('Question cannot be answered' + sLineBreak + 'Return: ' + LResponse.Content);

  Exit(LResponse.Content);


  Exit;
  LJsonValueAll := TJsonObject.ParseJSONValue(LResponse.Content);
  if not(LJsonValueAll is TJSONObject) then
    Exit('The question cannot be answered, return object not found.' + sLineBreak +
      'Return: ' + LResponse.Content);

  LJsonArrayChoices := (LJsonValueAll as TJsonObject).GetValue<TJsonArray>('choices');
  for LItemChoices := 0 to Pred(LJsonArrayChoices.Count) do
  begin
    LJsonObjMessage := LJsonArrayChoices.Items[LItemChoices].GetValue<TJsonObject>('message');
    LContent := LJsonObjMessage.GetValue<string>('content');
    Result := Result + LContent.Trim + sLineBreak;
  end;

  Result := Result.Trim;
end;

end.
