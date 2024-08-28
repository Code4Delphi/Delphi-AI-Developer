unit DelphiAIDev.IDE.NTAEditViewNotifier;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.Types,
  System.SyncObjs,
  System.RegularExpressions,
  Vcl.Dialogs,
  Vcl.Graphics,
  Vcl.Imaging.pngimage,
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.OTA,
  DelphiAIDev.Consts,
  DelphiAIDev.CodeCompletion.Vars,
  ToolsAPI;

type
  TDelphiAIDevIDENTAEditViewNotifier = class(TInterfacedObject, IOTANotifier, INTAEditViewNotifier)
  protected
    FIOTAEditView: IOTAEditView;
    FIndex: Integer;
    procedure RemoveNotifier;
  public
    constructor Create(FileName: string; AEditView: IOTAEditView);
    destructor Destroy; override;

    { INTAEditViewNotifier }
    ///<summary>EditorIdle é chamado após alguma ação ter ocorrido na visualização
    ///(edição, movimento do cursor, etc.) e um período de tempo ter passado sem que outra
    ///ação acontecesse. Isso é aproximadamente equivalente ao momento em que o Code
    ///Insight é acionado (e está vinculado à configuração de atraso do Code Insight)</summary>
    procedure EditorIdle(const View: IOTAEditView);
    procedure BeginPaint(const View: IOTAEditView; var FullRepaint: Boolean);
    procedure PaintLine(const View: IOTAEditView; LineNumber: Integer;
      const LineText: PAnsiChar; const TextWidth: Word; const LineAttributes: TOTAAttributeArray;
      const Canvas: TCanvas; const TextRect: TRect; const LineRect: TRect; const CellSize: TSize);
    ///<summary>EndPaint é chamado depois que todas as linhas foram repintadas.
    ///Use isso para limpar quaisquer estruturas de dados que foram mantidas
    ///ao longo da pintura das linhas</summary>
    procedure EndPaint(const View: IOTAEditView);

    //IOTANotifier
    procedure AfterSave;
    procedure BeforeSave;
    procedure Modified;
    procedure Destroyed;
  end;

implementation

constructor TDelphiAIDevIDENTAEditViewNotifier.Create(FileName: string; AEditView: IOTAEditView);
begin
  inherited Create;
  FIOTAEditView := AEditView;
  FIndex := FIOTAEditView.AddNotifier(Self);
end;

destructor TDelphiAIDevIDENTAEditViewNotifier.Destroy;
begin
  RemoveNotifier;
  inherited;
end;

procedure TDelphiAIDevIDENTAEditViewNotifier.Destroyed;
begin
  RemoveNotifier;
end;

procedure TDelphiAIDevIDENTAEditViewNotifier.AfterSave;
begin

end;

procedure TDelphiAIDevIDENTAEditViewNotifier.BeforeSave;
begin

end;

procedure TDelphiAIDevIDENTAEditViewNotifier.BeginPaint(const View: IOTAEditView; var FullRepaint: Boolean);
begin
  FullRepaint := True;
end;

procedure TDelphiAIDevIDENTAEditViewNotifier.EditorIdle(const View: IOTAEditView);
var
  LRow: Integer;
  LColumn: Integer;
begin
  TUtilsOTA.GetCursorPosition(LRow, LColumn);

//  TUtils.AddLog(Format('EditorIdle - %d (%d) - %d (%d) - %s ',
//    [TDelphiAIDevCodeCompletionVars.GetInstance.Row, LRow, TDelphiAIDevCodeCompletionVars.GetInstance.Column, LColumn, DateTimeToStr(Now)]));

  if (LRow <> TDelphiAIDevCodeCompletionVars.GetInstance.Row) or (LColumn <> TDelphiAIDevCodeCompletionVars.GetInstance.Column) then
  begin
    TDelphiAIDevCodeCompletionVars.GetInstance.LineIni := 0;
    TDelphiAIDevCodeCompletionVars.GetInstance.Clear;
  end;

  //TUtils.AddLog('EditorIdle ' + BoolToStr(TDelphiAIDevCodeCompletionVars.GetInstance.ClearNext, True));

//  if TDelphiAIDevCodeCompletionVars.GetInstance.ClearNext then
//  begin
//    TDelphiAIDevCodeCompletionVars.GetInstance.Clear;
//  end
//  else
//    TDelphiAIDevCodeCompletionVars.GetInstance.ClearNext := True;

  //View.AddNotifier()
  //View.GetEditWindow.Form.Repaint;
end;

procedure TDelphiAIDevIDENTAEditViewNotifier.EndPaint(const View: IOTAEditView);
begin
  //TUtils.AddLog('EndPaint');
end;

procedure TDelphiAIDevIDENTAEditViewNotifier.Modified;
begin

end;


procedure TDelphiAIDevIDENTAEditViewNotifier.PaintLine(const View: IOTAEditView; LineNumber: Integer;
  const LineText: PAnsiChar; const TextWidth: Word; const LineAttributes: TOTAAttributeArray;
  const Canvas: TCanvas; const TextRect: TRect; const LineRect: TRect; const CellSize: TSize);
var
  LLineText: string;
begin
  if LineNumber < 1 then
    Exit;

  LLineText := string(LineText);

  if not LLineText.Trim.IsEmpty then
    Exit;

  //if LineNumber <> View.CursorPos.Line then
  //  Exit;

  if (LineNumber >= TDelphiAIDevCodeCompletionVars.GetInstance.LineIni)and(LineNumber <= TDelphiAIDevCodeCompletionVars.GetInstance.LineEnd) then
  begin
    Canvas.Brush.Style := bsClear;
    Canvas.Font.Color := $777777; //$666666;

    try
      LLineText := TDelphiAIDevCodeCompletionVars.GetInstance.Contents[LineNumber - TDelphiAIDevCodeCompletionVars.GetInstance.LineIni];
      Canvas.TextOut(TextRect.Left, TextRect.Top, LLineText.TrimRight);
    except on E: Exception do
      TUtils.AddLog(E.Message);
    end;
  end;
end;

procedure TDelphiAIDevIDENTAEditViewNotifier.RemoveNotifier;
begin
  if Assigned(FIOTAEditView) and (FIndex >= 0) then
  begin
    FIOTAEditView.RemoveNotifier(FIndex);
    FIndex := -1;
    FIOTAEditView := nil;
  end;
end;

end.
