unit Providers_Connection;

{$mode Delphi}

interface

uses
  Classes, SysUtils, ZConnection, inifiles;

type

  { TProviderConnection }

  TProviderConnection = class(TDataModule)
    ZConnection: TZConnection;
  private
    procedure ConfigurarConexao;
  public
    constructor Create; reintroduce;
  end;

var
  ProviderConnection: TProviderConnection;

implementation

{$R *.lfm}


{ TProviderConnection }

procedure TProviderConnection.ConfigurarConexao;
var
  vDir: string;
  arqIni: TiniFile;
begin

  ArqIni := TiniFile.Create('DB.INI');
  try
    vDir := ArqIni.readString('CONFIG', 'PATH', 'Books.FDB');

  finally
    ArqIni.Free;
  end;


  Zconnection.database := vDir;
  ZConnection.connected := True;
end;

constructor TProviderConnection.Create;
begin
  inherited Create(nil);
  ZConnection.connected := False;
  ConfigurarConexao;

end;

end.
