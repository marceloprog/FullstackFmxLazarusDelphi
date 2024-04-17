program ApiLazarus;

{$MODE DELPHI}{$H+}

uses
  Horse, Horse.Jhonson,
  Horse.HandleException,
  Horse.CORS,
  Controllers_Book,
  controllers_Reservation,
  Providers_Connection,
  Services_Book;


begin
  THorse
     .Use(Jhonson())
     .Use(HandleException)
     .Use(CORS);

  Controllers_Book.Registry;
  Controllers_Reservation.Registry;

  THorse.Listen(9000);
end.


