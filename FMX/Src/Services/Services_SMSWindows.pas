unit Services_SMSWindows;

interface

uses
  Providers_Types_Mask_Format, System.Classes, System.SysUtils,
  Model_interfaces_SMS;

type

  TEnvioSmsWindows = Class(tInterfacedObject, iEnviarSMSOS)
  private
    // iGerenciadorSMS: JSMSManager;
  public
    TelefoneDestino: String;
    NomeDestino: String;

    constructor Create;
    function addCelular(Value: String): iEnviarSMSOS;
    function addContato(Value: String): iEnviarSMSOS;
    function EnviarSms: String;
  End;

implementation

{ TEnvioSmsWindows }

function TEnvioSmsWindows.addCelular(Value: String): iEnviarSMSOS;
begin
  result:=self;
  TelefoneDestino := Value;
end;

function TEnvioSmsWindows.addContato(Value: String): iEnviarSMSOS;
begin
  result:=self;
  NomeDestino := Value;
end;

constructor TEnvioSmsWindows.Create;
var
  FPermissaoSMSEnviar: String;
begin

end;

function TEnvioSmsWindows.EnviarSms: String;
var
  vTextoDestino: String;
  vTelDestino: String;
begin

  Result := '';

  if trim(TelefoneDestino) = '' then
    exit;
  vTelDestino := TMaskFormat.Celular.ExtractNumber((TelefoneDestino));
  Try
    // iGerenciadorSMS:= JSMSManager.JavaClass.getDefault;

    vTextoDestino := NomeDestino + ' Reserva de livros confirmada.';
    // iGerenciadorSMS.SendTextMessage(StringToJstring(TelefoneDestino),nil,StringToJstring(vTextoDestino)nil,nil);

  Except
    on e: Exception do
      Result := e.Message;

  End;
end;

end.
