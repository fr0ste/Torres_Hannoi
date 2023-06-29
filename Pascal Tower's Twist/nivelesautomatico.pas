(*
  fecha de creacion: 26/05/2023
  fecha de actualización:29/06/2023
  descripción: Esta unidad se utiliza para la seleccion de nivel y mandarlo a la
  vita de juego automatico.
*)
unit nivelesAutomatico;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, bass, funciones;

type

  { TForm12 }

  TForm12 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Sonido: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure SonidoClick(Sender: TObject);
  private

  public
    fname: string;
    rutaImg: string;//para obtener la ruta de las imagenes a cargar
    isPaused: boolean;
  end;

var
  Form12: TForm12;

implementation

{$R *.lfm}
uses
  mainAtm, menuInicio;

{ TForm12 }

procedure TForm12.Image2Click(Sender: TObject);
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

procedure TForm12.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Terminate;
end;

procedure TForm12.FormCreate(Sender: TObject);
begin
end;

procedure TForm12.FormShow(Sender: TObject);
begin
  rutaImg := obtenerRutaImagen(Application.ExeName);
  Sonido.Picture.LoadFromFile(rutaImg + '/fondos/sinsonido.png');
  isPaused := False;
end;

procedure TForm12.Image1Click(Sender: TObject);
begin

end;

procedure TForm12.Label1Click(Sender: TObject);
var
  Farm9: TForm9;
  numDisc: integer;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  numDisc := 3;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form9 := TForm9.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form9.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form9.Show;

end;

procedure TForm12.Label2Click(Sender: TObject);
var
  Farm9: TForm9;
  numDisc: integer;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  numDisc := 4;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form9 := TForm9.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form9.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form9.Show;
end;

procedure TForm12.Label3Click(Sender: TObject);
var
  Farm9: TForm9;
  numDisc: integer;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  numDisc := 5;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form9 := TForm9.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form9.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form9.Show;
end;

procedure TForm12.Label4Click(Sender: TObject);
var
  Farm9: TForm9;
  numDisc: integer;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  numDisc := 6;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form9 := TForm9.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form9.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form9.Show;
end;

procedure TForm12.Label5Click(Sender: TObject);
var
  Farm9: TForm9;
  numDisc: integer;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  numDisc := 7;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form9 := TForm9.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form9.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form9.Show;
end;

procedure TForm12.Label6Click(Sender: TObject);
var
  Farm9: TForm9;
  numDisc: integer;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  numDisc := 8;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form9 := TForm9.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form9.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form9.Show;
end;

procedure TForm12.SonidoClick(Sender: TObject);
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

end.
