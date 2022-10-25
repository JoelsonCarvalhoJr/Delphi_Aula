unit UKgVendasLib;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus,
  TLHelp32, PsAPI, WinInet, IdIPWatch, Winsock, System.AnsiStrings, shellapi,
  ComCtrls, ToolWin , StdCtrls, db, Buttons, Grids, DBGrids, Mask, DBCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  DateUtils, RichEdit, System.MaskUtils,

  {Arredondar}
  System.Math;


Function  IIF(lVerdade:Boolean;Valor1:Variant;Valor2:Variant):Variant;
Function  PADL(cString:String;nTamanho:Integer;sCaracter:ShortString):String;
Function  PADR(cString:String;nTamanho:Integer;sCaracter:ShortString):String;
Procedure ApagarGrid(Grid: TStringGrid; ApagarFixedCols: Boolean = True);


implementation

uses System.RegularExpressions;

// Função IIF
Function IIF(lVerdade:Boolean;Valor1:Variant;Valor2:Variant):Variant;
begin
  if lVerdade then
     result := Valor1
  else
     result := Valor2;

end;

Function PADL(cString:String;nTamanho:Integer;sCaracter:ShortString):String;
var
  cConteudo : String;
  I         : integer;
begin
  nTamanho := nTamanho - 1;
  cConteudo := Trim(cString);
  For I:=Length(cConteudo) to nTamanho do
      cConteudo := sCaracter+cConteudo;

  Result := cConteudo;

end;

Function PADR(cString:String;nTamanho:Integer;sCaracter:ShortString):String;
var
  cConteudo : String;
  I         : integer;
begin
  nTamanho := nTamanho - 1;
  cConteudo := Trim(cString);
  For I:=Length(cConteudo) to nTamanho do
      cConteudo := cConteudo + sCaracter;

  Result := cConteudo;
end;

procedure ApagarGrid (Grid: TStringGrid; ApagarFixedCols: Boolean);
var
  LiCountRow : Integer;
  LiCountCol : Integer;
  LiInicioCol: Integer;
begin
  if ApagarFixedCols then
    LiInicioCol := 0
  else
    LiInicioCol := Grid.FixedCols;

  for LiCountRow := Grid.FixedRows to Grid.RowCount do
   begin
     for LiCountCol := LiInicioCol to Grid.ColCount -1 do
       Grid.Cells[LiCountCol, LiCountRow] := '';
   end;

   if ApagarFixedCols then
     Grid.RowCount := Grid.FixedRows + 1;

end;

end.

