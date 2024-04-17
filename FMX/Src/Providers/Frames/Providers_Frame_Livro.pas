unit Providers_Frame_Livro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Ani;

type
  TframeLivro = class(TFrame)
    btnInfo: TSpeedButton;
    lblNome: TLabel;
    imgCheck: TPath;
    procedure lblNomeClick(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
  private
    { Private declarations }
    FChecked : Boolean;
    FOnClickInfo: TNotifyEvent;
    FIdentify:String;
    procedure SetChecked(const Value: Boolean);
  public
    { Public declarations }
    property Checked:Boolean read FChecked write SetChecked;
    property OnClickInfo: TNotifyEvent read FOnclickInfo write FOnclickInfo;
    property Identify:String read FIdentify write FIdentify;
    constructor Create(AOwner: TComponent); Override;

  end;

implementation

{$R *.fmx}

{ TframeLivro }

procedure TframeLivro.btnInfoClick(Sender: TObject);
begin
  if Assigned(FOnclickInfo) then
    FOnclickInfo(Self);

end;

constructor TframeLivro.Create(AOwner: TComponent);
begin
  inherited Create(Owner);
  FChecked:=false;

  imgCheck.Visible:=Checked;

end;

procedure TframeLivro.lblNomeClick(Sender: TObject);
begin
  Checked:= (not Checked);

end;

procedure TframeLivro.SetChecked(const Value: Boolean);
begin
  FChecked := Value;
  imgCheck.Visible:= Value;
end;

end.
