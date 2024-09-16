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
  DelphiAIDev.AI;

type
  IDelphiAIDevCodeCompletionSearch = interface
    ['{5F8BDEE9-14DC-4C8C-BA7A-681A94844AD8}']
    procedure Process(const AContext: IOTAKeyContext);
  end;

  TDelphiAIDevCodeCompletionSearch = class(TInterfacedObject, IDelphiAIDevCodeCompletionSearch)
  private
    FSettings: TDelphiAIDevSettings;
    FQuestions: TStrings;
    FAI: TDelphiAIDevAI;
    FVars: TDelphiAIDevCodeCompletionVars;
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
  FAI := TDelphiAIDevAI.Create;
  FQuestions := TStringList.Create;
  FVars := TDelphiAIDevCodeCompletionVars.GetInstance;
end;

destructor TDelphiAIDevCodeCompletionSearch.Destroy;
begin
  FQuestions.Free;
  FAI.Free;
  inherited;
end;

procedure TDelphiAIDevCodeCompletionSearch.Process(const AContext: IOTAKeyContext);
var
  LRow: Integer;
  LColumn: Integer;
  LText: string;
  i: Integer;
  LIOTAEditPosition: IOTAEditPosition;
begin
  FSettings.ValidateFillingSelectedAICodeCompletion(TShowMsg.No);

  Screen.Cursor := crHourGlass;
  try
    FQuestions.Clear;
    FQuestions.Add(FSettings.LanguageQuestions.GetLanguageDefinition);
    FQuestions.Add(FSettings.LanguageQuestions.GetMsgCodeCompletionSuggestion);
    FQuestions.Add(FSettings.LanguageQuestions.GetMsgCodeOnly);
    if not FSettings.CodeCompletionDefaultPrompt.Trim.IsEmpty then
      FQuestions.Add(FSettings.CodeCompletionDefaultPrompt);

    LIOTAEditPosition := AContext.EditBuffer.EditPosition;
    LIOTAEditPosition.InsertText(TConsts.TAG_CODE_COMPLETION);
    try
      FQuestions.Add(TUtilsOTA.GetSelectedBlockOrAllCodeUnit.Trim);
    finally
      LIOTAEditPosition.BackspaceDelete(TConsts.TAG_CODE_COMPLETION.Length);
    end;

    try
      FAI.AiUse(FSettings.CodeCompletionAIDefault).ProcessSend(FQuestions.Text);
    except
      Abort;
    end;

    FVars.Contents.Text := TUtils.ConfReturnAI(FAI.Response.Text);

    LRow := LIOTAEditPosition.Row;
    LColumn := LIOTAEditPosition.Column;

    FVars.Row := LRow;
    FVars.Column := LColumn;
    FVars.LineIni := LRow;
    FVars.LineEnd := FVars.LineIni + FVars.Contents.Count;

    LText := '';
    for i := 0 to Pred(FVars.Contents.Count) do
      LText := LText + sLineBreak;

    LIOTAEditPosition.InsertText(LText); //.TrimRight + sLineBreak);
    LIOTAEditPosition.Move(FVars.LineIni, LColumn);
  finally
    Screen.Cursor := crDefault;
  end;

  //LIOTAEditPositionMoveBOL;
  //  //LTextCurrentLineOrBlock := Context.EditBuffer.EditBlock.Text;
  //  LTextCurrentLineOrBlock := GetCurrentLineOrBlock(CnOtaGetTopMostEditView);
  //  if LTextCurrentLineOrBlock.Trim.IsEmpty then
  //    Exit;
end;

end.
