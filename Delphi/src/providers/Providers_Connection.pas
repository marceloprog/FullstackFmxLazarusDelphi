unit Providers_connection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.FBDef, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.ConsoleUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.IBBase,IniFiles;

type
  TProviderConnection = class(TDataModule)
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    Connection: TFDConnection;
  private
    { Private declarations }
    procedure ConfigurarConexao;
  public
    { Public declarations }
    constructor create; reintroduce;
  end;

var
  ProviderConnection: TProviderConnection;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

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
  connection.Params.Database := vDir;
  Connection.connected := True;
end;

constructor TProviderConnection.create;
begin
 inherited create(nil);
  Connection.connected := False;
  ConfigurarConexao;
end;

end.
