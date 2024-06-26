unit DelphiAIDev.DefaultsQuestions.Fields;

interface

type
  TDelphiAIDevDefaultsQuestionsFields = class
  private
    FGuid: string;
    FGuidMenuMaster: string;
    FQuestion: string;
    FOrder: Integer;
    FVisible: Boolean;
    FCodeOnly: Boolean;
  public
    constructor Create;
    procedure Clear;
    property Guid: string read FGuid write FGuid;
    property GuidMenuMaster: string read FGuidMenuMaster write FGuidMenuMaster;
    property Question: string read FQuestion write FQuestion;
    property Order: Integer read FOrder write FOrder;
    property Visible: Boolean read FVisible write FVisible;
    property CodeOnly: Boolean read FCodeOnly write FCodeOnly;
  end;

implementation

constructor TDelphiAIDevDefaultsQuestionsFields.Create;
begin
  Self.Clear;
end;

procedure TDelphiAIDevDefaultsQuestionsFields.Clear;
begin
  FGuid := '';
  FGuidMenuMaster := '';
  FQuestion := '';
  FOrder := 0;
  FVisible := True;
  FCodeOnly := False;
end;

end.
