unit uDAOProdutodoPedido;

interface
Uses SysUtils, SQLExpr,  Dialogs,  UProdutodoPedido, UDM, Classes, DB,
     Vcl.Controls, Data.FMTBcd,FireDAC.Comp.Client,
     FireDAC.Stan.Param,
     {Adicionado}
     UKgvendasLib;

  Type
   TFilter    = ( tfCodigoProdutodoPedido, tfCodigoPedido );
   TProdutodoPedidoDadosIdNumeroNome = Record
   ProdutodoPedido_nu_produtodopedido : Integer;
   ProdutodoPedido_nu_pedido          : Integer;
   ProdutodoPedido_co_produto         : Integer;
   ProdutodoPedido_nu_quantidade      : Double;
   ProdutodoPedido_nu_valorunitario   : Double;
   ProdutodoPedido_nu_valortotal      : Double;
  End;

  TArProdutodoPedidoDadosIdNumeroNome = Array of TProdutodoPedidoDadosIdNumeroNome;

  TProdutodoPedidoDados = Record
   nu_produtodopedido : Integer;
   nu_pedido          : Integer;
   co_produto         : Integer;
   no_produto         : String;
   nu_quantidade      : Double;
   nu_valorunitario   : Double;
   nu_valortotal      : Double;

   end;
   TArProdutodoPedidoDados = Array of TProdutodoPedidoDados;

   TProdutodoPedidoDAO = class
   _ProdutodoPedido : TProdutodoPedido; //o erro tá aqui. aqui tem d e ser TProdutoPedido
                     // TProdutodoPedido.Create;
   Private
     { Private Declarations }
      FListaProdutodoPedido: TList;
   Public
    { Public declarations }
      Constructor Create ;
      Destructor Destroy; Override;

      Function GetListaProdutodoPedido( NumeroProdutodoPedido: Integer; NumeroPedido: Integer; CodigoProduto: Integer ): TArProdutodoPedidoDados;
      Function Add ( ProdutodoPedido: TProdutodoPedido): Boolean;
      Function Delete ( ProdutodoPedido: TProdutodoPedido): Boolean;
      Property ListaProdutodoPedido: TList  Read FListaProdutodoPedido;

   end;

implementation

{ TProdutodoPedidoDAO }

constructor TProdutodoPedidoDAO.Create;
begin
  _ProdutodoPedido     := TProdutodoPedido.Create;
   FListaProdutodoPedido:= TList.Create;
end;

function TProdutodoPedidoDAO.Delete(ProdutodoPedido: TProdutodoPedido): Boolean;
var
  Qry     : TFDQuery;
  QryErro : TFDQuery;
begin
  try
   Qry := TFDQuery.Create(Nil);
   Qry.Connection := DM.dbsMain;

   Qry.SQL.Clear;
   Qry.SQL.ADD('DELETE FROM  kgvenda.produtodopedido  WHERE nu_pedido = :vnu_pedido ');
   Qry.Params[0].AsInteger  := ProdutodoPedido.nu_pedido;

   Qry.Prepared := True;
   Qry.ExecSQL;
   Result := True;
   FreeAndNil(Qry);

   except
     on e:exception do
     begin
       qryErro.SQL.Add(e.Message);
       ShowMessage('Erro na Exclusão dos Podutos do Pedido.'+#13+
                   'ERRO: '+e.Message+#13+#13+
                   'SCRIPT:[ '+e.Message+' ]' );
     end;
  end;

end;

destructor TProdutodoPedidoDAO.Destroy;
begin
  FreeAndNil(_ProdutodoPedido);
  FreeAndNil(FListaProdutodoPedido);
end;

function TProdutodoPedidoDAO.Add(ProdutodoPedido: TProdutodoPedido): Boolean;
var
  Qry     : TFDQuery;
  QryErro : TFDQuery;
begin
  Try
   Result := False;

   Qry := TFDQuery.Create(Nil);
   Qry.Connection := DM.dbsMain;

   Qry.SQL.Clear;
   Qry.SQL.ADD('INSERT INTO kgvenda.produtodopedido( ');
   Qry.SQL.ADD('  nu_pedido,');
   Qry.SQL.ADD('  co_produto,');
   Qry.SQL.ADD('  nu_quantidade,');
   Qry.SQL.ADD('  nu_valorunitario,');
   Qry.SQL.ADD('  nu_valortotal');

   Qry.SQL.ADD(') VALUES (');
   Qry.SQL.ADD('  :vnu_pedido,');
   Qry.SQL.ADD('  :vco_produto,');
   Qry.SQL.ADD('  :vnu_quantidade,');
   Qry.SQL.ADD('  :vnu_valorunitario,');
   Qry.SQL.ADD('  :vnu_valortotal');
   Qry.SQL.ADD(')');
   Qry.Params[0].AsInteger  := ProdutodoPedido.nu_pedido;
   Qry.Params[1].AsInteger  := ProdutodoPedido.co_produto;
   Qry.Params[2].AsFloat    := ProdutodoPedido.nu_quantidade;
   Qry.Params[3].AsFloat    := ProdutodoPedido.nu_valorunitario;
   Qry.Params[4].AsFloat    := ProdutodoPedido.nu_valortotal;

   Qry.Prepared := True;
   Qry.ExecSQL;
   Result := True;
   FreeAndNil(Qry);

   except
     on e:exception do
     begin
       qryErro.SQL.Add(e.Message);
       ShowMessage('Erro na inclusão dos Poduto do Pedido.'+#13+
                   'ERRO: '+e.Message+#13+#13+
                   'SCRIPT:[ '+e.Message+' ]' );
     end;
  end;

end;

function TProdutodoPedidoDAO.GetListaProdutodoPedido( NumeroProdutodoPedido: Integer; NumeroPedido: Integer; CodigoProduto: Integer ): TArProdutodoPedidoDados;
var
  Qry     : TFDQuery;
  LiIndice: Integer;
begin
  Qry := TFDQuery.Create(Nil);
  Qry.Connection := DM.dbsMain;

  Qry.SQL.Clear;
  Qry.SQL.ADD('select p.nu_produtodopedido, p.nu_pedido, p.co_produto, pr.no_produto,');
  Qry.SQL.ADD('        p.nu_quantidade,p.nu_valorunitario, p.nu_valortotal ');
  Qry.SQL.ADD('from  kgvenda.produtodopedido p');
  Qry.SQL.ADD('inner join kgvenda.dadosgerais d on (d.nu_pedido     = p.nu_pedido)');
  Qry.SQL.ADD('inner join kgvenda.produto     pr on (pr.co_produto  = p.co_produto)');
  if NumeroProdutodoPedido > 0  then
     Qry.SQL.ADD('where p.nu_pedido =  ' + inttostr(NumeroProdutodoPedido))
  else
  if NumeroPedido > 0  then
     Qry.SQL.ADD('where p.nu_pedido =  ' + inttostr(NumeroPedido))
  else
  if CodigoProduto > 0  then
     Qry.SQL.ADD('where p.co_produto =  ' + inttostr(CodigoProduto));

  Qry.SQL.ADD('group by  p.nu_produtodopedido');
  Try
    Qry.Open;
    Qry.FieldDefs.Update;
    while not Qry.Eof do
      begin
        LiIndice := Length(Result);
        SetLength(Result, LiIndice + 1);
        Result[LiIndice].nu_produtodopedido  := Qry.FieldByName('nu_produtodopedido').AsInteger;
        Result[LiIndice].nu_pedido           := Qry.FieldByName('nu_pedido').AsInteger;
        Result[LiIndice].co_produto          := Qry.FieldByName('co_produto').AsInteger;
        Result[LiIndice].no_produto          := Qry.FieldByName('no_produto').AsString;
        Result[LiIndice].nu_quantidade       := Qry.FieldByName('nu_quantidade').AsFloat;
        Result[LiIndice].nu_valorunitario    := Qry.FieldByName('nu_valorunitario').AsFloat;
        Result[LiIndice].nu_valortotal       := Qry.FieldByName('nu_valortotal').AsFloat;
        Qry.Next;
      end;
  Except
    On E: Exception do
      ShowMessage('ERRO: '+e.Message+#13+#13+
                  'SCRIPT:[ '+e.Message+' ]' );

  End;
 Qry.Close;
 FreeAndNil(Qry);

end;

end.
