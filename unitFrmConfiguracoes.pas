unit unitFrmConfiguracoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls, IniFiles,
  unitDm, Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmConfiguracoes = class(TForm)
    OpenDialog: TOpenDialog;
    PageControl1: TPageControl;
    tbs_configuracoes: TTabSheet;
    tbs_log: TTabSheet;
    pnl_fundo: TPanel;
    Label1: TLabel;
    btn_endereco: TSpeedButton;
    lbl_endereco_origem: TLabel;
    Label2: TLabel;
    lbl_versao_atual: TLabel;
    Label4: TLabel;
    btnSalvarAtualizacoes: TSpeedButton;
    Label3: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    btnFechar: TBitBtn;
    edt_nova_versao: TEdit;
    edt_descricao: TEdit;
    edt_nome_app: TEdit;
    pnl_config: TPanel;
    dbg_log: TDBGrid;
    DataSource: TDataSource;
    pnl_login: TPanel;
    Label7: TLabel;
    edt_senha: TEdit;
    Label8: TLabel;
    edt_login: TEdit;
    btn_logar: TBitBtn;
    procedure btn_enderecoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarAtualizacoesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure tbs_logShow(Sender: TObject);
    procedure btn_logarClick(Sender: TObject);
  private
    FenderecoBanco: string;
    Fconfirmado: boolean;
    //function GetVersaoServidor: Integer;
    //procedure SalvarVersao(const AVersao: string);
    procedure prc_atualizar_dados;
    procedure prc_logar;
    { Private declarations }
  public
    property enderecoBanco: string read FenderecoBanco write FenderecoBanco;
    property confirmado: boolean read Fconfirmado write Fconfirmado;
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

{$R *.dfm}

procedure TfrmConfiguracoes.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmConfiguracoes.btn_enderecoClick(Sender: TObject);
begin
 if OpenDialog.Execute then
  begin
    {inclui a \ no final}
    enderecoBanco :=IncludeTrailingPathDelimiter( ExtractFilePath(OpenDialog.FileName) );

    lbl_endereco_origem.Caption := enderecoBanco;
  end;
end;


procedure TfrmConfiguracoes.btn_logarClick(Sender: TObject);
begin
  prc_logar;
end;

procedure TfrmConfiguracoes.btnSalvarAtualizacoesClick(Sender: TObject);
begin
  if strtoint(edt_nova_versao.text) < strtoint(lbl_versao_atual.Caption) then
  begin
    ShowMessage('Versão inválida') ;
    edt_nova_versao.Text := lbl_versao_atual.Caption;
    exit;
  end;

  confirmado := true;

  try
    //SalvarVersao(edt_nova_versao.Text);
    prc_atualizar_dados;
    ShowMessage('Versão salva com sucesso!');
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;

  close;
end;

procedure TfrmConfiguracoes.FormCreate(Sender: TObject);
begin
  confirmado := false;
end;

procedure TfrmConfiguracoes.FormShow(Sender: TObject);
begin

  pnl_fundo.Enabled := false;
  pnl_login.Visible := true;


end;

procedure TfrmConfiguracoes.prc_logar;
begin
(*
  dm.qry.sql.Clear;
  dm.qry.open('select * from versao_app');

  if ((dm.qry.fieldbyname('USUARIO').AsString <> edt_login.Text) or
      (dm.qry.fieldbyname('SENHA').AsString <> edt_senha.Text)) then
  begin
    ShowMessage('E-mail ou Senha Inválido');
    close;
    exit;
  end else
  begin
    pnl_fundo.Enabled := true;
    pnl_login.Visible   := false;
    edt_nome_app.text := dm.qry.fieldbyname('NOME_APP').AsString;
    lbl_endereco_origem.Caption := dm.qry.fieldbyname('ENDERECO_APP').AsString;
    lbl_versao_atual.Caption := dm.qry.fieldbyname('VERSAO').AsString;
    edt_nova_versao.text := dm.qry.fieldbyname('VERSAO').AsString;
    edt_descricao.text := dm.qry.fieldbyname('DESCRICAO').AsString;
    edt_nome_app.text := dm.qry.fieldbyname('NOME_APP').AsString;
  end;
*)

  if ((dm.qry.fieldbyname('USUARIO').AsString <> edt_login.Text) or
      (dm.qry.fieldbyname('SENHA').AsString <> edt_senha.Text)) then
  begin
    ShowMessage('E-mail ou Senha Inválido');
    close;
    exit;
  end else
  begin
    pnl_fundo.Enabled := true;
    pnl_login.Visible   := false;
    edt_nome_app.text := dm.qry.fieldbyname('NOME_APP').AsString;
    lbl_endereco_origem.Caption := dm.qry.fieldbyname('ENDERECO_APP').AsString;
    lbl_versao_atual.Caption := dm.qry.fieldbyname('VERSAO').AsString;
    edt_nova_versao.text := dm.qry.fieldbyname('VERSAO').AsString;
    edt_descricao.text := dm.qry.fieldbyname('DESCRICAO').AsString;
    edt_nome_app.text := dm.qry.fieldbyname('NOME_APP').AsString;
  end;



end;


procedure TfrmConfiguracoes.PageControl1Change(Sender: TObject);
begin

end;

(*
function TfrmConfiguracoes.GetVersaoServidor: Integer;
var
  Ini: TIniFile;
  CaminhoINI: string;
  ValorStr: string;
begin
  CaminhoINI :=
    IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) +
    'config.ini';

  if not FileExists(CaminhoINI) then
    raise Exception.Create('Arquivo config.ini não encontrado.');

  Ini := TIniFile.Create(CaminhoINI);
  try
    ValorStr := Ini.ReadString('SISTEMA', 'VERSAO', '');

    if Trim(ValorStr) = '' then
      raise Exception.Create('VERSAO não encontrada no config.ini.');

    if not TryStrToInt(ValorStr, Result) then
      raise Exception.Create('VERSAO inválida no config.ini.');

  finally
    Ini.Free;
  end;
end;
*)

(*
procedure TfrmConfiguracoes.SalvarVersao(const AVersao: string);
var
  Ini: TIniFile;
  CaminhoINI: string;
  ValorInt: Integer;
begin
  CaminhoINI :=
    IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) +
    'config.ini';

  if Trim(AVersao) = '' then
    raise Exception.Create('Informe uma versão válida.');

  if not TryStrToInt(AVersao, ValorInt) then
    raise Exception.Create('A versão deve ser numérica.');

  Ini := TIniFile.Create(CaminhoINI);
  try
    Ini.WriteString('SISTEMA', 'VERSAO', AVersao);
  finally
    Ini.Free;
  end;
end;

*)

procedure TfrmConfiguracoes.prc_atualizar_dados;
begin
(*
  dm.qry.sql.Clear;
  dm.qry.sql.add('update versao_app set DATA_HORA =:DATA_HORA, VERSAO=:VERSAO, ');
  dm.qry.sql.add('  DESCRICAO=:DESCRICAO, NOME_APP=:NOME_APP, ENDERECO_APP=:ENDERECO_APP');
  dm.qry.sql.add('  WHERE ID=:ID');

  dm.qry.ParamByName('DATA_HORA').AsDateTime := Time;
  dm.qry.ParamByName('VERSAO').AsString := edt_nova_versao.Text;
  dm.qry.ParamByName('DESCRICAO').AsString := edt_descricao.text;

  dm.qry.ParamByName('NOME_APP').AsString := edt_nome_app.text;
  dm.qry.ParamByName('ENDERECO_APP').AsString := lbl_endereco_origem.Caption;
  dm.qry.ParamByName('ID').AsInteger := 1;

  dm.qry.ExecSQL;
*)

  dm.SalvarVersao(edt_nova_versao.Text, edt_login.text, edt_nome_app.Text, lbl_endereco_origem.Caption);

end;



procedure TfrmConfiguracoes.tbs_logShow(Sender: TObject);
begin
  dm.qry.SQL.Clear;
  dm.qry.Open('select * from UPDATE_LOG order by id');
end;

end.
