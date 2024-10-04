unit DelphiAIDev.AI.Response;

interface

uses
  System.SysUtils,
  System.Classes,
  DelphiAIDev.AI.Interfaces;

type
  TDelphiAIDevAIResponse = class(TInterfacedObject, IDelphiAIDevAIResponse)
  private
    FStatusCode: Integer;
    FContent: TStrings;
  protected
    function Clear: IDelphiAIDevAIResponse;
    function SetStatusCode(const Value: Integer): IDelphiAIDevAIResponse;
    function GetStatusCode: Integer;
    function SetContentText(const Value: string): IDelphiAIDevAIResponse;
    function GetContent: TStrings;
  public
    class function New: IDelphiAIDevAIResponse;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

class function TDelphiAIDevAIResponse.New: IDelphiAIDevAIResponse;
begin
  Result := Self.Create;
end;

constructor TDelphiAIDevAIResponse.Create;
begin
  FContent := TStringList.Create;
  Self.Clear;
end;

destructor TDelphiAIDevAIResponse.Destroy;
begin
  FContent.Free;
  inherited;
end;

function TDelphiAIDevAIResponse.Clear: IDelphiAIDevAIResponse;
begin
  Result := Self;
  FStatusCode := 0;
  FContent.Clear;
end;

function TDelphiAIDevAIResponse.SetStatusCode(const Value: Integer): IDelphiAIDevAIResponse;
begin
  Result := Self;
  FStatusCode := Value;
end;

function TDelphiAIDevAIResponse.GetStatusCode: Integer;
begin
  Result := FStatusCode;
end;

function TDelphiAIDevAIResponse.SetContentText(const Value: string): IDelphiAIDevAIResponse;
begin
  Result := Self;
  FContent.Text := Value;
end;

function TDelphiAIDevAIResponse.GetContent: TStrings;
begin
  Result := FContent;
end;

end.
