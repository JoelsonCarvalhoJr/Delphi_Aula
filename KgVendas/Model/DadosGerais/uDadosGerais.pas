unit uDadosGerais;

interface

uses

SysUtils, SQLExpr,  Dialogs;

Type
  TDadosGerais = class
   Private
    { Private declarations }
    Fnu_pedido    : Integer;
    Fdt_emissao   : TDateTime;
    Fco_cliente   : Integer;
    Fnu_valortotal: Double;

    Function GetFnu_pedido    : Integer;
    Function GetFdt_emissao   : TDateTime;
    Function GetFco_cliente   : Integer;
    Function GetFnu_valortotal: Double;

    Procedure SetFnu_pedido        ( Const Value : integer );
    Procedure SetFdt_emissao       ( Const Value : TDateTime);
    Procedure SetFco_cliente       ( Const Value : integer );
    Procedure SetFnu_valortotal    ( Const Value : Double );

   Public
    { Public declarations }
    Constructor Create;
    Property nu_pedido      : Integer    Read GetFnu_pedido     Write SetFnu_pedido;
    Property dt_emissao     : TDateTime  Read GetFdt_emissao    Write SetFdt_emissao;
    Property co_cliente     : Integer    Read GetFco_cliente    Write SetFco_cliente;
    Property nu_valortotal  : Double     Read GetFnu_valortotal Write SetFnu_valortotal;

  end;

implementation

{ TDadosGerai}

constructor TDadosGerais.Create;
begin
  Fnu_pedido     := 0;

end;

function TDadosGerais.GetFnu_pedido: Integer;
begin
  Result := Self.Fnu_pedido;
end;

function TDadosGerais.GetFdt_emissao: TDateTime;
begin
  Result := Self.Fdt_emissao;
end;

function TDadosGerais.GetFco_cliente: Integer;
begin
  Result := Self.Fco_cliente;
end;

function TDadosGerais.GetFnu_valortotal: Double;
begin
  Result := Self.Fnu_valortotal;
end;

procedure TDadosGerais.SetFnu_pedido(const Value: integer);
begin
  Self.Fnu_pedido := Value;
end;

procedure TDadosGerais.SetFdt_emissao(const Value: TDateTime);
begin
  Self.Fdt_emissao := Value;
end;

procedure TDadosGerais.SetFco_cliente(const Value: integer);
begin
  Self.Fco_cliente:= Value;
end;

procedure TDadosGerais.SetFnu_valortotal(const Value: Double);
begin
  Self.Fnu_valortotal:= Value;
end;

end.
