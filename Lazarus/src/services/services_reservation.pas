unit services_reservation;

{$mode Delphi}

interface

uses
  Classes, SysUtils, ZDataset, ZSqlUpdate, Providers_Connection,
  FpJson, DB, jsonparser, lazutf8,
  DateUtils,Generics.collections;

type

  { TReservationService }

  TReservationService = class(TProviderConnection)
    qryID: TZQuery;
    qryReservationDetalhe: TZQuery;
    qryReservation: TZQuery;
    qryUpdate: TZQuery;
  private
    vId:Integer;
    vNome: string;
    vCpf: string;
    vEmail: string;
    vTelefone: string;
    vData: TDateTime;
    function RetornaUltimoIdReserva: integer;
    procedure CriarReserva;
    procedure ReservarLivro(idReserva, idLIvro: integer);
    function JSONDate_To_Datetime(JSONDate: string): TDatetime;

  public
    function Append(const AReserva: string): TJsonObject;
    function GetById(const AId: integer): TJsonObject;
    function ListAll(const AParams: TDictionary<string, string>): TJsonArray;
  end;

implementation

{$R *.lfm}

function TReservationService.JSONDate_To_Datetime(JSONDate: string): TDatetime;
var
  Year, Month, Day, Hour, Minute, Second, Millisecond: word;
begin
  Year := StrToInt(Copy(JSONDate, 1, 4));
  Month := StrToInt(Copy(JSONDate, 6, 2));
  Day := StrToInt(Copy(JSONDate, 9, 2));

  if length(JSONDate) > 10 then
  begin
    Hour := StrToIntDef(Copy(JSONDate, 12, 2), 0);
    Minute := StrToIntDef(Copy(JSONDate, 15, 2), 0);
    Second := StrToIntDef(Copy(JSONDate, 18, 2), 0);
    Millisecond := Round(StrToFloatDef(Copy(JSONDate, 21, 3), 0));
    Result := EncodeDateTime(Year, Month, Day, Hour, Minute, Second, Millisecond);
  end
  else
  begin
    Result := EncodeDateTime(Year, Month, Day, 0, 0, 0, 0);

  end;
end;

function TReservationService.RetornaUltimoIdReserva: integer;
begin
  Result := 0;
  qryId.Open;
  if not qryId.IsEmpty then
    Result := qryId.FieldByName('ultimoid').AsInteger;

  qryId.Close;

end;

procedure TReservationService.CriarReserva;
begin
  qryUpdate.sql.Clear;
  qryUpdate.sql.add('INSERT INTO reserva');
  qryUpdate.sql.add('(NOME, CPF, EMAIL, TELEFONE,DATA) ');
  qryUpdate.sql.add('VALUES');
  qryUpdate.sql.add('( :NOME, :CPF, :EMAIL, :TELEFONE, :DATA)');

  qryUpdate.parambyname('nome').AsString := vNome;
  qryUpdate.parambyname('cpf').AsString := vCpf;
  qryUpdate.parambyname('email').AsString := vEmail;
  qryUpdate.parambyname('telefone').AsString := vTelefone;
  qryUpdate.parambyname('data').AsDateTime := vData;

  qryUpdate.ExecSQL;
end;

procedure TReservationService.ReservarLivro(idReserva, idLIvro: integer);
begin
  qryUpdate.sql.Clear;
  qryUpdate.sql.add('INSERT INTO reserva_livro');
  qryUpdate.sql.add('(ID_LIVRO, ID_RESERVA) ');
  qryUpdate.sql.add('VALUES');
  qryUpdate.sql.add('( :ID_LIVRO, :ID_RESERVA)');

  qryUpdate.parambyname('ID_RESERVA').AsInteger := idReserva;
  qryUpdate.parambyname('ID_LIVRO').AsInteger := idLivro;
  qryUpdate.ExecSQL;
end;


function TReservationService.Append(const AReserva: string): TJsonObject;
var
  jData: TJsonData;
  jObject, jObjItem,jObjAppend: TJsonObject;
  jItens: TJsonArray;
  i: integer;
  idLivro, idReserva: integer;

begin

  Result := nil;

  jData := GetJson(AReserva);

  jObject := (jData as TJsonObject);

  vNome := jObject.Strings['nome'];
  vCpf := jObject.Strings['cpf'];
  vEmail := jObject.Strings['email'];
  vTelefone := jObject.Strings['telefone'];
  vData := JSONDate_To_Datetime(jObject.Strings['data']);

  jItens := nil;
  jItens := (jObject.findPath('itens') as TJsonArray);

  if jItens = nil then
    exit;
  if jItens.Count = 0 then
    exit;

  idReserva := 0;
  for i := 0 to jItens.Count - 1 do
  begin
    jObjITem := (jItens[i] as TJsonObject);
    idLivro := jObjItem.Integers['idLivro'];

    if (idLivro > 0) and (i = 0) and (idReserva = 0) then
    begin
      CriarReserva;
      idReserva := RetornaUltimoIdReserva;
    end;

    ReservarLivro(idReserva, idLIvro);
  end;

  if idReserva > 0 then
  begin
    qryReservation.sql.add('where id=' + IntToStr(idReserva));
    qryReservation.Open;

    if not qryReservation.isempty then
    begin
      vId := qryReservation.FieldByName('id').AsInteger;
      vNome := qryReservation.FieldByName('nome').AsString;
      vCpf := qryReservation.FieldByName('cpf').AsString;
      vEmail:= qryReservation.FieldByName('email').AsString;
      vTelefone := qryReservation.FieldByName('telefone').AsString;
      vData := qryReservation.FieldByName('data').AsDateTime;

      JObjAppend := TJSONObject.Create(['id', vId, 'nome', vNome,
        'cpf', vCpf, 'email', vEmail, 'telefone', vTelefone,'data',FormatDateTime('YYYY-MM-DD',vData)]);
      Result := jObjAppend;
    end;

    qryReservation.Close;

  end;

end;

function TReservationService.GetById(const AId: integer): TJsonObject;
var
  jObject: TJsonObject;
begin
  Result := nil;
  qryReservation.SQL.add('where id=:id');
  qryReservation.ParamByname('id').AsInteger := Aid;
  qryReservation.Open;
  if not qryReservation.isempty then
  begin
    vId := qryReservation.FieldByName('id').AsInteger;
    vNome := qryReservation.FieldByName('nome').AsString;
    vCpf := qryReservation.FieldByName('cpf').AsString;
    vEmail:= qryReservation.FieldByName('email').AsString;
    vTelefone := qryReservation.FieldByName('telefone').AsString;
    vData := qryReservation.FieldByName('data').AsDateTime;

    JObject := TJSONObject.Create(['id', vId, 'nome', vNome,
        'cpf', vCpf, 'email', vEmail, 'telefone', vTelefone,'data',FormatDateTime('YYYY-MM-DD',vData)]);

     Result := jObject;
  end;

  qryReservation.close;
end;

function TReservationService.ListAll(const AParams: TDictionary<string, string>
  ): TJsonArray;
var
  jArray: TJsonArray;
begin

  qryReservationDetalhe.Close;
  qryReservationDetalhe.Open;

  jArray := TJsonArray.Create;

  while not qryReservationDetalhe.EOF do
  begin
     jArray.add(TJSONObject.Create(['id',qryReservationDetalhe.FieldByName('id').AsInteger,
    'id_livro',qryReservationDetalhe.FieldByName('id_livro').AsInteger,
    'id_reserva',qryReservationDetalhe.FieldByName('id_reserva').AsInteger,
    'nomelivro',qryReservationDetalhe.FieldByName('nomelivro').AsString,
    'autor',qryReservationDetalhe.FieldByName('autor').AsString,
    'descricao',qryReservationDetalhe.FieldByName('descricao').AsString,
    'data',FormatDateTime('YYYY-MM-DD',qryReservationDetalhe.FieldByName('data').AsDateTime),
    'nomepessoa',qryReservationDetalhe.FieldByName('nomepessoa').AsString,
    'cpf',qryReservationDetalhe.FieldByName('cpf').AsString,
    'email',qryReservationDetalhe.FieldByName('email').AsString,
    'telefone',qryReservationDetalhe.FieldByName('telefone').AsString
       ])
      );

      qryReservationDetalhe.Next;

  end;

  qryReservationDetalhe.close;
  Result := jArray;

end;

end.
