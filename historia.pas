unit historia;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Funciones;

type

  { TForm5 }

  TForm5 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Sonido: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure SonidoClick(Sender: TObject);
    constructor Create(UserID: Integer); // Constructor personalizado
  private

  public
    rutaImg: string;//para obtener la ruta de las imagenes a cargar
    fname: string;
    isPaused: boolean;
    IdUsuario:Integer;
  end;

var
  Form5: TForm5;

implementation

{$R *.lfm}

uses
  menuInicio;

{ TForm5 }

procedure TForm5.Button1Click(Sender: TObject);
var
  Form3: TForm3;
begin
  Hide;
  Form3 := TForm3.Create(IdUsuario);
  Form3.Show;
end;

procedure TForm5.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Terminate;
end;

procedure TForm5.FormShow(Sender: TObject);
begin
  rutaImg := obtenerRutaImagen(Application.ExeName);
  Sonido.Picture.LoadFromFile(rutaImg + '/fondos/sinsonido.png');
  isPaused := False;
end;

procedure TForm5.Image2Click(Sender: TObject);
var
  Form3: TForm3;
begin
  Hide;
  Form3 := TForm3.Create(IdUsuario);
  Form3.Show;
end;

procedure TForm5.SonidoClick(Sender: TObject);
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  // Si la reproducción está pausada, se reanuda la reproducción
  if isPaused then
  begin
    Pause(isPaused);
    rutaImg := obtenerRutaImagen(Application.ExeName);
    Sonido.Picture.LoadFromFile(rutaImg + '/fondos/sinsonido.png');
    //BtnPausePlay.Caption := 'Pause';
    isPaused := False;
  end
  else
  begin
    // Si la reproducción está en curso, se pausa la reproducción

    Pause(isPaused);
    rutaImg := obtenerRutaImagen(Application.ExeName);
    Sonido.Picture.LoadFromFile(rutaImg + '/fondos/sonido.png');
    //BtnPausePlay.Caption := 'Reanudar';
    isPaused := True;
  end;
end;


constructor TForm5.Create(UserID: Integer);
begin
  inherited Create(nil);
  IdUsuario:= UserID;
  // Resto del código de inicialización del formulario...
end;




end.
