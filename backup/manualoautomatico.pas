unit ManualOAutomatico;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,bass,funciones;

type

  { TForm11 }

  TForm11 = class(TForm)
    Image1: TImage;
    Sonido: TImage;
    Image6: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure SonidoClick(Sender: TObject);
  private

  public
    fname:String;
     isPaused: boolean;
      rutaImg: String;//para obtener la ruta de las imagenes a cargar
       Bstream: dword; // Canal del audio
  end;

var
  Form11: TForm11;

implementation

{$R *.lfm}
uses
  menuInicio,niveles,nivelesAutomatico;

{ TForm11 }

procedure TForm11.Image6Click(Sender: TObject);
var
  Form3:TForm3;
begin
  Hide;
  Form3:=TForm3.Create(nil);
  Form3.Show;
end;

procedure TForm11.Label1Click(Sender: TObject);
var
  Form12:TForm12;
begin
  Hide;
  Form12:=TForm12.Create(nil);
  Form12.Show; end;

procedure TForm11.Label2Click(Sender: TObject);
var
  Form7:TForm7;
begin
  Hide;
  Form7:=TForm7.Create(nil);
  Form7.Show;

end;

procedure TForm11.SonidoClick(Sender: TObject);
begin
     // Si la reproducción está pausada, se reanuda la reproducción
  if isPaused = true then
  begin
    BASS_ChannelPlay(Bstream, false);
    isPaused := false;
      rutaImg := obtenerRutaImagen(Application.ExeName);
     Sonido.Picture.LoadFromFile(rutaImg+'/fondos/sinsonido.png');
     ShowMessage('Sonido');
  end
  else
  begin
    // Si la reproducción está en curso, se pausa la reproducción
       BASS_ChannelPause(Bstream);
    isPaused := true;
      rutaImg := obtenerRutaImagen(Application.ExeName);
     Sonido.Picture.LoadFromFile(rutaImg+'/fondos/sonido.png');
     ShowMessage('sin Sonido');
  end;
end;

procedure TForm11.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
       Application.Terminate;
end;

procedure TForm11.FormCreate(Sender: TObject);
begin
    //BASS_Free;
      // Inicializa el sistema de audio BASS con la configuración predeterminada
  //BASS_Init(-1, 44100, 0, nil, nil);
        rutaImg := obtenerRutaImagen(Application.ExeName);
     Sonido.Picture.LoadFromFile(rutaImg+'/fondos/sinsonido.png');
      isPaused := false;
end;

procedure TForm11.FormShow(Sender: TObject);
begin
  //fname:=ExtractFilePath(Application.ExeName)+'Cancion3.mp3';
       //ShowMessage(fname);
      // PlayMP3(fname);
end;


end.

