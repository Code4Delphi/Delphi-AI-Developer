unit DelphiAIDev.Utils.ListView;

interface

uses
  System.SysUtils,
  Winapi.Windows,
  Vcl.ComCtrls;

type
  {$SCOPEDENUMS ON}
  TDelphiAIDevUtilsListViewSortStyle = (AlphaNum, Numeric, DateTime);
  {$SCOPEDENUMS OFF}

  IDelphiAIDevUtilsListView = Interface
    ['{5C7DF3C8-2C85-495F-A3B5-FA0DE48F388F}']
    procedure FindAndSelectItems(const AStrFind: string; const ANumColumn: Integer; const AAutoRestart: Boolean = True);
    procedure CopyIndexListView(const AIndexSubItem: Integer);
    function SortStyle(const ASortStyle: TDelphiAIDevUtilsListViewSortStyle): IDelphiAIDevUtilsListView;
    function InvertOrder(const AInvertOrder: Boolean): IDelphiAIDevUtilsListView;
    function ColumnIndex(const AColumnIndex: Integer): IDelphiAIDevUtilsListView;
    procedure CustomSort;
  End;

  TDelphiAIDevUtilsListView = class(TInterfacedObject, IDelphiAIDevUtilsListView)
  private
    FListView: TListView;
    FColumnIndex: Integer;
    class var FInvertOrder: Boolean;
    class var FSortOrder: array[0..10] of Boolean;
    class var FSortStyle: TDelphiAIDevUtilsListViewSortStyle;
  protected
    procedure FindAndSelectItems(const AStrFind: string;
      const ANumColumn: Integer;
      const AAutoRestart: Boolean = True);
    procedure CopyIndexListView(const AIndexSubItem: Integer);
    function SortStyle(const ASortStyle: TDelphiAIDevUtilsListViewSortStyle): IDelphiAIDevUtilsListView;
    function InvertOrder(const AInvertOrder: Boolean): IDelphiAIDevUtilsListView;
    function ColumnIndex(const AColumnIndex: Integer): IDelphiAIDevUtilsListView;
    procedure CustomSort;
  public
    class function New(AListView: TListView): IDelphiAIDevUtilsListView;
    constructor Create(AListView: TListView);
  end;

implementation

uses
  Vcl.Clipbrd,
  DelphiAIDev.Utils.GetIniPositionStr;

{$REGION 'functions locais'}

function IsValidNumber(Astring: string; var AInteger: Integer): Boolean;
var
  LCode: Integer;
begin
  Val(Astring, AInteger, LCode);
  Result := (LCode = 0);
end;

function IsValidDate(Astring: string; var ADateTime: TDateTime): Boolean;
begin
  Result := True;
  try
    ADateTime := StrToDateTime(Astring);
  except
    ADateTime := 0;
    Result := False;
  end;
end;

function CompareDates(dt1, dt2: TDateTime): Integer;
begin
  Result := -1;
  if(dt1 > dt2)then
    Result := 1
  else if(dt1 = dt2)then
    Result := 0;
end;

function CompareNumeric(AInt1, AInt2: Integer): Integer;
begin
  Result := -1;
  if(AInt1 > AInt2)then
    Result := 1
  else if(AInt1 = AInt2)then
    Result := 0;
end;
{$ENDREGION}

procedure TDelphiAIDevUtilsListView.FindAndSelectItems(const AStrFind: string;
  const ANumColumn: Integer;
  const AAutoRestart: Boolean = True);
var
  LColIni: Integer;
  i: Integer;
  LIndexCurrent: Integer;
  LListItem: TListItem;
  LUtilsGetIniPositionStr: IDelphiAIDevUtilsGetIniPositionStr;
  LStrSource: string;
  LStrFind: string;
begin
  if(FListView.Items.Count <= 0)then
    Exit;

  LStrFind := AStrFind.ToLower;
  if(LStrFind.Trim.IsEmpty)then
    Exit;

  LUtilsGetIniPositionStr := TDelphiAIDevUtilsGetIniPositionStr.New
    .WholeWordOnly(False)
    .CaseSensitive(False);

  LIndexCurrent := 0;
  if(FListView.Selected <> nil)then
    LIndexCurrent := FListView.Selected.Index + 1;

  for i := LIndexCurrent to Pred(FListView.Items.Count) do
  begin
    LListItem := FListView.Items[i];
    if(ANumColumn = 0)then
      LStrSource := LowerCase(LListItem.Caption)
    else if(ANumColumn > 0)then
      LStrSource := LowerCase(LListItem.SubItems[Pred(ANumColumn)]);

    LColIni := 0;
    LColIni := LUtilsGetIniPositionStr.GetInitialPosition(LStrSource, LStrFind, LColIni);
    if(LColIni > -1)then
    begin
      FListView.Selected := LListItem;
      LListItem.MakeVisible(False);
      Exit;
    end;
  end;

  if(AAutoRestart)then
  begin
    if(FListView.Items.Count > 0)then
      FListView.Items.Item[0].Selected := True;
    Self.FindAndSelectItems(AStrFind, ANumColumn, False);
  end;
end;

procedure TDelphiAIDevUtilsListView.CopyIndexListView(const AIndexSubItem: Integer);
var
  LListItemSel: TListItem;
  LStrCopy: string;
begin
  if(AIndexSubItem < -1)then
    Exit;

  if(FListView.Selected = nil)then
    Exit;

  LListItemSel := FListView.Items[FListView.Selected.Index];
  if(AIndexSubItem = -1)then
    LStrCopy := LListItemSel.Caption
  else
    LStrCopy := LListItemSel.SubItems[AIndexSubItem];

  if(not LStrCopy.Trim.IsEmpty)then
    Clipboard.AsText := LStrCopy;
end;

function ListViewCustomSortProc(Item1, Item2: TListItem; SortColumn: Integer): Integer; stdcall;
var
  LStrItem1, LStrItem2: string;
  LIntItem1, LIntItem2: Integer;
  LValidItem1, LValidItem2: Boolean;
  LDhItem1, LDhItem2: TDateTime;
begin
  Result := 0;
  if(Item1 = nil)or(Item2 = nil)then
    Exit;

  case(SortColumn)of
    -1: //COMPARE CAPTIONS
    begin
      LStrItem1 := Item1.Caption;
      LStrItem2 := Item2.Caption;
    end;
    else //COMPARE SUBITEMS
    LStrItem1 := '';
    LStrItem2 := '';
    //CHECK RANGE
    if(SortColumn < Item1.SubItems.Count)then
      LStrItem1 := Item1.SubItems[SortColumn];
    if(SortColumn < Item2.SubItems.Count)then
      LStrItem2 := Item2.SubItems[SortColumn]
  end;

  //SORT STYLES
  case(TDelphiAIDevUtilsListView.FSortStyle)of
    TDelphiAIDevUtilsListViewSortStyle.AlphaNum:
    begin
      Result := lstrcmp(PChar(LStrItem1), PChar(LStrItem2));
    end;
    TDelphiAIDevUtilsListViewSortStyle.Numeric:
    begin
      LValidItem1 := IsValidNumber(LStrItem1, LIntItem1);
      LValidItem2 := IsValidNumber(LStrItem2, LIntItem2);
      Result := ord(LValidItem1 or LValidItem2);
      if(Result <> 0)then
      begin
        if(LIntItem1 = 0)then
          LIntItem1 := 99999999;
        if(LIntItem2 = 0)then
          LIntItem2 := 99999999;
        Result := CompareNumeric(LIntItem2, LIntItem1);
      end;
    end;
    TDelphiAIDevUtilsListViewSortStyle.DateTime:
    begin
      LValidItem1 := IsValidDate(LStrItem1, LDhItem1);
      LValidItem2 := IsValidDate(LStrItem2, LDhItem2);
      Result := ord(LValidItem1 or LValidItem2);
      if(Result <> 0)then
        Result := CompareDates(LDhItem1, LDhItem2);
    end;
  end;

  //SORT DIRECTION
  if(not TDelphiAIDevUtilsListView.FSortOrder[SortColumn + 1])then
    Result := - Result;
end;

{TDelphiAIDevUtilsListView}
class function TDelphiAIDevUtilsListView.New(AListView: TListView): IDelphiAIDevUtilsListView;
begin
  Result := Self.Create(AListView);
end;

constructor TDelphiAIDevUtilsListView.Create(AListView: TListView);
var
  i: Integer;
begin
  FListView := AListView;
  FInvertOrder := True;
  FColumnIndex := 0;
  for i := 0 to Length(FSortOrder) do
    FSortOrder[i] := False;
end;

function TDelphiAIDevUtilsListView.InvertOrder(const AInvertOrder: Boolean): IDelphiAIDevUtilsListView;
begin
  Result := Self;
  FInvertOrder := AInvertOrder;
end;

function TDelphiAIDevUtilsListView.SortStyle(const ASortStyle: TDelphiAIDevUtilsListViewSortStyle): IDelphiAIDevUtilsListView;
begin
  Result := Self;
  FSortStyle := ASortStyle;
end;

function TDelphiAIDevUtilsListView.ColumnIndex(const AColumnIndex: Integer): IDelphiAIDevUtilsListView;
begin
  Result := Self;
  FColumnIndex := AColumnIndex;
end;

procedure TDelphiAIDevUtilsListView.CustomSort;
begin
  if(FInvertOrder)then
    FSortOrder[FColumnIndex] := not FSortOrder[FColumnIndex];
  FListView.CustomSort(@ListViewCustomSortProc, FColumnIndex -1);
end;

end.
