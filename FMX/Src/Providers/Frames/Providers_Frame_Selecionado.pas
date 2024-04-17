unit Providers_Frame_Selecionado;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TFrameSelecionado = class(TFrame)
    lblNome: TLabel;
    btnDelete: TSpeedButton;
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    FIdentify: String;
  public
    { Public declarations }
    property Identify: String read FIdentify write FIdentify;
  end;

implementation

{$R *.fmx}

procedure TFrameSelecionado.btnDeleteClick(Sender: TObject);
begin
  Self.Owner.RemoveComponent(Self);
  Self.Destroy;
end;

end.
