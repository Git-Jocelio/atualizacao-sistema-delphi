object frmConfiguracoes: TfrmConfiguracoes
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Configura'#231#245'es'
  ClientHeight = 388
  ClientWidth = 780
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 780
    Height = 388
    ActivePage = tbs_configuracoes
    Align = alClient
    TabOrder = 0
    object tbs_configuracoes: TTabSheet
      Caption = 'Configura'#231#245'es'
      object pnl_fundo: TPanel
        AlignWithMargins = True
        Left = 10
        Top = 10
        Width = 752
        Height = 338
        Margins.Left = 10
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 10
        Align = alClient
        BevelOuter = bvNone
        Color = 15263976
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 142
          Top = 94
          Width = 218
          Height = 15
          Caption = 'Endere'#231'o onde se encontra a nova vers'#227'o'
        end
        object btn_endereco: TSpeedButton
          Left = 140
          Top = 121
          Width = 23
          Height = 22
          OnClick = btn_enderecoClick
        end
        object lbl_endereco_origem: TLabel
          Left = 169
          Top = 118
          Width = 15
          Height = 15
          Caption = 'C:\'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 142
          Top = 153
          Width = 67
          Height = 15
          Caption = 'Vers'#227'o atual:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl_versao_atual: TLabel
          Left = 217
          Top = 151
          Width = 27
          Height = 17
          Caption = '100.1'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 142
          Top = 188
          Width = 72
          Height = 15
          Caption = 'Vers'#227'o Nova :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btnSalvarAtualizacoes: TSpeedButton
          Left = 142
          Top = 299
          Width = 153
          Height = 29
          Caption = 'Confirme as atualiza'#231#245'es'
          OnClick = btnSalvarAtualizacoesClick
        end
        object Label3: TLabel
          Left = 142
          Top = 227
          Width = 58
          Height = 15
          Caption = 'Descri'#231#227'o :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 142
          Top = 53
          Width = 75
          Height = 15
          Caption = 'Nome do App'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 0
          Top = 0
          Width = 752
          Height = 32
          Align = alTop
          Alignment = taCenter
          Caption = 'Configura'#231#245'es'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 153
        end
        object Label9: TLabel
          Left = 142
          Top = 264
          Width = 64
          Height = 15
          Caption = 'Nova Senha'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btnFechar: TBitBtn
          Left = 294
          Top = 299
          Width = 155
          Height = 29
          Caption = 'Sair de configura'#231#245'es'
          TabOrder = 0
          OnClick = btnFecharClick
        end
        object edt_nova_versao: TEdit
          Left = 225
          Top = 185
          Width = 394
          Height = 23
          TabOrder = 1
          Text = 'Informe a nova vers'#227'o do app'
        end
        object edt_descricao: TEdit
          Left = 225
          Top = 224
          Width = 394
          Height = 23
          TabOrder = 2
          TextHint = 'Descreva as novas funcionalidades'
        end
        object edt_nome_app: TEdit
          Left = 225
          Top = 48
          Width = 394
          Height = 23
          TabOrder = 3
          TextHint = 'Informe o nome do app'
        end
        object edt_nova_senha: TEdit
          Left = 225
          Top = 261
          Width = 394
          Height = 23
          TabOrder = 4
          TextHint = 'Trocar de senha'
        end
      end
    end
    object tbs_log: TTabSheet
      Caption = 'Logs de Atualiza'#231#245'es'
      ImageIndex = 1
      OnShow = tbs_logShow
      object pnl_config: TPanel
        Left = 0
        Top = 0
        Width = 772
        Height = 358
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object StringGrid: TStringGrid
          Left = 0
          Top = 41
          Width = 772
          Height = 317
          Align = alClient
          FixedRows = 0
          TabOrder = 0
          OnDrawCell = StringGridDrawCell
          RowHeights = (
            24
            24
            24
            24
            24)
        end
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 772
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Label10: TLabel
            Left = 252
            Top = 12
            Width = 47
            Height = 15
            Caption = 'M'#225'quina'
          end
          object Label11: TLabel
            Left = 16
            Top = 12
            Width = 24
            Height = 15
            Caption = 'Data'
          end
          object edtFiltroMaquina: TEdit
            Left = 336
            Top = 12
            Width = 121
            Height = 23
            TabOrder = 0
            OnChange = edtFiltroMaquinaChange
          end
          object edtFiltroData: TEdit
            Left = 56
            Top = 9
            Width = 121
            Height = 23
            TabOrder = 1
            OnChange = edtFiltroDataChange
          end
        end
      end
    end
  end
  object pnl_login: TPanel
    AlignWithMargins = True
    Left = 264
    Top = 113
    Width = 265
    Height = 224
    Margins.Left = 10
    Margins.Top = 35
    Margins.Right = 10
    Margins.Bottom = 15
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    Visible = False
    object Label7: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 83
      Width = 245
      Height = 21
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Align = alTop
      Caption = 'Senha'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 44
    end
    object Label8: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 10
      Width = 245
      Height = 21
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Align = alTop
      Caption = 'Login'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 41
    end
    object edt_senha: TEdit
      AlignWithMargins = True
      Left = 10
      Top = 117
      Width = 245
      Height = 29
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 0
      Text = '12345678'
    end
    object edt_login: TEdit
      AlignWithMargins = True
      Left = 10
      Top = 44
      Width = 245
      Height = 29
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'Admin'
    end
    object btn_logar: TBitBtn
      AlignWithMargins = True
      Left = 10
      Top = 156
      Width = 245
      Height = 25
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Logar'
      TabOrder = 2
      OnClick = btn_logarClick
    end
    object BitBtn1: TBitBtn
      AlignWithMargins = True
      Left = 10
      Top = 191
      Width = 245
      Height = 25
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Sair de login'
      TabOrder = 3
      OnClick = BitBtn1Click
    end
  end
  object OpenDialog: TOpenDialog
    Left = 138
    Top = 98
  end
end
