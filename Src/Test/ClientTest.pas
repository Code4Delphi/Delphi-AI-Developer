unit ClientTest;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IniFiles;

type
  TCliente = class(TPersistent)
  private
    FID: Integer;              // Identificador do cliente
    FNome: String;            // Nome do cliente
    FTelefone: String;        // Telefone do cliente
    FCidade: String;          // Cidade do cliente
  public
    function GetID: Integer;
    procedure SetID(const AValue: Integer);
    function GetNome: String;
    procedure SetNome(const AValue: String);
    function GetTelefone: String;
    procedure SetTelefone(const AValue: String);
    function GetCidade: String;
    procedure SetCidade(const AValue: String);
    constructor Create(const AID, ANome, ATelefone, ACidade: String); overload;
    constructor Create(const AID: Integer; const ANome, ATelefone, ACidade: String); overload;

    procedure SaveToFile(const AFileName: String);
  end;

implementation

 {TCliente }
function TCliente.GetID: Integer;
begin
  Result := FID;
end;

procedure TCliente.SetID(const AValue: Integer);
begin
  FID := AValue;
end;

function TCliente.GetNome: String;
begin
  Result := FNome;
end;

procedure TCliente.SetNome(const AValue: String);
begin
  FNome := AValue;
end;

function TCliente.GetTelefone: String;
begin
  Result := FTelefone;
end;

procedure TCliente.SetTelefone(const AValue: String);
begin
  FTelefone := AValue;
end;

function TCliente.GetCidade: String;
begin
  Result := FCidade;
end;

procedure TCliente.SetCidade(const AValue: String);
begin
  FCidade := AValue;
end;

constructor TCliente.Create(const AID, ANome, ATelefone, ACidade: String);
begin
  SetID(AID.ToInteger);
  SetNome(ANome);
  SetTelefone(ATelefone);
  SetCidade(ACidade);
end;

constructor TCliente.Create(const AID: Integer; const ANome, ATelefone, ACidade: String);
begin
  SetID(AID);
  SetNome(ANome);
  SetTelefone(ATelefone);
  SetCidade(ACidade);
end;

procedure TCliente.SaveToFile(const AFileName: String);
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(AFileName);
  try
    IniFile.WriteInteger('Cliente', 'ID', GetID);    // Salva o ID do cliente na seção 'Cliente'
    IniFile.WriteString('Cliente', 'Nome', GetNome); // Salva o nome do cliente na seção 'Cliente'
    IniFile.WriteString('Cliente', 'Telefone', GetTelefone); // Salva o telefone do cliente na seção 'Cliente'
    IniFile.WriteString('Cliente', 'Cidade', GetCidade); // Salva a cidade do cliente na seção 'Cliente'
  finally
    IniFile.Free;
  end;
end;

end.
