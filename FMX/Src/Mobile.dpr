program Mobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  Views_Principal in 'Views\Views_Principal.pas' {FrmPrincipal},
  Service_Principal in 'Services\Service_Principal.pas' {DMServicePrincipal: TDataModule},
  Providers_Frame_Livro in 'Providers\Frames\Providers_Frame_Livro.pas' {frameLivro: TFrame},
  Providers_Frame_Selecionado in 'Providers\Frames\Providers_Frame_Selecionado.pas' {FrameSelecionado: TFrame},
  Providers_Types_Mask_Format in 'Providers\Types\Providers_Types_Mask_Format.pas',
  Services_SMS in 'Services\Services_SMS.pas',
  Model_interfaces_SMS in 'Interfaces\Model_interfaces_SMS.pas',
  Services_SMSAndroid in 'Services\Services_SMSAndroid.pas',
  Services_SMSIOS in 'Services\Services_SMSIOS.pas',
  Services_SMSWindows in 'Services\Services_SMSWindows.pas',
  Providers_Frame_ListaReservas in 'Providers\Frames\Providers_Frame_ListaReservas.pas' {frameListaReservas: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
