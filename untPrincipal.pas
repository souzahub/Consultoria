unit untPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics,
   FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation,FMX.Edit, FMX.ScrollBox,
  {$IFDEF ANDROID}
    Androidapi.Jni.GraphicsContentViewText,
    Androidapi.Jni.Net,
    idUri,
    Androidapi.Helpers,
  {$ENDIF ANDROID}
  FMX.Memo, FMX.Ani, FMX.Objects;

type
    TToastLength = (LongToast, ShortToast);
    TfrmPrincipal = class(TForm)
    btnToastLong: TButton;
    btnToastShort: TButton;
    toolbar: TRectangle;
    Text1: TText;
    GradientAnimation1: TGradientAnimation;
    btnSair: TSpeedButton;
    Text2: TText;
    procedure btnToastLongClick(Sender: TObject);
    procedure btnToastShortClick(Sender: TObject);
    procedure WhatsAppAPI;
    procedure btnSairClick(Sender: TObject);
    procedure Text2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$IFDEF ANDROID}
uses
  Androidapi.JNI.Toasts,
  FMX.Helpers.Android;

  procedure Toast(const Msg: string; duration: TToastLength);
  var
    ToastLength: Integer;
  begin
    if duration = ShortToast then
      ToastLength := TJToast.JavaClass.LENGTH_SHORT
    else
      ToastLength := TJToast.JavaClass.LENGTH_LONG;

    CallInUiThread (
      procedure
      begin
        TJToast.JavaClass.makeText (SharedActivityContext,StrToJCharSequence(Msg), ToastLength).show
      end
    );
  end;
{$ENDIF}

{$R *.fmx}

procedure TfrmPrincipal.WhatsAppAPI;
var Numero, Texto, EndURL: string;
    Intend : JIntent;

  begin

    Numero := '5522998521515'; //<– País+DDD+Número
    Texto := 'Olá';
    EndURL := 'https://api.whatsapp.com/send?phone='+
              Numero+'&text='+Texto+'&source=&data=#23';

    try
      Intend := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW);
      Intend.setData(TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(EndURL))));
      SharedActivity.startActivity(Intend);
      Intend.setPackage(StringToJString('com.whatsapp.w4b'));
      Except on E: Exception do
      ShowMessage(E.Message);
    end;


  end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.btnToastLongClick(Sender: TObject);
  var
  URL: string;
  Intent: JIntent;
begin
  URL := 'https://www.instagram.com/juniorvsiqueira/?igshid=f8tyhp4k5ual';
  Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
      TJnet_Uri.JavaClass.parse(StringToJString(URL)));
  SharedActivity.startActivity(Intent);
    Toast ('Obrigado por entrar em contato !', LongToast);
  end;

procedure TfrmPrincipal.btnToastShortClick(Sender: TObject);
  begin
     WhatsAppAPI;
//    Toast ('Mensagem Curta', ShortToast);
    Toast ('Obrigado por entrar em contato !', LongToast);
  end;

procedure TfrmPrincipal.Text2Click(Sender: TObject);
  var
  URL: string;
  Intent: JIntent;
begin
  URL := 'https://www.instagram.com/luansouzasiqueira/end.';
  Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
      TJnet_Uri.JavaClass.parse(StringToJString(URL)));
  SharedActivity.startActivity(Intent);
    Toast ('Obrigado por entrar em contato !', LongToast);
  end;

end.
