unit DelphiAIDev.DefaultsQuestions.Fields;

interface

uses
  DelphiAIDev.Types;

type
  TDelphiAIDevDefaultsQuestionsFields = class
  private
    FGuid: string;
    FGuidMenuMaster: string;
    FQuestion: string;
    FKind: TC4DQuestionKind;
    FOrder: Integer;
    FVisible: Boolean;
    FCodeOnly: Boolean;
    FCaption: string;
    FCreated: Boolean;
  public
    constructor Create;
    procedure Clear;
    property Guid: string read FGuid write FGuid;
    property GuidMenuMaster: string read FGuidMenuMaster write FGuidMenuMaster;
    property Caption: string read FCaption write FCaption;
    property Question: string read FQuestion write FQuestion;
    property Kind: TC4DQuestionKind read FKind write FKind;
    property Order: Integer read FOrder write FOrder;
    property Visible: Boolean read FVisible write FVisible;
    property CodeOnly: Boolean read FCodeOnly write FCodeOnly;
    property Created: Boolean read FCreated write FCreated;
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
  FCaption := '';
  FQuestion := '';
  FKind := TC4DQuestionKind.ItemMenuNormal;
  FOrder := 0;
  FVisible := True;
  FCodeOnly := False;
  FCreated := False;
end;

end.
