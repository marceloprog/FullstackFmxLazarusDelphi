unit Model_interfaces_SMS;

interface

type

  iEnviarSMSOS = interface
    ['{8CE2F41E-4B4C-4B93-89D3-B0C1335DBE81}']
    function addCelular(Value:String):iEnviarSMSOS;
    function addContato(Value:String):iEnviarSMSOS;
    function EnviarSms: String;
  end;

  iFactoryEnviarSMS = interface
    ['{219A08AF-32F7-4F02-9454-3BC2D99159B2}']
    function GetEnviarSms: iEnviarSMSOS;
  end;

implementation

end.
