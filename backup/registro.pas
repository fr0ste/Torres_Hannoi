
unit registro;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, TransaccionesMySQL, Funciones;

type

  { TForm8 }

  TForm8 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Image3: TImage;
    Image2: TImage;
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit2KeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
  private
    procedure regresar();

  public

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
  regresar();
end;

procedure TForm8.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Terminate;
end;

procedure TForm8.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if (Length(Edit1.Text) >= 20) and (Key <> #8) then
    Key := #0 // Cancela la pulsación de la tecla si se alcanzó el límite de caracteres y la tecla no es de retroceso (borrar)
  else if not (EsAlfaNumerico(Key) or (Key = #8)) then
    Key := #0; // Cancela la pulsación de la tecla si el carácter ingresado no es una letra ni un número
end;

procedure TForm8.Edit2KeyPress(Sender: TObject; var Key: char);
begin
  if (Length(Edit2.Text) >= 20) and (Key <> #8) then
    Key := #0 // Cancela la pulsación de la tecla si se alcanzó el límite de caracteres y la tecla no es de retroceso (borrar)
  else if not (EsAlfaNumerico(Key) or(EsCaracterEspecial(Key)) or (Key = #8)) then
    Key := #0; // Cancela la pulsación de la tecla si el carácter ingresado no es una letra ni un número
end;

procedure TForm8.Image2Click(Sender: TObject);
var
  user, pwd: string;
  creado: integer;
begin
  user := Edit1.Text;
  pwd := Edit2.Text;

  if (user <> '') and (pwd <> '') then
  begin
    creado := crearUsuario(user, pwd);
    if creado=1 then
    begin
      ShowMessage('El usuario ya existe');
    end
    else
    begin
      ShowMessage('Registro creado');
      regresar();
    end;
  end
  else
  begin
    ShowMessage('No se han ingresado datos en los campos.');
  end;
end;
procedure TForm8.regresar();
var
  Form4: TForm4;
begin
  Hide;
  Form4 := TForm4.Create(nil);
  Form4.Show;
end;
end.s



