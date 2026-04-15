unit unitDm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, IniFiles, vcl.Forms;

type
  Tdm = class(TDataModule)
    Conn: TFDConnection;
    qry: TFDQuery;
  private

  public
    function LerConfiguracoes: TStringList;
    procedure SalvarVersao(const AVersao, AUsuario, ANomeAPP, AEndereco: string);

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
  CaminhoINI := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'config.ini';

  // Verifica se o arquivo existe para evitar erros
  if not FileExists(CaminhoINI) then Exit;

  Ini := TIniFile.Create(CaminhoINI);
  try
    // O segundo parâmetro é o valor padrão caso a chave não exista
    Result.Values['VERSAO']   := Ini.ReadString('SISTEMA', 'VERSAO', '0');
    Result.Values['USUARIO']  := Ini.ReadString('SISTEMA', 'USUARIO', '');
    Result.Values['NOME_APP'] := Ini.ReadString('SISTEMA', 'NOME_APP', '');
    Result.Values['ENDERECO'] := Ini.ReadString('SISTEMA', 'ENDERECO_APP', '');
  finally
    Ini.Free;
  end;
end;


procedure Tdm.SalvarVersao(const AVersao, AUsuario, ANomeAPP, AEndereco: string);
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
    Ini.WriteString('SISTEMA', 'USUARIO', AUsuario);
    Ini.WriteString('SISTEMA', 'NOME_APP', ANomeAPP);
    Ini.WriteString('SISTEMA', 'ENDERECO_APP', AEndereco);
  finally
    Ini.Free;
  end;
end;


end.
