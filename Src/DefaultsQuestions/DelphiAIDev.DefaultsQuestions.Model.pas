unit DelphiAIDev.DefaultsQuestions.Model;

interface

type
  TDelphiAIDevDefaultsQuestionsModel = class
  private
    FId: Integer;
    FIdParent: Integer;
    FQuestion: string;
    FOrder: Integer;
    FVisible: Boolean;
    FCodeOnly: Boolean;
  public
    constructor Create;
    procedure Clear;

    property Id: Integer read FId write FId;
    property IdParent: Integer read FIdParent write FIdParent;
    property Question: string read FQuestion write FQuestion;
    property Order: Integer read FOrder write FOrder;
    property Visible: Boolean read FVisible write FVisible;
    property CodeOnly: Boolean read FCodeOnly write FCodeOnly;
  end;

implementation

constructor TDelphiAIDevDefaultsQuestionsModel.Create;
begin
  Self.Clear;
end;

procedure TDelphiAIDevDefaultsQuestionsModel.Clear;
begin
  FId := 0;
  FIdParent := 0;
  FQuestion := '';
  FOrder := 0;
  FVisible := True;
  FCodeOnly := False;
end;

end.
