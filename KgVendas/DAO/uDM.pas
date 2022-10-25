unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TDM = class(TDataModule)
    dbsMain: TFDConnection;
    MySQLDriverLink: TFDPhysMySQLDriverLink;
    Qry: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    Function GetDataServidor(sDia: String = ''): TDatetime;
    Function GetUltimoId(scodigo: string; stabela: string): Integer; // Ultimo ID gerado

  end;

var
  DM: TDM;

implementation
Uses UKgVendasLib;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDM }

function TDM.GetDataServidor(sDia: String): TDatetime;
var
  QryDat: TFDQuery;
  dData: TDatetime;
  iDia: integer;
begin

  QryDat := TFDQuery.Create(self);
  with QryDat do
  begin
    DisableControls;
    Close;
    ConnectionName := 'dbsMain';
    SQL.Add('select current_timestamp as DataServidor');
    Prepare;

    TRY
      Open;
    EXCEPT
      on e: exception do
      begin
        Raise EConvertError.Create('Erro ao capturar a data do servidor.');
      end;
    END;

    dData := FieldByName('DataServidor').AsDateTime;

    Close;
    Destroy;
  end;

  //CONSIDERANDO O MES VIGENTE
  if UpperCase(sDia) = 'PRIMEIRO' then
     dData := StrToDate('01/' + formatdatetime('mm/yyyy', dData))

  else if UpperCase(sDia) = 'ULTIMO' then
     begin
       iDia := 31;
       while 1 = 1 do
       begin
         try
           dData := StrToDate(PADL(IntToStr(iDia), 2, '0') + '/' +
                              formatdatetime('mm/yyyy', dData));
           Break;
         except
           iDia := iDia - 1;
         end;
       end;
     end

  //CONSIDERANDO O ANO VIGENTE
  else if UpperCase(sDia) = 'PRIMEIRO-ANO' then
     dData := StrToDate('01/01/' + formatdatetime('yyyy', dData))

  else if UpperCase(sDia) = 'ULTIMO-ANO' then
     dData := StrToDate('31/12/' + formatdatetime('yyyy', dData));

  result := dData;



end;

function TDM.GetUltimoId(scodigo, stabela: string): Integer;
var
  sSQL       : string;
begin
  Result := -1;
  Qry.Close;
  Qry.SQL.Clear;
  sSQL   := 'SELECT MAX(' +scodigo+') as id FROM kgvenda.'+stabela+'';
  Qry.SQL.Add(sSQL);

  Qry.Open;

  Result := Qry.FieldByName('id').AsInteger;

end;

end.
