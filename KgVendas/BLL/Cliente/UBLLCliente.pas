unit UBLLCliente;

interface
Uses Vcl.Controls,SysUtils,Classes, UKgVendasLib, UDAOCliente, UCliente,
     Messages, Forms, Winapi.Windows, FireDAC.Comp.Client, FireDAC.Dapt;

Type
  TFiltroPesquisaCliente= (tfCliente, tfCodigo, tfNome);
  TNomeCampo = ( tncco_cliente, tncno_cliente);

  TClienteBLL = class
   Private
     FCliente: TCliente;
     FClienteDAO : TClienteDAO;
   Public
    Function Add ( Cliente : TCliente): Boolean;
    Function Delete ( Cliente : TCliente): Boolean;
    Function Update( Cliente : TCliente): Boolean;
    Function GetListaCliente (CodigoCliente: Integer; NomeCliente: string): TArClienteDados;
    Function ValidarCampo ( Cliente : TCliente; TNomeCampo : TNomeCampo ): Boolean;
    function ValidarValoresPesquisaCliente( Filtros: TFiltroPesquisaCliente; ValorFiltro: string ):Boolean;

    procedure DefinirParametrosPesquisaCliente( Filtros: TFiltroPesquisaCliente;
                                                  ValorPesquisa:  string;
                                                  var ico_cliente: Integer);
    Constructor Create;
    Destructor  Destroy; Override;
    Property Cliente: TCliente Read FCliente Write FCliente;
  end;

implementation

{ TClienteBLL }
constructor TClienteBLL.Create;
begin
  FCliente    := TCliente.Create;
  FClienteDAO := TClienteDAO.Create;
end;

destructor TClienteBLL.Destroy;
begin
  FreeAndNil(FCliente);
  FreeAndNil(FClienteDAO);
end;

function TClienteBLL.Add(Cliente: TCliente): Boolean;
begin
  Result := True;

  if Length(Cliente.no_cliente) = 0 then
  begin
    Application.MessageBox('Informe o nome do Cliente!','Atenção', MB_ICONEXCLAMATION);
    Result := False;
  end;

  if Length(Cliente.no_cidade) = 0 then
  begin
    Application.MessageBox('Informe o nome da Cidade!','Atenção', MB_ICONEXCLAMATION);
    Result := False;
  end;

  if Length(Cliente.no_uf) = 0 then
  begin
    Application.MessageBox('Informe Estado!','Atenção', MB_ICONEXCLAMATION);
    Result := False;
  end;

  if Result then
  begin
      Result :=  FClienteDAO.Add(Cliente);
  end;

end;

function TClienteBLL.GetListaCliente(CodigoCliente: Integer; NomeCliente: string): TArClienteDados;
begin
  Result := FClienteDAO.getListaCliente(CodigoCliente, NomeCliente);
end;

function TClienteBLL.Update(Cliente: TCliente): Boolean;
begin
  Result := True;

  if Length(Cliente.no_cliente) = 0 then
  begin
    Application.MessageBox('Informe o nome do Cliente!','Atenção', MB_ICONEXCLAMATION);
    Result := False;
  end;

  if Length(Cliente.no_cidade) = 0 then
  begin
    Application.MessageBox('Informe o nome da Cidade!','Atenção', MB_ICONEXCLAMATION);
    Result := False;
  end;

  if Length(Cliente.no_uf) = 0 then
  begin
    Application.MessageBox('Informe Estado!','Atenção', MB_ICONEXCLAMATION);
    Result := False;
  end;

  if Result then
  begin
      Result :=  FClienteDAO.Update(Cliente);
  end;

end;

function TClienteBLL.ValidarCampo(Cliente: TCliente; TNomeCampo: TNomeCampo): Boolean;
begin
  Result := False;
  case TNomeCampo of
   tncno_cliente: begin
                 Result := iif (Length(Trim(cliente.no_cliente)) = 0, False, True);
                 if Not Result then
                    Application.MessageBox('Necessário informar nome do Cliente!','Atenção', MB_ICONEXCLAMATION);

               end;
  end;
end;

function TClienteBLL.ValidarValoresPesquisaCliente(
  Filtros: TFiltroPesquisaCliente; ValorFiltro: string): Boolean;
begin
  Result := True;

  case Filtros of
   tfCodigo:
     begin
       if Length(ValorFiltro) = 0 then
       begin
         Application.MessageBox('Informe o Cliente!','Atenção', MB_ICONEXCLAMATION);
         Result := False;
         Abort
       end;

     end;
  end;
end;

procedure TClienteBLL.DefinirParametrosPesquisaCliente(Filtros: TFiltroPesquisaCliente; ValorPesquisa: string;
          var ico_Cliente: Integer);
begin
  case filtros of
   tfCodigo:begin
              if  ValidarValoresPesquisaCliente(tfCodigo,ValorPesquisa) then
              begin
                ico_cliente:= StrToInt(ValorPesquisa);
              end;
            end;

  end;

end;

function TClienteBLL.Delete(Cliente: TCliente): Boolean;
begin
  Result := True;

  if Length(IntToStr(Cliente.co_cliente)) = 0 then
  begin
    Application.MessageBox('Informe o Código do Cliente para exclusão!','Atenção', MB_ICONEXCLAMATION);
    Result := False;
  end;

  if Result then
  begin
    if Application.MessageBox('Confirma Exclusão ?','Atenção', mb_YesNo) = mrYes then
       Result :=  FClienteDAO.Delete(Cliente);

  end;

end;

end.
