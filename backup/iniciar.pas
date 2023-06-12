unit Iniciar;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Spin,
  ExtCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}
uses
  main;

{ TForm2 }

procedure TForm2.Button1Click(Sender: TObject);
var
  Form1: TForm1;
  numDisc: integer;
begin
  // Ocultar el formulario actual (Form1)
  numDisc:= SpinEdit1.Value+2;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form1 := TForm1.Create;

  // Pasar el número como parámetro al formulario Form2
  Form1.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form1.Show;
end;

procedure TForm2.Image2Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.

