unit Controllers_Book;

interface

procedure Registry;

implementation

uses
  Horse, Services_Book, System.Json, Dataset.Serialize,Data.Db;

procedure DoPostBook(Req: THorseRequest; Res: THorseResPonse);
var
  LService: TBookService;
begin
  LService := TBookService.create;
  try

    if LService.Append(Req.Body<TJsonObject>) then
      Res.Send(LService.QryBooks.ToJSONObject).Status(THTTPStatus.created);

  finally
    LService.Free;
  end;
end;

procedure DoListBook(Res: THorseResPonse);
var
  LService: TBookService;
begin
  LService := TBookService.create;
  try

    Res.Send(LService.ListAll.toJsonArray())

  finally
    LService.Free;
  end;
end;

procedure DoGetBook(Req: THorseRequest; Res: THorseResPonse);
var
LId:Integer;
var
  LService: TBookService;
begin
  LService := TBookService.create;
  LId:=Req.Params.Field('id').AsInteger;
  try
     if LService.GetById(LId).IsEmpty then
       raise EHorseException.New.Error('Livro não cadastrado').Status(THTTPStatus.NotFound);

     Res.Send(LService.QryBooks.ToJSONObject());
  finally
    LService.Free;
  end;
end;

procedure DoPutBook(Req: THorseRequest; Res: THorseResPonse);
var
LId:Integer;
var
  LService: TBookService;
begin
  LService := TBookService.create;
  LId:=Req.Params.Field('id').AsInteger;
  try
     if LService.GetById(LId).IsEmpty then
       raise EHorseException.New.Error('Livro não cadastrado').Status(THTTPStatus.NotFound);

     if LService.Update(Req.body<TJsonObject>) then
         Res.Status(THTTPStatus.NoContent);

  finally
    LService.Free;
  end;
end;

procedure DoDeleteBook(Req: THorseRequest; Res: THorseResPonse);
var
LId:Integer;
var
  LService: TBookService;
begin
  LService := TBookService.create;
  LId:=Req.Params.Field('id').AsInteger;
  try
     if LService.GetById(LId).IsEmpty then
       raise EHorseException.New.Error('Livro não cadastrado').Status(THTTPStatus.NotFound);

     if LService.Delete then
         Res.Status(THTTPStatus.NoContent);

  finally
    LService.Free;
  end;
end;


procedure Registry;
begin
  THorse.Post('/books', DoPostBook);
  THorse.Get('/books', DoListBook);
  THorse.Get('/books/:id', DoGetBook);
  THorse.Put('/books/:id', DoPutBook);
  THorse.Delete('/books/:id', DoDeleteBook);
end;


end.
