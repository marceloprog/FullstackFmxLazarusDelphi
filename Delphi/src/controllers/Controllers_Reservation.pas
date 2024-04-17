unit Controllers_Reservation;

interface

procedure Registry;

implementation

uses
  Horse, Services_Reservation, System.Json, Dataset.serialize,Data.db;

procedure DoPostReservation(Req: THorseRequest; Res: THorseResponse);
var
  LService: TReservationService;
begin
  LService := TReservationService.create;
  try
    if LService.append(Req.body<TJsonObject>) then
      Res.Send(LService.QryReservation.ToJsonObject)
        .Status(THTTPStatus.created);

  finally
    LService.free;
  end;
end;

procedure DoListReservations(Res: THorseResponse);
var
  LService: TReservationService;
begin
  LService := TReservationService.create;
  try
    Res.Send(LService.ListAll.ToJsonArray());
  finally
    LService.free;
  end;

end;

procedure DoGetReservation(Req: THorseRequest; Res: THorseResponse);
var
  LService: TReservationService;
  LId: Integer;
begin
  LId := Req.Params.field('id').asInteger;
  LService := TReservationService.create;
  try
   if LService.GetById(LId).IsEmpty then
     raise EHorseException.new.Error('Reserva não localizada').Status(THTTPStatus.NotFound);

    Res.Send(LService.qryReservation.ToJSONObject());

  finally
    LService.free;
  end;

end;

procedure Registry;
begin
  THorse.Post('/reservations', DoPostReservation);
  THorse.Get('/reservations', DoListReservations);
  THorse.Get('/reservations/:id', DoGetReservation);
end;

end.
