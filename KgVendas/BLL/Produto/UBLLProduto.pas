unit UBLLProduto;

interface
Uses Vcl.Controls,SysUtils,Classes, UDAOProduto, UProduto,
     Messages, Forms, Winapi.Windows, FireDAC.Comp.Client, FireDAC.Dapt, UKgVendasLib;

Type
  TFiltroPesquisaProduto= (tfProduto, tfCodigo, tfNome);
  TNomeCampo = ( tncco_produto, tncno_produto);
  TProdutoBLL = class
   Private
     FProduto: TProduto;
     FProdutoDAO : TProdutoDAO;
   Public
    Function Add ( Produto : TProduto ): Boolean;
    Function Delete ( Produto : TProduto): Boolean;
    Function Update( Produto : TProduto): Boolean;
    Function GetListaProduto (CodigoProduto: Integer; NomeProduto: string): TArProdutoDados;
    Function ValidarCampo ( Produto : TProduto; TNomeCampo : TNomeCampo ): Boolean;
    function ValidarValoresPesquisaProduto( Filtros: TFiltroPesquisaProduto; ValorFiltro: string ):Boolean;

    procedure DefinirParametrosPesquisaProduto( Filtros: TFiltroPesquisaProduto;
                                                  ValorPesquisa:  string;
                                                  var ico_produto: Integer);
    Constructor Create;
    Destructor  Destroy; Override;
    Property Produto: TProduto Read FProduto Write FProduto;
  end;

implementation

{ TProdutoBLL }
constructor TProdutoBLL.Create;
begin
  FProduto    := TProduto.Create;
  FProdutoDAO := TProdutoDAO.Create;
end;

procedure TProdutoBLL.DefinirParametrosPesquisaProduto(
  Filtros: TFiltroPesquisaProduto; ValorPesquisa: string;
  var ico_produto: Integer);
begin
  case filtros of
   tfCodigo:begin
              if  ValidarValoresPesquisaProduto(tfCodigo,ValorPesquisa) then
              begin
                ico_produto:= StrToInt(ValorPesquisa);
              end;
            end;

  end;

end;



destructor TProdutoBLL.Destroy;
begin
  FreeAndNil(FProduto);
  FreeAndNil(FProdutoDAO);
end;

function TProdutoBLL.Add(Produto: TProduto): Boolean;
begin
  Result := True;

  if Length(Produto.no_produto) = 0 then
  begin
    Application.MessageBox('Informe o nome do Produto!','Atenção', MB_ICONEXCLAMATION);
    Result := False;
  end;

  if Result then
  begin
      Result :=  FProdutoDAO.Add(Produto);
  end;

end;


function TProdutoBLL.GetListaProduto(CodigoProduto: Integer; NomeProduto: String): TArProdutoDados;
begin
   Result := FProdutoDAO.getListaProduto(CodigoProduto, NomeProduto);
end;

function TProdutoBLL.Update(Produto: TProduto): Boolean;
begin
  Result := True;

  if Length(Produto.no_produto) = 0 then
  begin
    Application.MessageBox('Informe a descrição do produto!','Atenção', MB_ICONEXCLAMATION);
    Result := False;
  end;

  if Produto.nu_valorvenda = 0.0 then
  begin
    Application.MessageBox('Informe Valor da Venda!','Atenção', MB_ICONEXCLAMATION);
    Result := False;
  end;


  if Result then
  begin
      Result :=  FProdutoDAO.Update(Produto);
  end;
end;

function TProdutoBLL.ValidarCampo(Produto: TProduto;
  TNomeCampo: TNomeCampo): Boolean;
begin
  Result := False;
  case TNomeCampo of
   tncno_produto: begin
                 Result := iif (Length(Trim(produto.no_produto)) = 0, False, True);
                 if Not Result then
                    Application.MessageBox('Necessário informar nome do Produto!','Atenção', MB_ICONEXCLAMATION);

               end;
  end;
end;

function TProdutoBLL.ValidarValoresPesquisaProduto(
  Filtros: TFiltroPesquisaProduto; ValorFiltro: string): Boolean;
begin
  Result := True;

  case Filtros of
   tfCodigo:
     begin
       if Length(ValorFiltro) = 0 then
       begin
         Application.MessageBox('Informe o código do Produto!','Atenção', MB_ICONEXCLAMATION);
         Result := False;
         Abort
       end;

     end;
  end;
end;

function TProdutoBLL.Delete(Produto: TProduto): Boolean;
begin
  Result := True;

  if Length(IntToStr(Produto.co_produto)) = 0 then
  begin
    Application.MessageBox('Informe o Código do Produto para exclusão!','Atenção', MB_ICONEXCLAMATION);
    Result := False;
  end;

  if Result then
  begin
    if Application.MessageBox('Confirma Exclusão ?','Atenção', mb_YesNo) = mrYes then
       Result :=  FProdutoDAO.Delete(Produto);

  end;


end;

end.
