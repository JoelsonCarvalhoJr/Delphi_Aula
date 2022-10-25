unit UFormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFormPrincipal = class(TForm)
    Menu: TMainMenu;
    Cliente1: TMenuItem;
    Sair1: TMenuItem;
    Cadastro1: TMenuItem;
    Cliente2: TMenuItem;
    Produto1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure Cliente1Click(Sender: TObject);
    procedure Cliente2Click(Sender: TObject);
    procedure Produto1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}
uses uFormVenda, uFormCliente, uformProduto;


procedure TFormPrincipal.Cliente1Click(Sender: TObject);
begin
  try
     Application.CreateForm(tFormVenda, FormVenda);
     FormVenda.Showmodal;
  finally
     FreeAndNil(FormVenda);
  end;

end;

procedure TFormPrincipal.Cliente2Click(Sender: TObject);
begin
  try
     Application.CreateForm(tFormCliente, FormCliente);
     FormCliente.Showmodal;
  finally
     FreeAndNil(FormCliente);
  end;

end;

procedure TFormPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Application.Terminate;
end;

procedure TFormPrincipal.FormResize(Sender: TObject);
begin
  if Self.Height < 561 then
     Self.Height := 561;

end;


procedure TFormPrincipal.Produto1Click(Sender: TObject);
begin
  try
     Application.CreateForm(tFormProduto, FormProduto);
     FormProduto.Showmodal;
  finally
     FreeAndNil(FormProduto);
  end;

end;

procedure TFormPrincipal.Sair1Click(Sender: TObject);
begin
  Close;
end;

end.
