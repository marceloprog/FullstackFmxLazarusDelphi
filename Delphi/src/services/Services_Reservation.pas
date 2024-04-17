unit Services_Reservation;

interface

uses
  System.SysUtils, System.Classes, Providers_Connection, FireDAC.Phys.FBDef,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.IBBase,system.json, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TReservationService = class(TProviderConnection)
    qryReservation: TFDQuery;
    qryitens: TFDQuery;
    dsReservation: TDataSource;
    qryReservationID: TIntegerField;
    qryReservationDATA: TSQLTimeStampField;
    qryReservationNOME: TStringField;
    qryReservationCPF: TStringField;
    qryReservationEMAIL: TStringField;
    qryReservationTELEFONE: TStringField;
    qryitensID: TIntegerField;
    qryitensID_LIVRO: TIntegerField;
    qryitensID_RESERVA: TIntegerField;
    qryitensNOME: TStringField;
    qryitensAUTOR: TStringField;
    FDSchemaAdapter: TFDSchemaAdapter;
    qryReservationDetalhe: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function Append(Const AReservation:TJsonObject):Boolean;
    function ListAll:TDataset;
    function GetById(const Aid:integer):TDataset;
  end;

implementation
uses
horse,Dataset.serialize;
{$R *.dfm}

{ TReservationService }

function TReservationService.Append(const AReservation: TJsonObject): Boolean;
begin
 qryReservation.SQL.Add(' where id is null');
 qryReservation.Open();

 qryItens.SQL.Add(' where rl.id is null');
 qryItens.Open();

 qryReservation.LoadFromJSON(AReservation,false);

 QryItens.Close;

  result:=true;

end;

function TReservationService.GetById(const Aid: integer): TDataset;
begin
 qryReservation.SQL.Add(' where id=:id');
 QryReservation.ParamByName('id').AsInteger:=Aid;
 qryReservation.Open();

 qryItens.SQL.Add(' where rl.id_reserva=:idreserva');
 qryItens.ParamByName('idreserva').AsInteger:=Aid;
 qryItens.Open();

 Result:=QryReservation;
end;

function TReservationService.ListAll: TDataset;
begin
 (*qryReservation.Open();
  QryItens.Open();
  Result:=QryReservation*)
  qryReservationDetalhe.Open();
  Result:=QryReservationDetalhe;
end;

end.
