unit uProduto;

interface

uses

SysUtils, SQLExpr,  Dialogs;

Type
  TProduto = class
   Private
    { Private declarations }
    FProdutoco_produto   : Integer;
    FProdutono_produto   : String;
    FProdutonu_valorvenda: Double;

    Function GetFProdutoco_produto    : Integer;
    Function GetFProdutono_produto    : String;
    Function GetFProdutonu_valorvenda : Double;

    Procedure SetFProdutoco_produto    ( Const Value : integer );
    Procedure SetFProdutono_produto    ( Const Value : String  );
    Procedure SetFProdutonu_valorvenda ( Const Value : Double  );

   Public
    { Public declarations }
    Constructor Create;
    Property co_produto     : Integer Read GetFProdutoco_produto     Write SetFProdutoco_produto;
    Property no_produto     : String  Read GetFProdutono_produto     Write SetFProdutono_produto;
    Property nu_valorvenda  : Double  Read GetFProdutonu_valorvenda  Write SetFProdutonu_valorvenda;
  end;

implementation

{ TProduto}

constructor TProduto.Create;
begin
  FProdutoco_produto     := 0;
end;

function TProduto.GetFProdutoco_produto: Integer;
begin
  Result := Self.FProdutoco_produto;
end;

function TProduto.GetFProdutono_produto: String;
begin
  Result := Self.FProdutono_produto;
end;

function TProduto.GetFProdutonu_valorvenda: Double;
begin
  Result := Self.FProdutonu_valorvenda;
end;

procedure TProduto.SetFProdutoco_produto(const Value: integer);
begin
  Self.FProdutoco_produto := Value;
end;

procedure TProduto.SetFProdutono_produto(const Value: String);
begin
  Self.FProdutono_produto := Value;
end;

procedure TProduto.SetFProdutonu_valorvenda(const Value: Double);
begin
  Self.FProdutonu_valorvenda := Value;
end;

end.
