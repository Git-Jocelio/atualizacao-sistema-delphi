unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShellAPI, DateUtils,
  Vcl.Buttons, TlHelp32, Vcl.ExtCtrls, Vcl.Menus, unitFrmConfiguracoes, System.IOUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, IdStack, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, IdIPWatch, unitDm;

type
  TfrmPrincipal = class(TForm)
    pnlLateral: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    lbl_versao: TLabel;
    ImgLogo: TImage;
    lblAbrirConfiguracoes: TLabel;
    lblcaminhoOrigiem: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblNomeExecutável: TLabel;
    Panel2: TPanel;
    Bevel: TBevel;
    Label2: TLabel;
    btn_atualizar_agora: TPanel;
    btn_atualizar_depois: TPanel;
    Panel3: TPanel;
    Label7: TLabel;
    lbl_usuario: TLabel;
    procedure pnl_botaoFecharClick(Sender: TObject);
    procedure btn_atualizar_agoraClick(Sender: TObject);
    procedure lblAbrirConfiguracoesClick(Sender: TObject);
    procedure btn_atualizar_depoisClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    FNomeDoExecutavel: string;
    FCaminhoOrigem: string;
    FNovaVersao: string;
    FDescricao: string;
    procedure CopiarArquivoRede(const ArquivoRede, ArquivoLocal: string);
    procedure RenomearArquivo(const NomeAntigo, NomeNovo: string);
    function processExists(exeFileName: string): Boolean;
    procedure prc_atualizar_tela;
    procedure GravarLogAtualizacao(const Versao, Descricao: string);
    { Private declarations }
  public
    {Recebido por parametro da tela de confirurações}
    property NomeDoExecutavel: string read FNomeDoExecutavel write FNomeDoExecutavel;
    property CaminhoOrigem: string read FCaminhoOrigem write FCaminhoOrigem;
    property NovaVersao: string read FNovaVersao write FNovaVersao;
    property Descricao: string read FDescricao write FDescricao;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.CopiarArquivoRede(const ArquivoRede, ArquivoLocal: string);
var ano, mes, dia : word;
    hora : string;
    horas: TDate;
    data : string;
    CaminhoBase: string;
begin
  CaminhoBase := ExtractFilePath(Application.ExeName);

  try
    DecodeDate(date,ano,mes, dia);
    horas := now;
    hora  := FormatDateTime('hhmmss', horas);

    data := inttostr( ano ) + FormatFloat('00',mes)+ FormatFloat('00',dia) +  '_' + hora +'_' ;
    if FileExists(ArquivoRede) then
    begin
      RenomearArquivo( CaminhoBase + NomeDoExecutavel,
                       CaminhoBase + data + ChangeFileExt(NomeDoExecutavel, '.old'))  ;


      TFile.Copy(ArquivoRede, ArquivoLocal, True);

      {gravar log}
      //jocelio aqui passar a versão por variavel: corrigir depois
      ShowMessage('Descricao recebida: ' + Descricao);
      GravarLogAtualizacao(NovaVersao, Descricao);

      ShellExecute(
        Handle,
        PChar('open'),
        PChar(CaminhoBase + NomeDoExecutavel),
        nil,
        PChar(CaminhoBase),
        SW_SHOWNORMAL
      );
    //  ShowMessage('Sistema atualizado com sucesso.') ;
    end
    else
      ShowMessage('Erro: Arquivo na rede não encontrado.');
  except
      on E: Exception do
        ShowMessage('Erro ao atualizar: ' + E.Message);
  end;

  sleep(1000);
  close;

end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FreeAndNil(frmPrincipal);
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  prc_atualizar_tela;
end;

procedure TfrmPrincipal.prc_atualizar_tela;
var
  Config: TStringList;
begin
  // vem do banco
(*
  dm.qry.sql.Clear;
  dm.qry.open('select * from versao_app');
  lbl_user.Caption   := dm.qry.fieldbyname('USUARIO').AsString;
  lbl_versao.Caption := 'Versão' + dm.qry.fieldbyname('VERSAO').AsString ;
  NomeDoExecutavel   := dm.qry.fieldbyname('NOME_APP').AsString;//'Aplicacao.exe';
  CaminhoOrigem      := dm.qry.fieldbyname('ENDERECO_APP').AsString;// 'Y:\Teste AT\';
  lblNomeExecutável.Caption := NomeDoExecutavel;
  lblcaminhoOrigiem.Caption := CaminhoOrigem;
*)

  // ler configurações do inifile
  Config := dm.LerConfiguracoes;
  // atualizar variaveis
  CaminhoOrigem    := Config.Values['ENDERECO_APP']+'\';// 'Y:\Teste AT\';
  NomeDoExecutavel := Config.Values['NOME_APP'];

  // atualizar componentes visuais
  lbl_usuario.Caption   := Config.Values['USUARIO'];
  lbl_versao.Caption    := 'Versão' + Config.Values['VERSAO'] ;
  lblNomeExecutável.Caption := NomeDoExecutavel;
  lblcaminhoOrigiem.Caption := CaminhoOrigem;

end;

procedure TfrmPrincipal.lblAbrirConfiguracoesClick(Sender: TObject);
begin
  try
    if frmConfiguracoes = NIL then
    begin
      frmConfiguracoes := TfrmConfiguracoes.Create(self);
      frmConfiguracoes.lbl_endereco_origem.Caption := CaminhoOrigem;
      frmConfiguracoes.ShowModal;
      if frmConfiguracoes.confirmado then
      begin
        if frmConfiguracoes.enderecoBanco <> '' then
        begin
          CaminhoOrigem := frmConfiguracoes.enderecoBanco;
          lblcaminhoOrigiem.Caption := frmConfiguracoes.CaminhoOrigem;
        end;
        NomeDoExecutavel := frmConfiguracoes.NomeDoExecutavel;
        CaminhoOrigem    := frmConfiguracoes.CaminhoOrigem;
        NovaVersao       := frmConfiguracoes.edt_nova_versao.Text;
        Descricao       := frmConfiguracoes.edt_descricao.Text;

        prc_atualizar_tela;
        btn_atualizar_agora.Caption := 'Atualizar para versão :' + NovaVersao;

      end;
    end;
  finally
    freeandnil(frmConfiguracoes);
  end;
end;

procedure TfrmPrincipal.btn_atualizar_depoisClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.pnl_botaoFecharClick(Sender: TObject);
begin
  CLOSE;
end;

procedure TfrmPrincipal.btn_atualizar_agoraClick(Sender: TObject);
var
  caminhoLocal: string;
begin

  // pasta e executável à atualizar
  caminhoLocal:= ExtractFilePath(Application.ExeName) + NomeDoExecutavel;

  {Só atualiza se o sistema estiver fechado}
  if not processExists(NomeDoExecutavel) then
    begin
    CopiarArquivoRede( CaminhoOrigem + NomeDoExecutavel, caminhoLocal);
  end
  else
  begin
    ShowMessage('Feche a aplicação SIGECORP e tente novamente mais tarde !')
  end;

end;

procedure TfrmPrincipal.RenomearArquivo(const NomeAntigo, NomeNovo: string);
begin
  if FileExists(NomeAntigo) then
  begin
    if not RenameFile(NomeAntigo, NomeNovo) then
      raise Exception.Create('Erro ao renomear arquivo.');
  end
  else
    ShowMessage('Erro: Arquivo não encontrado.');
end;


{verifica se a aplicação esta rodando}
function TfrmPrincipal.processExists(exeFileName: string): Boolean;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := False;

  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if FSnapshotHandle = INVALID_HANDLE_VALUE then Exit;

  try
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);

    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

    while ContinueLoop do
    begin
      if UpperCase(FProcessEntry32.szExeFile) = UpperCase(exeFileName) then
      begin
        Result := True;
        Break;
      end;

      ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    end;

  finally
    CloseHandle(FSnapshotHandle);
  end;
end;



procedure TfrmPrincipal.GravarLogAtualizacao(const Versao, Descricao: string);
var
  CaminhoLog: string;
  Linha: string;
  FS: TFileStream;
  Bytes: TBytes;
begin
  CaminhoLog := 'Y:\Teste AT\LogAtualizador.txt';

  Linha := Format('%s | %s | Usuario: %s | Versao: %s | Descricao: %s%s',
    [
      FormatDateTime('yyyy-mm-dd hh:nn:ss', Now),
      GetEnvironmentVariable('COMPUTERNAME'),
      GetEnvironmentVariable('USERNAME'),
      Versao,
      'Descricao',
      sLineBreak
    ]);

  if not FileExists(CaminhoLog) then
    TFile.WriteAllText(CaminhoLog, '');

  FS := TFileStream.Create(CaminhoLog, fmOpenReadWrite or fmShareDenyNone);
  try
    FS.Seek(0, soEnd);
    Bytes := TEncoding.UTF8.GetBytes(Linha);
    FS.WriteBuffer(Bytes, Length(Bytes));
  finally
    FS.Free;
  end;
end;

end.
