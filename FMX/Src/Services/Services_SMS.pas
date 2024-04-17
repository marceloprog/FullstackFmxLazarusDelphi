unit Services_SMS;

interface

uses
  {Androidapi.JNI.Telephony, FMX.Platform, FMX.PhoneDialers, Sysem.permissions,
    Androidapi.JNI.JavaTypes,}
  Providers_Types_Mask_Format, System.Classes, System.SysUtils,
  Model_interfaces_SMS;

type

  TEnvioSms = Class(tInterfacedObject, iFactoryEnviarSMS)
  private
    // iGerenciadorSMS: JSMSManager;
    FEnvioSMS: iEnviarSMSOS;
  public

    constructor Create;
    function GetEnviarSms: iEnviarSMSOS;
    class function New: iFactoryEnviarSMS;

  End;

implementation

uses
  FMX.Dialogs, Services_SMSAndroid,Services_SMSIOS,
  Services_SMSWindows;

{ TEnvioSms }

constructor TEnvioSms.Create;
begin
{$IF DEFINED (ANDROID)}
  FEnvioSMS := TEnvioSmsAndroid.Create;
{$ENDIF}
{$IF DEFINED  (IOS)}
  FEnvioSMS := TEnvioSmsIOS.Create;
{$ENDIF}
{$IF DEFINED (MSWINDOWS)}
    FEnvioSMS := TEnvioSmsWindows.create;
{$ENDIF}
end;

function TEnvioSms.GetEnviarSms: iEnviarSMSOS;
begin
  Result := FEnvioSMS;
end;

class function TEnvioSms.New: iFactoryEnviarSMS;
begin
  Result := Self.Create;

end;

end.
