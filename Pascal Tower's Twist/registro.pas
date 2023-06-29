unit registro;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, TransaccionesMySQL, Funciones, mensajes;

type

  { TForm8 }

  TForm8 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Image1: TImage;
    Image3: TImage;
    Image2: TImage;
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit2KeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    constructor Create(UserID: Integer); // Constructor personalizado
  private
    procedure regresar();

  public
    fname: string;
    IdUsuario:Integer;
  end;

var
  Form8: TForm8;

implementation

{$R *.lfm}
uses
  login;

{ TForm8 }

procedure TForm8.Image3Click(Sender: TObject);
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  regresar();
end;

procedure TForm8.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Terminate;
end;

procedure TForm8.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if (Length(Edit1.Text) >= 20) and (Key <> #8) then
    Key :=
      #0 // Cancela la pulsación de la tecla si se alcanzó el límite de caracteres y la tecla no es de retroceso (borrar)
  else if not (EsAlfaNumerico(Key) or (Key = #8)) then
    Key := #0;
  // Cancela la pulsación de la tecla si el carácter ingresado no es una letra ni un número
end;

procedure TForm8.Edit2KeyPress(Sender: TObject; var Key: char);
begin
  if (Length(Edit2.Text) >= 20) and (Key <> #8) then
    Key :=
      #0 // Cancela la pulsación de la tecla si se alcanzó el límite de caracteres y la tecla no es de retroceso (borrar)
  else if not (EsAlfaNumerico(Key) or (EsCaracterEspecial(Key)) or (Key = #8)) then
    Key := #0;
  // Cancela la pulsación de la tecla si el carácter ingresado no es una letra ni un número
end;

procedure TForm8.Image2Click(Sender: TObject);
var
  user, pwd, pwd2, rutaImg: string;
  creado: integer;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  user := Edit1.Text;
  pwd := Edit2.Text;
  pwd2 := Edit3.Text;

  if (user <> '') and (pwd <> '') and (pwd2 <> '') then
  begin

    if (pwd2 = pwd) then
    begin
      creado := crearUsuario(user, pwd);
      if creado = 1 then
      begin
        rutaImg := obtenerRutaImagen(Application.ExeName);
        //obtenemos la ruta de la imagen
        MostrarImagenEmergente(rutaImg + '/mensajes/usuarioExiste.png', Form8);

      end
      else
      begin
        rutaImg := obtenerRutaImagen(Application.ExeName);
        //obtenemos la ruta de la imagen
        MostrarImagenEmergente(rutaImg + '/mensajes/registroCreado.png', Form8);
        regresar();
      end;
    end
    else
    begin
       rutaImg := obtenerRutaImagen(Application.ExeName); //obtenemos la ruta de la imagen
    MostrarImagenEmergente(rutaImg + '/mensajes/noCoincide.jpg', Form8);
    end;
  end
  else
  begin
    rutaImg := obtenerRutaImagen(Application.ExeName); //obtenemos la ruta de la imagen
    MostrarImagenEmergente(rutaImg + '/mensajes/validacionCampos.png', Form8);
  end;
end;

procedure TForm8.regresar();
var
  Form4: TForm4;
begin
  Hide;
  Form4 := TForm4.Create(IdUsuario);
  Form4.Show;
end;


constructor TForm8.Create(UserID: Integer);
begin
  inherited Create(nil);
  IdUsuario:= UserID;
  // Resto del código de inicialización del formulario...
end;

end.
