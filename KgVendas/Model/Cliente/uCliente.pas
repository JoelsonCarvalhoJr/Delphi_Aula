unit uCliente;

interface

uses
SysUtils, SQLExpr,  Dialogs;

Type
  TCliente = class
   Private
    { Private declarations }
    Fco_cliente : Integer;
    Fno_cliente : String;
    Fno_cidade  : String;
    Fno_uf      : String;

    Function GetFco_cliente : Integer;
    Function GetFno_cliente : String;
    Function GetFno_cidade  : String;
    Function GetFno_uf      : String;

    Procedure SetFco_cliente ( Const Value : integer );
    Procedure SetFno_cliente ( Const Value : String );
    Procedure SetFno_cidade  ( Const Value : String );
    Procedure SetFno_uf      ( Const Value : String );

   Public
    { Public declarations }
    Constructor Create;
    Property co_cliente : Integer Read GetFco_cliente Write SetFco_cliente;
    Property no_cliente : String  Read GetFno_cliente Write SetFno_cliente;
    Property no_cidade  : String  Read GetFno_cidade  Write SetFno_cidade;
    Property no_uf      : String  Read GetFno_uf      Write SetFno_uf;

  end;

implementation

{ TCliente}

constructor TCliente.Create;
begin
  Fco_cliente := 0;
end;

function TCliente.GetFco_cliente: Integer;
begin
  Result := Self.Fco_cliente;
end;

function TCliente.GetFno_cliente: String;
begin
  Result := Self.Fno_cliente;
end;

function TCliente.GetFno_cidade: String;
begin
  Result := Self.Fno_cidade;
end;

function TCliente.GetFno_uf: String;
begin
  Result := Self.Fno_uf;
end;

procedure TCliente.SetFco_cliente(const Value: Integer);
begin
  Self.Fco_cliente := Value;
end;

procedure TCliente.SetFno_cliente(const Value: String);
begin
  Self.Fno_cliente := Value;
end;

procedure TCliente.SetFno_cidade(const Value: String);
begin
  Self.Fno_cidade:= Value;
end;

procedure TCliente.SetFno_uf(const Value: String);
begin
  Self.Fno_uf:= Value;
end;


end.
