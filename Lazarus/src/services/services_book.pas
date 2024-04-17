unit Services_Book;

{$mode Delphi}

interface

uses
  Classes, SysUtils, ZDataset, ZSqlUpdate, Providers_Connection, FpJson, DB, jsonparser,
  Generics.collections,lazutf8;

type

  { TBookService }

  TBookService = class(TProviderConnection)
    qryBooks: TZQuery;
    qryBooksAUTOR: TStringField;
    qryBooksDESCRICAO: TStringField;
    qryBooksID: TLongintField;
    qryBooksNOME: TStringField;
    qryBooksSTATUS: TSmallintField;
    qryUpdate: TZQuery;
    qryID: TZQuery;
  private
    vNome: string;
    vDescricao: string;
    vAutor: string;
    vStatus: integer;
    vId: integer;
    function RetornaUltimoId: integer;
  public

    function Append(const Abook:String): TJsonObject;
    function ListAll(const AParams: TDictionary<string, string>): TJsonArray;
    function GetById(const AId: integer): TJsonObject;
    function Update(const AId: integer; const Abook: String): boolean;
    function Delete(const AId: integer): boolean;
  end;


implementation

uses
  Dataset.Serialize;

{$R *.lfm}

{ TBookService }

function TBookService.Append(const Abook: String): TJsonObject;
var
  jData:TJsonData;
  jObject,jObjAppend:TJsonObject;
begin

  Result:=nil;

  jData:=GetJson(ABook);

  jObject := (jData as TJsonObject);

  vNome := jObject.Strings['nome'];
  vDescricao := jObject.Strings['descricao'];
  vAutor := jObject.Strings['autor'];
  vStatus := jObject.Integers['status'];

  qryUpdate.sql.Clear;
  qryUpdate.sql.add('INSERT INTO livro');
  qryUpdate.sql.add('(NOME, DESCRICAO, AUTOR, STATUS) ');
  qryUpdate.sql.add('VALUES');
  qryUpdate.sql.add('( :NOME, :DESCRICAO, :AUTOR, :STATUS)');

  qryUpdate.parambyname('nome').AsString := vNome;
  qryUpdate.parambyname('descricao').AsString := vDescricao;
  qryUpdate.parambyname('autor').AsString := vAutor;
  qryUpdate.parambyname('status').AsInteger := vStatus;

  vId := RetornaUltimoId;

  qryUpdate.ExecSQL;

  qryBooks.sql.add('where id=' + IntToStr(vId + 1));
  qryBooks.Open;

  if not qryBooks.isempty then
  begin
    vId := qryBooks.FieldByName('id').AsInteger;
    vNome := qryBooks.FieldByName('nome').AsString;
    vDescricao := qryBooks.FieldByName('descricao').AsString;
    vAutor := qryBooks.FieldByName('autor').AsString;
    vStatus := qryBooks.FieldByName('status').AsInteger;

    JObjAppend:=TJSONObject.Create(['id', vId,
      'nome', vNome,
      'descricao',vDescricao,
      'autor', vAutor,
      'status', vStatus
      ])  ;
     Result := jObjAppend;
  end;

  qryBooks.Close;


end;

function TBookService.ListAll(const AParams: TDictionary<string, string>): TJsonArray;
var
  jArray: TJsonArray;
begin

  qryBooks.Close;
  QryBooks.Open;

  jArray := TJsonArray.Create;

  while not qryBooks.EOF do
  begin

    vId := qryBooks.FieldByName('id').AsInteger;
    vNome := qryBooks.FieldByName('nome').AsString;
    vDescricao := qryBooks.FieldByName('descricao').AsString;
    vAutor := qryBooks.FieldByName('autor').AsString;
    vStatus := qryBooks.FieldByName('status').AsInteger;

    jArray.add(TJSONObject.Create(['id', vId,
      'nome', vNome,
      'descricao',vDescricao,
      'autor', vAutor,
      'status', vStatus
      ])
      );

      qryBooks.Next;

  end;

  qryBooks.close;
  Result := jArray;

end;

function TBookService.GetById(const AId: integer): TJsonObject;
var
  jObject: TJsonObject;
begin
  Result := nil;
  qrybooks.SQL.add('where id=:id');
  qryBooks.ParamByname('id').AsInteger := Aid;
  qrybooks.Open;
  if not qryBooks.isempty then
  begin
    vId := qryBooks.FieldByName('id').AsInteger;
    vNome := qryBooks.FieldByName('nome').AsString;
    vDescricao := qryBooks.FieldByName('descricao').AsString;
    vAutor := qryBooks.FieldByName('autor').AsString;
    vStatus := qryBooks.FieldByName('status').AsInteger;

    JObject:=TJSONObject.Create(['id', vId,
      'nome', vNome,
      'descricao',vDescricao,
      'autor', vAutor,
      'status', vStatus
      ])  ;
     Result := jObject;
  end;

  qrybooks.close;
end;

function TBookService.Update(const AId: integer; const Abook: String): boolean;
var
  jData:TJsonData;
  jObject:TJsonObject;
begin

  jData:=GetJson(ABook);

  jObject := (jData as TJsonObject);

  vNome := jObject.Strings['nome'];
  vDescricao := jObject.Strings['descricao'];
  vAutor := jObject.Strings['autor'];
  vStatus := jObject.Integers['status'];


  qryUpdate.sql.Clear;

  qryUpdate.sql.add('UPDATE livro SET  ');
  qryUpdate.sql.add('NOME = :NOME, DESCRICAO = :DESCRICAO, ');
  qryUpdate.sql.add('AUTOR = :AUTOR,STATUS = :STATUS  ');
  qryUpdate.sql.add('WHERE  livro.ID = :ID ');

  qryUpdate.parambyname('nome').AsString := vNome;
  qryUpdate.parambyname('descricao').AsString := vDescricao;
  qryUpdate.parambyname('autor').AsString := vAutor;
  qryUpdate.parambyname('status').AsInteger := vStatus;
  qryUpdate.parambyname('id').AsInteger := AId;

  qryUpdate.ExecSQL;

  Result := True;
end;

function TBookService.Delete(const AId: integer): boolean;
begin
  qryUpdate.sql.Clear;

  qryUpdate.sql.add('DELETE FROM livro  ');
  qryUpdate.sql.add('WHERE  livro.ID = :ID ');

  qryUpdate.parambyname('id').AsInteger := AId;

  qryUpdate.ExecSQL;

  Result := True;
end;

function TBookService.RetornaUltimoId: integer;
begin
  Result := 0;
  qryId.Open;
  if not qryId.IsEmpty then
    Result := qryId.FieldByName('ultimoid').AsInteger;

  qryId.Close;

end;

end.
