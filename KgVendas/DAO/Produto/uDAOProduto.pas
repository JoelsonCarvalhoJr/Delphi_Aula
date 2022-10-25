unit uDAOProduto;

interface
Uses SysUtils, SQLExpr,  Dialogs,  UProduto, UDM, Classes, DB,
     Vcl.Controls, Data.FMTBcd,FireDAC.Comp.Client,
     FireDAC.Stan.Param,
     {Adicionado}
     UKgvendasLib;

Type
  TFilter    = ( tfCodigo, tfNome );
  TProdutoDadosIdNumeroNome = Record
    produto_co_produto    : Integer;
    produto_no_produto    : String;
    produto_nu_valorvenda : Double;

  End;
  TArProdutoDadosIdNumeroNome = Array of TProdutoDadosIdNumeroNome;

  TProdutoDados = Record
    co_produto    : Integer;
    no_produto    : String;
    nu_valorvenda : Double;
   end;
   TArProdutoDados = Array of TProdutoDados;

   TProdutoDAO = class
   _Produto : TProduto;

   Private
     { Private Declarations }
      FListaProduto   : TList;
   Public
    { Public declarations }
      Constructor Create ;
      Destructor Destroy; Override;
      Function GetListaProduto(CodigoProduto: Integer; NomePoduto: string): TArProdutoDados;
      Function Add ( Produto : TProduto): Boolean;
      Function Update( Produto: TProduto): Boolean;
      Function Delete ( Produto: TProduto): Boolean;
      Property ListaProduto  : TList  Read FListaProduto;

   end;


implementation

{ TProdutoDAO }

constructor TProdutoDAO.Create;
begin
  _Produto      := TProduto.Create;
  FListaProduto := TList.Create;
end;


destructor TProdutoDAO.Destroy;
begin
  FreeAndNil(_Produto);
  FreeAndNil(FListaProduto);
end;

function TProdutoDAO.GetListaProduto(CodigoProduto: Integer; NomePoduto: string): TArProdutoDados;
var
  Qry     : TFDQuery;
  LiIndice: Integer;
begin
  Qry := TFDQuery.Create(Nil);
  Qry.Connection := DM.dbsMain;

  Qry.SQL.Clear;
  Qry.SQL.ADD('SELECT distinct co_produto, no_produto, nu_valorvenda');

  if Length(NomePoduto) > 0 then
  begin
    Qry.SQL.ADD('from  kgvenda.produto where no_produto like ' + QuotedStr(trim(NomePoduto)+'%'));
  end
  else
  if CodigoProduto > 0 then
  begin
    Qry.SQL.ADD('from  kgvenda.produto where co_produto = '  + inttostr(CodigoProduto))
  end
  else
    Qry.SQL.ADD('from  kgvenda.produto');


  Try
    Qry.Open;
    Qry.FieldDefs.Update;
    while not Qry.Eof do
      begin
        LiIndice := Length(Result);
        SetLength(Result, LiIndice + 1);
        Result[LiIndice].co_produto    := Qry.FieldByName('co_produto').AsInteger;
        Result[LiIndice].no_produto    := Qry.FieldByName('no_produto').AsString;
        Result[LiIndice].nu_valorvenda := Qry.FieldByName('nu_valorvenda').AsFloat;
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

function TProdutoDAO.Add(Produto: TProduto): Boolean;
var
  Qry     : TFDQuery;
  QryErro : TFDQuery;
begin
  Try
   Result := False;

   Qry := TFDQuery.Create(Nil);
   Qry.Connection := DM.dbsMain;

   Qry.SQL.Clear;
   Qry.SQL.ADD('INSERT INTO kgvenda.produto( ');
   Qry.SQL.ADD('  no_produto,');
   Qry.SQL.ADD('  nu_valorvenda');
   Qry.SQL.ADD(') VALUES (');
   Qry.SQL.ADD('  :vno_produto,');
   Qry.SQL.ADD('  :vnu_valorvenda ');
   Qry.SQL.ADD(')');
   Qry.Params[0].AsString  := Produto.no_produto;
   Qry.Params[1].AsFloat   := Produto.nu_valorvenda;
   Qry.Prepared := True;
   Qry.ExecSQL;
   Result := True;
   FreeAndNil(Qry);

   except
     on e:exception do
     begin
       qryErro.SQL.Add(e.Message);
       ShowMessage('Erro na inclusão do Produto.'+#13+
                   'ERRO: '+e.Message+#13+#13+
                   'SCRIPT:[ '+e.Message+' ]' );
     end;
  end;

end;

function TProdutoDAO.Update(Produto: TProduto): Boolean;
var
  Qry     : TFDQuery;
begin

   Result := False;

   Qry := TFDQuery.Create(Nil);
   Qry.Connection := DM.dbsMain;
   Try
   Qry.SQL.Clear;
   Qry.SQL.ADD('UPDATE kgvenda.produto');
   Qry.SQL.ADD('SET no_produto     = :vno_produto,');
   Qry.SQL.ADD('    nu_valorvenda  = :cnu_valorvenda');
   Qry.SQL.ADD('WHERE co_produto   = :vco_produto');


   Qry.Params[0].AsInteger := Produto.co_produto;
   Qry.Params[1].AsString  := Produto.no_produto;
   Qry.Params[2].AsFloat   := Produto.nu_valorvenda;


   Qry.Prepared := True;
   Qry.ExecSQL;
   Result := True;
   FreeAndNil(Qry);

   except
     on e:exception do
     begin
       ShowMessage('Erro na inclusão do Cliente.'+#13+
                   'ERRO: '+e.Message+#13+#13+
                   'SCRIPT:[ '+e.Message+' ]' );
     end;
  end;


end;

function TProdutoDAO.Delete(Produto: TProduto): Boolean;
var
  Qry     : TFDQuery;
  QryErro : TFDQuery;

begin
  try
   Qry := TFDQuery.Create(Nil);
   Qry.Connection := DM.dbsMain;

   Qry.SQL.Clear;
   Qry.SQL.ADD('DELETE FROM  kgvenda.produto WHERE co_produto = :vco_produto');
   Qry.Params[0].AsInteger  := Produto.co_produto;

   Qry.Prepared := True;
   Qry.ExecSQL;
   Result       := True;
   FreeAndNil(Qry);

   except
     on e:exception do
     begin
       qryErro.SQL.Add(e.Message);
       ShowMessage('Erro na Exclusão do produto.'+#13+
                   'ERRO: '+e.Message+#13+#13+
                   'SCRIPT:[ '+e.Message+' ]' );
     end;
  end;


end;

end.
