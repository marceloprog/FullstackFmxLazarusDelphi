unit controllers_Reservation;

{$mode Delphi}

interface

procedure Registry;

implementation

uses
  Horse, Services_reservation, fpjson;

procedure DoPostReservation(Req: THorseRequest; Res: THorseResponse);
var
  LService: TReservationService;
  LObj: TJsonObject;
begin
  LService := TReservationService.Create;

  try
    LObj := LService.append(Req.body);
    if LObj <> nil then
      Res.Send<TJsonObject>(LObj).Status(
        THttpStatus.created);

  finally
    LService.Free;
  end;

end;

procedure DoListReservations(Req: THorseRequest; Res: THorseResponse);
var
   LService: TReservationService;
begin
  LService := TReservationService.Create;

  try
     Res.Send<TJsonArray>(LService.ListAll(Req.Query.Dictionary));

  finally
    LService.Free;
  end;

end;

procedure DoGetReservation(Req: THorseRequest; Res: THorseResponse);
var
    LService: TReservationService;
  LId: integer;
  LObj: TJsonObject;
begin
  LService := TReservationService.Create;
  try
    Lid := Req.Params.field('id').AsInteger;

    lObj := LService.GetById(Lid);
    if LObj = nil then
      raise EHorseException.new.error('Reserva não localizada').Status(
        THttpStatus.NotFound);

    Res.Send<TJsonObject>(LObj);

  finally
    LService.Free;
  end;

end;
procedure Registry;
begin
  THorse.Post('/reservations', DoPostReservation);
  THorse.Get('/reservations', DoListReservations);
  THorse.Get('/reservations/:id', DoGetReservation);
end;

end.
