unit DelphiAIDev.CodeCompletion.Search;

interface

uses
  System.SysUtils,
  System.Classes,
  ToolsAPI,
  DelphiAIDev.Types,
  DelphiAIDev.Consts,
  DelphiAIDev.Settings,
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA,
  DelphiAIDev.CodeCompletion.Vars,
  DelphiAIDev.Chat;

type
  IDelphiAIDevCodeCompletionSearch = interface
    ['{5F8BDEE9-14DC-4C8C-BA7A-681A94844AD8}']
    procedure Process(const AContext: IOTAKeyContext);
  end;

  TDelphiAIDevCodeCompletionSearch = class(TInterfacedObject, IDelphiAIDevCodeCompletionSearch)
  private
    FSettings: TDelphiAIDevSettings;
    FQuestions: TStrings;
    FChat: TDelphiAIDevChat;
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
  FChat := TDelphiAIDevChat.Create;
  FQuestions := TStringList.Create;
end;

destructor TDelphiAIDevCodeCompletionSearch.Destroy;
begin
  FQuestions.Free;
  FChat.Free;
  inherited;
end;

procedure TDelphiAIDevCodeCompletionSearch.Process(const AContext: IOTAKeyContext);
var
  LRow: Integer;
  LColumn: Integer;
  i: Integer;
  LText: string;
begin
  FSettings.ValidateFillingSelectedAI;

  FQuestions.Clear;
  FQuestions.Add(FSettings.LanguageQuestions.GetLanguageDefinition);
  FQuestions.Add(TUtilsOTA.GetSelectedBlockOrAllCodeUnit.Trim);
  FQuestions.Add(FSettings.LanguageQuestions.GetMsgCodeOnly);

  FQuestions.Add('Com base no seguinte código delphi, de uma sugestão ' +
    'de código para ser adicionado onde esta o comentário //Suggestion');
   TUtils.ShowMsg(FQuestions.Text);
  try
    FChat.ProcessSend(FQuestions.Text);
  except
    Abort;
  end;
  //Self.AddBlockText;

  TDelphiAIDevCodeCompletionVars.GetInstance.Contents.Clear;
  for i := 0 to Pred(FChat.Response.Count) do
  begin
    TDelphiAIDevCodeCompletionVars.GetInstance.Contents.Add(FChat.Response[i]);
  end;

  TUtils.ShowMsg(TDelphiAIDevCodeCompletionVars.GetInstance.Contents.Text);

  LRow := AContext.EditBuffer.EditPosition.Row;
  LColumn := AContext.EditBuffer.EditPosition.Column;

  TDelphiAIDevCodeCompletionVars.GetInstance.LineIni := LRow; // + 1;
  TDelphiAIDevCodeCompletionVars.GetInstance.LineEnd := TDelphiAIDevCodeCompletionVars.GetInstance.LineIni + (TDelphiAIDevCodeCompletionVars.GetInstance.Contents.Count); // + 1 //TDelphiAIDevCodeCompletionVars.GetInstance.LineIni + 1;

  //Context.EditBuffer.EditPosition.InsertText(sLineBreak + sLineBreak);
  LText := '';
  for i := 0 to Pred(TDelphiAIDevCodeCompletionVars.GetInstance.Contents.Count) do
    LText := LText + sLineBreak;

  AContext.EditBuffer.EditPosition.InsertText(LText.TrimRight + sLineBreak);
  AContext.EditBuffer.EditPosition.Move(TDelphiAIDevCodeCompletionVars.GetInstance.LineIni, LColumn);

  TDelphiAIDevCodeCompletionVars.GetInstance.Row := TDelphiAIDevCodeCompletionVars.GetInstance.LineIni;
  TDelphiAIDevCodeCompletionVars.GetInstance.Column := LColumn;

  //Context.EditBuffer.EditPosition.MoveBOL;
  //  //LTextCurrentLineOrBlock := Context.EditBuffer.EditBlock.Text;
  //  LTextCurrentLineOrBlock := GetCurrentLineOrBlock(CnOtaGetTopMostEditView);
  //  if LTextCurrentLineOrBlock.Trim.IsEmpty then
  //    Exit;
end;

end.
