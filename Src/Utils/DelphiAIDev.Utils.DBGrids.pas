unit DelphiAIDev.Utils.DBGrids;

interface

uses
  System.SysUtils,
  System.Types,
  System.Classes,
  Data.DB,
  Vcl.DBGrids,
  Vcl.Grids,
  Vcl.Graphics,
  Vcl.Clipbrd,
  DelphiAIDev.Utils,
  DelphiAIDev.Utils.Ota,
  DelphiAIDev.Types;

type
  TUtilsDBGrids = class
  private
    class procedure DrawColumnCellLight(const ADBGrid: TDBGrid; const ARect: TRect; const ADataCol: Integer; const AColumn: TColumn;
      const AState: TGridDrawState);
    class procedure DrawColumnCellDark(const ADBGrid: TDBGrid; const ARect: TRect; const ADataCol: Integer; const AColumn: TColumn;
      const AState: TGridDrawState);
  public
    class procedure DBGridToClipboardCurrentColumn(const ADBGrid: TDBGrid);
    class procedure DBGridToClipboardCurrentLine(ADBGrid: TDBGrid; ACopyTitle: Boolean = True);
    class procedure DBGridToClipboardAll(ADBGrid: TDBGrid; ACopyTitle: Boolean = True);
    class procedure DBGridToCSV(ADBGrid: TDBGrid; ACopyTitle: Boolean = True);
    class procedure DBGridToTxt(ADBGrid: TDBGrid; ACopyTitle: Boolean = True);
    class procedure DBGridToFile(ADBGrid: TDBGrid; const AExtension: string;
      const ASeparator: string; ACopyTitle: Boolean = True);
    class function DBGridToString(ADBGrid: TDBGrid; const AExtension: string;
      ACopyTitle: Boolean = True): string;

    class procedure ConfDBGrid(const ADBGrid: TDBGrid);
    class procedure DrawColumnCell(const ADBGrid: TDBGrid; const ARect: TRect; const ADataCol: Integer; const AColumn: TColumn;
      const AState: TGridDrawState);
  end;

implementation

class procedure TUtilsDBGrids.DBGridToClipboardCurrentColumn(const ADBGrid: TDBGrid);
var
  LText: string;
begin
  if ADBGrid.DataSource.DataSet.IsEmpty then
    Exit;

  if ADBGrid.SelectedIndex < 0 then
    Exit;

  LText := ADBGrid.Columns[ADBGrid.SelectedIndex].Field.AsString;
  ClipBoard.Clear;
  ClipBoard.SetTextBuf(PWideChar(LText));
end;

class procedure TUtilsDBGrids.DBGridToClipboardCurrentLine(ADBGrid: TDBGrid; ACopyTitle: Boolean = True);
var
  LText: string;
  LContCol: Integer;
begin
  if ADBGrid.DataSource.DataSet.IsEmpty then
    Exit;

  LText := '';
  if ACopyTitle then
  begin
    LText := ADBGrid.Columns[0].Title.Caption;
    for LContCol := 1 to Pred(ADBGrid.Columns.Count) do
      LText := format('%s|%s', [LText, ADBGrid.Columns[LContCol].Title.Caption]);

    LText := LText + sLineBreak;
  end;

  LText := LText + ADBGrid.Columns[0].Field.AsString;
  for LContCol := 1 to Pred(ADBGrid.Columns.Count) do
    LText := format('%s|%s', [LText, ADBGrid.Columns[LContCol].Field.AsString]);

  LText := LText + sLineBreak;
  ClipBoard.Clear;
  ClipBoard.SetTextBuf(PWideChar(LText));
end;

class procedure TUtilsDBGrids.DBGridToClipboardAll(ADBGrid: TDBGrid; ACopyTitle: Boolean = True);
var
  LText: string;
begin
  LText := Self.DBGridToString(ADBGrid, ';', ACopyTitle);
  ClipBoard.Clear;
  ClipBoard.SetTextBuf(PWideChar(LText));
end;

class procedure TUtilsDBGrids.DBGridToCSV(ADBGrid: TDBGrid; ACopyTitle: Boolean = True);
begin
  Self.DBGridToFile(ADBGrid, TC4DExtensionsCommon.csv.ToString, ';', ACopyTitle);
end;

class procedure TUtilsDBGrids.DBGridToTxt(ADBGrid: TDBGrid; ACopyTitle: Boolean = True);
begin
  Self.DBGridToFile(ADBGrid, TC4DExtensionsCommon.txt.ToString, '|', ACopyTitle);
end;

class procedure TUtilsDBGrids.DBGridToFile(ADBGrid: TDBGrid; const AExtension: string;
  const ASeparator: string; ACopyTitle: Boolean = True);
var
  LStrings: TStringList;
  LFileName: string;
begin
  LFileName := TUtils.GetFileName(AExtension);

  LStrings := TStringList.Create;
  try
    LStrings.Text := Self.DBGridToString(ADBGrid, ASeparator, ACopyTitle);
    LStrings.SaveToFile(LFileName);
  finally
    LStrings.Free;
  end;
end;

class function TUtilsDBGrids.DBGridToString(ADBGrid: TDBGrid; const AExtension: string;
  ACopyTitle: Boolean = True): string;
var
  LContCol: Integer;
  LBookMarkCurrent: TBookMark;
begin
  Result := '';
  if ACopyTitle then
  begin
    Result := ADBGrid.Columns[0].Title.Caption;
    for LContCol := 1 to Pred(ADBGrid.Columns.Count) do
      Result := format('%s%s%s', [Result, AExtension, ADBGrid.Columns[LContCol].Title.Caption]);

    Result := Result + sLineBreak;
  end;

  LBookMarkCurrent := ADBGrid.DataSource.DataSet.GetBookmark;
  ADBGrid.DataSource.DataSet.DisableControls;
  try
    ADBGrid.DataSource.DataSet.First;
    while not ADBGrid.DataSource.DataSet.Eof do
    begin
      Result := Result + ADBGrid.Columns[0].Field.AsString;
      for LContCol := 1 to Pred(ADBGrid.Columns.Count) do
        Result := format('%s%s%s', [Result, AExtension, ADBGrid.Columns[LContCol].Field.AsString]);
      Result := Result + sLineBreak;
      ADBGrid.DataSource.DataSet.Next;
    end;

    ADBGrid.DataSource.DataSet.GotoBookMark(LBookMarkCurrent);
    ADBGrid.DataSource.DataSet.FreeBookMark(LBookMarkCurrent);
  finally
    ADBGrid.DataSource.DataSet.EnableControls;
  end;
end;

class procedure TUtilsDBGrids.DrawColumnCell(const ADBGrid: TDBGrid; const ARect: TRect;
  const ADataCol: Integer; const AColumn: TColumn; const AState: TGridDrawState);
begin
  if TUtilsOTA.ActiveThemeIsDark then
    Self.DrawColumnCellDark(ADBGrid, ARect, ADataCol, AColumn, AState)
  else
    Self.DrawColumnCellLight(ADBGrid, ARect, ADataCol, AColumn, AState);
end;

class procedure TUtilsDBGrids.DrawColumnCellLight(const ADBGrid: TDBGrid; const ARect: TRect;
  const ADataCol: Integer; const AColumn: TColumn; const AState: TGridDrawState);
begin
  ADBGrid.Canvas.Brush.Color := $00E6ECEC; //$00E6ECEC;
  //EMULA dgRowSelect
  if ARect.Top = TStringGrid(ADBGrid).CellRect(0, TStringGrid(ADBGrid).Row).Top then
  begin
    ADBGrid.Canvas.FillRect(ARect);
    ADBGrid.Canvas.Brush.Color := $0056BBF9;
    ADBGrid.Canvas.Font.Color := clWindowText;
    ADBGrid.DefaultDrawDataCell(ARect, AColumn.Field, AState)
  end
  else if Odd(ADBGrid.DataSource.DataSet.RecNo) then
    ADBGrid.Canvas.Brush.Color := clwhite;


  ADBGrid.DefaultDrawColumnCell(ARect, ADataCol, AColumn, AState);
end;

class procedure TUtilsDBGrids.DrawColumnCellDark(const ADBGrid: TDBGrid; const ARect: TRect; const ADataCol: Integer; const AColumn: TColumn; const AState: TGridDrawState);
begin
  ADBGrid.Canvas.Brush.Color := $00322F2D; //$004A4136; //$00E6ECEC
  ADBGrid.Canvas.Font.Color := clWindow;
  //EMULA dgRowSelect
  if ARect.Top = TStringGrid(ADBGrid).CellRect(0, TStringGrid(ADBGrid).Row).Top then
  begin
    ADBGrid.Canvas.FillRect(ARect);
    ADBGrid.Canvas.Brush.Color := $00C08000; //$005B4224;
    ADBGrid.Canvas.Font.Color := clWindowText;
    ADBGrid.DefaultDrawDataCell(ARect, AColumn.Field, AState)
  end
  else if Odd(ADBGrid.DataSource.DataSet.RecNo) then
    ADBGrid.Canvas.Brush.Color := $004A4132; //$00535353;

  //ADBGrid.Canvas.FillRect(ARect);

  ADBGrid.DefaultDrawColumnCell(ARect, ADataCol, AColumn, AState);
end;

class procedure TUtilsDBGrids.ConfDBGrid(const ADBGrid: TDBGrid);
begin
  ADBGrid.Options := ADBGrid.Options + [dgColumnResize];
  ADBGrid.Options := ADBGrid.Options + [dgTitleClick];
  ADBGrid.Options := ADBGrid.Options - [dgRowSelect];
  ADBGrid.TitleFont.Style := ADBGrid.TitleFont.Style + [fsBold];
  ADBGrid.TitleFont.Name := 'Arial';
  ADBGrid.TitleFont.Color := clWindowText;
  ADBGrid.DrawingStyle := TGridDrawingStyle.gdsThemed;

  if TUtilsOTA.ActiveThemeIsDark then
  begin
    ADBGrid.TitleFont.Color := clWindow;
    ADBGrid.DrawingStyle := TGridDrawingStyle.gdsGradient;
    ADBGrid.GradientStartColor := $005C5143;
    ADBGrid.GradientEndColor := $00342D25; //$00FFF1D5;

    ADBGrid.Color := $00322F2D;
  end;
end;

end.
