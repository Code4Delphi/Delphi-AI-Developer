unit DelphiAIDev.DefaultsQuestions.Dao;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  DelphiAIDev.Utils,
  DelphiAIDev.DefaultsQuestions.Interfaces,
  DelphiAIDev.DefaultsQuestions.Model;

type
  TDelphiAIDevDefaultsQuestionsDao = class(TInterfacedObject, IDelphiAIDevDefaultsQuestionsDao)
  private
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
  //
end;

procedure TDelphiAIDevDefaultsQuestionsDao.ReadData(AProc: TProc<TDelphiAIDevDefaultsQuestionsModel>);
var
 LStringList: TStringList;
 LJSONObjItem: TJSONObject;
 LJSONArray: TJsonArray;
 i: Integer;
 LModel: TDelphiAIDevDefaultsQuestionsModel;
begin
  LModel := TDelphiAIDevDefaultsQuestionsModel.Create;
  try
    if not FileExists(TUtils.GetPathFileJSONDefaultsQuestions) then
    begin
      AProc(LModel);
      Exit;
    end;

    LStringList := TStringList.Create;
    try
      LStringList.LoadFromFile(TUtils.GetPathFileJSONDefaultsQuestions);
      LJSONArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LStringList.Text), 0) as TJSONArray;
    finally
      LStringList.Free;
    end;

    try
      for i := 0 to Pred(LJSONArray.Count) do
      begin
        if not(LJSONArray.Items[i] is TJSONObject) then
          Continue;

        LJSONObjItem := LJSONArray.Items[i] as TJSONObject;

        LModel.Guid := LJSONObjItem.GetValue<string>('guid');
        LModel.GuidMenuMaster := LJSONObjItem.GetValue<string>('guid_menu_master');
        LModel.Question := LJSONObjItem.GetValue<string>('question');
        LModel.Order := LJSONObjItem.GetValue<Integer>('order');
        LModel.Visible := LJSONObjItem.GetValue<Boolean>('visible');
        LModel.CodeOnly := LJSONObjItem.GetValue<Boolean>('code_only');
        AProc(LModel);
      end;
    finally
      LJSONArray.Free;
    end;
  finally
    LModel.Free;
  end;
end;

function TDelphiAIDevDefaultsQuestionsDao.SaveOrEditData(AModel: TDelphiAIDevDefaultsQuestionsModel): IDelphiAIDevDefaultsQuestionsDao;
var
  LStringList: TStringList;
  LJSONArray: TJSONArray;
  LJSONObject: TJSONObject;
begin
  Result := Self;

  LStringList := TStringList.Create;
  try
    if FileExists(TUtils.GetPathFileJSONDefaultsQuestions) then
      LStringList.LoadFromFile(TUtils.GetPathFileJSONDefaultsQuestions);

    LJSONArray := TJSONArray.Create;
    try
      if string(LStringList.Text).Trim.StartsWith('[') then
      begin
        LJSONArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LStringList.Text), 0) as TJSONArray;
      end;

      if AModel.Guid.Trim.IsEmpty then
        AModel.Guid := TUtils.GetGuidStr;

      LJSONObject := TJSONObject.Create;
      LJSONObject.AddPair('guid', AModel.Guid);
      LJSONObject.AddPair('guid_menu_master', AModel.GuidMenuMaster);
      LJSONObject.AddPair('question', AModel.Question);
      LJSONObject.AddPair('order', TJSONNumber.Create(AModel.Order));
      LJSONObject.AddPair('visible', TJSONBool.Create(AModel.Visible));
      LJSONObject.AddPair('code_only', TJSONBool.Create(AModel.CodeOnly));
      LJSONArray.AddElement(LJSONObject);

      LStringList.Text := LJSONArray.Format(2)
    finally
      LJSONArray.Free;
    end;

    LStringList.SaveToFile(TUtils.GetPathFileJSONDefaultsQuestions);
  finally
    LStringList.Free;
  end;


//  FQuery.CloseClear.ExecSQL('CREATE TABLE IF NOT EXISTS defaults_questions(id INTEGER PRIMARY KEY, '+
//   'id_parent Integer, question TEXT, order_display Integer, name TEXT)');
//
//  FQuery.CloseClear
//    .Add('CREATE TABLE IF NOT EXISTS defaults_questions(')
//    .Add('  id INTEGER PRIMARY KEY,')
//    .Add('  id_parent INTEGER,')
//    .Add('  question TEXT,')
//    .Add('  order_display INTEGER,')
//    .Add('  visible TEXT,')
//    .Add('  code_only TEXT')
//    .Add(') ')
//    .ExecSQL;
//
//  FQuery.CloseClear
//    .Add('insert into defaults_questions(id_parent, question, order_display, visible, code_only)')
//    .Add('values(:id_parent, :question, :order_display, :visible, :code_only)')
//    .AddParam('id_parent', AModel.IdParent)
//    .AddParam('question', AModel.Question)
//    .AddParam('order_display', AModel.Order)
//    .AddParam('visible', TUtils.BoolToStrC4D(AModel.Visible))
//    .AddParam('code_only', TUtils.BoolToStrC4D(AModel.CodeOnly))
//    .ExecSQL;
end;

end.

