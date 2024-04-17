unit Views_Principal;

interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics,
  Service_Principal, FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo, FMX.Edit, FMX.Layouts, FMX.TabControl, FMX.Objects, System.Json,
  FMX.ListBox;

type
  TFrmPrincipal = class(TForm)
    retHeader: TRectangle;
    lblHeader: TLabel;
    TbControl: TTabControl;
    TabLivros: TTabItem;
    retPesquisar: TRectangle;
    retReservar: TRectangle;
    vsbLivros: TVertScrollBox;
    edtPesquisar: TEdit;
    btnReservar: TButton;
    TabLivro: TTabItem;
    lblTitulo: TLabel;
    lblDescricao: TLabel;
    lblAutor: TLabel;
    retVotarLIvro: TRectangle;
    btnVoltarLIvro: TButton;
    ScrollLIvro: TScrollBox;
    TabReserva: TTabItem;
    retContentReserva: TRectangle;
    edtNome: TEdit;
    edtCpf: TEdit;
    edtTelefone: TEdit;
    edtEmail: TEdit;
    retFooterReserva: TRectangle;
    btnConfirmarReserva: TButton;
    btnCancelarReserva: TButton;
    vsbLivrosSelecionados: TVertScrollBox;
    btnPesquisar: TSpeedButton;
    TabEnviar: TTabItem;
    retEnviar: TRectangle;
    btnVoltarEnvio: TButton;
    listEnviar: TListBox;
    TabMenu: TTabItem;
    TabCadastro: TTabItem;
    TabListReserva: TTabItem;
    retMenu: TRectangle;
    lytBtnListarLIvros: TLayout;
    recBtnListarLivros: TRectangle;
    lblBtnListarLivros: TLabel;
    spBtnListarLivros: TSpeedButton;
    lytBtnCadastrarLivro: TLayout;
    recBtnCadastrarLivro: TRectangle;
    lblBtnCadastrarLivro: TLabel;
    spBtnCadastrarLivro: TSpeedButton;
    lytBtnListarReservas: TLayout;
    recBtnListarReservas: TRectangle;
    lblBtnListarReservas: TLabel;
    spBtnListarReservas: TSpeedButton;
    btnVoltarReservar: TButton;
    retCadastrar: TRectangle;
    btnCadastrarLivro: TButton;
    btnVoltarCadastroLivro: TButton;
    Rectangle2: TRectangle;
    btnVoltarListarReserva: TButton;
    vsbListaReservas: TVertScrollBox;
    btnListarReservas: TButton;
    retCadastroLivro: TRectangle;
    edtNomeLivro: TEdit;
    edtAutorLivro: TEdit;
    edtDescricaoLivro: TEdit;
    chkStatusLivro: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnVoltarLIvroClick(Sender: TObject);
    procedure btnReservarClick(Sender: TObject);
    procedure btnConfirmarReservaClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure edtCpfTyping(Sender: TObject);
    procedure edtTelefoneTyping(Sender: TObject);
    procedure btnVoltarEnvioClick(Sender: TObject);
    procedure spBtnListarLivrosClick(Sender: TObject);
    procedure spBtnCadastrarLivroClick(Sender: TObject);
    procedure spBtnListarReservasClick(Sender: TObject);
    procedure btnVoltarReservarClick(Sender: TObject);
    procedure btnVoltarListarReservaClick(Sender: TObject);
    procedure btnVoltarCadastroLivroClick(Sender: TObject);
    procedure btnListarReservasClick(Sender: TObject);
    procedure btnCadastrarLivroClick(Sender: TObject);
  private
    { Private declarations }
    FService: TDMServicePrincipal;
    procedure ConfigurarFramesPesquisa;
    procedure DoOnclickInfo(Sender: TObject);
    function PrepararDdosdaReserva: Boolean;
    procedure LimparReserva;
    procedure DesmarcarLivrosSelecionados;
    procedure LimparLivrosSelecionados;
    procedure ExecutarRotinadeEnvio;
    function EnviarSMS: Boolean;
    procedure ConfigurarFramesListaReservas;
    procedure LimparListaReservas;
    procedure LimparCadastroLivro;
    procedure ExecutarCadastroLivro;
    function PrepararDdosCadastroLivro: boolean;

  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  Providers_Frame_Livro, Providers_Frame_Selecionado, FMX.Dialogs,
  Providers_Types_Mask_Format, SErvices_SMS,Model_interfaces_SMS,
  Providers_Frame_ListaReservas;

{$R *.fmx}

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  FService := TDMServicePrincipal.Create(Self);
end;

procedure TFrmPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FService);
end;

procedure TFrmPrincipal.btnCadastrarLivroClick(Sender: TObject);
begin
  if (trim(edtNomeLivro.text)='') or
  (trim(edtAutorLivro.text)='') or
  (trim(edtDescricaoLivro.text)='') then
  begin
     Showmessage('Preencha todos campos para cadastrar livro');
     edtNomeLivro.SetFocus;
     exit;
  end;


  try

    ExecutarCadastroLivro;

  Except
    on e: Exception do
      showmessage(e.message);
  end;


  LimparCadastroLivro;
end;

procedure TFrmPrincipal.btnConfirmarReservaClick(Sender: TObject);
begin
  if (trim(edtNome.text)='') or
  (trim(edtCpf.text)='') or
  (trim(edtTelefone.text)='') or
  (trim(edtEmail.text)='') then
  begin
     Showmessage('Preencha todos campos para reservar livro');
     edtNome.SetFocus;
     exit;
  end;

  try
    if (vsbLivrosSelecionados.Content.ControlsCount = 0) then
    begin
      showmessage('Selecione algum livro para reservar.');
      exit;
    end;

    ExecutarRotinadeEnvio;

  Except
    on e: Exception do
      showmessage(e.message);
  end;
end;

procedure TFrmPrincipal.btnPesquisarClick(Sender: TObject);
begin
  ConfigurarFramesPesquisa
end;

procedure TFrmPrincipal.btnReservarClick(Sender: TObject);
var
  i: integer;
  LFrame: TFrameSelecionado;
begin

  LimparReserva;
  vsbLivrosSelecionados.BeginUpdate;

  try

    for i := 0 to Pred(vsbLivros.Content.ControlsCount) do
    begin
      if not vsbLivros.Content.Controls.Items[i].InheritsFrom(TFrameLivro) then
        continue;
      if not TFrameLivro(vsbLivros.Content.Controls.Items[i]).Checked then
        continue;

      LFrame := TFrameSelecionado.Create(vsbLivrosSelecionados);
      LFrame.Align := TAlignLayout.Top;
      LFrame.Parent := vsbLivrosSelecionados;
      LFrame.lblNome.text := TFrameLivro(vsbLivros.Content.Controls.Items[i])
        .lblNome.text;
      LFrame.Identify := TFrameLivro(vsbLivros.Content.Controls.Items[i]
        ).Identify;
      LFrame.Name := LFrame.ClassName + i.ToString;

    end;

    if (vsbLivrosSelecionados.Content.ControlsCount = 0) then
    begin
      showmessage('Selecione algum livro para reservar');
      exit;
    end;

    TbControl.ActiveTab := TabReserva;

  finally
    vsbLivrosSelecionados.EndUpdate;
  end;
end;

procedure TFrmPrincipal.btnVoltarEnvioClick(Sender: TObject);
begin
  TbControl.ActiveTab := TabMenu;
end;

procedure TFrmPrincipal.btnVoltarLIvroClick(Sender: TObject);
begin
  DesmarcarLivrosSelecionados;
  TbControl.ActiveTab := TabLivros;
end;

procedure TFrmPrincipal.btnVoltarReservarClick(Sender: TObject);
begin
  LimparLivrosSelecionados;
  TbControl.ActiveTab := TabMenu;
end;

procedure TFrmPrincipal.btnVoltarCadastroLivroClick(Sender: TObject);
begin
  LimparCadastroLivro;
  TbControl.ActiveTab := TabMenu;
end;

procedure TFrmPrincipal.btnListarReservasClick(Sender: TObject);
begin
  ConfigurarFramesListaReservas;
end;

procedure TFrmPrincipal.btnVoltarListarReservaClick(Sender: TObject);
begin
  LimparListaReservas;
  TbControl.ActiveTab := TabMenu;
end;

procedure TFrmPrincipal.ConfigurarFramesListaReservas;
var
  i,k: integer;
  LFrame: TFrameListaReservas;
  idReserva:Integer;
begin

  try

    FService.ListReservas(edtPesquisar.text);

    vsbLivros.BeginUpdate;
    try
      for i := Pred(vsbListaReservas.Content.ControlsCount) Downto 0 do
        vsbListaReservas.Content.Controls.Items[i].DisposeOf;

      FService.mtReservas.First;
      While not FService.mtReservas.Eof do
      begin
        LFrame := TFrameListaReservas.Create(vsbListaReservas);
        LFrame.lstReserva.items.Clear;
        LFrame.Parent := vsbListaReservas;
        LFrame.Align := TAlignLayout.Top;
        LFrame.Name := LFrame.ClassName + FService.mtReservas.RecNo.ToString;
        LFrame.Identify := FService.mtReservas.FieldByName('id').AsString;

        LFrame.lblReserva.text := 'Reserva: ' + FService.mtReservas.FieldByName('id_reserva').AsString+
        '         Data: '+ Formatdatetime('DD/MM/YYYY',FService.mtReservas.FieldByName('data').AsDateTime);
        LFrame.lblNome.text := FService.mtReservas.FieldByName('Nomepessoa').AsString;
        LFrame.lblCpf.text := 'CPF: '+FService.mtReservas.FieldByName('Cpf').AsString;
        LFrame.lblTelefone.text :='Telefone: '+ FService.mtReservas.FieldByName('Telefone').AsString;
        LFrame.lblEmail.text :='Email: '+FService.mtReservas.FieldByName('Email').AsString;

        idReserva:=FService.mtReservas.FieldByName('id_reserva').AsInteger;
        k:=0;
        While (not FService.mtReservas.Eof) and
          (idReserva=FService.mtReservas.FieldByName('id_reserva').AsInteger) do
        begin
           inc(K);
           LFrame.lstReserva.Items.Add('Livro '+FormatFloat('00',k)+': '+FService.mtReservas.FieldByName('NOMELIVRO').AssTring);
           LFrame.lstReserva.Items.Add('Autor: '+FService.mtReservas.FieldByName('AUTOR').AssTring);
           FService.mtReservas.Next;
        end;
      end;

    finally
      vsbLivros.EndUpdate;
    end;
  except
    on e: Exception do
      showmessage(e.message);

  end;
end;

procedure TFrmPrincipal.ConfigurarFramesPesquisa;
var
  i: integer;
  LFrame: TFrameLivro;
begin

  try

    FService.ListBooks(edtPesquisar.text);

    vsbLivros.BeginUpdate;
    try
      for i := Pred(vsbLivros.Content.ControlsCount) Downto 0 do
        vsbLivros.Content.Controls.Items[i].DisposeOf;

      FService.mtBooks.First;
      While not FService.mtBooks.Eof do
      begin
        LFrame := TFrameLivro.Create(vsbLivros);
        LFrame.Parent := vsbLivros;
        LFrame.Align := TAlignLayout.Top;
        LFrame.lblNome.text := FService.mtBooks.FieldByName('nome').AsString;
        LFrame.Name := LFrame.ClassName + FService.mtBooks.RecNo.ToString;
        LFrame.Identify := FService.mtBooks.FieldByName('id').AsString;
        LFrame.OnClickInfo := DoOnclickInfo;
        FService.mtBooks.Next;
      end;

    finally
      vsbLivros.EndUpdate;
    end;
  except
    on e: Exception do
      showmessage(e.message);

  end;
end;


procedure TFrmPrincipal.LimparLivrosSelecionados;
var
  i: integer;
begin

  try
    vsbLivros.BeginUpdate;
    for i := Pred(vsbLivros.Content.ControlsCount) Downto 0 do
      TFrameLivro(vsbLivros.Content.Controls.Items[i]).DisposeOf;

  finally
    vsbLivros.EndUpdate;
  end;
end;

procedure TFrmPrincipal.DoOnclickInfo(Sender: TObject);
begin

  if not FService.mtBooks.Locate('ID', TFrameLivro(Sender).Identify) then
    exit;

  lblTitulo.text := FService.mtBooks.FieldByName('nome').AsString;
  lblAutor.text := FService.mtBooks.FieldByName('autor').AsString;
  lblDescricao.text := FService.mtBooks.FieldByName('descricao').AsString;

  TbControl.ActiveTab := TabLivro;

end;

procedure TFrmPrincipal.edtCpfTyping(Sender: TObject);
begin
  edtCpf.text := TMaskFormat.CPF.format(edtCpf.text);
  edtCpf.CaretPosition := edtCpf.text.Length;
end;

procedure TFrmPrincipal.edtTelefoneTyping(Sender: TObject);
begin
  edtTelefone.text := TMaskFormat.Celular.format(edtTelefone.text);
  edtTelefone.CaretPosition := edtTelefone.text.Length;
end;

function TFrmPrincipal.EnviarSMS: Boolean;
var
  EnvioSMS: iEnviarSMSOS;
  RetornoEnvio:String;
begin
  Result := true;

  Try
    EnvioSMS := TEnvioSms.New.GetEnviarSms;
    EnvioSMS.addCelular(edtTelefone.text).
    addContato(edtNome.Text);

    RetornoEnvio:=EnvioSMS.EnviarSMS;
    ListEnviar.Items.Add(RetornoEnvio);
    if Trim(RetornoEnvio)<>'' then
       Result:=False;
  Finally

  End;

end;

procedure TFrmPrincipal.ExecutarCadastroLivro;
begin

  listEnviar.Items.Clear;

  btnVoltarCadastroLivro.Enabled := false;
  btnCadastrarLivro.Enabled := false;
  try
    ListEnviar.Items.Add('Iniciando processo de reserva');
    if PrepararDdosCadastroLivro then
       Showmessage('Livro Cadastrado');

    LimparCadastroLivro;
  finally
    btnVoltarCadastroLivro.Enabled := true;
    btnCadastrarLivro.Enabled := true;
  end;

end;

procedure TFrmPrincipal.ExecutarRotinadeEnvio;
begin
  TbControl.ActiveTab := TabEnviar;
  listEnviar.Items.Clear;

  btnVoltarEnvio.Enabled := false;
  try
    ListEnviar.Items.Add('Iniciando processo de reserva');
    if PrepararDdosdaReserva then
    begin
      listEnviar.Items.Add('Reserva Efetuada');

      if  EnviarSMS then
        listEnviar.Items.Add('SMS de confirmação enviado.');
    end
    else
      listEnviar.Items.Add('Falha ao tentar Reservar');

    LimparReserva;
    LimparLivrosSelecionados;
  finally
    btnVoltarEnvio.Enabled := true;
  end;

  // TbControl.ActiveTab := TabLivros;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  TbControl.ActiveTab := TabMenu;
  // ConfigurarFramesPesquisa;
end;

procedure TFrmPrincipal.LimparCadastroLivro;
begin
  edtNomeLivro.text := EmptyStr;
  edtAutorLivro.text := EmptyStr;
  edtDescricaoLivro.text := EmptyStr;
  chkStatusLivro.IsChecked:=false;

end;

procedure TFrmPrincipal.LimparListaReservas;
var
  i: integer;
begin

  vsbListaReservas.BeginUpdate;

  try
    for i := Pred(vsbListaReservas.Content.ControlsCount) Downto 0 do
      vsbListaReservas.Content.Controls.Items[i].DisposeOf;

  finally
    vsbListaReservas.EndUpdate;
  end;

end;

procedure TFrmPrincipal.DesmarcarlivrosSelecionados;
var
  i: integer;
begin

  try
    vsbLivros.BeginUpdate;
    for i := Pred(vsbLivros.Content.ControlsCount) Downto 0 do
      TFrameLivro(vsbLivros.Content.Controls.Items[i]).Checked := false;

  finally
    vsbLivros.EndUpdate;
  end;
end;

procedure TFrmPrincipal.LimparReserva;
var
  i: integer;
begin
  edtNome.text := EmptyStr;
  edtCpf.text := EmptyStr;
  edtTelefone.text := EmptyStr;
  edtEmail.text := EmptyStr;

  vsbLivrosSelecionados.BeginUpdate;

  try
    for i := Pred(vsbLivrosSelecionados.Content.ControlsCount) Downto 0 do
      vsbLivrosSelecionados.Content.Controls.Items[i].DisposeOf;

  finally
    vsbLivrosSelecionados.EndUpdate;
  end;

end;

function TFrmPrincipal.PrepararDdosCadastroLivro: boolean;
var
  LLivro: TJsonObject;
  i: integer;
begin
  Result := true;
  try
    LLivro := TJsonObject.Create;
    LLivro.AddPair('nome', edtNomeLivro.text);
    LLivro.AddPair('autor', edtAutorLivro.text);
    LLivro.AddPair('descricao', edtDescricaoLivro.text);
    if ChkStatusLivro.IsChecked then
      LLivro.AddPair('status',  TJSONNumber.Create(1))
    else
      LLivro.AddPair('status', TJSONNumber.Create(0));


    FService.ProcessarCadastroLivro(LLivro);


  except
    Result := false;
  end;

end;

function TFrmPrincipal.PrepararDdosdaReserva: Boolean;
var
  LReserva: TJsonObject;
  LLivros: TJsonArray;
  i: integer;
  Lid: integer;
begin
  Result := true;
  try
    LReserva := TJsonObject.Create;
    LReserva.AddPair('data', FormatDateTime('YYYY-MM-DD', Date));
    LReserva.AddPair('nome', edtNome.text);
    LReserva.AddPair('cpf', edtCpf.text);
    LReserva.AddPair('telefone', edtTelefone.text);
    LReserva.AddPair('email', edtEmail.text);

    LLivros := TJsonArray.Create;

    for i := 0 to Pred(vsbLivrosSelecionados.Content.ControlsCount) do
    begin
      Lid := TFrameSelecionado(vsbLivrosSelecionados.Content.Controls.Items[i])
        .Identify.ToInteger;
      LLivros.Add(TJsonObject.Create.AddPair('idLivro',
        TJsonNumber.Create(Lid)));
    end;

    LReserva.AddPair('itens', LLivros);

    FService.ProcessarReserva(LReserva);


  except
    Result := false;
  end;

end;

procedure TFrmPrincipal.spBtnCadastrarLivroClick(Sender: TObject);
begin
 TbControl.ActiveTab := TabCadastro;
end;

procedure TFrmPrincipal.spBtnListarLivrosClick(Sender: TObject);
begin
    TbControl.ActiveTab := TabLivros;
end;

procedure TFrmPrincipal.spBtnListarReservasClick(Sender: TObject);
begin
    TbControl.ActiveTab := TabListReserva;
end;

end.
