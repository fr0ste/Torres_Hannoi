unit menuInicio;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, bass, funciones, TransaccionesMySQL;

type

  { TForm3 }

  TForm3 = class(TForm)
    Image1: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Sonido: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;

    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image12Click(Sender: TObject);
    procedure Image13Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure SonidoClick(Sender: TObject);
    constructor Create(UserID: Integer); // Constructor personalizado

  private
    procedure Partida(idUsuario: integer);

     // Declaración de la propiedad UserID
  public

    rutaImg: string;//para obtener la ruta de las imagenes a cargar
    isPaused: boolean;
    fname: string;
    IdUsuario: Integer;



  end;

var
  Form3: TForm3;
  {agregado de la variable, despues se cambiará a privado**********************}
  idUsuario: integer = 1;

implementation


{$R *.lfm}

uses
  historia, puntajes, niveles, creditos, ManualOAutomatico, login, main;

{ TForm3 }

procedure TForm3.Image8Click(Sender: TObject);
var
  Form11: TForm11;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  Hide;
  Form11 := TForm11.Create(IdUsuario);
  Form11.Show;

end;

procedure TForm3.Image9Click(Sender: TObject);
var
  Form1: TForm1;
  numDisc: integer;
  idPartida: integer;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);


  {actualizar esto solo se puso un id de usuario para probar}
  idPartida := obtenerIdPartida(idUsuario);
  numDisc := obtenerNumeroDiscos(idPartida);
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form1 := TForm1.Create(True,IdUsuario);

  // Pasar el número como parámetro al formulario Form2
  Form1.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form1.Show;
end;

procedure TForm3.SonidoClick(Sender: TObject);
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

procedure TForm3.Image13Click(Sender: TObject);
var
  Form4: TForm4;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  Hide;
  Form4 := TForm4.Create(IdUsuario);
  Form4.Show;
end;

procedure TForm3.Image10Click(Sender: TObject);
var
  Form5: TForm5;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  Hide;
  Form5 := TForm5.Create(IdUsuario);
  Form5.Show;

end;

procedure TForm3.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Terminate;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  ShowMessage('el id del usuario es:' + IntToStr(IdUsuario));

end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  BASS_Free;

  BASS_Init(-1, 44100, 0, nil, nil);

end;



procedure TForm3.FormShow(Sender: TObject);
begin
  rutaImg := obtenerRutaImagen(Application.ExeName);
  Sonido.Picture.LoadFromFile(rutaImg + '/fondos/sonido.png');
  isPaused := False;
  BASS_Init(-1, 44100, 0, nil, nil);
  fname := ExtractFilePath(Application.ExeName) + '/Audios/AudioMenu.mp3';
  PlayMP3(fname);
  //habilitar el botón de continuar si existe la partida
  Partida(idUsuario);

end;



procedure TForm3.Image11Click(Sender: TObject);
var
  Form6: TForm6;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  Hide;
  Form6 := TForm6.Create(IdUsuario);
  Form6.Show;

end;

procedure TForm3.Image12Click(Sender: TObject);
var
  Form10: TForm10;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  Hide;
  Form10 := TForm10.Create(IdUsuario);
  Form10.Show;

end;

procedure TForm3.Partida(idUsuario: integer);
var
  existe: integer;
begin
  existe := existePartida(idUsuario);
  if existe = 0 then
    //deshabilitar el boton de continuar
  begin
    Image9.Hide;
    rutaImg := obtenerRutaImagen(Application.ExeName);
    Image2.Picture.LoadFromFile(rutaImg + '/fondos/fondoContinuar1.png');
  end
  else
  begin
  end;
end;

constructor TForm3.Create(UserID: Integer);
begin
  inherited Create(nil);
  IdUsuario:= UserID;
  // Resto del código de inicialización del formulario...
end;



end.
