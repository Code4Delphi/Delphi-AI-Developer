unit DelphiAIDev.DefaultsQuestions.PopupMenu;

interface

uses
  System.SysUtils,
  Vcl.Menus,
  System.Generics.Collections,
  DelphiAIDev.Consts,
  DelphiAIDev.Utils,
  DelphiAIDev.Types,
  DelphiAIDev.DefaultsQuestions.Fields,
  DelphiAIDev.DefaultsQuestions.Model,
  DelphiAIDev.Utils.ABMenuAction;

type
  TDelphiAIDevDefaultsQuestionsPopupMenu = class
  private
    FPopupMenu: TPopupMenu;
    FList: TObjectList<TDelphiAIDevDefaultsQuestionsFields>;
    FCont: Integer;
    FProcessClickInItem: TProc<Boolean, string>;
    procedure CreateMenuItemsList;
    function CreateSubMenu(const AMenuItemParent: TMenuItem;
      const AFields: TDelphiAIDevDefaultsQuestionsFields): TMenuItem;
    procedure ItemMenuClick(Sender: TObject);
    procedure ClickFromString(const AStringClick: String);
  public
    function ProcessClickInItem(AProc: TProc<Boolean, string>): TDelphiAIDevDefaultsQuestionsPopupMenu;
    procedure CreateMenus(const APopupMenu: TPopupMenu);
    constructor Create;
    destructor Destroy; override;
  end;

implementation

constructor TDelphiAIDevDefaultsQuestionsPopupMenu.Create;
begin
  FList := TObjectList<TDelphiAIDevDefaultsQuestionsFields>.Create;
  FCont := 0;
  FProcessClickInItem := nil;
end;

destructor TDelphiAIDevDefaultsQuestionsPopupMenu.Destroy;
begin
  FList.Free;
  inherited;
end;

procedure TDelphiAIDevDefaultsQuestionsPopupMenu.CreateMenus(const APopupMenu: TPopupMenu);
begin
  FPopupMenu := APopupMenu;
  FPopupMenu.Items.Clear;

  FList.Clear;

  TDelphiAIDevDefaultsQuestionsModel.New.ReadData(
    procedure(AFields: TDelphiAIDevDefaultsQuestionsFields)
    var
      LFields: TDelphiAIDevDefaultsQuestionsFields;
    begin
      if not AFields.Visible then
        Exit;

      if AFields.Caption.Trim.IsEmpty then
        Exit;

      if (AFields.Kind = TC4DQuestionKind.ItemMenuNormal) and (AFields.Question.Trim.IsEmpty) then
        Exit;

      LFields := TDelphiAIDevDefaultsQuestionsFields.Create;
      LFields.Guid := AFields.Guid;
      LFields.GuidMenuMaster := AFields.GuidMenuMaster;
      LFields.Caption := AFields.Caption;
      LFields.Question := AFields.Question;
      LFields.Kind := AFields.Kind;
      LFields.Order := AFields.Order;
      LFields.Visible := AFields.Visible;
      LFields.CodeOnly := AFields.CodeOnly;

      FList.Add(LFields);

    end
  );

  Self.CreateMenuItemsList;
end;

procedure TDelphiAIDevDefaultsQuestionsPopupMenu.CreateMenuItemsList;
var
  LItem: TDelphiAIDevDefaultsQuestionsFields;
  LListOrder: TList<Integer>;
  LOrder: Integer;
  LMenuItem: TMenuItem;

 procedure AddSubMenuChildrens(const AFields: TDelphiAIDevDefaultsQuestionsFields; const AMenuItem: TMenuItem);
 var
   LOrder2: Integer;
   LItem2: TDelphiAIDevDefaultsQuestionsFields;
   LMenuItem2: TMenuItem;
 begin
   for LOrder2 in LListOrder do
     for LItem2 in FList do
     begin
       if(LItem2.Order = LOrder2)then
         if(not LItem2.Created)and(LItem2.GuidMenuMaster.Trim = AFields.Guid.Trim)then
         begin
           LMenuItem2 := Self.CreateSubMenu(AMenuItem, LItem2);
           LItem2.Created := True;
           //RETIRA O CLICK DO MENU PAI, PARA NAO EXECUTAR O CLICK AO PASSAR O MOUSE E ATIVAR O SUBMENU
           AMenuItem.OnClick := nil;
           AddSubMenuChildrens(LItem2, LMenuItem2);
         end;
     end;
 end;
begin
  if FList.Count <= 0 then
    Exit;

  LListOrder := TList<Integer>.Create;
  try
    for LItem in FList do
    begin
      if(LItem.Order <= 0)then
        LItem.Order := 9999;

      if(not LListOrder.Contains(LItem.Order))then //(LItem.Order > 0)and
        LListOrder.Add(LItem.Order);
    end;

    LListOrder.Sort;

    //LACO NA LListOrder PARA ADD PELA ORDEM, ADD OS QUE NAO TEM MENU MASTER, E A CADA MENU MASTER ADD SEU FILHOS
    for LOrder in LListOrder do
      for LItem in FList do
      begin
        if(LItem.Order = LOrder)then
          if(not LItem.Created)and(LITem.GuidMenuMaster.Trim.IsEmpty)then
          begin
            LMenuItem := Self.CreateSubMenu(nil, LItem);
            LItem.Created := True;

            AddSubMenuChildrens(LItem, LMenuItem);
          end;
      end;

    //ADD TODOS QUE TENHA A ORDEM MAIOR QUE ZERO, E QUE AINDA NAO FORAM ADICIONADOS
    for LOrder in LListOrder do
      for LItem in FList do
      begin
        if(LItem.Order = LOrder)then
          if(not LItem.Created)then
          begin
            LMenuItem := Self.CreateSubMenu(nil, LItem);
            LItem.Created := True;

            AddSubMenuChildrens(LItem, LMenuItem);
          end;
      end;
  finally
    LListOrder.Free;
  end;
end;

function TDelphiAIDevDefaultsQuestionsPopupMenu.CreateSubMenu(const AMenuItemParent: TMenuItem;
  const AFields: TDelphiAIDevDefaultsQuestionsFields): TMenuItem;
var
  LMenuItem: TMenuItem;
begin
  if AMenuItemParent <> nil then
    LMenuItem := TMenuItem.Create(AMenuItemParent)
  else
    LMenuItem := TMenuItem.Create(FPopupMenu);

  LMenuItem.Name := 'DelphiAIDevItemMenu' + TUtils.IncInt(FCont).ToString;
  LMenuItem.Caption := AFields.Caption;
  LMenuItem.OnClick := Self.ItemMenuClick;
  LMenuItem.Hint := AFields.CodeOnly.ToString(TUseBoolStrs.True)
    + TConsts.SEPARATOR_P + AFields.Question;
  LMenuItem.ImageIndex := -1;

  if AMenuItemParent <> nil then
    AMenuItemParent.Add(LMenuItem)
  else
    FPopupMenu.Items.Add(LMenuItem);

  Result := LMenuItem;
end;

procedure TDelphiAIDevDefaultsQuestionsPopupMenu.ItemMenuClick(Sender: TObject);
var
  LMenuItem: TMenuItem;
begin
  LMenuItem := GetMenuItemOfSender(Sender);
  if LMenuItem = nil then
    Exit;

  Self.ClickFromString(LMenuItem.Hint);
end;

function TDelphiAIDevDefaultsQuestionsPopupMenu.ProcessClickInItem(AProc: TProc<Boolean, string>): TDelphiAIDevDefaultsQuestionsPopupMenu;
begin
  Result := Self;
  FProcessClickInItem := AProc;
end;

procedure TDelphiAIDevDefaultsQuestionsPopupMenu.ClickFromString(const AStringClick: String);
var
  LStringClick: string;
  LSeparator: string;
  LCodeOnly: string;
  LQuestion: string;
begin
  LStringClick := AStringClick;
  LSeparator := TConsts.SEPARATOR_P;
  if LStringClick.Trim.Replace(LSeparator, '').IsEmpty then
    Exit;

  LCodeOnly := Copy(LStringClick, 1, pos(LSeparator, LStringClick) - 1);
  LQuestion := Copy(LStringClick, (pos(LSeparator, LStringClick) + LSeparator.Length), LStringClick.Length);

  if Assigned(FProcessClickInItem) then
    FProcessClickInItem(StrToBoolDef(LCodeOnly, False), LQuestion);
end;

end.
