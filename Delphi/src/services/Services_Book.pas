unit Services_Book;

interface

uses
  System.SysUtils, System.Classes, Providers_connection, FireDAC.Phys.FBDef,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.IBBase, System.json, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TBookService = class(TProviderConnection)
    QryBooks: TFDQuery;
    QryBooksID: TIntegerField;
    QryBooksNOME: TStringField;
    QryBooksDESCRICAO: TStringField;
    QryBooksAUTOR: TStringField;
    QryBooksSTATUS: TSmallintField;
  private
    { Private declarations }
  public
    { Public declarations }
    function Append(Const ABook: TJsonObject): boolean;
    function ListAll: TDataset;
    function GetById(const AId: integer): TDataset;
    function Update(Const ABook: TJsonObject): boolean;
    function Delete: boolean;
  end;

implementation

{$R *.dfm}

uses
  DataSet.Serialize;

{ TBookService }

function TBookService.Append(const ABook: TJsonObject): boolean;
begin
  QryBooks.SQL.Add('where id is null');
  QryBooks.Open();
  QryBooks.LoadFromJSON(ABook, False);
  Result := true;

end;

function TBookService.GetById(const AId: integer): TDataset;
begin
  QryBooks.SQL.Add('where id=:id');
  QryBooks.ParamByName('id').AsInteger := AId;
  QryBooks.Open();
  Result := QryBooks;
end;

function TBookService.ListAll: TDataset;
begin
  QryBooks.Open();
  Result := QryBooks;
end;

function TBookService.Update(const ABook: TJsonObject): boolean;
begin
  QryBooks.MergeFromJsonObject(ABook, False);
  Result := true;
end;

function TBookService.Delete: boolean;
begin
  QryBooks.Delete;
  Result := true

end;

end.
