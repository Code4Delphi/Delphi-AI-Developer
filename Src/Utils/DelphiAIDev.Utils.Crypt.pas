unit DelphiAIDev.Utils.Crypt;

interface

uses
  System.SysUtils;

type
  TUtilsCrypt = class
  public
    class function Decrypt(Value: string): string;
    class function Encrypt(Value: string): string;
  end;

implementation

const
  SEQUENCE01 = '1234567890ABCDEFGHIJLMNOPQRSTUVXZWYKabcdefghijlmnopqrstuvxzwyk';
  SEQUENCE02 = '2wqVR03ILHNYMvu6qip9EmsJKb4yl7tvQ1FdPZgOc8nXTzjokxBDSU5fhAGW';

class function TUtilsCrypt.Encrypt(Value: string): string;
var
  i: Integer;
begin
  for i := 1 to Length(Value)do
    if Pos(Value[i], SEQUENCE01) <> 0 then
      Value[i] := SEQUENCE02[Pos(Value[i], SEQUENCE01)];

  Result := Value;
end;

class function TUtilsCrypt.Decrypt(Value: string): string;
var
  i: Integer;
begin
  for i := 1 to Length(Value) do
    if Pos(Value[i], SEQUENCE02) <> 0 then
      Value[i] := SEQUENCE01[Pos(Value[i], SEQUENCE02)];

  Result := Value;
end;

end.
