(*
  fecha de creacion: 26/05/2023
  fecha de actualización:29/06/2023
  descripción: Esta unidad se utiliza para la seleccion del tipo de nivel que
  el usuario prefiera.
*)
unit ManualOAutomatico;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, bass, funciones;

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
    constructor Create(UserID: integer); (*Constructor personalizado*)
  private

  public
    fname: string;
    isPaused: boolean;
    rutaImg: string;(*para obtener la ruta de las imagenes a cargar*)
    Bstream: dword;(*Canal del audio*)
  end;

var
  Form11: TForm11;

implementation

{$R *.lfm}
uses
  menuInicio, niveles, nivelesAutomatico;

{ TForm11 }

procedure TForm11.Image6Click(Sender: TObject);
var
  Form3: TForm3;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  PlayBoton(fname);
  Hide;
  Form3 := TForm3.Create(IdUsuario);
  Form3.Show;
end;

procedure TForm11.Label1Click(Sender: TObject);
var
  Form12: TForm12;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  PlayBoton(fname);
  Hide;
  Form12 := TForm12.Create(nil);
  Form12.Show;
end;

procedure TForm11.Label2Click(Sender: TObject);
var
  Form7: TForm7;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  PlayBoton(fname);
  Hide;
  Form7 := TForm7.Create(IdUsuario);
  Form7.Show;

end;

procedure TForm11.SonidoClick(Sender: TObject);
begin
  if isPaused then
  begin
    fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
    PlayBoton(fname);
    Pause(isPaused);
    rutaImg := obtenerRutaImagen(Application.ExeName);
    Sonido.Picture.LoadFromFile(rutaImg + '/fondos/sinsonido.png');
    //BtnPausePlay.Caption := 'Pause';
    isPaused := False;
  end
  else
  begin
    (*Si la reproducción está en curso, se pausa la reproducción*)

    Pause(isPaused);
    rutaImg := obtenerRutaImagen(Application.ExeName);
    Sonido.Picture.LoadFromFile(rutaImg + '/fondos/sonido.png');
    isPaused := True;
  end;
end;

(*Cerrar programa*)
procedure TForm11.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Terminate;
end;

procedure TForm11.FormCreate(Sender: TObject);
begin
  rutaImg := obtenerRutaImagen(Application.ExeName);
  Sonido.Picture.LoadFromFile(rutaImg + '/fondos/sinsonido.png');
  isPaused := False;
end;

procedure TForm11.FormShow(Sender: TObject);
begin

end;


constructor TForm11.Create(UserID: integer);
begin
  inherited Create(nil);
  IdUsuario := UserID;
  // Resto del código de inicialización del formulario...
end;


end.
