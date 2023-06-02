unit niveles;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm7 }

  TForm7 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure Label1Click(Sender: TObject);
    procedure Label1MouseEnter(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
  private

  public

  end;

var
  Form7: TForm7;

implementation

{$R *.lfm}
uses
  main,mainAtm;

{ TForm7 }

procedure TForm7.Label1Click(Sender: TObject);
var
  Form1: TForm1;
  numDisc: integer;
begin
  numDisc:=3;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form1 := TForm1.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form1.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form1.Show;
end;

procedure TForm7.Label1MouseEnter(Sender: TObject);
begin

end;

procedure TForm7.Label2Click(Sender: TObject);
var
  Form1: TForm1;
  numDisc: integer;
begin
  numDisc:=4;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form1 := TForm1.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form1.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form1.Show;
end;

procedure TForm7.Label3Click(Sender: TObject);
var
  Form1: TForm1;
  numDisc: integer;
begin
  numDisc:=5;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form1 := TForm1.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form1.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form1.Show;
end;

procedure TForm7.Label4Click(Sender: TObject);
var
  Form1: TForm1;
  numDisc: integer;
begin
  numDisc:=6;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form1 := TForm1.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form1.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form1.Show;
end;

procedure TForm7.Label5Click(Sender: TObject);
var
  Form1: TForm1;
  numDisc: integer;
begin
  numDisc:=7;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form1 := TForm1.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form1.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form1.Show;
end;

procedure TForm7.Label6Click(Sender: TObject);
var
  Form9: TForm9;
  numDisc: integer;
begin
  numDisc:=5;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form9 := TForm9.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form9.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form9.Show;
end;

end.

