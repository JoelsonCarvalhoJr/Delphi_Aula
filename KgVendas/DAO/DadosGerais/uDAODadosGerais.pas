unit uDAODadosGerais;

interface
Uses SysUtils, SQLExpr,  Dialogs,  UDadosGerais, UDM, Classes, DB,
     Vcl.Controls, Data.FMTBcd,FireDAC.Comp.Client,
     FireDAC.Stan.Param,
     {Adicionado}
     UKgvendasLib;

Type
  TFilter    = ( tfnu_pedido, tfNome );
  TDadosGeraisDadosIdNumeroNome = Record
    DadosGerais_nu_pedido     : Integer;
    DadosGerais_dt_emissao    : TDateTime;
    DadosGerais_co_cliente    : Integer;
    DadosGerais_no_cliente    : String;
    DadosGerais_nu_valortotal : Double;

  End;
  TArDadosGeraisDadosIdNumeroNome = Array of TDadosGeraisDadosIdNumeroNome;

  TDadosGeraisDados = Record
    nu_pedido     : Integer;
    dt_emissao    : TDateTime;
    co_cliente    : Integer;
    no_cliente    : String;
    nu_valortotal : Double;

   end;
   TArDadosGeraisDados = Array of TDadosGeraisDados;

   TDadosGeraisDAO = class
   _DadosGerais : TDadosGerais;

   Private
     { Private Declarations }
      FListaDadosGerais: TList;
   Public
    { Public declarations }
      Constructor Create ;
      Destructor Destroy; Override;
      Function GetListaDadosGerais(NumeroPedido: Integer; CodigoCliente: Integer): TArDadosGeraisDados;
      Function Add ( DadosGerais: TDadosGerais): Boolean;
      Function Delete ( DadosGerais: TDadosGerais): Boolean;
      Property ListaDadosGerais : TList  Read FListaDadosGerais;

   end;


implementation

{ TDadosGeraisDAO }
constructor TDadosGeraisDAO.Create;
begin
  _DadosGerais      := TDadosGerais.Create;
  FListaDadosGerais := TList.Create;
end;


function TDadosGeraisDAO.Delete(DadosGerais: TDadosGerais): Boolean;
var
  Qry     : TFDQuery;
  QryErro : TFDQuery;

begin
  try
   Qry := TFDQuery.Create(Nil);
   Qry.Connection := DM.dbsMain;

   Qry.SQL.Clear;
   Qry.SQL.ADD('DELETE FROM  kgvenda.dadosgerais  WHERE nu_pedido = :vnu_pedido ');
   Qry.Params[0].AsInteger  := DadosGerais.nu_pedido;

   Qry.Prepared := True;
   Qry.ExecSQL;
   Result := True;
   FreeAndNil(Qry);

   except
     on e:exception do
     begin
       qryErro.SQL.Add(e.Message);
       ShowMessage('Erro na Exclusão dos Dados Gerais.'+#13+
                   'ERRO: '+e.Message+#13+#13+
                   'SCRIPT:[ '+e.Message+' ]' );
     end;
  end;


end;

destructor TDadosGeraisDAO.Destroy;
begin
  FreeAndNil(_DadosGerais);
  FreeAndNil(FListaDadosGerais);
end;

function TDadosGeraisDAO.Add(DadosGerais: TDadosGerais): Boolean;
var
  Qry     : TFDQuery;
  QryErro : TFDQuery;
begin
  Try
   Result := False;

   Qry := TFDQuery.Create(Nil);
   Qry.Connection := DM.dbsMain;

   Qry.SQL.Clear;
   Qry.SQL.ADD('INSERT INTO kgvenda.dadosgerais( ');
   Qry.SQL.ADD('  dt_emissao,');
   Qry.SQL.ADD('  co_cliente,');
   Qry.SQL.ADD('  nu_valortotal');

   Qry.SQL.ADD(') VALUES (');
   Qry.SQL.ADD('  :vdt_emissao,');
   Qry.SQL.ADD('  :vco_cliente,');
   Qry.SQL.ADD('  :vnu_valortotal');
   Qry.SQL.ADD(')');
   Qry.Params[0].AsDate     := DadosGerais.dt_emissao;
   Qry.Params[1].AsInteger  := DadosGerais.co_cliente;
   Qry.Params[2].AsFloat    := DadosGerais.nu_valortotal;

   Qry.Prepared := True;
   Qry.ExecSQL;
   Result := True;
   FreeAndNil(Qry);

   except
     on e:exception do
     begin
       qryErro.SQL.Add(e.Message);
       ShowMessage('Erro na inclusão dos Dados Gerais.'+#13+
                   'ERRO: '+e.Message+#13+#13+
                   'SCRIPT:[ '+e.Message+' ]' );
     end;
  end;

end;

function TDadosGeraisDAO.GetListaDadosGerais(NumeroPedido: Integer; CodigoCliente: integer): TArDadosGeraisDados;
var
  Qry     : TFDQuery;
  LiIndice: Integer;
begin

  Qry := TFDQuery.Create(Nil);
  Qry.Connection := DM.dbsMain;

  Qry.SQL.Clear;
  Qry.SQL.ADD('SELECT d.nu_pedido, d.dt_emissao, d.co_cliente,');
  Qry.SQL.ADD('       c.no_cliente, d.nu_valortotal');
  Qry.SQL.ADD('from  kgvenda.dadosgerais d ');
  Qry.SQL.ADD('inner join kgvenda.cliente c on (c.co_cliente = d.co_cliente)');
  if NumeroPedido > 0 then
    Qry.SQL.ADD('where d.nu_pedido = '  + inttostr(NumeroPedido))
  else
  if CodigoCliente > 0 then
    Qry.SQL.ADD('where d.co_cliente = '  + inttostr(CodigoCliente));

  Qry.SQL.ADD('group by nu_pedido');

  Try
    Qry.Open;
    Qry.FieldDefs.Update;
    while not Qry.Eof do
      begin
        LiIndice := Length(Result);
        SetLength(Result, LiIndice + 1);
        Result[LiIndice].nu_pedido     := Qry.FieldByName('nu_pedido').AsInteger;
        Result[LiIndice].dt_emissao    := Qry.FieldByName('dt_emissao').Asdatetime;
        Result[LiIndice].co_cliente    := Qry.FieldByName('co_cliente').AsInteger;
        Result[LiIndice].no_cliente    := Qry.FieldByName('no_cliente').AsString;
        Result[LiIndice].nu_valortotal := Qry.FieldByName('nu_valortotal').AsFloat;
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
