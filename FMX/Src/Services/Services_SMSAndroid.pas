unit Services_SMSAndroid;

interface

uses
  {Androidapi.JNI.Telephony, FMX.Platform, FMX.PhoneDialers, Sysem.permissions,
    Androidapi.JNI.JavaTypes,}
  Providers_Types_Mask_Format, System.Classes, System.SysUtils,
  Model_interfaces_SMS;

type

  TEnvioSmsAndroid = Class(tInterfacedObject, iEnviarSMSOS)
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

{ TEnvioSms }

function TEnvioSmsAndroid.addCelular(Value: String): iEnviarSMSOS;
begin
  Result:=self;
  TelefoneDestino:=value;
end;

function TEnvioSmsAndroid.addContato(Value: String): iEnviarSMSOS;
begin
 Result:=self;
 NomeDestino:=Value;
end;

constructor TEnvioSmsAndroid.Create;
var
  FPermissaoSMSEnviar: String;
begin
  //FPermissaoSMSEnviar:=JStringToString(TJManifest_permission.JavaClass.SEND_SMS);
  // PermissionService.RequestPermissions(FPermissaoSMSEnviar),nil,nil);
end;

function TEnvioSmsAndroid.EnviarSms: String;
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
