unit UBLLProdutodoPedido;

interface
Uses Vcl.Controls,SysUtils,Classes, UDAOProdutodoPedido, UProdutodoPedido,
     Messages, Forms, Winapi.Windows, FireDAC.Comp.Client, FireDAC.Dapt, UKgVendasLib;

Type
  TFiltroPesquisaProdutodoPedido= (tfProdutodoPedido, tfCodigoProdutoPedido, tfCodigoPedido);
  TNomeCampo = ( tncco_produtodopedido, tncco_pedido);

  TProdutodoPedidoBLL = class
   Private
     FProdutodoPedido    : TProdutodoPedido;
     FProdutodoPedidoDAO : TProdutodoPedidoDAO;
   Public
    Function Add ( ProdutodoPedido: TProdutodoPedido): Boolean;
    Function Delete ( ProdutodoPedido : TProdutodoPedido ): Boolean;

    Function GetListaProdutodoPedido (CodigoProdutoPedido: Integer; CodigoPedido: integer; CodigoProduto: Integer): TArProdutodoPedidoDados;

    Function ValidarCampo ( ProdutodoPedido: TProdutodoPedido; TNomeCampo : TNomeCampo ): Boolean;

    function ValidarValoresPesquisaProdutodoPedido( Filtros: TFiltroPesquisaProdutodoPedido; ValorFiltro: string ):Boolean;

    procedure DefinirParametrosPesquisaCliente( Filtros: TFiltroPesquisaProdutodoPedido;
                                                  ValorPesquisa:  string;
                                                  var iCodigoProdutoPedido: Integer;
                                                  var iCodigoPedido: Integer);
    Constructor Create;
    Destructor  Destroy; Override;
    Property ProdutodoPedido: TProdutodoPedido Read FProdutodoPedido Write FProdutodoPedido;
  end;

implementation

{ TProdutodoPedidoBLL }
constructor TProdutodoPedidoBLL.Create;
begin
  FProdutodoPedido    := TProdutodoPedido.Create;
  FProdutodoPedidoDAO := TProdutodoPedidoDAO.Create;
end;

destructor TProdutodoPedidoBLL.Destroy;
begin
  FreeAndNil(FProdutodoPedido);
  FreeAndNil(FProdutodoPedidoDAO);
end;

function TProdutodoPedidoBLL.Add(ProdutodoPedido: TProdutodoPedido): Boolean;
begin
  Result := True;

  if ProdutodoPedido.nu_pedido = 0 then
  begin
    Application.MessageBox('Informe o número do Pedido!','Atenção', MB_ICONEXCLAMATION);
    Result := False;
  end;

  if Result then
  begin
      Result :=  FProdutodoPedidoDAO.Add(ProdutodoPedido);
  end;

end;

function TProdutodoPedidoBLL.GetListaProdutodoPedido(CodigoProdutoPedido: Integer; CodigoPedido: integer; CodigoProduto: Integer): TArProdutodoPedidoDados;
begin
  Result := FProdutodoPedidoDAO.getListaProdutodoPedido(CodigoProdutoPedido, CodigoPedido, CodigoProduto);
end;

function TProdutodoPedidoBLL.ValidarCampo(ProdutodoPedido: TProdutodoPedido; TNomeCampo: TNomeCampo): Boolean;
begin
  Result := False;
  case TNomeCampo of
   tncco_produtodopedido: begin
                 Result := iif(ProdutodoPedido.nu_pedido = 0, False, True);
                 if Not Result then
                    Application.MessageBox('Necessário informar número do Pedido!','Atenção', MB_ICONEXCLAMATION);

               end;

  end;
end;

function TProdutodoPedidoBLL.ValidarValoresPesquisaProdutodoPedido(
       Filtros: TFiltroPesquisaProdutodoPedido; ValorFiltro: string): Boolean;
begin
  Result := True;

  case Filtros of
   tfCodigoPedido:
     begin
       if Length(ValorFiltro) = 0 then
       begin
         Application.MessageBox('Informe Código do Pedido Cliente!','Atenção', MB_ICONEXCLAMATION);
         Result := False;
         Abort
       end;

     end;
  end;
end;

procedure TProdutodoPedidoBLL.DefinirParametrosPesquisaCliente(Filtros: TFiltroPesquisaProdutodoPedido; ValorPesquisa: string;
          var iCodigoProdutoPedido: Integer;
          var iCodigoPedido: Integer);
begin
  case filtros of
   tfCodigoPedido:
            begin
              if  ValidarValoresPesquisaProdutodoPedido(tfCodigoPedido,ValorPesquisa) then
              begin
                iCodigoPedido:= StrToInt(ValorPesquisa);
              end;
            end;

  end;

end;

function TProdutodoPedidoBLL.Delete(ProdutodoPedido: TProdutodoPedido): Boolean;
var
  FProdutodoPedidoDAO  : TProdutodoPedidoDAO;

begin
  FProdutodoPedidoDAO := TProdutodoPedidoDAO.Create;

  if Application.MessageBox('Confirma Exclusão ?','Atenção', mb_YesNo) = mrYes then
      FProdutodoPedidoDAO.Delete(ProdutodoPedido);


end;

end.
