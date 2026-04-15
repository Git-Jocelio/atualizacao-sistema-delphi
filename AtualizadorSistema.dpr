program AtualizadorSistema;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {frmPrincipal},
  unitFrmConfiguracoes in 'unitFrmConfiguracoes.pas' {frmConfiguracoes},
  unitDm in 'unitDm.pas' {dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
