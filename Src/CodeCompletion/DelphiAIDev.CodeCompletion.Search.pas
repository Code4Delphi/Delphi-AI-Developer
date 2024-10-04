unit DelphiAIDev.CodeCompletion.Search;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  ToolsAPI,
  DelphiAIDev.Types,
  DelphiAIDev.Consts,
  DelphiAIDev.Settings,
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA,
  DelphiAIDev.CodeCompletion.Vars,
  DelphiAIDev.AI.Facade;

type
  IDelphiAIDevCodeCompletionSearch = interface
    ['{5F8BDEE9-14DC-4C8C-BA7A-681A94844AD8}']
    procedure Process(const AContext: IOTAKeyContext);
  end;

  TDelphiAIDevCodeCompletionSearch = class(TInterfacedObject, IDelphiAIDevCodeCompletionSearch)
  private
    FSettings: TDelphiAIDevSettings;
    FQuestions: TStrings;
    FAIRequest: TDelphiAIDevAIFacade;
    FVars: TDelphiAIDevCodeCompletionVars;
    FIOTAEditPosition: IOTAEditPosition;
    procedure ProcessQuestions(const AContext: IOTAKeyContext);
    procedure ProcessResponse;
  protected
    procedure Process(const AContext: IOTAKeyContext);
  public
    class function New: IDelphiAIDevCodeCompletionSearch;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

class function TDelphiAIDevCodeCompletionSearch.New: IDelphiAIDevCodeCompletionSearch;
begin
  Result := Self.Create;
end;

constructor TDelphiAIDevCodeCompletionSearch.Create;
begin
  FSettings := TDelphiAIDevSettings.GetInstance;
  FAIRequest := TDelphiAIDevAIFacade.Create;
  FQuestions := TStringList.Create;
  FVars := TDelphiAIDevCodeCompletionVars.GetInstance;
end;

destructor TDelphiAIDevCodeCompletionSearch.Destroy;
begin
  FQuestions.Free;
  FAIRequest.Free;
  inherited;
end;

procedure TDelphiAIDevCodeCompletionSearch.Process(const AContext: IOTAKeyContext);
begin
  FSettings.ValidateFillingSelectedAICodeCompletion(TShowMsg.No);

  Screen.Cursor := crHourGlass;
  try
    Self.ProcessQuestions(AContext);

    try
      FAIRequest.AiUse(FSettings.CodeCompletionAIDefault).ProcessSend(FQuestions.Text);
    except
      Abort;
    end;

    Self.ProcessResponse;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TDelphiAIDevCodeCompletionSearch.ProcessQuestions(const AContext: IOTAKeyContext);
begin
  FQuestions.Clear;
  FQuestions.Add(FSettings.LanguageQuestions.GetLanguageDefinition);
  FQuestions.Add(FSettings.LanguageQuestions.GetMsgCodeCompletionSuggestion);
  FQuestions.Add(FSettings.LanguageQuestions.GetMsgCodeOnly);
  if not FSettings.CodeCompletionDefaultPrompt.Trim.IsEmpty then
    FQuestions.Add(FSettings.CodeCompletionDefaultPrompt);

  FIOTAEditPosition := AContext.EditBuffer.EditPosition;
  FIOTAEditPosition.InsertText(TConsts.TAG_CODE_COMPLETION);
  try
    FQuestions.Add(TUtilsOTA.GetSelectedBlockOrAllCodeUnit.Trim);
  finally
    FIOTAEditPosition.BackspaceDelete(TConsts.TAG_CODE_COMPLETION.Length);
  end;
end;

procedure TDelphiAIDevCodeCompletionSearch.ProcessResponse;
var
  LRow: Integer;
  LColumn: Integer;
  LBlankTextLines: string;
  i: Integer;
begin
  if FAIRequest.Response.GetStatusCode <> 200 then
  begin
    TUtils.ShowMsg('Unable to perform AI request.',
      Format('Code: %d %s Message: %s', [FAIRequest.Response.GetStatusCode, sLineBreak, FAIRequest.Response.GetContent.Text]));
    Exit;
  end;

  FVars.Module := TUtilsOTA.GetCurrentModule;
  FVars.Contents.Text := TUtils.ConfReturnAI(FAIRequest.Response.GetContent.Text);
  LRow := FIOTAEditPosition.Row;
  LColumn := FIOTAEditPosition.Column;

  FVars.Row := LRow;
  FVars.Column := LColumn;
  FVars.LineIni := LRow;
  FVars.LineEnd := FVars.LineIni + FVars.Contents.Count;

  LBlankTextLines := '';
  for i := 1 to Pred(FVars.Contents.Count) do
    LBlankTextLines := LBlankTextLines + sLineBreak;

  FIOTAEditPosition.InsertText(LBlankTextLines);
  FIOTAEditPosition.Move(FVars.LineIni, LColumn);
end;

end.
