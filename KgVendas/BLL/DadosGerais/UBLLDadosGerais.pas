unit UBLLDadosGerais;

interface
Uses Vcl.Controls,SysUtils,Classes, UDAODadosGerais, UDadosGerais,
     Messages, Forms, Winapi.Windows, FireDAC.Comp.Client, FireDAC.Dapt, UKgVendasLib;

Type
  TFiltroPesquisaDadosGerais= (tfDadosGerais, tfCodigo, tfCodigoCliente);
  TNomeCampo = ( tnccodigo,tncco_cliente);
  TDadosGeraisBLL = class
   Private
     FDadosGerais: TDadosGerais;
     FDadosGeraisDAO : TDadosGeraisDAO;
   Public
    Function Add ( DadosGerais: TDadosGerais): Boolean;
    Function Delete ( DadosGerais: TDadosGerais): Boolean;

    Function GetListaDadosGerais(CodigoPedido: Integer; CodigoCliente: Integer): TArDadosGeraisDados;

    Function ValidarCampo ( DadosGerais : TDadosGerais; TNomeCampo : TNomeCampo ): Boolean;

    function ValidarValoresPesquisaDadosGerais( Filtros: TFiltroPesquisaDadosGerais; ValorFiltro: string ):Boolean;
    Constructor Create;
    Destructor  Destroy; Override;
    Property DadosGerais: TDadosGerais Read FDadosGerais Write FDadosGerais;
  end;

implementation

{ TDadosGeraisLL }
constructor TDadosGeraisBLL.Create;
begin
  FDadosGerais    := TDadosGerais.Create;
  FDadosGeraisDAO := TDadosGeraisDAO.Create;
end;

function TDadosGeraisBLL.Delete(DadosGerais: TDadosGerais): Boolean;
var
  FDadosGeraisDAO  : TDadosGeraisDAO;

begin

  FDadosGeraisDAO := TDadosGeraisDAO.Create;
  FDadosGeraisDAO.Delete(DadosGerais);

end;

destructor TDadosGeraisBLL.Destroy;
begin
  FreeAndNil(FDadosGerais);
  FreeAndNil(FDadosGeraisDAO);
end;


function TDadosGeraisBLL.Add(DadosGerais: TDadosGerais): Boolean;
var
  LBoolResult : Boolean;
begin
  Result := True;

  if Length(inttostr(DadosGerais.co_cliente))=0 then
  begin
    Application.MessageBox('Informe Cliente!','Atenção', MB_ICONEXCLAMATION);
    Result := False;
  end;

  if Result then
  begin
      Result :=  FDadosGeraisDAO.Add(DadosGerais);
  end;

end;

function TDadosGeraisBLL.GetListaDadosGerais(CodigoPedido: Integer; CodigoCliente: Integer): TArDadosGeraisDados;
begin
   Result := FDadosGeraisDAO.getListaDadosGerais(CodigoPedido, CodigoCliente);
end;

function TDadosGeraisBLL.ValidarCampo(DadosGerais: TDadosGerais;
  TNomeCampo: TNomeCampo): Boolean;
begin
  Result := False;
  case TNomeCampo of
   tnccodigo: begin
               Result := iif(Length(inttostr(DadosGerais.nu_pedido)) = 0, False, True);
                 if Not Result then
                    Application.MessageBox('Necessário informar Número do Pedido!','Atenção', MB_ICONEXCLAMATION);

               end;
  end;
end;

function TDadosGeraisBLL.ValidarValoresPesquisaDadosGerais(
        Filtros: TFiltroPesquisaDadosGerais; ValorFiltro: string ):Boolean;
begin
  Result := True;

  case Filtros of
   tfCodigo:
     begin
       if Length(ValorFiltro) = 0 then
       begin
         Application.MessageBox('Informe o código do Pedido!','Atenção', MB_ICONEXCLAMATION);
         Result := False;
         Abort
       end;

     end;
  end;
end;

end.
