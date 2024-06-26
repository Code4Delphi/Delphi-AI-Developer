unit DelphiAIDev.DefaultsQuestions.Dao;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  Rest.JSON,
  DelphiAIDev.Utils,
  DelphiAIDev.DefaultsQuestions.Interfaces,
  DelphiAIDev.DefaultsQuestions.Model;

type
  TDelphiAIDevDefaultsQuestionsDao = class(TInterfacedObject, IDelphiAIDevDefaultsQuestionsDao)
  private
    procedure SaveData(const AModel: TDelphiAIDevDefaultsQuestionsModel);
    procedure EditData(const AModel: TDelphiAIDevDefaultsQuestionsModel);
  protected
    procedure ReadData(AProc: TProc<TDelphiAIDevDefaultsQuestionsModel>);
    procedure SaveOrEditData(const AModel: TDelphiAIDevDefaultsQuestionsModel);
    procedure RemoveData(const AGuid: string);
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

procedure TDelphiAIDevDefaultsQuestionsDao.SaveOrEditData(const AModel: TDelphiAIDevDefaultsQuestionsModel);
begin
  if AModel.Guid.Trim.IsEmpty then
    Self.SaveData(AModel)
  else
    Self.EditData(AModel);
end;

procedure TDelphiAIDevDefaultsQuestionsDao.SaveData(const AModel: TDelphiAIDevDefaultsQuestionsModel);
var
  LStringList: TStringList;
  LJSONArray: TJSONArray;
  LJSONObject: TJSONObject;
begin
  LStringList := TStringList.Create;
  try
    if FileExists(TUtils.GetPathFileJSONDefaultsQuestions) then
      LStringList.LoadFromFile(TUtils.GetPathFileJSONDefaultsQuestions);

    LJSONArray := TJSONArray.Create;
    try
      if string(LStringList.Text).Trim.StartsWith('[') then
        LJSONArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LStringList.Text), 0) as TJSONArray;

      LJSONObject := TJSONObject.Create;
      LJSONObject.AddPair('guid', TUtils.GetGuidStr);
      LJSONObject.AddPair('guid_menu_master', AModel.GuidMenuMaster);
      LJSONObject.AddPair('question', AModel.Question);
      LJSONObject.AddPair('order', TJSONNumber.Create(AModel.Order));
      LJSONObject.AddPair('visible', TJSONBool.Create(AModel.Visible));
      LJSONObject.AddPair('code_only', TJSONBool.Create(AModel.CodeOnly));
      LJSONArray.AddElement(LJSONObject);

      LStringList.Text := LJSONArray.Format(2);
    finally
      LJSONArray.Free;
    end;

    LStringList.SaveToFile(TUtils.GetPathFileJSONDefaultsQuestions);
  finally
    LStringList.Free;
  end;
end;

procedure TDelphiAIDevDefaultsQuestionsDao.EditData(const AModel: TDelphiAIDevDefaultsQuestionsModel);
var
  LStringList: TStringList;
  LJSONArray: TJSONArray;
  LJSONObjItem: TJSONObject;
  i: Integer;
begin
  LStringList := TStringList.Create;
  try
    if FileExists(TUtils.GetPathFileJSONDefaultsQuestions) then
      LStringList.LoadFromFile(TUtils.GetPathFileJSONDefaultsQuestions);

    LJSONArray := TJSONArray.Create;
    try
      if string(LStringList.Text).Trim.StartsWith('[') then
        LJSONArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LStringList.Text), 0) as TJSONArray;

      for i := 0 to Pred(LJSONArray.Count) do
      begin
        if not(LJSONArray.Items[i] is TJSONObject) then
          Continue;

        LJSONObjItem := LJSONArray.Items[i] as TJSONObject;

        if LJSONObjItem.GetValue<string>('guid') = AModel.Guid then
        begin
          LJSONObjItem.RemovePair('guid_menu_master').Free;
          LJSONObjItem.AddPair('guid_menu_master', AModel.GuidMenuMaster);

          LJSONObjItem.RemovePair('question').Free;
          LJSONObjItem.AddPair('question', AModel.Question);

          LJSONObjItem.RemovePair('order').Free;
          LJSONObjItem.AddPair('order', TJSONNumber.Create(AModel.Order));

          LJSONObjItem.RemovePair('visible').Free;
          LJSONObjItem.AddPair('visible', TJSONBool.Create(AModel.Visible));

          LJSONObjItem.RemovePair('code_only').Free;
          LJSONObjItem.AddPair('code_only', TJSONBool.Create(AModel.CodeOnly));
          Break;
        end;
      end;

      LStringList.Text := LJSONArray.Format(2);
    finally
      LJSONArray.Free;
    end;

    LStringList.SaveToFile(TUtils.GetPathFileJSONDefaultsQuestions);
  finally
    LStringList.Free;
  end;
end;

procedure TDelphiAIDevDefaultsQuestionsDao.RemoveData(const AGuid: string);
var
  LStringList: TStringList;
  LJSONArray: TJSONArray;
  LJSONObjItem: TJSONObject;
  i: Integer;
begin
  if AGuid.Trim.IsEmpty then
    Exit;

  if not FileExists(TUtils.GetPathFileJSONDefaultsQuestions) then
    Exit;

  LStringList := TStringList.Create;
  try
    LStringList.LoadFromFile(TUtils.GetPathFileJSONDefaultsQuestions);
    if not string(LStringList.Text).Trim.StartsWith('[') then
      Exit;

    LJSONArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LStringList.Text), 0) as TJSONArray;
    try
      for i := 0 to Pred(LJSONArray.Count) do
      begin
        if not(LJSONArray.Items[i] is TJSONObject) then
          Continue;

        LJSONObjItem := LJSONArray.Items[i] as TJSONObject;
        if LJSONObjItem.GetValue<string>('guid') = AGuid then
        begin
          LJSONArray.Remove(i);
          Break;
        end;
      end;

      LStringList.Text := LJSONArray.Format(2);
    finally
      LJSONArray.Free;
    end;

    LStringList.SaveToFile(TUtils.GetPathFileJSONDefaultsQuestions);
  finally
    LStringList.Free;
  end;
end;

end.
