unit DelphiAIDev.Utils.DBGrids;

interface

uses
  System.Types,
  Vcl.DBGrids,
  Vcl.Grids,
  Vcl.Graphics,
  DelphiAIDev.Utils.Ota;

type
  TUtilsDBGrids = class
  private
    class procedure DrawColumnCellLight(const ADBGrid: TDBGrid; const ARect: TRect; const ADataCol: Integer; const AColumn: TColumn;
      const AState: TGridDrawState);
    class procedure DrawColumnCellDark(const ADBGrid: TDBGrid; const ARect: TRect; const ADataCol: Integer; const AColumn: TColumn;
      const AState: TGridDrawState);
  public
    class procedure ConfDBGrid(const ADBGrid: TDBGrid);

    class procedure DrawColumnCell(const ADBGrid: TDBGrid; const ARect: TRect; const ADataCol: Integer; const AColumn: TColumn;
      const AState: TGridDrawState);
  end;

implementation

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
