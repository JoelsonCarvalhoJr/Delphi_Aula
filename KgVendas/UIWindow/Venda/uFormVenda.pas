unit uFormVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoCrud, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Mask, Vcl.Grids ;

type
  TFormVenda = class(TFormPadraoCrud)
    Panel1: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Label3: TLabel;
    ed_co_produto: TEdit;
    ed_no_produto: TEdit;
    ed_nu_valor_venda: TEdit;
    Label7: TLabel;
    ed_nu_quantidade: TEdit;
    Label6: TLabel;
    ed_nu_valorunitario: TEdit;
    Label5: TLabel;
    Panel5: TPanel;
    BtnConfirmar: TBitBtn;
    BtnGravarPedido: TBitBtn;
    Label2: TLabel;
    ed_co_cliente: TEdit;
    ed_no_cliente: TEdit;
    SgCliente: TStringGrid;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    SgPedidoVenda: TStringGrid;
    PnlValorTotal: TPanel;
    SgDadosGerais: TStringGrid;
    SgProdutodoPedido: TStringGrid;
    Panel11: TPanel;
    Panel12: TPanel;
    BtnCancelarPedido: TBitBtn;
    btncarregarPedido: TBitBtn;
    Label1: TLabel;
    ed_nu_pedido: TEdit;
    Timer1: TTimer;
    procedure ed_nu_quantidadeExit(Sender: TObject);
    procedure ed_nu_valorunitarioExit(Sender: TObject);
    procedure ed_co_produtoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ed_co_produtoExit(Sender: TObject);
    procedure ed_co_produtoKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure BtnConfirmarClick(Sender: TObject);
    procedure SgPedidoVendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnGravarPedidoClick(Sender: TObject);
    procedure ed_co_clienteExit(Sender: TObject);
    procedure ed_co_clienteKeyPress(Sender: TObject; var Key: Char);
    procedure ed_no_clienteExit(Sender: TObject);
    procedure SgClienteClick(Sender: TObject);
    procedure ed_co_clienteClick(Sender: TObject);
    procedure ed_no_clienteClick(Sender: TObject);
    procedure SgDadosGeraisClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure ed_nu_pedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ed_nu_pedidoKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure btncarregarPedidoClick(Sender: TObject);
    procedure BtnCancelarPedidoClick(Sender: TObject);

  private
    { Private declarations }
    Procedure Procurar_produto;
    Procedure Procurar_Cliente;
    Procedure Consultar_Venda;
    Procedure Filtrar_ItemVenda;
    procedure LimparCampo;
    Procedure RegistrarNoBanco;
    Procedure Registrar_prodpedido;
    Procedure Cancelar_DadosGerais;
    Procedure IniciarGrid;
    Procedure CarregarCliente;
    Function  CalcularTotalPedido(fvalor: Double) :Double;
  public
    { Public declarations }
  end;
   Const
   //Pedido de Venda
   cipco_produto         = 0;
   cipno_produto         = 1;
   cipnu_quantidade      = 2;
   cipnu_valorunitario   = 3;
   cipnu_total           = 4;

   //cliente
   cicco_cliente         = 0;
   cicno_cliente         = 1;
   cicno_cidade          = 2;
   cicno_uf              = 3;

   //dadosgerais
   cidnu_pedido          = 0;
   ciddt_emissao         = 1;
   cidco_cliente         = 2;
   cidno_cliente         = 3;
   cidnu_valortotal      = 4;

   //produtodopedido
   ciinu_produtodopedido = 0;
   ciinu_pedido          = 1;
   ciico_produto         = 2;
   ciino_produto         = 3;
   ciinu_quantidade      = 4;
   ciinu_valorunitario   = 5;
   ciinu_valortotal      = 6;

var
  FormVenda     : TFormVenda;
  totalpedido   : Double;
  numeropedido  : Integer;
  CodigoCliente : Integer;
  nuumeroprodped: Integer;
  CodigoProduto : Integer;

implementation
Uses UDAOProduto, UBLLProduto, UKgVendasLib, uDM,  UBLLCliente, UDAOCliente,
     uDAODadosGerais, UBLLDadosGerais,
     uDAOProdutodoPedido,UBLLProdutodoPedido;

{$R *.dfm}

procedure TFormVenda.BtnCancelarClick(Sender: TObject);
var
  BLLProdutodoPedido     : TProdutodoPedidoBLL;
  inu_pedido             : integer;

begin
  inherited;


end;

procedure TFormVenda.BtnCancelarPedidoClick(Sender: TObject);
var
  BLLProdutodoPedido     : TProdutodoPedidoBLL;

begin
  inherited;
  if Length(ed_nu_pedido.Text) = 0 then
   begin
     Application.MessageBox('informe n�mero do pedido para exclus�o!','Aten��o', MB_ICONEXCLAMATION);
     ed_nu_pedido.SetFocus;
     Abort;
   end;

   try
    BLLProdutodoPedido := TProdutodoPedidoBLL.Create;
    BLLProdutodoPedido.ProdutodoPedido.nu_pedido   := StrToInt(ed_nu_pedido.Text);

    BLLProdutodoPedido.Delete(BLLProdutodoPedido.ProdutodoPedido);

   finally
    FreeAndNil(BLLProdutodoPedido);
   end;

   Cancelar_DadosGerais;

   numeropedido   := 0;
   nuumeroprodped := 0;
   Consultar_Venda;
   Filtrar_ItemVenda;

end;

procedure TFormVenda.btncarregarPedidoClick(Sender: TObject);
begin
  inherited;
  if Length(ed_nu_pedido.Text) = 0 then
   begin
     Application.MessageBox('informe n�mero do pedido para Pesquisa!','Aten��o', MB_ICONEXCLAMATION);
     ed_nu_pedido.SetFocus;
     Abort;
   end;
  numeropedido   := StrToInt(ed_nu_pedido.Text);
  nuumeroprodped := 0;
  Consultar_Venda;
  Filtrar_ItemVenda;
  ed_nu_pedido.Text := '';
  ed_nu_pedido.SetFocus;
end;

procedure TFormVenda.BtnConfirmarClick(Sender: TObject);
var
  i : integer;
  total: Double;
begin
  if Length(ed_co_produto.Text) = 0  then
  begin
    Application.MessageBox('Informe Produto!','Aten��o', MB_ICONEXCLAMATION);
    ed_co_produto.SetFocus;
    Abort;
  end;

  if Length(ed_nu_quantidade.Text) = 0  then
  begin
    Application.MessageBox('Informe Quantidade!','Aten��o', MB_ICONEXCLAMATION);
    ed_nu_quantidade.SetFocus;
    Abort;
  end;

  if Length(ed_nu_valorunitario.Text) = 0  then
  begin
    Application.MessageBox('Informe Valor Unit�rio!!','Aten��o', MB_ICONEXCLAMATION);
    ed_nu_valorunitario.SetFocus;
    Abort;
  end;

  BtnGravarPedido.Enabled := True;
  ed_co_cliente.Enabled := True;
  ed_no_cliente.Enabled := True;

  total := StrToFloat(ed_nu_quantidade.Text)* StrToFloat(ed_nu_valorunitario.Text);
  if BtnConfirmar.Caption = 'Alterar' then
  begin
    SgPedidoVenda.Cells[cipco_produto,SgPedidoVenda.Row]       := ed_co_produto.Text;
    SgPedidoVenda.Cells[cipno_produto,SgPedidoVenda.Row]       := ed_no_produto.Text;
    SgPedidoVenda.Cells[cipnu_quantidade,SgPedidoVenda.Row]    := ed_nu_quantidade.Text;
    SgPedidoVenda.Cells[cipnu_valorunitario,SgPedidoVenda.Row] := ed_nu_valorunitario.Text;
    SgPedidoVenda.Cells[cipnu_total,SgPedidoVenda.Row]         := Formatfloat('#####0.00',total);
  end
  else
  if SgPedidoVenda.RowCount = 2 then
  begin
    SgPedidoVenda.Cells[cipco_produto,SgPedidoVenda.RowCount-1]       := ed_co_produto.Text;
    SgPedidoVenda.Cells[cipno_produto,SgPedidoVenda.RowCount-1]       := ed_no_produto.Text;
    SgPedidoVenda.Cells[cipnu_quantidade,SgPedidoVenda.RowCount-1]    := ed_nu_quantidade.Text;
    SgPedidoVenda.Cells[cipnu_valorunitario,SgPedidoVenda.RowCount-1] := ed_nu_valorunitario.Text;
    SgPedidoVenda.Cells[cipnu_total,SgPedidoVenda.RowCount-1]         := Formatfloat('#####0.00',total);
    SgPedidoVenda.RowCount := SgPedidoVenda.RowCount +1;
  end
  else
  if SgPedidoVenda.RowCount > 2 then
  begin
    SgPedidoVenda.Cells[cipco_produto,SgPedidoVenda.RowCount-1]       := ed_co_produto.Text;
    SgPedidoVenda.Cells[cipno_produto,SgPedidoVenda.RowCount-1]       := ed_no_produto.Text;
    SgPedidoVenda.Cells[cipnu_quantidade,SgPedidoVenda.RowCount-1]    := ed_nu_quantidade.Text;
    SgPedidoVenda.Cells[cipnu_valorunitario,SgPedidoVenda.RowCount-1] := ed_nu_valorunitario.Text;
    SgPedidoVenda.Cells[cipnu_total,SgPedidoVenda.RowCount-1]         := Formatfloat('#####0.00',total);
    SgPedidoVenda.RowCount := SgPedidoVenda.RowCount +1;
  end;

  if BtnConfirmar.Caption = 'Alterar' then
     BtnConfirmar.Caption := 'Confirmar';

  LimparCampo;
  CalcularTotalPedido(total);
  ed_co_produto.SetFocus;

end;

procedure TFormVenda.BtnGravarPedidoClick(Sender: TObject);
begin
  inherited;
  if Length(ed_co_cliente.Text) = 0 then
  begin
    Application.MessageBox('Neces�rio Informar Cliente!','Aten��o', MB_ICONEXCLAMATION);
    ed_co_cliente.SetFocus;
    Abort;
  end
  else
  begin
    RegistrarNoBanco;
    LimparCampo;
    totalpedido           :=0;
    PnlValorTotal.Caption := '0,00';
    ed_co_produto.SetFocus;
  end;
end;

function TFormVenda.CalcularTotalPedido(fvalor: Double): Double;
begin
   totalpedido           :=    totalpedido+fvalor;
   PnlValorTotal.Caption := 'Valot total do pedido: '+ Formatfloat('#####0.00',   totalpedido);

   if totalpedido = 0 then
     BtnGravarPedido.Enabled := False;

end;

procedure TFormVenda.Cancelar_DadosGerais;
var
  BLLDadosGerais : TDadosGeraisBLL;
begin
  inherited;

   try
    BLLDadosGerais := TDadosGeraisBLL.Create;
    BLLDadosGerais.DadosGerais.nu_pedido   := StrToInt(ed_nu_pedido.Text);
    BLLDadosGerais.Delete(BLLDadosGerais.DadosGerais);

   finally
    FreeAndNil(BLLDadosGerais);
   end;
   numeropedido   := 0;
   CodigoCliente  := 0;
   nuumeroprodped := 0;

   Consultar_Venda;
   Filtrar_ItemVenda;
   ed_nu_pedido.Text := '';
   ed_nu_pedido.SetFocus;

end;

procedure TFormVenda.CarregarCliente;
begin
  ed_co_cliente.Text := SgCliente.Cells[cicco_cliente,SgCliente.Row];
  ed_no_cliente.Text := SgCliente.Cells[cicno_cliente,SgCliente.Row];
end;

procedure TFormVenda.Consultar_Venda;
var
  i : Integer;
  ln:integer;
  ListaDadosGerais: TArDadosGeraisDados;
  BLLDadosGerais: TDadosGeraisBLL;

begin
  inherited;
  try
    BLLDadosGerais := TDadosGeraisBLL.Create;
    ListaDadosGerais:= BLLDadosGerais.GetListaDadosGerais(numeropedido, CodigoCliente);
    ApagarGrid(SgDadosGerais);
    if ListaDadosGerais<> Nil then
    begin
       ln:=1;
       for  i:= Low(ListaDadosGerais) to High(ListaDadosGerais) do
       begin
        if numeropedido = 0  then
        NumeroPedido :=ListaDadosGerais[i].nu_pedido;

        SgDadosGerais.cells[cidnu_pedido,ln]     := IntToStr(ListaDadosGerais[i].nu_pedido);
        SgDadosGerais.cells[ciddt_emissao,ln]    := DateToStr(ListaDadosGerais[i].dt_emissao);
        SgDadosGerais.cells[cidco_cliente,ln]    := IntToStr(ListaDadosGerais[i].co_cliente);
        SgDadosGerais.cells[cidno_cliente,ln]    := ListaDadosGerais[i].no_cliente;
	    	SgDadosGerais.cells[cidnu_valortotal,ln] := FloatToStr(ListaDadosGerais[i].nu_valortotal);
        inc(ln);
       end;

    if ln > SgDadosGerais.FixedRows then
      SgDadosGerais.RowCount := ln;

    end
    else
      if numeropedido <> 0 then
        Application.MessageBox('�N�mero do Pedido n�o localizado!','Aten��o', MB_ICONEXCLAMATION);

  finally
    FreeAndNil(BLLDadosGerais);
  end;

end;

procedure TFormVenda.ed_co_clienteClick(Sender: TObject);
begin
  inherited;
  ed_no_cliente.Text := '';
end;

procedure TFormVenda.ed_co_clienteExit(Sender: TObject);
begin
  inherited;
  if Length(ed_co_cliente.Text) > 0 then
    Procurar_Cliente;

end;

procedure TFormVenda.ed_co_clienteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (key in ['0'..'9', #8, #27, #32]) then
    begin
    beep;
    key := #0;
  end;
end;

procedure TFormVenda.ed_nu_pedidoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If key = VK_RETURN then
     if Length(ed_nu_pedido.Text) = 0 then
      raise Exception.Create('Informe n�mero do Pedido!')

end;

procedure TFormVenda.ed_nu_pedidoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (key in ['0'..'9', #8, #27, #32]) then
    begin
    beep;
    key := #0;
  end;

end;

procedure TFormVenda.ed_co_produtoExit(Sender: TObject);
begin
  inherited;
  if Length(ed_co_produto.Text) > 0 then
    Procurar_produto;

end;

procedure TFormVenda.ed_co_produtoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If key = VK_RETURN then
    if Length(ed_co_produto.Text) = 0 then
    raise Exception.Create('Informe C�digo do Produto!')

end;

procedure TFormVenda.ed_co_produtoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (key in ['0'..'9', #8, #27, #32]) then
    begin
    beep;
    key := #0;
  end;
end;

procedure TFormVenda.ed_no_clienteClick(Sender: TObject);
begin
  inherited;
  ed_co_cliente.Text := '';
end;

procedure TFormVenda.ed_no_clienteExit(Sender: TObject);
begin
  inherited;
  if Length(ed_no_cliente.Text) > 0 then
  begin
   ed_co_cliente.Text :='0';
   Procurar_Cliente;
  end;

end;


procedure TFormVenda.ed_nu_quantidadeExit(Sender: TObject);
begin
  inherited;
  if Length(ed_nu_quantidade.Text)>0 then
     ed_nu_quantidade.Text:= FormatFloat('0.00', (StrToFloat(ed_nu_quantidade.Text)))

end;

procedure TFormVenda.ed_nu_valorunitarioExit(Sender: TObject);
begin
  inherited;
  if Length(ed_nu_valorunitario.Text) > 0 then
   ed_nu_valorunitario.Text:= FormatFloat('0.00', (StrToFloat(ed_nu_valorunitario.Text)));

end;

procedure TFormVenda.Filtrar_ItemVenda;
var
  i: Integer;
  ln:integer;
  ListaProdutoPedido: TArProdutodoPedidoDados;
  BLLProdutodoPedido: TProdutodoPedidoBLL;

begin
  inherited;
  try
    BLLProdutodoPedido := TProdutodoPedidoBLL.Create;
    ListaProdutoPedido:= BLLProdutodoPedido.GetListaProdutodoPedido(nuumeroprodped, numeropedido,CodigoProduto);
    ApagarGrid(SgProdutodoPedido);
    if ListaProdutoPedido<> Nil then
    begin
       ln:=1;
       for  i:= Low(ListaProdutoPedido) to High(ListaProdutoPedido) do
       begin
        SgProdutodoPedido.cells[ciinu_produtodopedido,ln] := IntToStr(ListaProdutoPedido[i].nu_produtodopedido);
        SgProdutodoPedido.cells[ciinu_pedido,ln]          := IntToStr(ListaProdutoPedido[i].nu_pedido);
        SgProdutodoPedido.cells[ciico_produto,ln]         := IntToStr(ListaProdutoPedido[i].co_produto);
        SgProdutodoPedido.cells[ciino_produto,ln]         := ListaProdutoPedido[i].no_produto;
        SgProdutodoPedido.cells[ciinu_quantidade,ln]      := FloatToStr(ListaProdutoPedido[i].nu_quantidade);
	    	SgProdutodoPedido.cells[ciinu_valorunitario,ln]   := FloatToStr(ListaProdutoPedido[i].nu_valorunitario);
	    	SgProdutodoPedido.cells[ciinu_valortotal,ln]      := FloatToStr(ListaProdutoPedido[i].nu_valortotal);
        inc(ln);

       end;

    if ln > SgProdutodoPedido.FixedRows then
      SgProdutodoPedido.RowCount := ln;

    end;

  finally
    FreeAndNil(BLLProdutodoPedido);
  end;

end;

procedure TFormVenda.FormActivate(Sender: TObject);
begin
  inherited;
  IniciarGrid;
  numeropedido   := 0;
  nuumeroprodped := 0;
  Consultar_Venda;
  Filtrar_ItemVenda;
  ed_co_produto.SetFocus;

end;

procedure TFormVenda.IniciarGrid;
begin
  // Pedido de Venda
  SgPedidoVenda.ColCount                   := 5;
  SgPedidoVenda.RowCount                   := 2;
  SgPedidoVenda.DefaultColWidth            := 6;
  SgPedidoVenda.DefaultRowHeight           := 15;
  SgPedidoVenda.Cells[cipco_produto, SgPedidoVenda.FixedRows - 1] := 'Pedido de Vendas';

  SgPedidoVenda.cells[cipco_produto,0]      :='C�digo';
  SgPedidoVenda.ColWidths[cipco_produto]    := 60;

  SgPedidoVenda.cells[cipno_produto,0]      :='Produto';
  SgPedidoVenda.ColWidths[cipno_produto]    := 390;

  SgPedidoVenda.cells[cipnu_quantidade,0]   :='Quantidade';
  SgPedidoVenda.ColWidths[cipnu_quantidade] := 100;

  SgPedidoVenda.cells[cipnu_valorunitario,0]   :='Valor Unit�rio';
  SgPedidoVenda.ColWidths[cipnu_valorunitario] := 100;

  SgPedidoVenda.cells[cipnu_total,0]           :='Valor Total';
  SgPedidoVenda.ColWidths[cipnu_total]         := 100;

  totalpedido := 0;

   //cliente
  SgCliente.ColCount             := 4;
  SgCliente.RowCount             := 2;
  SgCliente.DefaultColWidth      := 5;
  SgCliente.DefaultRowHeight     := 15;
  SgCliente.Cells[cicco_cliente, SgCliente.FixedRows - 1] := 'Clientes';

  SgCliente.cells[cicco_cliente,0]        :='C�digo';
  SgCliente.ColWidths[cicco_cliente]      := 60;

  SgCliente.cells[cicno_cliente,0]        :='Nome';
  SgCliente.ColWidths[cicno_cliente]      := 300;

  SgCliente.cells[cicno_cidade,0]         :='Cidade';
  SgCliente.ColWidths[cicno_cidade]       := 200;

  SgCliente.cells[cicno_uf,0]             :='UF';
  SgCliente.ColWidths[cicno_uf]           := 60;

   //dadosgerais
  SgDadosGerais.ColCount            := 5;
  SgDadosGerais.RowCount            := 2;
  SgDadosGerais.DefaultColWidth     := 6;
  SgDadosGerais.DefaultRowHeight    := 15;
  SgDadosGerais.Cells[cidnu_pedido, SgDadosGerais.FixedRows - 1] := 'Vendas';

  SgDadosGerais.cells[cidnu_pedido,0]           :='Pedido';
  SgDadosGerais.ColWidths[cidnu_pedido]         := 60;

  SgDadosGerais.cells[ciddt_emissao,0]           :='Dt Emiss�o';
  SgDadosGerais.ColWidths[ciddt_emissao]         := 120;

  SgDadosGerais.cells[cidco_cliente,0]           :='C�digo';
  SgDadosGerais.ColWidths[cidco_cliente]         := 60;

  SgDadosGerais.cells[cidno_cliente,0]           :='Cliente';
  SgDadosGerais.ColWidths[cidno_cliente]         := 300;

  SgDadosGerais.cells[cidnu_valortotal,0]        :='Valor Total';
  SgDadosGerais.ColWidths[cidnu_valortotal]      := 200;


   //produtodopedido
  SgProdutodoPedido.ColCount                   := 7;
  SgProdutodoPedido.RowCount                   := 2;
  SgProdutodoPedido.DefaultColWidth            := 8;
  SgProdutodoPedido.DefaultRowHeight           := 15;
  SgProdutodoPedido.Cells[ciinu_produtodopedido, SgProdutodoPedido.FixedRows - 1] := 'Produtos';

  SgProdutodoPedido.cells[ciinu_produtodopedido,0]           :='Codigo';
  SgProdutodoPedido.ColWidths[ciinu_produtodopedido]         := 60;

  SgProdutodoPedido.cells[ciinu_pedido,0]           :='Pedido';
  SgProdutodoPedido.ColWidths[ciinu_pedido]         := 60;

  SgProdutodoPedido.cells[ciico_produto,0]           :='C�digo';
  SgProdutodoPedido.ColWidths[ciico_produto]         := -1;

  SgProdutodoPedido.cells[ciino_produto,0]           :='Produto';
  SgProdutodoPedido.ColWidths[ciino_produto]         := 200;

  SgProdutodoPedido.cells[ciinu_quantidade,0]        :='Quantidade';
  SgProdutodoPedido.ColWidths[ciinu_quantidade]      := 120;

  SgProdutodoPedido.cells[ciinu_valorunitario,0]     :='Valor Unit�rio';
  SgProdutodoPedido.ColWidths[ciinu_valorunitario]   := 100;

  SgProdutodoPedido.cells[ciinu_valortotal,0]        :='Valor Total';
  SgProdutodoPedido.ColWidths[ciinu_valortotal]      := 100;

end;

procedure TFormVenda.LimparCampo;
begin
  ed_co_produto.Text       := '';
  ed_nu_valor_venda.Text   := '';
  ed_nu_quantidade.Text    := '';
  ed_nu_valorunitario.Text := '';
  ed_no_produto.Text       := '';
  ed_co_cliente.Text       := '';
  ed_no_cliente.Text       := '';
end;

procedure TFormVenda.Procurar_Cliente;
var
  i: Integer;
  ln:integer;
  ListaCliente: TArClienteDados;
  BLLCliente: TClienteBLL;

begin
  inherited;
  try
    BLLCliente := TClienteBLL.Create;
    ListaCliente:= BLLCliente.GetListaCliente(StrToInt(ed_co_cliente.Text), Trim(ed_no_cliente.Text));

    ed_co_cliente.Text := '';
    ed_co_cliente.Text := '';
    ApagarGrid(SgCliente);

    if ListaCliente<> Nil then
    begin
      ln:=1;
      for  i:= Low(ListaCliente) to High(ListaCliente) do
      begin
       ed_co_cliente.Text:= IntToStr(ListaCliente[i].co_cliente);
       ed_no_cliente.Text:= ListaCliente[i].no_cliente;
       SgCliente.cells[cicco_cliente,ln] := IntToStr(ListaCliente[i].co_cliente);
       SgCliente.cells[cicno_cliente,ln] := Trim(ListaCliente[i].no_cliente);
       SgCliente.cells[cicno_cidade,ln]  := Trim(ListaCliente[i].no_cidade);
	   	SgCliente.cells[cicno_uf,ln]       := Trim(ListaCliente[i].no_uf);
       inc(ln);
      end;

      if ln > SgCliente.FixedRows then
        SgCliente.RowCount := ln;

    end
    else
      Application.MessageBox('Cliente n�o localizado!','Aten��o', MB_ICONEXCLAMATION);

  finally
    FreeAndNil(BLLCliente);
  end;

end;

procedure TFormVenda.Procurar_produto;
var
  i: Integer;
  ln: Integer;
  ListaProduto : TArProdutoDados;
  BLLProduto: TProdutoBLL;
begin
  inherited;
  try
    BLLProduto := TProdutoBLL.Create;
    ed_no_produto.Text := '';
    ListaProduto := BLLProduto.GetListaProduto(StrToInt(ed_co_produto.Text), trim(ed_no_produto.Text));

    if ListaProduto <> Nil then
    begin
       ed_co_produto.Text     := IntToStr(ListaProduto[0].co_produto);
       ed_nu_valor_venda.Text := Formatfloat('#####0.00',ListaProduto[0].nu_valorvenda);
       ed_no_produto.Text     := ListaProduto[0].no_produto;
    end
    else
    begin
      Application.MessageBox('Produto n�o localizado!','Aten��o', MB_ICONEXCLAMATION);
      LimparCampo;
      ed_co_produto.SetFocus;
    end;

  finally
    FreeAndNil(BLLProduto);
  end;

end;

procedure TFormVenda.RegistrarNoBanco;
var
  BLLDadosGerais    : TDadosgeraisBLL;
  inu_pedido        : integer;
begin
  inherited;

  try
    BLLDadosGerais := TDadosgeraisBLL.Create;
    BLLDadosGerais.DadosGerais.dt_emissao    := DM.GetDataServidor();
    BLLDadosGerais.DadosGerais.co_cliente    := StrToInt(ed_co_cliente.Text);
    BLLDadosGerais.DadosGerais.nu_valortotal := totalpedido;

   if BLLDadosGerais.Add(BLLDadosGerais.DadosGerais) then
     Registrar_prodpedido;

  finally
    FreeAndNil(BLLDadosGerais);
  end;

  LimparCampo;
  ApagarGrid(SgPedidoVenda);
  ApagarGrid(SgCliente);

  numeropedido   := 0;
  nuumeroprodped := 0;
  Consultar_Venda;
  Filtrar_ItemVenda;

end;

procedure TFormVenda.Registrar_prodpedido;
var
  BLLProdutodoPedido                            : TProdutodoPedidoBLL;
  inu_pedido, i                                 : integer;
  fnu_quantidade, fnu_valorunitario, fnu_total: Double;
begin
  inherited;
  try
    // captura ultimo numero do pedido cadastrado
    inu_pedido:= DM.GetUltimoId('nu_pedido','dadosgerais');

    for i:= 1 to SgPedidoVenda.RowCount do
    begin
      if Length(SgPedidoVenda.Cells[cipco_produto,i]) > 0 then
      begin
        fnu_quantidade     := StrToFloat(SgPedidoVenda.Cells[cipnu_quantidade,i]);
        fnu_valorunitario  := StrToFloat(SgPedidoVenda.Cells[cipnu_valorunitario,i]);
        fnu_total          := StrToFloat(SgPedidoVenda.Cells[cipnu_total,i]);

        BLLProdutodoPedido := TProdutodoPedidoBLL.Create;
        BLLProdutodoPedido.ProdutodoPedido.nu_pedido        := inu_pedido;
        BLLProdutodoPedido.ProdutodoPedido.co_produto       := StrToInt(SgPedidoVenda.Cells[cipco_produto,i]);
        BLLProdutodoPedido.ProdutodoPedido.nu_quantidade    := StrToFloat(SgPedidoVenda.Cells[cipnu_quantidade,i]);
        BLLProdutodoPedido.ProdutodoPedido.nu_valorunitario := StrToFloat(SgPedidoVenda.Cells[cipnu_valorunitario,i]);
        BLLProdutodoPedido.ProdutodoPedido.nu_valortotal    := StrToFloat(SgPedidoVenda.Cells[cipnu_total,i]);

        BLLProdutodoPedido.Add(BLLProdutodoPedido.ProdutodoPedido);

      end;

    end;

  finally
    FreeAndNil(BLLProdutodoPedido);
  end;

end;

procedure TFormVenda.SgClienteClick(Sender: TObject);
begin
  inherited;
  CarregarCliente
end;

procedure TFormVenda.SgDadosGeraisClick(Sender: TObject);
begin
  inherited;
  numeropedido   := StrToInt(SgDadosGerais.Cells[cidnu_pedido,SgDadosGerais.Row]);
  nuumeroprodped := 0;
  Filtrar_ItemVenda;
end;

procedure TFormVenda.SgPedidoVendaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var i: integer;
      valor: String;
      totalvenda: Double;
begin
  inherited;
  If key = VK_RETURN then
  begin
    ed_co_produto.Text       := SgPedidoVenda.Cells[cipco_produto,SgPedidoVenda.Row];
    ed_no_produto.Text       := SgPedidoVenda.Cells[cipno_produto,SgPedidoVenda.Row];
    ed_nu_quantidade.Text    := SgPedidoVenda.Cells[cipnu_quantidade,SgPedidoVenda.Row];
    ed_nu_valorunitario.Text := SgPedidoVenda.Cells[cipnu_valorunitario,SgPedidoVenda.Row];
    BtnConfirmar.Caption     := 'Alterar';
  end
  else
  If key = VK_DELETE then
  begin
    if Length(SgPedidoVenda.Cells[cipnu_total,SgPedidoVenda.Row]) = 0 then
    begin
      for i:= SgPedidoVenda.row to SgPedidoVenda.RowCount do
        SgPedidoVenda.Rows[i]:= SgPedidoVenda.Rows[i+1];
      if SgPedidoVenda.RowCount >2 then
        SgPedidoVenda.RowCount:=SgPedidoVenda.RowCount-1;
    end
    else
    begin
      if MessageDlg('Confirma Exclus�o? '+#13+
                    'Produto: < '+SgPedidoVenda.cells[cipco_produto,SgPedidoVenda.row] +
                    ' - '+
                   SgPedidoVenda.cells[cipno_produto,SgPedidoVenda.row]+' >',mtWarning, [mbYes, mbNo], 0) = mrYes then
      begin
      if Length(SgPedidoVenda.Cells[cipnu_total,SgPedidoVenda.Row]) > 0 then
      begin
        totalvenda := (StrToFloat(SgPedidoVenda.Cells[cipnu_total,SgPedidoVenda.Row])*-1);
        CalcularTotalPedido(totalvenda);
      end;

      for i:= SgPedidoVenda.row to SgPedidoVenda.RowCount do
        SgPedidoVenda.Rows[i]:= SgPedidoVenda.Rows[i+1];
      if SgPedidoVenda.RowCount >2 then
        SgPedidoVenda.RowCount:=SgPedidoVenda.RowCount-1;
      end;
    end;

    ed_co_produto.SetFocus;

  end;

end;

procedure TFormVenda.Timer1Timer(Sender: TObject);
begin
  inherited;
  if Length(ed_co_cliente.Text) = 0 then
  begin
    BtnCancelarPedido.Visible := True;
    btncarregarPedido.Visible := True;
  end
  else
  begin
    BtnCancelarPedido.Visible := False;
    btncarregarPedido.Visible := False;
  end;

end;

end.

