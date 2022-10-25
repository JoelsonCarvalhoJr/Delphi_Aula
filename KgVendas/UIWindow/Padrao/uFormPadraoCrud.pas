unit uFormPadraoCrud;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TFormPadraoCrud = class(TForm)
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    BtnGravar: TBitBtn;
    BtnCancelar: TBitBtn;
    BtnAlterar: TBitBtn;
    BtnIncluir: TBitBtn;
    BtnSair: TBitBtn;
    BtnExcluir: TBitBtn;
    procedure BtnSairClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  protected
    Procedure Incluir          ; Virtual;
    Procedure Gravar           ; Virtual;
    Procedure Alterar          ; Virtual;
    Procedure Cancelar         ; Virtual;
    Procedure Excluir          ; Virtual;
    Procedure IniciarForm      ; Virtual;
    Procedure RegistrarNoBanco ; Virtual;
    Procedure Processar        ; Virtual;

  public
    { Public declarations }
  end;

var
  FormPadraoCrud: TFormPadraoCrud;

implementation

{$R *.dfm}

procedure TFormPadraoCrud.Alterar;
begin
  //Override;
end;

procedure TFormPadraoCrud.BtnAlterarClick(Sender: TObject);
begin
  Alterar;
end;

procedure TFormPadraoCrud.BtnCancelarClick(Sender: TObject);
begin
  Cancelar;
end;

procedure TFormPadraoCrud.BtnExcluirClick(Sender: TObject);
begin
  Excluir;
end;

procedure TFormPadraoCrud.BtnGravarClick(Sender: TObject);
begin
  Gravar;
end;

procedure TFormPadraoCrud.BtnIncluirClick(Sender: TObject);
begin
  Incluir;
end;

procedure TFormPadraoCrud.BtnSairClick(Sender: TObject);
begin
  close;
end;

procedure TFormPadraoCrud.Cancelar;
begin
  //Override;
end;

procedure TFormPadraoCrud.Excluir;
begin
  //Override;
end;

procedure TFormPadraoCrud.FormCreate(Sender: TObject);
begin
  IniciarForm;
end;

procedure TFormPadraoCrud.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If key = VK_RETURN then
     keybd_event(VK_TAB,0,0,0);

end;

procedure TFormPadraoCrud.Gravar;
begin
  //Override;
end;

procedure TFormPadraoCrud.Incluir;
begin
  //Override;
end;

procedure TFormPadraoCrud.IniciarForm;
begin
  Self.Caption := Application.Title;
end;

procedure TFormPadraoCrud.Processar;
begin
  //Sobrescrever
end;

procedure TFormPadraoCrud.RegistrarNoBanco;
begin
  //Sobrescrever
end;

end.
