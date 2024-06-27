unit DelphiAIDev.DefaultsQuestions.Model;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  Rest.JSON,
  DelphiAIDev.Utils,
  DelphiAIDev.Types,
  DelphiAIDev.DefaultsQuestions.Interfaces,
  DelphiAIDev.DefaultsQuestions.Fields;

type
  TDelphiAIDevDefaultsQuestionsModel = class(TInterfacedObject, IDelphiAIDevDefaultsQuestionsModel)
  private
    procedure SaveData(const AFields: TDelphiAIDevDefaultsQuestionsFields);
    procedure EditData(const AFields: TDelphiAIDevDefaultsQuestionsFields);
  protected
    procedure ReadData(AProc: TProc<TDelphiAIDevDefaultsQuestionsFields>);
    procedure SaveOrEditData(const AFields: TDelphiAIDevDefaultsQuestionsFields);
    procedure RemoveData(const AGuid: string);
  public
    class function New: IDelphiAIDevDefaultsQuestionsModel;
    constructor Create;
  end;

implementation

class function TDelphiAIDevDefaultsQuestionsModel.New: IDelphiAIDevDefaultsQuestionsModel;
begin
  Result := Self.Create;
end;

constructor TDelphiAIDevDefaultsQuestionsModel.Create;
begin
  //
end;

procedure TDelphiAIDevDefaultsQuestionsModel.ReadData(AProc: TProc<TDelphiAIDevDefaultsQuestionsFields>);
var
 LStringList: TStringList;
 LJSONObjItem: TJSONObject;
 LJSONArray: TJsonArray;
 i: Integer;
 LFields: TDelphiAIDevDefaultsQuestionsFields;
begin
  LFields := TDelphiAIDevDefaultsQuestionsFields.Create;
  try
    if not FileExists(TUtils.GetPathFileJSONDefaultsQuestions) then
    begin
      AProc(LFields);
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
        LFields.Guid := LJSONObjItem.GetValue<string>('guid');
        LFields.GuidMenuMaster := LJSONObjItem.GetValue<string>('guid_menu_master');
        LFields.Kind := TC4DQuestionKind(LJSONObjItem.GetValue<Integer>('kind')); //TUtils.StrToDefaultsQuestionsKind(LJSONObjItem.GetValue<string>('kind'));
        LFields.Caption := LJSONObjItem.GetValue<string>('caption');
        LFields.Question := LJSONObjItem.GetValue<string>('question');
        LFields.Order := LJSONObjItem.GetValue<Integer>('order');
        LFields.Visible := LJSONObjItem.GetValue<Boolean>('visible');
        LFields.CodeOnly := LJSONObjItem.GetValue<Boolean>('code_only');
        AProc(LFields);
      end;
    finally
      LJSONArray.Free;
    end;
  finally
    LFields.Free;
  end;
end;

procedure TDelphiAIDevDefaultsQuestionsModel.SaveOrEditData(const AFields: TDelphiAIDevDefaultsQuestionsFields);
begin
  if AFields.Guid.Trim.IsEmpty then
    Self.SaveData(AFields)
  else
    Self.EditData(AFields);
end;

procedure TDelphiAIDevDefaultsQuestionsModel.SaveData(const AFields: TDelphiAIDevDefaultsQuestionsFields);
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
      LJSONObject.AddPair('guid_menu_master', AFields.GuidMenuMaster);
      LJSONObject.AddPair('kind', TJSONNumber.Create(Integer(AFields.Kind)));
      LJSONObject.AddPair('caption', AFields.Caption);
      LJSONObject.AddPair('question', AFields.Question);
      LJSONObject.AddPair('order', TJSONNumber.Create(AFields.Order));
      LJSONObject.AddPair('visible', TJSONBool.Create(AFields.Visible));
      LJSONObject.AddPair('code_only', TJSONBool.Create(AFields.CodeOnly));
      LJSONArray.AddElement(LJSONObject);

      {$IF CompilerVersion <= 32.0} //Tokyo
        LStringList.Text := LJSONArray.ToJSON;
      {$ELSE}
        LStringList.Text := LJSONArray.Format(2);
      {$ENDIF}
    finally
      LJSONArray.Free;
    end;

    LStringList.SaveToFile(TUtils.GetPathFileJSONDefaultsQuestions);
  finally
    LStringList.Free;
  end;
end;

procedure TDelphiAIDevDefaultsQuestionsModel.EditData(const AFields: TDelphiAIDevDefaultsQuestionsFields);
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

        if LJSONObjItem.GetValue<string>('guid') = AFields.Guid then
        begin
          LJSONObjItem.RemovePair('guid_menu_master').Free;
          LJSONObjItem.AddPair('guid_menu_master', AFields.GuidMenuMaster);

          LJSONObjItem.RemovePair('kind').Free;
          LJSONObjItem.AddPair('kind', TJSONNumber.Create(Integer(AFields.Kind))); // AFields.Kind.ToString);

          LJSONObjItem.RemovePair('caption').Free;
          LJSONObjItem.AddPair('caption', AFields.Caption);

          LJSONObjItem.RemovePair('question').Free;
          LJSONObjItem.AddPair('question', AFields.Question);

          LJSONObjItem.RemovePair('order').Free;
          LJSONObjItem.AddPair('order', TJSONNumber.Create(AFields.Order));

          LJSONObjItem.RemovePair('visible').Free;
          LJSONObjItem.AddPair('visible', TJSONBool.Create(AFields.Visible));

          LJSONObjItem.RemovePair('code_only').Free;
          LJSONObjItem.AddPair('code_only', TJSONBool.Create(AFields.CodeOnly));
          Break;
        end;
      end;

      {$IF CompilerVersion <= 32.0} //Tokyo
        LStringList.Text := LJSONArray.ToJSON;
      {$ELSE}
        LStringList.Text := LJSONArray.Format(2);
      {$ENDIF}
    finally
      LJSONArray.Free;
    end;

    LStringList.SaveToFile(TUtils.GetPathFileJSONDefaultsQuestions);
  finally
    LStringList.Free;
  end;
end;

procedure TDelphiAIDevDefaultsQuestionsModel.RemoveData(const AGuid: string);
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

      {$IF CompilerVersion <= 32.0} //Tokyo
        LStringList.Text := LJSONArray.ToJSON;
      {$ELSE}
        LStringList.Text := LJSONArray.Format(2);
      {$ENDIF}
    finally
      LJSONArray.Free;
    end;

    LStringList.SaveToFile(TUtils.GetPathFileJSONDefaultsQuestions);
  finally
    LStringList.Free;
  end;
end;

end.
