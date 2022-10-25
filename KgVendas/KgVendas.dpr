program KgVendas;

uses
  Vcl.Forms,
  UFormPrincipal in 'UIWindow\Principal\UFormPrincipal.pas' {FormPrincipal},
  uDM in 'DAO\uDM.pas' {DM: TDataModule},
  uDAOProduto in 'DAO\Produto\uDAOProduto.pas',
  uProduto in 'Model\Produto\uProduto.pas',
  uFormPadraoCrud in 'UIWindow\Padrao\uFormPadraoCrud.pas' {FormPadraoCrud},
  uFormVenda in 'UIWindow\Venda\uFormVenda.pas' {FormVenda},
  UKgVendasLib in 'Util\UKgVendasLib.pas',
  UBLLProduto in 'BLL\Produto\UBLLProduto.pas',
  uCliente in 'Model\Cliente\uCliente.pas',
  uDAOCliente in 'DAO\Cliente\uDAOCliente.pas',
  UBLLCliente in 'BLL\Cliente\UBLLCliente.pas',
  UBLLDadosGerais in 'BLL\DadosGerais\UBLLDadosGerais.pas',
  uDAODadosGerais in 'DAO\DadosGerais\uDAODadosGerais.pas',
  uDadosGerais in 'Model\DadosGerais\uDadosGerais.pas',
  UBLLProdutodoPedido in 'BLL\ProdutodoPedido\UBLLProdutodoPedido.pas',
  uDAOProdutodoPedido in 'DAO\ProdutodoPedido\uDAOProdutodoPedido.pas',
  uProdutodoPedido in 'Model\ProdutodoPedido\uProdutodoPedido.pas',
  uFormCliente in 'UIWindow\Cliente\uFormCliente.pas' {FormCliente},
  uformProduto in 'UIWindow\Produto\uformProduto.pas' {formProduto};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormCliente, FormCliente);
  Application.CreateForm(TformProduto, formProduto);
  Application.Run;
end.
