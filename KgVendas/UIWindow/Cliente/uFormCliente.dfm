inherited FormCliente: TFormCliente
  Caption = 'Cadastro de cliente'
  ClientWidth = 975
  KeyPreview = True
  OnActivate = FormActivate
  ExplicitWidth = 991
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl2: TPageControl
    Width = 975
    ExplicitWidth = 975
    inherited TabSheet1: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 30
      ExplicitWidth = 967
      ExplicitHeight = 591
      inherited Panel2: TPanel
        Width = 967
        ExplicitWidth = 967
        object Pnlcadastro: TPanel
          Left = 158
          Top = 8
          Width = 796
          Height = 185
          BorderStyle = bsSingle
          Enabled = False
          TabOrder = 1
          object Label2: TLabel
            Left = 5
            Top = 7
            Width = 45
            Height = 19
            Caption = 'C'#243'digo'
          end
          object Label1: TLabel
            Left = 5
            Top = 57
            Width = 38
            Height = 19
            Caption = 'Nome'
          end
          object Label3: TLabel
            Left = 5
            Top = 109
            Width = 44
            Height = 19
            Caption = 'Cidade'
          end
          object Label5: TLabel
            Left = 713
            Top = 111
            Width = 20
            Height = 19
            Caption = 'UF'
          end
          object ed_co_cliente: TEdit
            Left = 5
            Top = 27
            Width = 85
            Height = 27
            Alignment = taCenter
            Enabled = False
            MaxLength = 240
            TabOrder = 0
          end
          object ed_no_cliente: TEdit
            Left = 5
            Top = 78
            Width = 756
            Height = 27
            MaxLength = 200
            TabOrder = 1
          end
          object ed_no_cidade: TEdit
            Left = 5
            Top = 129
            Width = 691
            Height = 27
            MaxLength = 200
            TabOrder = 2
          end
          object CBoxUf: TComboBox
            Left = 702
            Top = 128
            Width = 55
            Height = 27
            Style = csDropDownList
            CharCase = ecUpperCase
            TabOrder = 3
            Items.Strings = (
              'AC'
              'AL'
              'AP'
              'AM'
              'BA'
              'CE'
              'DF'
              'ES'
              'GO'
              'MA'
              'MT'
              'MS'
              'MG'
              'PA'
              'PB'
              'PR'
              'PE'
              'PI'
              'RJ'
              'RN'
              'RS'
              'RO'
              'RR'
              'SC'
              'SP'
              'SE'
              'TO')
          end
        end
        object Panel4: TPanel
          Left = 158
          Top = 216
          Width = 795
          Height = 361
          BorderStyle = bsSingle
          TabOrder = 2
          object Panel5: TPanel
            Left = 1
            Top = 1
            Width = 789
            Height = 80
            Align = alTop
            BorderStyle = bsSingle
            TabOrder = 0
            object lb_filtro: TLabel
              Left = 8
              Top = 23
              Width = 38
              Height = 19
              Caption = 'Nome'
            end
            object ed_procurar1: TEdit
              Left = 52
              Top = 23
              Width = 518
              Height = 27
              MaxLength = 200
              TabOrder = 0
              OnKeyDown = ed_procurar1KeyDown
            end
            object BtnProcurar: TBitBtn
              Left = 681
              Top = 3
              Width = 99
              Height = 35
              Caption = 'Procurar'
              Glyph.Data = {
                460A0000424D460A00000000000036000000280000001E0000001C0000000100
                180000000000100A0000120B0000120B00000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFF9F9F9C4CBD34885B05589B172799094797A0000FFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDEDE
                E02A669074C3E88ACBE75C8DB67882970000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB1BCC75D9CC37CCAEB
                ADEBFC81D3F83A9DDA3176AF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDEEF02A6D9A74C8ECAFEDFE85D3F63C
                AAE8217EBD335E810000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF9BACB9559BC67BCDEFAFECFD83D3F63DABE91F7FC1C2D3
                E1FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFEEF3F83980AC72C8EDADEBFD86D3F53FADED2386C86386A0FFFFFFFFFFFF
                0000D59C6AD39A6AD19768CF9566CD9165CB8E63C98C61C78860C6865EC4845D
                C2805CBF7C59BB7755B97453B87151B77052B97254BA7354BB7154AC79665E84
                A16DC3EBB0EFFF85D3F63EADEC1E81C1B9CFE0FFFFFFFFFFFFFFFFFF0000DA95
                59E6C4A7E7CCB8E6C7B1E4C4AFE1C2AEDFBFABDEBCABDDBBA9D6B3A2C69E8DB0
                816FA16F5D9D6B599C6958A27160B38476C69B8ECCA092C5A19889A2B966B2DE
                75C8F03EB0EE268FD17B9BB2FAFAFAFFFFFFFFFFFFFFFFFF0000E2A974F9F3ED
                FFFFFFFDFFFFFCFDFFFBFCFFF9FBFEF9FBFFECE9EDC7B9BBBAA79BCCBCA1DDD4
                B2E8E6C1E2DFC2CEC6B2B4A49DAE9C9DBBABADBEAEAFC3B9BC85A9C8399DDE2A
                8CCBB7CFE0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000E3A972FAF0E7FFFFFFFE
                FEFEFDFCFCFDFBFBFBFAFAE4DEE0C0ACA3CDB393ECDAAAF8F0BCFEFBC8FFFFD2
                FFFFD8FBFADAF1EED7D5CBBDA9938FA28A8AB29C9AC1B5B992BBDC736B72E6CF
                C9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000E4A972FAF0E7FFFFFFFEFEFEFDFC
                FCFFFFFFEFEAEBC4AFA9D0B28FF8E3ADFEF2BBFEF5C0FEFBC8FEFED1FEFFDAFF
                FFE3FFFFECFFFFF1E6DFD6AF9B989C8282CCB9B7E5DFE3AF684CE3C2C1FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000E5AB74FAF0E7FFFFFFFEFEFEFFFEFEFCFBFC
                D5C8C7CFB090F8DEA5FDEAB3FBE9B2FCF3BDFEFCC9FEFED3FEFEDBFEFEE4FEFE
                EDFFFFF6FFFFFEDCD5CEAC9593D5C5C5EBE2E4B56B4DE2C2C1FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000E5AD74FAF1E7FFFFFFFEFEFEFFFFFFEAE8EBCDB7A9E9
                C897FCE6ADFAE1A9FAE4ACFCF2BBFEFBC8FEFED2FEFEDBFEFEE3FEFEECFEFEF3
                FFFFFAFAF9EEC9BBB3C7B6B7EAE2E4B36B4DE2C2C1FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000E6AD75FAF1E7FFFFFFFEFEFEFFFFFFE0D9DAD1B297F9D89DFAE0
                A7F9DFA6FAEBB3FCF4C2FEFCCDFEFED4FEFED9FEFEE0FEFEE8FEFEECFEFEF0FF
                FFF1DAD1C2C4B3B0E4DCDFB36B4EE2C2C1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000E7AE76FAF1E8FFFFFFFFFFFFFDFEFEE0D4D0DBB996FBDAA0F9E0A7FAE6AE
                FBEDB7FCF2C2FDF9CDFDFDD8FEFEDCFEFEDBFEFEE1FEFEE5FEFEE7FFFFE7E8E2
                CBCBBDB5D9D1D4B56D50E2C2C1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000E8AF
                77FAF1E8FFFFFFFFFFFFFBFBFBE0D3D0E0C29FFADA9FFAE3ABFAE7B0FAE8B3FB
                ECB9FCF1BCFDFACEFEFEE1FEFED9FEFED9FEFEDDFEFEDEFFFFDFEBE7CAC9BBB2
                D4CACEB66E51E2C2C1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000E9B077FBF1E8
                FFFFFFFFFFFFFCFDFDE4D8D4E1C09DF9D79CFAE2AAFBEEB8FCF8CCFDF9DBFCF5
                D3FCF5C4FDFBD3FEFED7FEFED3FEFED5FEFED6FFFFD7ECE8C5D0C3B8D9D1D4B6
                6F52E2C2C1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000E9B277FBF2E8FFFFFFFE
                FEFEFEFFFFE8E1E1DFBF9FF8CF92FAE1A9FCF4C0FEFED5FEFFEBFEFCECFCF2C6
                FDF4C4FDFBCFFDFBCAFEFDCBFEFCCDFFFFCFE7E1BBD4C8C0E6E1E4B66F52E1C1
                C1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000EAB379FBF2E8FFFFFFFEFEFEFFFF
                FFF0EEF1E2C8B3F3C88EF9DCA2FCEFB9FEFCCCFEFFDEFEFDE0FCEFC1FDF2C0FD
                F5C4FCF3BDFDF4BFFDF8C3FEFAC5DED2B2D5CAC9EFEBEFB67052E1C1C1FFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000EAB479FBF2E8FFFFFFFEFEFEFEFFFFFBFBFD
                EBDDD6E9C398F8D194FAE5ADFBF2BEFDFBCBFEFACCFCEEBAFCF1BDFBEAB3FAE7
                B0FCECB5FEF4BCF1E4B6D7C7B6E5DDDEF1EFF1B77153E1C1C1FFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000EBB679FBF2E8FFFFFFFEFEFEFEFEFEFFFFFFF5F3F4E6
                CFBDF0C694F9D598F9E2A9FBECB5FBEEB7FAEBB5F9E3ABF9DDA5FAE4ADFCECB2
                F6E6B1DCCBB1DBD0CFF6F1F1F3F0F0B97255E1C1C1FFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF0000EBB77BFBF2E9FFFFFFFEFFFFFEFFFFFEFFFFFEFEFFF1EEEFE9D2
                BFF0C796F7D096F8D99EF9DDA2F9E0A6FADEA5F9E0A6F9E2ABF4DDAAE3CFB2DE
                D4D1F1EEF0F9F6F7F3F1F4B97356E1C1C1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                0000EDB77BFBF2E8FFFFFFFEFDFEFEFEFEFEFEFEFFFEFFFEFFFFF4F1F1EADAD0
                EDCBA9F2C794F4D099F4D49FF5D7A3F3D6A3EBCFA8E1CFBFE5DDDAF6F3F4FAF8
                F8F9F7F7F4F3F5BA7357E1C1C1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000EDB1
                6DFBE0C0FFE9D4FEE5CEFEE3CBFEE2C9FEDEC7FEDDC5FDD9C3FAD3BCF2C4AAEE
                BFA5ECC2A4EAC4A8EAC0A5E8B79CEAAA8EF2B29AFABBA3FDBDA4FBBBA2FBBBA2
                F5B5A2B95D3AE1C4C1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000EDA653FBC17C
                FFC282FEBC7BFEB674FEB06DFEAA66FEA360FE9B59FE9453FD8D4CFD8645FC81
                40F8874FFA773BFC6726FD5F1CFE5915FF510DFE4E0AFE4D0AFF4E0AF4450AB7
                3304E1CBC1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000EAA24BFBC47CFFCA86FF
                C27DFFBB76FFB370FFAC67FFA55FFF9D57FF9650FF8D47FF853EFF7D37FF7630
                FF6C26FF641DFF5B14FF530BFF4902FF4500FF4500FF4700F23C00B12F00DFC8
                BCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000E6993EF1B262F6BA6FF4B469F4AD
                63F3A65DF29F57F19950F0934AEF8C45EE853EED7E37EC7630EC6E29EA6823E9
                621DE85A16E75310E74B0AE64605E44503E64402D23D05CC856AEFE3DDFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFF0000A96E2AA86D28A76C28A56826A26525A16123
                9F5E219C5A1E99571C97531A955019934D169249149045128C42108A3F0F883C
                0C85380A8335098131077E2E057C2B027D2F09FFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000}
              TabOrder = 1
              OnClick = BtnProcurarClick
            end
            object RgFiltro: TRadioGroup
              Left = 580
              Top = 2
              Width = 99
              Height = 70
              Caption = 'Filtro'
              ItemIndex = 0
              Items.Strings = (
                'Nome'
                'C'#243'digo')
              TabOrder = 2
              OnClick = RgFiltroClick
            end
            object ed_procurar2: TEdit
              Left = 60
              Top = 23
              Width = 85
              Height = 27
              Alignment = taCenter
              MaxLength = 10
              TabOrder = 3
              OnKeyDown = ed_procurar2KeyDown
              OnKeyPress = ed_procurar2KeyPress
            end
            object BtnLimparFiltro: TBitBtn
              Left = 683
              Top = 39
              Width = 99
              Height = 35
              Caption = 'Limpar'
              Glyph.Data = {
                DE010000424DDE01000000000000760000002800000024000000120000000100
                0400000000006801000000000000000000001000000010000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
                6666666666666666666666660000666666666666666666666666666666666666
                00006FF6FF6666666666666666666666666666660000FFFFFFFF666666666666
                66666666666666660000FFFFFF8111666666666666666888666666660000FFFF
                F89111166666666666668888866666660000FFFFF91911116666666666688888
                886666660000FF6F619991110666666666687888888666660000F66669191910
                8066666666688788888866660000666666919103780666666666887888788666
                00006666666910BB3780666666666888778788660000666666663BF7B3780666
                66666687F778788600006666666663BF7B303066666666687F77888800006666
                6666663BFB0333666666666687F788880000666666666663B37B336666666666
                68787788000066666666666637BBB36666666666668777780000666666666666
                63FBBB66666666666668F7770000666666666666663FBB666666666666668F77
                0000}
              NumGlyphs = 2
              TabOrder = 4
              OnClick = BtnLimparFiltroClick
            end
          end
          object SgCliente: TStringGrid
            Left = 1
            Top = 81
            Width = 789
            Height = 275
            Align = alClient
            RowCount = 2
            TabOrder = 1
            OnClick = SgClienteClick
            ColWidths = (
              64
              64
              64
              64
              64)
            RowHeights = (
              24
              24)
          end
        end
      end
    end
  end
end
