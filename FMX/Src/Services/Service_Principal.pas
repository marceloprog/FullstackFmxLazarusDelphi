unit Service_Principal;

interface

uses
  System.SysUtils, System.Classes,RestRequest4D, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,Horse, Dataset.Serialize,system.json,IpPeerClient;

type
  TDMServicePrincipal = class(TDataModule)
    mtBooks: TFDMemTable;
    mtBooksID: TIntegerField;
    mtBooksNOME: TStringField;
    mtBooksDESCRICAO: TStringField;
    mtBooksAUTOR: TStringField;
    mtBooksSTATUS: TSmallintField;
    mtReservas: TFDMemTable;
    mtReservasID: TIntegerField;
    mtReservasID_LIVRO: TIntegerField;
    mtReservasID_RESERVA: TIntegerField;
    mtReservasNOMELIVRO: TStringField;
    mtReservasAUTOR: TStringField;
    mtReservasDESCRICAO: TStringField;
    mtReservasDATA: TSQLTimeStampField;
    mtReservasNOMEPESSOA: TStringField;
    mtReservasCPF: TStringField;
    mtReservasEMAIL: TStringField;
    mtReservasTELEFONE: TStringField;
  public
    { Public declarations }
    procedure ListBooks(const AFilter:String);
    procedure ListBooks2(const AFilter:String);
    procedure ProcessarReserva(const AReserva:TJsonObject);
    procedure ListReservas(const AFilter:String);
    procedure ProcessarCadastroLivro(const ALivro:TJsonObject);
  end;


implementation

uses
  DataSet.Serialize.Adapter.RESTRequest4D;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDMServicePrincipal }

procedure TDMServicePrincipal.ListBooks(const AFilter: String);
begin
  if not mtBooks.Active then
    mtBooks.Open;

  mtBooks.EmptyDataSet;
  TRequest.New
  .BaseUrl('http://127.0.0.1:9000')
  .Resource('books')
  .Adapters(TDataSetSerializeAdapter.New(mtBooks))
  .AddParam('filter',AFilter)
  .Get;

end;

procedure TDMServicePrincipal.ListBooks2(const AFilter: String);
var
i:integer;
begin
  if not mtBooks.Active then
    mtBooks.Open;
 i:=0;
  while  i<50 do
  begin
    inc(i)  ;
    mtBooks.Append;
    mtBooksNOME.AsString:='Memorias de teste '+i.ToString;
    mtBooksDESCRICAO.asString:=
              ' as peripercias de fulano de tal na praia tomando uma geladisssims ' +inttostr(i);

    mtBooksAUTOR.AsString:='amado batista ' ;
    mtBooksSTATUS.AsInteger:=0;
   mtBooks.post;

  end;


end;

procedure TDMServicePrincipal.ListReservas(const AFilter: String);
begin
 if not mtReservas.Active then
    mtReservas.Open;

  mtReservas.EmptyDataSet;
  TRequest.New
  .BaseUrl('http://127.0.0.1:9000')
  .Resource('reservations')
  .Adapters(TDataSetSerializeAdapter.New(mtReservas))
  .AddParam('filter',AFilter)
  .Get;

end;

procedure TDMServicePrincipal.ProcessarCadastroLivro(const ALivro: TJsonObject);
begin
  TRequest.New
  .BaseURL('http://127.0.0.1:9000')
  .Resource('books')
  .AddBody(ALIvro)
  .Post;

end;

procedure TDMServicePrincipal.ProcessarReserva(const AReserva: TJsonObject);
begin
   TRequest.New
  .BaseUrl('http://127.0.0.1:9000')
  .Resource('reservations')
  .AddBody(AReserva)
  .Post;

end;

end.
