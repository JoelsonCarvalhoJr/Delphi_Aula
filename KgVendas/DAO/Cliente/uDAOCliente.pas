unit uDAOCliente;

interface
Uses SysUtils, SQLExpr,  Dialogs,  UCliente, UDM, Classes, DB,
     Vcl.Controls, Data.FMTBcd,FireDAC.Comp.Client,
     FireDAC.Stan.Param,
     {Adicionado}
     UKgvendasLib;

Type
  TFilter    = ( tfCodigo, tfNome );
  TClienteDadosIdNumeroNome = Record
    cliente_co_cliente  : Integer;
    cliente_no_cliente  : String;
    cliente_no_cidade   : String;
    cliente_no_uf       : String;

  End;
  TArClienteDadosIdNumeroNome = Array of TClienteDadosIdNumeroNome;

  TClienteDados = Record
    co_cliente  : Integer;
    no_cliente  : String;
    no_cidade   : String;
    no_uf       : String;
   end;
   TArClienteDados = Array of TClienteDados;

   TClienteDAO = class
   _Cliente : TCliente;

   Private
     { Private Declarations }
      FListaCliente: TList;
   Public
    { Public declarations }
      Constructor Create ;
      Destructor Destroy; Override;
      Function GetListaCliente(CodigoCliente: Integer;NomeCliente: string): TArClienteDados;
      Function Add ( Cliente: TCliente): Boolean;
      Function Update( Cliente: TCliente): Boolean;
      Function Delete ( Cliente: TCliente): Boolean;
      Property ListaCliente: TList  Read FListaCliente;

   end;

implementation

{ TClienteDAO }
constructor TClienteDAO.Create;
begin
  _Cliente      := TCliente.Create;
  FListaCliente := TList.Create;
end;

destructor TClienteDAO.Destroy;
begin
  FreeAndNil(_Cliente);
  FreeAndNil(FListaCliente);
end;

function TClienteDAO.Add(Cliente: TCliente): Boolean;
var
  Qry     : TFDQuery;
begin
  Try
   Result := False;

   Qry := TFDQuery.Create(Nil);
   Qry.Connection := DM.dbsMain;

   Qry.SQL.Clear;
   Qry.SQL.ADD('INSERT INTO kgvenda.cliente( ');
   Qry.SQL.ADD('  no_cliente,');
   Qry.SQL.ADD('  no_cidade,');
   Qry.SQL.ADD('  no_uf');
   Qry.SQL.ADD(') VALUES (');
   Qry.SQL.ADD('  :vno_cliente,');
   Qry.SQL.ADD('  :vno_cidade,');
   Qry.SQL.ADD('  :vno_uf ');
   Qry.SQL.ADD(')');

   Qry.Params[0].AsString  := Cliente.no_cliente;
   Qry.Params[1].AsString  := Cliente.no_cidade;
   Qry.Params[2].AsString  := Cliente.no_uf;

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

function TClienteDAO.GetListaCliente(CodigoCliente: Integer; NomeCliente: string): TArClienteDados;
var
  Qry     : TFDQuery;
  LiIndice: Integer;
begin
  Qry := TFDQuery.Create(Nil);
  Qry.Connection := DM.dbsMain;

  Qry.SQL.Clear;
  Qry.SQL.ADD('SELECT distinct co_cliente, no_cliente, no_cidade, no_uf');

  if CodigoCliente = -1  then
  begin
    Qry.SQL.ADD('from  kgvenda.cliente');
  end
  else
  if CodigoCliente > 0  then
  begin
    Qry.SQL.ADD('from  kgvenda.cliente where co_cliente = ' + inttostr(CodigoCliente));
  end
  else
    Qry.SQL.ADD('from  kgvenda.cliente where no_cliente like ' + QuotedStr(trim(NomeCliente)+'%'));

  Try
    Qry.Open;
    Qry.FieldDefs.Update;
    while not Qry.Eof do
      begin
        LiIndice := Length(Result);
        SetLength(Result, LiIndice + 1);
        Result[LiIndice].co_cliente    := Qry.FieldByName('co_cliente').AsInteger;
        Result[LiIndice].no_cliente    := Qry.FieldByName('no_cliente').AsString;
        Result[LiIndice].no_cidade     := Qry.FieldByName('no_cidade').AsString;
        Result[LiIndice].no_uf         := Qry.FieldByName('no_uf').AsString;
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

function TClienteDAO.Update(Cliente: TCliente): Boolean;
var
  Qry     : TFDQuery;
begin

   Result := False;

   Qry := TFDQuery.Create(Nil);
   Qry.Connection := DM.dbsMain;
   Try
   Qry.SQL.Clear;
   Qry.SQL.ADD('UPDATE kgvenda.cliente');
   Qry.SQL.ADD('SET no_cliente = :vno_cliente,');
   Qry.SQL.ADD('    no_cidade  = :vno_cidade,');
   Qry.SQL.ADD('    no_uf`     = :vno_uf');
   Qry.SQL.ADD('WHERE co_cliente = :vco_cliente');


   Qry.Params[0].AsInteger := Cliente.co_cliente;
   Qry.Params[1].AsString  := Cliente.no_cliente;
   Qry.Params[2].AsString  := Cliente.no_cidade;
   Qry.Params[2].AsString  := Cliente.no_uf;

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

function TClienteDAO.Delete(Cliente: TCliente): Boolean;
var
  Qry     : TFDQuery;
  QryErro : TFDQuery;

begin
  try
   Qry := TFDQuery.Create(Nil);
   Qry.Connection := DM.dbsMain;

   Qry.SQL.Clear;
   Qry.SQL.ADD('DELETE FROM  kgvenda.cliente  WHERE co_cliente = :vco_cliente');
   Qry.Params[0].AsInteger  := Cliente.co_cliente;

   Qry.Prepared := True;
   Qry.ExecSQL;
   Result := True;
   FreeAndNil(Qry);

   except
     on e:exception do
     begin
       qryErro.SQL.Add(e.Message);
       ShowMessage('Erro na Exclusão do Cliente.'+#13+
                   'ERRO: '+e.Message+#13+#13+
                   'SCRIPT:[ '+e.Message+' ]' );
     end;
  end;


end;

end.
