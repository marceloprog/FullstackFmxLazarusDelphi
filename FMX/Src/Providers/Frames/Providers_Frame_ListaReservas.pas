unit Providers_Frame_ListaReservas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox;

type
  TframeListaReservas = class(TFrame)
    lblNome: TLabel;
    lstReserva: TListBox;
    lblEmail: TLabel;
    lblTelefone: TLabel;
    lblCpf: TLabel;
    lblReserva: TLabel;
  private
    { Private declarations }
     FIdentify:String;
  public
    { Public declarations }
    property Identify:String read FIdentify write FIdentify;
    constructor Create(AOwner: TComponent); Override;
  end;

implementation

{$R *.fmx}

{ TframeListaReservas }

constructor TframeListaReservas.Create(AOwner: TComponent);
begin
  inherited;

end;

end.
