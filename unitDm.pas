unit unitDm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, IniFiles, vcl.Forms, vcl.dialogs;

type
  Tdm = class(TDataModule)
    Conn: TFDConnection;
    qry: TFDQuery;
  private

  public
    function LerConfiguracoes: TStringList;
    procedure SalvarVersao(const AVersao, AUsuario, ASenha, ANomeAPP, AEndereco, ADescricao: string);

  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}




function Tdm.LerConfiguracoes: TStringList;
var
  Ini: TIniFile;
  CaminhoINI: string;
begin
  Result := TStringList.Create;
//  CaminhoINI := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'config.ini';
  CaminhoINI := 'Y:\Teste AT\config.ini';
  // Verifica se o arquivo existe para evitar erros
  if not FileExists(CaminhoINI) then Exit;

  Ini := TIniFile.Create(CaminhoINI);
  try
//showmessage('lendo o ini') ;
    // O segundo parâmetro é o valor padrão caso a chave não exista
    Result.Values['VERSAO']   := Ini.ReadString('SISTEMA', 'VERSAO', '0.0.0.0');
    Result.Values['USUARIO']  := Ini.ReadString('SISTEMA', 'USUARIO', '');
    Result.Values['SENHA']  := Ini.ReadString('SISTEMA', 'SENHA', '');
    Result.Values['NOME_APP'] := Ini.ReadString('SISTEMA', 'NOME_APP', '');
    Result.Values['ENDERECO_APP'] := Ini.ReadString('SISTEMA', 'ENDERECO_APP', '');
    Result.Values['DESCRICAO'] := Ini.ReadString('SISTEMA', 'DESCRICAO', '');
  finally
    Ini.Free;
  end;
end;


procedure Tdm.SalvarVersao(const AVersao, AUsuario, ASenha, ANomeAPP, AEndereco, ADescricao: string);
var
  Ini: TIniFile;
  CaminhoINI: string;
  ValorInt: Integer;
begin
  //CaminhoINI := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'config.ini';
  CaminhoINI := 'Y:\Teste AT\' + 'config.ini';

  if Trim(AVersao) = '' then
    raise Exception.Create('Informe uma versão válida.');

  Ini := TIniFile.Create(CaminhoINI);
  try
//ShowMessage('alterando dados');
    Ini.WriteString('SISTEMA', 'VERSAO', AVersao);
    Ini.WriteString('SISTEMA', 'USUARIO', AUsuario);
    //Ini.WriteString('SISTEMA', 'SENHA', ASenha);
    Ini.WriteString('SISTEMA', 'NOME_APP', ANomeAPP);
    Ini.WriteString('SISTEMA', 'ENDERECO_APP', AEndereco);
    Ini.WriteString('SISTEMA', 'DESCRICAO', ADescricao);
  finally
    Ini.Free;
  end;
end;


end.
