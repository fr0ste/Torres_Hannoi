(*
  fecha de creacion:
  fecha de actualización:
  descripción:
*)

unit login;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, MaskEdit, BASS, funciones, TransaccionesMySQL, mensajes;

type

  { TForm4 }

  TForm4 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit2KeyPress(Sender: TObject; var Key: char);
    constructor Create(UserID: integer); // Constructor personalizado

  private

  public
    fname: string;
    IdUsuario: integer;
  end;

var
  Form4: TForm4;

implementation

{$R *.lfm}

uses
  menuInicio, registro;

{ TForm4 }

procedure TForm4.Image2Click(Sender: TObject);
var
  Form3: TForm3;
  user, rutaImg: string;
  pwd: string;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  user := Edit1.Text;
  pwd := Edit2.Text;
  if (user <> '') and (pwd <> '') then
  begin

    idUsuario := ValidarUsuario(user, pwd);
    if idUsuario <> 0 then
    begin
      Hide;

      Form3 := TForm3.Create(IdUsuario);
      Form3.Show;

    end
    else
    begin
      rutaImg := obtenerRutaImagen(Application.ExeName);
      //obtenemos la ruta de la imagen
      MostrarImagenEmergente(rutaImg + '/mensajes/credencialesInvalidas.png', Form4);
    end;
  end
  else
  begin
    rutaImg := obtenerRutaImagen(Application.ExeName); //obtenemos la ruta de la imagen

    MostrarImagenEmergente(rutaImg + '/mensajes/validacionCampos.png', Form4);
  end;

end;

procedure TForm4.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Terminate;

end;



procedure TForm4.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if (Length(Edit1.Text) >= 20) and (Key <> #8) then
    Key :=
      #0 // Cancela la pulsación de la tecla si se alcanzó el límite de caracteres y la tecla no es de retroceso (borrar)
  else if not (EsAlfaNumerico(Key) or (Key = #8)) then
    Key := #0;
  // Cancela la pulsación de la tecla si el carácter ingresado no es una letra ni un número
end;

procedure TForm4.Edit2KeyPress(Sender: TObject; var Key: char);
begin
  if (Length(Edit2.Text) >= 20) and (Key <> #8) then
    Key :=
      #0 // Cancela la pulsación de la tecla si se alcanzó el límite de caracteres y la tecla no es de retroceso (borrar)
  else if not (EsAlfaNumerico(Key) or (EsCaracterEspecial(Key)) or (Key = #8)) then
    Key := #0;
  // Cancela la pulsación de la tecla si el carácter ingresado no es una letra ni un número
end;



procedure TForm4.FormCreate(Sender: TObject);
begin
  // Inicializa el sistema de audio BASS con la configuración predeterminada
  BASS_Init(-1, 44100, 0, nil, nil);

end;

procedure TForm4.FormShow(Sender: TObject);
begin
  //fn0ame:=ExtractFilePath(Application.ExeName)+'/Audios/AudioMenu.mp3';
  //ShowMessage(fname);
  //PlayMP3(fname);
  bass_free;
end;

procedure TForm4.Image1Click(Sender: TObject);
begin

end;

procedure TForm4.Image3Click(Sender: TObject);
var
  Form8: TForm8;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  Hide;
  Form8 := TForm8.Create(IdUsuario);
  Form8.Show;

end;


constructor TForm4.Create(UserID: integer);
begin
  inherited Create(nil);
  IdUsuario := UserID;
  // Resto del código de inicialización del formulario...
end;


{ TForm4 }



end.
