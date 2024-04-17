unit Controllers_Book;

{$mode Delphi}

interface

procedure Registry;

implementation

uses
  Horse, Dataset.serialize, Services_Book, fpjson;

procedure DoListBooks(Req: THorseRequest; Res: THorseResponse);
var
  LService: TBookService;
begin
  LService := TBookService.Create;

  try
    Res.Send<TJsonArray>(LService.ListAll(Req.Query.Dictionary));

  finally
    LService.Free;
  end;

end;

procedure DoGetBook(Req: THorseRequest; Res: THorseResponse);
var
  LService: TBookService;
  LId: integer;
  LObj: TJsonObject;
begin
  LService := TBookService.Create;
  try
    Lid := Req.Params.field('id').AsInteger;

    lObj := LService.GetById(Lid);
    if LObj = nil then
      raise EHorseException.new.error('Livro não localizado').Status(
        THttpStatus.NotFound);

    Res.Send<TJsonObject>(LObj);

  finally
    LService.Free;
  end;

end;


procedure DoPostBook(Req: THorseRequest; Res: THorseResponse);
var
  LService: TBookService;
   LObj: TJsonObject;
begin
  LService := TBookService.Create;

  try
    LObj:=LService.append(Req.body);
    if LObj <> nil then
      Res.Send<TJsonObject>(LObj).Status(
        THttpStatus.created);

  finally
    LService.Free;
  end;
end;

procedure DoPutBook(Req: THorseRequest; Res: THorseResponse);
var
  LService: TBookService;
  LId: integer;
  LObj: TJsonObject;
begin
  LService := TBookService.Create;
  try
    Lid := Req.Params.field('id').AsInteger;

    LObj := LService.GetById(Lid);
    if LObj = nil then
      raise EHorseException.new.error('Livro não localizado').Status(
        THttpStatus.NotFound);


    if LService.Update(LId, Req.body) then
      Res.Status(THttpStatus.NoContent);

  finally
    LService.Free;
  end;

end;

procedure DoDeleteBook(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  LService: TBookService;
  LId: integer;
  LObj: TJsonObject;
begin
  LService := TBookService.Create;
  try
    Lid := Req.Params.field('id').AsInteger;
    LObj := LService.GetById(Lid);
    if LObj = nil then
      raise EHorseException.new.error('Livro não localizado').Status(
        THttpStatus.NotFound);

    if LService.Delete(LId) then
      Res.Status(THttpStatus.NoContent);

  finally
    LService.Free;
  end;

end;


procedure Registry;
begin
  THorse.Get('/books', DoListBooks);
  THorse.Get('/books/:id', DoGetBook);
  THorse.Post('/books', DoPostBook);
  THorse.Put('/books/:id', DoPutBook);
  THorse.Delete('/books/:id', DoDeleteBook);

end;

end.
