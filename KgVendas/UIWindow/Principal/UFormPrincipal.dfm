object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'Kg Vendas'
  ClientHeight = 802
  ClientWidth = 1260
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = Menu
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Menu: TMainMenu
    Left = 184
    Top = 72
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object Cliente2: TMenuItem
        Caption = 'Cliente'
        OnClick = Cliente2Click
      end
      object Produto1: TMenuItem
        Caption = 'Produto'
        OnClick = Produto1Click
      end
    end
    object Cliente1: TMenuItem
      Caption = 'Venda'
      OnClick = Cliente1Click
    end
    object Sair1: TMenuItem
      Caption = 'Sair'
      OnClick = Sair1Click
    end
  end
end
