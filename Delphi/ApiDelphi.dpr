program ApiDelphi;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.CORS,
  Horse.HandleException,
  System.SysUtils,
  Controllers_Reservation in 'src\controllers\Controllers_Reservation.pas',
  Controllers_Book in 'src\controllers\Controllers_Book.pas',
  Providers_Connection in 'src\providers\Providers_Connection.pas' {ProviderConnection: TDataModule},
  Services_Book in 'src\services\Services_Book.pas' {BookService: TDataModule},
  Services_Reservation in 'src\services\Services_Reservation.pas' {ReservationService: TDataModule};

begin
  THorse.Use(Jhonson())
  .Use(CORS)
  .Use(HandleException);

  Controllers_Book.Registry;
  Controllers_Reservation.Registry;

  THorse.Listen(9000,
    procedure
    begin
       writeln('****************************************************************');
       writeln('  Servidor API-Horse (Marcelo Vidal), Aguardando requisicao .....');
       Writeln(Format('  Porta %d', [THorse.Port]));
       writeln('****************************************************************') ;
   end);

end.
