unit unitFrmConfiguracoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls, IniFiles,
  unitDm, Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  System.Math;
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
    pnl_login: TPanel;
    Label7: TLabel;
    edt_senha: TEdit;
    Label8: TLabel;
    edt_login: TEdit;
    btn_logar: TBitBtn;
    Label9: TLabel;
    edt_nova_senha: TEdit;
    BitBtn1: TBitBtn;
    StringGrid: TStringGrid;
    Panel1: TPanel;
    edtFiltroMaquina: TEdit;
    edtFiltroData: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    procedure btn_enderecoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarAtualizacoesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbs_logShow(Sender: TObject);
    procedure btn_logarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: LongInt;
      Rect: TRect; State: TGridDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure edtFiltroMaquinaChange(Sender: TObject);
    procedure edtFiltroDataChange(Sender: TObject);
  private
    FenderecoBanco: string;
    Fconfirmado: boolean;
    FNomeDoExecutavel: string;
    FCaminhoOrigem: string;
    FLogOriginal: TStringList;
    procedure prc_atualizar_dados;
    procedure prc_logar;
    procedure CarregarLog;
    procedure configurarGrid;
    procedure AplicarFiltro;
    function CompararVersao(const V1, V2: string): Integer;
    { Private declarations }
  public
    property enderecoBanco: string read FenderecoBanco write FenderecoBanco;
    property confirmado: boolean read Fconfirmado write Fconfirmado;
    property NomeDoExecutavel: string read FNomeDoExecutavel write FNomeDoExecutavel;
    property CaminhoOrigem: string read FCaminhoOrigem write FCaminhoOrigem;
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

{$R *.dfm}

procedure TfrmConfiguracoes.BitBtn1Click(Sender: TObject);
begin
  close;
end;

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
  {validações}
  if edt_nome_app.text = '' then
  begin
    ShowMessage('Informe o nome do APlicativo a ser Atualizado') ;
    edt_nome_app.SetFocus;
    exit;
  end;

  if lbl_endereco_origem.Caption = 'C:\' then
  begin
    ShowMessage('Informe o endereço onde a nova versão do se encontra') ;
    btn_endereco.Click;
    exit;
  end;

  if edt_nova_versao.Text = trim('') then
  begin
    ShowMessage('Informe a versão');
    edt_nova_versao.SetFocus;
    Exit;
  end;

  if CompararVersao(edt_nova_versao.Text, lbl_versao_atual.Caption) < 0 then
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


function TfrmConfiguracoes.CompararVersao(const V1, V2: string): Integer;
var
  A1, A2: TArray<string>;
  i, N1, N2: Integer;
begin
  A1 := V1.Split(['.']);
  A2 := V2.Split(['.']);

  for i := 0 to Max(Length(A1), Length(A2)) - 1 do
  begin
    if i < Length(A1) then
      N1 := StrToIntDef(A1[i], 0)
    else
      N1 := 0;

    if i < Length(A2) then
      N2 := StrToIntDef(A2[i], 0)
    else
      N2 := 0;

    if N1 < N2 then Exit(-1);
    if N1 > N2 then Exit(1);
  end;

  Result := 0; // iguais
end;

procedure TfrmConfiguracoes.FormCreate(Sender: TObject);
begin
  confirmado := false;
  FLogOriginal := TStringList.Create;
end;

procedure TfrmConfiguracoes.FormDestroy(Sender: TObject);
begin
 FLogOriginal.Free;
end;

procedure TfrmConfiguracoes.FormShow(Sender: TObject);
begin
  pnl_fundo.Enabled := false;
  pnl_login.Visible := true;
end;

procedure TfrmConfiguracoes.prc_logar;
var
  Config: TStringList;
begin

  // vem do arquivo ini
  Config := dm.LerConfiguracoes;

  if ((Config.Values['USUARIO'] <> edt_login.Text) or
      (Config.Values['SENHA'] <> edt_senha.Text)) then
  begin
    ShowMessage('E-mail ou Senha Inválido');
    close;
    exit;
  end else
  begin
    lbl_endereco_origem.Caption := Config.Values['ENDERECO_APP'];
    edt_nome_app.text := Config.Values['NOME_APP'];
    lbl_versao_atual.Caption := Config.Values['VERSAO'];
    edt_nova_versao.text := Config.Values['VERSAO'];
    edt_descricao.text := Config.Values['DESCRICAO'];

    NomeDoExecutavel := Config.Values['NOME_APP'];
    CaminhoOrigem    := Config.Values['ENDERECO_APP'];// 'Y:\Teste AT\';

    pnl_fundo.Enabled := true;
    pnl_login.Visible := false;

  end;

end;


procedure TfrmConfiguracoes.StringGridDrawCell(Sender: TObject; ACol,
  ARow: LongInt; Rect: TRect; State: TGridDrawState);
var
  R: TRect;
  Texto: string;
  Flags: Integer;
begin
  with StringGrid.Canvas do
  begin
    // Fundo
    if ARow = 0 then
    begin
      Brush.Color := $00D6D6D6;
      Font.Style := [fsBold];
    end
    else
    begin
      if Odd(ARow) then
        Brush.Color := $00F5F5F5
      else
        Brush.Color := clWhite;

      Font.Style := [];
    end;

    // Seleção
    if gdSelected in State then
      Brush.Color := $00FFD580;

    FillRect(Rect);

    Texto := StringGrid.Cells[ACol, ARow];

    // margem interna
    R := Rect;
    InflateRect(R, -5, 0);

    // alinhamento
    if ACol = 3 then
      Flags := DT_RIGHT
    else
      Flags := DT_LEFT;

    // desenho seguro (NÃO SANGRA)
   DrawText(
  StringGrid.Canvas.Handle,
  PChar(Texto),
  Length(Texto),
  R,
  Flags or DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS
  );
  end;
end;

procedure TfrmConfiguracoes.prc_atualizar_dados;
begin
  // salva IniFile
  dm.SalvarVersao(edt_nova_versao.Text, edt_login.text, edt_nova_senha.text,edt_nome_app.Text, lbl_endereco_origem.Caption, edt_descricao.Text);
end;



procedure TfrmConfiguracoes.tbs_logShow(Sender: TObject);
begin
 // listar log a partir de um txt


 configurarGrid;
 CarregarLog;
end;

procedure TfrmConfiguracoes.configurarGrid;
begin
  StringGrid.DefaultDrawing := False;
  StringGrid.ColCount := 4;
  StringGrid.FixedRows := 1;

  StringGrid.Options := StringGrid.Options + [goRowSelect];
  StringGrid.DefaultRowHeight := 25;

  // Cabeçalho
  StringGrid.Cells[0,0] := 'Data/Hora';
  StringGrid.Cells[1,0] := 'Máquina';
  StringGrid.Cells[2,0] := 'Usuário';
  StringGrid.Cells[3,0] := 'Versão';

  // Largura das colunas
  StringGrid.ColWidths[0] := 150;
  StringGrid.ColWidths[1] := 120;
  StringGrid.ColWidths[2] := 120;
  StringGrid.ColWidths[3] := 100;
end;


procedure TfrmConfiguracoes.edtFiltroDataChange(Sender: TObject);
begin
  AplicarFiltro;
end;

procedure TfrmConfiguracoes.edtFiltroMaquinaChange(Sender: TObject);
begin
  AplicarFiltro;
end;

procedure TfrmConfiguracoes.CarregarLog;
var
  Lista: TStringList;
  i: Integer;
  Linha, DataHora, Maquina, Usuario, Versao: string;
  Partes: TArray<string>;
begin
  FLogOriginal.Clear;
  FLogOriginal.LoadFromFile(
    IncludeTrailingPathDelimiter(CaminhoOrigem) + 'LogAtualizador.txt'
  );

  AplicarFiltro;
end;


procedure TfrmConfiguracoes.AplicarFiltro;
var
  i, LinhaGrid: Integer;
  Linha, DataHora, Maquina, Usuario, Versao: string;
  Partes: TArray<string>;
  FiltroMaquina, FiltroData: string;
begin
  FiltroMaquina := UpperCase(Trim(edtFiltroMaquina.Text));
  FiltroData    := Trim(edtFiltroData.Text); // formato: YYYY-MM-DD

  StringGrid.RowCount := 1;
  LinhaGrid := 1;

  for i := 0 to FLogOriginal.Count - 1 do
  begin
    Linha := FLogOriginal[i];
    Partes := Linha.Split(['|']);

    if Length(Partes) < 4 then Continue;

    DataHora := Trim(Partes[0]);
    Maquina  := Trim(Partes[1]);
    Usuario  := Trim(StringReplace(Partes[2], 'Usuario:', '', []));
    Versao   := Trim(StringReplace(Partes[3], 'Versao:', '', []));

    //FILTRO
    if (FiltroMaquina <> '') and
       (Pos(FiltroMaquina, UpperCase(Maquina)) = 0) then
      Continue;

    if (FiltroData <> '') and
       (Pos(FiltroData, DataHora) = 0) then
      Continue;

    // adiciona no grid
    StringGrid.RowCount := LinhaGrid + 1;

    StringGrid.Cells[0, LinhaGrid] := DataHora;
    StringGrid.Cells[1, LinhaGrid] := Maquina;
    StringGrid.Cells[2, LinhaGrid] := Usuario;
    StringGrid.Cells[3, LinhaGrid] := Versao;

    Inc(LinhaGrid);
  end;
end;


end.
