unit puntajes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TForm6 }

  TForm6 = class(TForm)
    Imagen1:Timage;
    Imagen2:Timage;
    Imagen3:Timage;
    Imagen4:Timage;
    Imagen5:Timage;
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
  private

  public

  end;

var
  Form6: TForm6;

implementation

{$R *.lfm}

uses
  menuInicio;


{ TForm6 }

procedure TForm6.Image4Click(Sender: TObject);
begin
  Application.Terminate;

end;

procedure TForm6.Image5Click(Sender: TObject);
var
   Form3:TForm3;
begin
  Hide;
  Form3:=TForm3.Create(nil);
  Form3.Show;

end;

end.

