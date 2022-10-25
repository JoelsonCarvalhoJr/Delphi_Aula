unit uFormCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormPadraoCrud, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids;

type
  TFormCliente = class(TFormPadraoCrud)
    Pnlcadastro: TPanel;
    Panel4: TPanel;
    Label2: TLabel;
    ed_co_cliente: TEdit;
    Label1: TLabel;
    ed_no_cliente: TEdit;
    Label3: TLabel;
    ed_no_cidade: TEdit;
    CBoxUf: TComboBox;
    Panel5: TPanel;
    SgCliente: TStringGrid;
    lb_filtro: TLabel;
    ed_procurar1: TEdit;
    Label5: TLabel;
    BtnProcurar: TBitBtn;
    RgFiltro: TRadioGroup;
    ed_procurar2: TEdit;
    BtnLimparFiltro: TBitBtn;
    procedure RgFiltroClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ed_procurar2KeyPress(Sender: TObject; var Key: Char);
    procedure BtnProcurarClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure SgClienteClick(Sender: TObject);
    procedure BtnLimparFiltroClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure ed_procurar2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ed_procurar1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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
    procedure Excluir_cliente;
  public
    { Public declarations }
  end;

  Const
   cico_cliente = 0;
   cino_cliente = 1;
   cino_cidade  = 2;
   cino_uf      = 3;

var
  FormCliente: TFormCliente;
  filtro: string;
  status: string;

implementation
Uses UKgVendasLib, uDM,  UBLLCliente, UDAOCliente,UBLLDadosGerais, uDAODadosGerais;

{$R *.dfm}



procedure TFormCliente.AtivarAlteracao;
begin
  Pnlcadastro.Enabled := True;
  ed_no_cliente.SetFocus;

  // Botões
  BtnIncluir.Enabled   := False;
  BtnCancelar.Enabled  := True;
  BtnGravar.Enabled    := True;
  BtnAlterar.Enabled   := False;
  BtnSair.Enabled      := False;
  BtnProcurar.Enabled  := False;
  BtnExcluir.Enabled   := False;
  Panel5.Enabled       := False;
  SgCliente.Enabled    := False;

  status:= 'ALT';
end;

procedure TFormCliente.AtivarInclusao;
begin
  Pnlcadastro.Enabled := True;
  ed_no_cliente.SetFocus;

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
  SgCliente.Enabled    := False;

  status:= 'INC';

end;

procedure TFormCliente.BtnLimparFiltroClick(Sender: TObject);
begin
  inherited;
  ed_procurar2.Text := '-1';
  procurar;
  ed_procurar2.Text := '';
  CarregarCampo;
end;

procedure TFormCliente.BtnAlterarClick(Sender: TObject);
begin
  inherited;
//  AtivarAlteracao;
  ShowMessage('Alteração não autorizada!');
end;

procedure TFormCliente.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  DesativarInclusao;
  CarregarCampo;
end;

procedure TFormCliente.BtnExcluirClick(Sender: TObject);
var
  ListaDadosGerais: TArDadosGeraisDados;
  BLLDadosGerais  : TDadosGeraisBLL;
  i               : integer;
  excluir         : Boolean;
begin
  inherited;
  try
    BLLDadosGerais := TDadosGeraisBLL.Create;
    ListaDadosGerais:= BLLDadosGerais.GetListaDadosGerais(0, StrToInt(ed_co_cliente.Text));

    excluir := True;

    for  i:= Low(ListaDadosGerais) to High(ListaDadosGerais) do
    begin
      if ListaDadosGerais[i].co_cliente = StrToInt(ed_co_cliente.Text) then
      begin
         excluir := False;
         break;
      end;

    end;

    if not excluir then
    begin
      Application.MessageBox('Cliente possui Compras!'+#13+' Exclusão não autorizada!','Atenção', MB_ICONEXCLAMATION);
      Abort;
    end;



    Excluir_cliente;

  finally
    FreeAndNil(BLLDadosGerais);
  end;


end;

procedure TFormCliente.BtnGravarClick(Sender: TObject);
begin
  inherited;
  if Length(ed_no_cliente.Text) = 0 then
  begin
    Application.MessageBox('Necesário Informar Cliente!','Atenção', MB_ICONEXCLAMATION);
    ed_no_cliente.SetFocus;
    Abort;
  end
  else
  if Length(ed_no_cidade.Text) = 0 then
  begin
    Application.MessageBox('Necesário Informar Cidade!','Atenção', MB_ICONEXCLAMATION);
    ed_no_cidade.SetFocus;
    Abort;
  end
  else
  if CBoxUf.ItemIndex = -1 then
  begin
    Application.MessageBox('Necesário Informar Estado da Confederação!','Atenção', MB_ICONEXCLAMATION);
    CBoxUf.SetFocus;
    Abort;
  end;
  RegistrarNoBanco;
  BtnLimparFiltroClick(BtnLimparFiltro);
  LimparCampo;
  ed_no_cliente.SetFocus;

end;

procedure TFormCliente.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  LimparCampo;
  AtivarInclusao;
end;

procedure TFormCliente.BtnProcurarClick(Sender: TObject);
begin
  inherited;
  if filtro = 'Nome' then
  begin
    if Length(ed_procurar1.Text) = 0 then
    begin
      Application.MessageBox('Informe o nome do Cliente para pesquisa!','Atenção', MB_ICONEXCLAMATION);
      ed_procurar1.SetFocus;
      Abort;
    end;
  end
  else
  if filtro = 'Codigo' then
  begin
    if Length(ed_procurar2.Text) = 0 then
    begin
      Application.MessageBox('Informe o Código do Cliente para pesquisa!','Atenção', MB_ICONEXCLAMATION);
      ed_procurar2.SetFocus;
      Abort;
    end;
  end;
  procurar;
  CarregarCampo;
  ed_procurar1.Text := '';
  ed_procurar2.Text := '';
end;

procedure TFormCliente.CarregarCampo;
begin
  ed_co_cliente.Text  := SgCliente.Cells[cico_cliente,SgCliente.Row];
  ed_no_cliente.Text  := SgCliente.Cells[cino_cliente,SgCliente.Row];
  ed_no_cidade.Text   := SgCliente.Cells[cino_cidade,SgCliente.Row];
  CBoxUf.ItemIndex    := CBoxUf.Items.IndexOf(SgCliente.Cells[cino_uf,SgCliente.Row]);


end;

procedure TFormCliente.DesativarInclusao;
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
  SgCliente.Enabled    := True;
end;

procedure TFormCliente.ed_procurar1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
   BtnProcurarClick(BtnProcurar);

end;

procedure TFormCliente.ed_procurar2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
  BtnProcurarClick(BtnProcurar);

end;

procedure TFormCliente.ed_procurar2KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (key in ['0'..'9', #8, #27, #32]) then
    begin
    beep;
    key := #0;
  end;
end;

procedure TFormCliente.Excluir_cliente;
var
  BLLCliente      : TClienteBLL;
  ListaCliente    : TArClienteDados;

begin
  try
    BLLCliente := TClienteBLL.Create;
    BLLCliente.Cliente.co_cliente   := StrToInt(ed_co_cliente.Text);

    if not BLLCliente.Delete(BLLCliente.Cliente) then
    begin
      Application.MessageBox('Erro na Inclusão dos dados, verifique os log´s!','Atenção', MB_ICONEXCLAMATION);
      BtnCancelarClick(BtnCancelar);
    end;

  finally
    FreeAndNil(BLLCliente);
  end;
  LimparCampo;
  ApagarGrid(SgCliente);
  BtnLimparFiltroClick(BtnLimparFiltro);
  CarregarCampo;
  ed_procurar2.Text     := '-2';

end;

procedure TFormCliente.FormActivate(Sender: TObject);
begin
  inherited;
  RgFiltroClick(RgFiltro);
  IniciarGrid;
  BtnLimparFiltroClick(BtnLimparFiltro);
  CarregarCampo;
  ed_procurar2.Text     := '-2';
end;

procedure TFormCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = 27 then
  BtnLimparFiltroClick(BtnLimparFiltro);

end;

procedure TFormCliente.IniciarGrid;
begin
  SgCliente.ColCount                   := 4;
  SgCliente.RowCount                   := 2;

  SgCliente.DefaultColWidth            := 5;
  SgCliente.DefaultRowHeight           := 15;
  SgCliente.Cells[cico_cliente, SgCliente.FixedRows - 1] := 'Cadastro Cliente';

  SgCliente.cells[cico_cliente,0]      := 'Código';
  SgCliente.ColWidths[cico_cliente]    := 60;

  SgCliente.cells[cino_cliente,0]      := 'Nome';
  SgCliente.ColWidths[cino_cliente]    := 390;

  SgCliente.cells[cino_cidade,0]       := 'Cidade';
  SgCliente.ColWidths[cino_cidade]     := 250;

  SgCliente.cells[cino_uf,0]           := 'UF';
  SgCliente.ColWidths[cino_uf]         := 80;

end;

procedure TFormCliente.LimparCampo;
begin
  ed_co_cliente.Text := '';
  ed_no_cliente.Text := '';
  ed_no_cidade.Text  := '';
  CBoxUf.ItemIndex   := -1;
end;


procedure TFormCliente.procurar;
var
  i           : Integer;
  ln          :integer;
  ListaCliente: TArClienteDados;
  BLLCliente  : TClienteBLL;

begin
  try
    BLLCliente := TClienteBLL.Create;
    ListaCliente:= BLLCliente.GetListaCliente(StrToInt(ed_procurar2.Text), Trim(ed_procurar1.Text));
    ApagarGrid(SgCliente);

    if ListaCliente<> Nil then
    begin
      ln:=1;
      for  i:= Low(ListaCliente) to High(ListaCliente) do
      begin
       SgCliente.cells[cico_cliente,ln] := IntToStr(ListaCliente[i].co_cliente);
       SgCliente.cells[cino_cliente,ln] := Trim(ListaCliente[i].no_cliente);
       SgCliente.cells[cino_cidade,ln]  := Trim(ListaCliente[i].no_cidade);
	     SgCliente.cells[cino_uf,ln]      := Trim(ListaCliente[i].no_uf);
       inc(ln);
      end;

      if ln > SgCliente.FixedRows then
        SgCliente.RowCount := ln;

    end
    else
      Application.MessageBox('Cliente não localizado!','Atenção', MB_ICONEXCLAMATION);

  finally
    FreeAndNil(BLLCliente);
  end;

end;

procedure TFormCliente.RgFiltroClick(Sender: TObject);
begin
  inherited;
  ed_procurar1.Text     := '';
  ed_procurar2.Text     := '';

  if RgFiltro.ItemIndex = 0  then // Nome
  begin
   lb_filtro.Caption     := 'Nome:';
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

procedure TFormCliente.SgClienteClick(Sender: TObject);
begin
  inherited;
  CarregarCampo;
end;

procedure TFormCliente.RegistrarNoBanco;
var
  BLLCliente    : TClienteBLL;

begin
  inherited;
  try
    BLLCliente := TClienteBLL.Create;

    if status = 'INC' then
    begin
      BLLCliente.Cliente.no_cliente   := Trim(ed_no_cliente.Text);
      BLLCliente.Cliente.no_cidade    := Trim(ed_no_cidade.Text);
      BLLCliente.Cliente.no_uf        := CBoxUf.Items[CBoxUf.ItemIndex];

      if not BLLCliente.Add(BLLCliente.Cliente) then
      begin
        Application.MessageBox('Erro na Inclusão dos dados, verifique os log´s!','Atenção', MB_ICONEXCLAMATION);
        BtnCancelarClick(BtnCancelar);
      end;
    end
    else
    if status = 'ALT' then
    begin
      BLLCliente.Cliente.co_cliente   := StrToInt(ed_co_cliente.Text);
      BLLCliente.Cliente.no_cliente   := Trim(ed_no_cliente.Text);
      BLLCliente.Cliente.no_cidade    := Trim(ed_no_cidade.Text);
      BLLCliente.Cliente.no_uf        := CBoxUf.Items[CBoxUf.ItemIndex];

      if not BLLCliente.Update(BLLCliente.Cliente) then
      begin
        Application.MessageBox('Erro na alteração dos dados, verifique os log´s!','Atenção', MB_ICONEXCLAMATION);
        BtnCancelarClick(BtnCancelar);
      end;
    end;

  finally
    FreeAndNil(BLLCliente);
  end;

  LimparCampo;
  ApagarGrid(SgCliente);

end;
end.
