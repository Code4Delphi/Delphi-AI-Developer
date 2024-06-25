unit DelphiAIDev.DefaultsQuestions.Dao;

interface

uses
  System.SysUtils,
  System.Classes,
  C4D.Conn,
  DelphiAIDev.Utils,
  DelphiAIDev.DefaultsQuestions.Interfaces,
  DelphiAIDev.DefaultsQuestions.Model;

type
  TDelphiAIDevDefaultsQuestionsDao = class(TInterfacedObject, IDelphiAIDevDefaultsQuestionsDao)
  private
    FQuery: IC4DConnQuery;
  protected
    procedure ReadData(AProc: TProc<TDelphiAIDevDefaultsQuestionsModel>);
    function SaveOrEditData(AModel: TDelphiAIDevDefaultsQuestionsModel): IDelphiAIDevDefaultsQuestionsDao;
  public
    class function New: IDelphiAIDevDefaultsQuestionsDao;
    constructor Create;
  end;

implementation

class function TDelphiAIDevDefaultsQuestionsDao.New: IDelphiAIDevDefaultsQuestionsDao;
begin
  Result := Self.Create;
end;

constructor TDelphiAIDevDefaultsQuestionsDao.Create;
begin
  FQuery := C4DConn.Query('FDQueryDefaultsQuestions');

end;

procedure TDelphiAIDevDefaultsQuestionsDao.ReadData(AProc: TProc<TDelphiAIDevDefaultsQuestionsModel>);
var
  i: Integer;
  LModel: TDelphiAIDevDefaultsQuestionsModel;
begin
  for i := 0 to 10 do
  begin
    LModel := TDelphiAIDevDefaultsQuestionsModel.Create;
    try
      LModel.Id := i;
      LModel.IdParent := i + 10;
      LModel.Question := 'Question ' + i.ToString;
      LModel.Order := i;
      LModel.Visible := True;
      LModel.CodeOnly := False;
      AProc(LModel);
    finally
      LModel.Free;
    end;
  end;

//  LIniFile := Self.GetIniFile;
//  try
//    LSections := TStringList.Create;
//    try
//      LIniFile.ReadSections(LSections);
//      for i := 0 to Pred(LSections.Count) do
//      begin
//        LSessaoStr := LSections[i];
//        LModel := TC4DWizardOpenExternal.Create;
//        try
//          LModel.Guid := LSessaoStr;
//          LModel.Description := LIniFile.ReadString(LSessaoStr, TC4DConsts.OPEN_EXTERNAL_INI_Description, '');
//          LModel.Path := LIniFile.ReadString(LSessaoStr, TC4DConsts.OPEN_EXTERNAL_INI_Path, '');
//          LModel.Parameters := LIniFile.ReadString(LSessaoStr, TC4DConsts.OPEN_EXTERNAL_INI_Parameters, '');
//          LModel.Kind := TC4DWizardUtils.StrToOpenExternalKind(LIniFile.ReadString(LSessaoStr, TC4DConsts.OPEN_EXTERNAL_INI_Kind, ''));
//          LModel.Visible := LIniFile.ReadBool(LSessaoStr, TC4DConsts.OPEN_EXTERNAL_INI_Visible, True);
//          LModel.VisibleInToolBarUtilities := LIniFile.ReadBool(LSessaoStr, TC4DConsts.OPEN_EXTERNAL_INI_VisibleInToolBarUtilities, False);
//          LModel.Order := LIniFile.ReadInteger(LSessaoStr, TC4DConsts.OPEN_EXTERNAL_INI_Order, 0);
//          LModel.Shortcut := LIniFile.ReadString(LSessaoStr, TC4DConsts.OPEN_EXTERNAL_INI_Shortcut, '');
//          LModel.IconHas := LIniFile.ReadBool(LSessaoStr, TC4DConsts.OPEN_EXTERNAL_INI_IconHas, False);
//          LModel.GuidMenuMaster := LIniFile.ReadString(LSessaoStr, TC4DConsts.OPEN_EXTERNAL_INI_GuidMenuMaster, '');
//          AProc(LModel);
//        finally
//          LModel.Free;
//        end;
//      end;
//    finally
//      LSections.Free;
//    end;
//  finally
//    LIniFile.Free;
//  end;
end;

function TDelphiAIDevDefaultsQuestionsDao.SaveOrEditData(AModel: TDelphiAIDevDefaultsQuestionsModel): IDelphiAIDevDefaultsQuestionsDao;
begin
  Result := Self;


  FQuery.CloseClear.ExecSQL('CREATE TABLE IF NOT EXISTS defaults_questions(id INTEGER PRIMARY KEY, '+
   'id_parent Integer, question TEXT, order_display Integer, name TEXT)');

  FQuery.CloseClear
    .Add('CREATE TABLE IF NOT EXISTS defaults_questions(')
    .Add('  id INTEGER PRIMARY KEY,')
    .Add('  id_parent INTEGER,')
    .Add('  question TEXT,')
    .Add('  order_display INTEGER,')
    .Add('  visible TEXT,')
    .Add('  code_only TEXT')
    .Add(') ')
    .ExecSQL;

  FQuery.CloseClear
    .Add('insert into defaults_questions(id_parent, question, order_display, visible, code_only)')
    .Add('values(:id_parent, :question, :order_display, :visible, :code_only)')
    .AddParam('id_parent', AModel.IdParent)
    .AddParam('question', AModel.Question)
    .AddParam('order_display', AModel.Order)
    .AddParam('visible', TUtils.BoolToStrC4D(AModel.Visible))
    .AddParam('code_only', TUtils.BoolToStrC4D(AModel.CodeOnly))
    .ExecSQL;
end;

end.

