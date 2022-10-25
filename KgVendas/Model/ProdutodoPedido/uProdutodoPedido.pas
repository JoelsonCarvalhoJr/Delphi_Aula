unit uProdutodoPedido;

interface

uses
SysUtils, SQLExpr,  Dialogs;

Type
  TProdutodoPedido= class
   Private
    { Private declarations }
    Fnu_produtodopedido : Integer;
    Fnu_pedido          : Integer;
    Fco_produto         : Integer;
    Fno_produto         : String;
    Fnu_quantidade      : Double;
    Fnu_valorunitario   : Double;
    Fnu_valortotal      : Double;

    Function GetFnu_produtodopedido : Integer;
    Function GetFnu_pedido          : Integer;
    Function GetFco_produto         : Integer;
    Function GetFno_produto         : String;
    Function GetFnu_quantidade      : Double;
    Function GetFnu_valorunitario   : Double;
    Function GetFnu_valortotal      : Double;

    Procedure SetFnu_produtodopedido ( Const Value : integer );
    Procedure SetFnu_pedido          ( Const Value : integer );
    Procedure SetFco_produto         ( Const Value : integer );
    Procedure SetFno_produto         ( Const Value : String );
    Procedure SetFnu_quantidade      ( Const Value : Double );
    Procedure SetFnu_valorunitario   ( Const Value : Double );
    Procedure SetFnu_valortotal      ( Const Value : Double );

   Public
    { Public declarations }
    Constructor Create;
    Property nu_produtodopedido : Integer Read GetFnu_produtodopedido Write SetFnu_produtodopedido;
    Property nu_pedido          : Integer Read GetFnu_pedido          Write SetFnu_pedido;
    Property co_produto         : Integer Read GetFco_produto         Write SetFco_produto;
    Property no_produto         : String  Read GetFno_produto         Write SetFno_produto;
    Property nu_quantidade      : Double  Read GetFnu_quantidade      Write SetFnu_quantidade;
    Property nu_valorunitario   : Double  Read GetFnu_valorunitario   Write SetFnu_valorunitario;
    Property nu_valortotal      : Double  Read GetFnu_valortotal      Write SetFnu_valortotal;

  end;

implementation

{ TProdutodoPedido}

constructor TProdutodoPedido.Create;
begin
  Fnu_produtodopedido   := 0;

end;

function TProdutodoPedido.GetFnu_produtodopedido: Integer;
begin
  Result := Self.Fnu_produtodopedido;
end;

function TProdutodoPedido.GetFnu_pedido: Integer;
begin
  Result := Self.Fnu_pedido;
end;

function TProdutodoPedido.GetFco_produto: Integer;
begin
  Result := Self.Fco_produto;
end;

function TProdutodoPedido.GetFno_produto: String;
begin
  Result := Self.Fno_produto;
end;

function TProdutodoPedido.GetFnu_quantidade: Double;
begin
  Result := Self.Fnu_quantidade;
end;

function TProdutodoPedido.GetFnu_valorunitario: Double;
begin
  Result := Self.Fnu_valorunitario;
end;

function TProdutodoPedido.GetFnu_valortotal: Double;
begin
  Result := Self.Fnu_valortotal;
end;

procedure TProdutodoPedido.SetFnu_produtodopedido(const Value: integer);
begin
  Self.Fnu_produtodopedido:= Value;
end;

procedure TProdutodoPedido.SetFnu_pedido(const Value: integer);
begin
  Self.Fnu_pedido:= Value;
end;

procedure TProdutodoPedido.SetFco_produto(const Value: integer);
begin
  Self.Fco_produto:= Value;
end;

procedure TProdutodoPedido.SetFno_produto(const Value: String);
begin
  Self.Fno_produto:= Value;
end;

procedure TProdutodoPedido.SetFnu_quantidade(const Value: Double);
begin
  Self.Fnu_quantidade:= Value;
end;

procedure TProdutodoPedido.SetFnu_valorunitario(const Value: Double);
begin
  Self.Fnu_valorunitario:= Value;
end;

procedure TProdutodoPedido.SetFnu_valortotal(const Value: Double);
begin
  Self.Fnu_valortotal:= Value;
end;

end.
