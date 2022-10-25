unit uformProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoCrud, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids;

type
  TformProduto = class(TFormPadraoCrud)
    Pnlcadastro: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    ed_co_produto: TEdit;
    ed_no_produto: TEdit;
    ed_nu_valorvenda: TEdit;
    Panel4: TPanel;
    Panel5: TPanel;
    lb_filtro: TLabel;
    ed_procurar1: TEdit;
    BtnProcurar: TBitBtn;
    RgFiltro: TRadioGroup;
    ed_procurar2: TEdit;
    BtnLimparFiltro: TBitBtn;
    SgProduto: TStringGrid;
    procedure RgFiltroClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnProcurarClick(Sender: TObject);
    procedure BtnLimparFiltroClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure SgProdutoClick(Sender: TObject);
    procedure ed_procurar2KeyPress(Sender: TObject; var Key: Char);
    procedure ed_procurar2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ed_procurar1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ed_nu_valorvendaExit(Sender: TObject);
  private
    { Private declarations }
    procedure AtivarInclusao;
    procedure DesativarInclusao;
    procedure AtivarAlteracao;
    procedure LimparCampo;
    procedure CarregarCampo;
    procedure IniciarGrid;
    Procedure RegistrarNoBanco;
    procedure Procurar;
    procedure Excluir_Produto;
  public
    { Public declarations }
  end;

  Const
   //Pedido de Venda
   cico_produto     = 0;
   cino_produto     = 1;
   cinu_valorvenda  = 2;


var
  formProduto: TformProduto;
  filtro: string;
  status: string;

implementation
Uses UKgVendasLib, uDM,  UBLLProduto, UDAOProduto, UBLLProdutodoPedido, uDAOProdutodoPedido;
{$R *.dfm}

{ TformProduto }

procedure TformProduto.AtivarAlteracao;
begin
  // Botões
  BtnIncluir.Enabled   := True;
  BtnCancelar.Enabled  := False;
  BtnGravar.Enabled    := False;
  BtnAlterar.Enabled   := True;
  BtnSair.Enabled      := True;
  BtnProcurar.Enabled  := True;
  BtnExcluir.Enabled   := True;
  Panel5.Enabled       := True;
  Pnlcadastro.Enabled  := False;
  SgProduto.Enabled    := True;

end;

procedure TformProduto.AtivarInclusao;
begin
  Pnlcadastro.Enabled := True;
  ed_no_produto.SetFocus;

  // Botões
  BtnIncluir.Enabled   := False;
  BtnCancelar.Enabled  := True;
  BtnGravar.Enabled    := True;
  BtnAlterar.Enabled   := False;
  BtnSair.Enabled      := False;
  BtnProcurar.Enabled  := False;
  BtnExcluir.Enabled   := False;
  Panel5.Enabled       := False;
  Pnlcadastro.Enabled  := True;
  SgProduto.Enabled    := False;

  status:= 'INC';

end;

procedure TformProduto.BtnAlterarClick(Sender: TObject);
begin
  inherited;
//  AtivarAlteracao;
  ShowMessage('Alteração não autorizada!');
end;

procedure TformProduto.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  DesativarInclusao;
  CarregarCampo;
end;

procedure TformProduto.BtnExcluirClick(Sender: TObject);
var
  ListaProdutodoPedido: TArProdutodoPedidoDados;
  BLLProdutodoPedido  : TProdutodoPedidoBLL;
  i               : integer;
  excluir         : Boolean;

begin
  inherited;
  try
    BLLProdutodoPedido  := TProdutodoPedidoBLL.Create;
    ListaProdutodoPedido:= BLLProdutodoPedido.GetListaProdutodoPedido(0,0,StrToInt(ed_co_produto.Text));

    excluir := True;

    for  i:= Low(ListaProdutodoPedido) to High(ListaProdutodoPedido) do
    begin
      if ListaProdutodoPedido[i].co_produto = StrToInt(ed_co_produto.Text) then
      begin
         excluir := False;
         break;
      end;

    end;

    if not excluir then
    begin
      Application.MessageBox('Produto possui Compras!'+#13+' Exclusão não autorizada!','Atenção', MB_ICONEXCLAMATION);
      Abort;
    end;

    Excluir_Produto;

  finally
    FreeAndNil(BLLProdutodoPedido);
  end;


end;

procedure TformProduto.BtnGravarClick(Sender: TObject);
begin
  inherited;
  if Length(ed_no_produto.Text) = 0 then
  begin
    Application.MessageBox('Necesário Informar Descrição do Produto!','Atenção', MB_ICONEXCLAMATION);
    ed_no_produto.SetFocus;
    Abort;
  end
  else
  if StrToFloat(ed_nu_valorvenda.Text) = 0.0 then
  begin
    Application.MessageBox('Informe Valor da Venda!','Atenção', MB_ICONEXCLAMATION);
    ed_nu_valorvenda.SetFocus;
    Abort;
  end;
  RegistrarNoBanco;
  BtnLimparFiltroClick(BtnLimparFiltro);
  LimparCampo;
  ed_no_produto.SetFocus;
end;

procedure TformProduto.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  LimparCampo;
  AtivarInclusao;
end;

procedure TformProduto.BtnLimparFiltroClick(Sender: TObject);
begin
  inherited;
  ed_procurar2.Text := '-1';
  procurar;
  ed_procurar2.Text := '';
  CarregarCampo;
end;

procedure TformProduto.BtnProcurarClick(Sender: TObject);
begin
  inherited;
  if filtro = 'Nome' then
  begin
    if Length(ed_procurar1.Text) = 0 then
    begin
      Application.MessageBox('Informe a Descrição do Produto para pesquisa!','Atenção', MB_ICONEXCLAMATION);
      ed_procurar1.SetFocus;
      Abort;
    end;
  end
  else
  if filtro = 'Codigo' then
  begin
    if Length(ed_procurar2.Text) = 0 then
    begin
      Application.MessageBox('Informe o Código do Produto para pesquisa!','Atenção', MB_ICONEXCLAMATION);
      ed_procurar2.SetFocus;
      Abort;
    end;
  end;
  procurar;
  CarregarCampo;
  ed_procurar1.Text := '';
  ed_procurar2.Text := '';
end;

procedure TformProduto.CarregarCampo;
begin
  ed_co_produto.Text    := SgProduto.Cells[cico_produto,SgProduto.Row];
  ed_no_produto.Text    := SgProduto.Cells[cino_produto,SgProduto.Row];
  ed_nu_valorvenda.Text := SgProduto.Cells[cinu_valorvenda,SgProduto.Row];
end;

procedure TformProduto.DesativarInclusao;
begin
  // Botões
  BtnIncluir.Enabled   := True;
  BtnCancelar.Enabled  := False;
  BtnGravar.Enabled    := False;
  BtnAlterar.Enabled   := True;
  BtnSair.Enabled      := True;
  BtnProcurar.Enabled  := True;
  BtnExcluir.Enabled   := True;
  Panel5.Enabled       := True;
  Pnlcadastro.Enabled  := False;
  SgProduto.Enabled    := True;
end;

procedure TformProduto.ed_nu_valorvendaExit(Sender: TObject);
begin
  inherited;
  if Length(ed_nu_valorvenda.Text) > 0 then
   ed_nu_valorvenda.Text:= FormatFloat('0.00', (StrToFloat(ed_nu_valorvenda.Text)));

end;

procedure TformProduto.ed_procurar1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
  BtnProcurarClick(BtnProcurar);

end;

procedure TformProduto.ed_procurar2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
  BtnProcurarClick(BtnProcurar);

end;

procedure TformProduto.ed_procurar2KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (key in ['0'..'9', #8, #27, #32]) then
    begin
    beep;
    key := #0;
  end;

end;

procedure TformProduto.Excluir_Produto;
var
  BLLProduto   : TProdutoBLL;
  ListaPrdouto : TArProdutoDados;

begin
  try
    BLLProduto := TProdutoBLL.Create;
    BLLProduto.Produto.co_produto   := StrToInt(ed_co_produto.Text);

    if not BLLProduto.Delete(BLLProduto.Produto) then
    begin
      Application.MessageBox('Erro na Exclusão do Produto!','Atenção', MB_ICONEXCLAMATION);
      BtnCancelarClick(BtnCancelar);
    end;

  finally
    FreeAndNil(BLLProduto);
  end;
  LimparCampo;
  ApagarGrid(SgProduto);
  BtnLimparFiltroClick(BtnLimparFiltro);
  CarregarCampo;
  ed_procurar2.Text     := '-2';

end;

procedure TformProduto.FormActivate(Sender: TObject);
begin
  inherited;
  RgFiltroClick(RgFiltro);
  IniciarGrid;
  BtnLimparFiltroClick(BtnLimparFiltro);
  CarregarCampo;
  ed_procurar2.Text     := '-2';
end;

procedure TformProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = 27 then
  BtnLimparFiltroClick(BtnLimparFiltro);

end;

procedure TformProduto.IniciarGrid;
begin
  SgProduto.ColCount                   := 3;
  SgProduto.RowCount                   := 2;
  SgProduto.DefaultColWidth            := 5;
  SgProduto.DefaultRowHeight           := 15;
  SgProduto.Cells[cico_produto, SgProduto.FixedRows - 1] := 'Cadastro de Produto';

  SgProduto.cells[cico_produto,0]      := 'Código';
  SgProduto.ColWidths[cico_produto]    := 60;

  SgProduto.cells[cino_produto,0]      := 'Produto';
  SgProduto.ColWidths[cino_produto]    := 390;

  SgProduto.cells[cinu_valorvenda,0]   := 'Cidade';
  SgProduto.ColWidths[cinu_valorvenda] := 120;

end;

procedure TformProduto.LimparCampo;
begin
  ed_co_produto.Text    := '';
  ed_no_produto.Text    := '';
  ed_nu_valorvenda.Text := '';
end;

procedure TformProduto.Procurar;
var
  i           : Integer;
  ln          :integer;
  ListaProduto: TArProdutoDados;
  BLLProduto  : TProdutoBLL;

begin
  try
    BLLProduto := TProdutoBLL.Create;

    ListaProduto := BLLProduto.GetListaProduto(StrToInt(ed_procurar2.Text), Trim(ed_procurar1.Text));

    ApagarGrid(SgProduto);

    if ListaProduto<> Nil then
    begin
      ln:=1;
      for  i:= Low(ListaProduto) to High(ListaProduto) do
      begin
       SgProduto.cells[cico_produto,ln]   := IntToStr(ListaProduto[i].co_produto);
       SgProduto.cells[cino_produto,ln]   := ListaProduto[i].no_produto;
       SgProduto.cells[cinu_valorvenda,ln]:= FloattoStr(ListaProduto[i].nu_valorvenda);
       inc(ln);
      end;

      if ln > SgProduto.FixedRows then
        SgProduto.RowCount := ln;

    end
    else
      Application.MessageBox('Produto não localizado!','Atenção', MB_ICONEXCLAMATION);

  finally
    FreeAndNil(BLLProduto);
  end;

end;

procedure TformProduto.RegistrarNoBanco;
var
  BLLProduto    : TProdutoBLL;

begin
  inherited;
  try
    BLLProduto:= TProdutoBLL.Create;

    if status = 'INC' then
    begin
      BLLProduto.Produto.no_produto    := Trim(ed_no_produto.Text);
      BLLProduto.Produto.nu_valorvenda := StrToFloat(ed_nu_valorvenda.Text);

      if not BLLProduto.Add(BLLProduto.Produto) then
      begin
        Application.MessageBox('Erro na Inclusão dos Produto!','Atenção', MB_ICONEXCLAMATION);
        BtnCancelarClick(BtnCancelar);
      end;
    end
    else
    if status = 'ALT' then
    begin
      BLLProduto.Produto.co_produto    := StrToInt(ed_co_produto.Text);
      BLLProduto.Produto.no_produto    := Trim(ed_no_produto.Text);
      BLLProduto.Produto.nu_valorvenda := StrToFloat(ed_nu_valorvenda.Text);

      if not BLLProduto.Update(BLLProduto.Produto) then
      begin
        Application.MessageBox('Erro na alteração do Produto!','Atenção', MB_ICONEXCLAMATION);
        BtnCancelarClick(BtnCancelar);
      end;
    end;

  finally
    FreeAndNil(BLLProduto);
  end;

  LimparCampo;
  ApagarGrid(SgProduto);

  //Procurar;


end;

procedure TformProduto.RgFiltroClick(Sender: TObject);
begin
  inherited;
  ed_procurar1.Text     := '';
  ed_procurar2.Text     := '';

  if RgFiltro.ItemIndex = 0  then // Nome
  begin
   lb_filtro.Caption     := 'Produto:';
   ed_procurar1.Visible  := True;
   ed_procurar2.Visible  := False;
   ed_procurar1.SetFocus;
   filtro := 'Nome';
  end
  else
  if RgFiltro.ItemIndex = 1  then // Código
  begin
   lb_filtro.Caption := 'Código:';
   ed_procurar1.Visible  := False;
   ed_procurar2.Visible  := True;
   ed_procurar2.SetFocus;
   filtro := 'Codigo';
  end;
end;

procedure TformProduto.SgProdutoClick(Sender: TObject);
begin
  inherited;
  CarregarCampo;
end;

end.
