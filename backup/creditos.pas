unit creditos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Funciones;

type

  { TForm10 }

  TForm10 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Sonido: TImage;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure SonidoClick(Sender: TObject);
    constructor Create(UserID: Integer); // Constructor personalizado
  private

  public
    rutaImg: string;//para obtener la ruta de las imagenes a cargar
    isPaused: boolean;
    fname: string;
    IdUsuario:Integer;
  end;

var
  Form10: TForm10;

implementation

{$R *.lfm}
uses
  menuInicio;

{ TForm10 }

procedure TForm10.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Terminate;
end;

procedure TForm10.FormShow(Sender: TObject);
begin
  rutaImg := obtenerRutaImagen(Application.ExeName);
  Sonido.Picture.LoadFromFile(rutaImg + '/fondos/sinsonido.png');
  isPaused := False;
end;

procedure TForm10.Image2Click(Sender: TObject);
var
  Form3: TForm3;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  Hide;
  Form3 := TForm3.Create(IdUsuario);
  Form3.Show;
end;

procedure TForm10.SonidoClick(Sender: TObject);
begin
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

  
constructor TForm10.Create(UserID: Integer);
begin
  inherited Create(nil);
  IdUsuario:= UserID;
  // Resto del código de inicialización del formulario...
end;




end.
