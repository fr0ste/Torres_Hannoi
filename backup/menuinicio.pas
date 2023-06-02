unit menuInicio;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,stdctrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    Image1: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    procedure Image10Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image13Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation


{$R *.lfm}

uses
  Iniciar,historia,puntajes,niveles;

{ TForm3 }

procedure TForm3.Image8Click(Sender: TObject);
var
  Form7:TForm7;
begin

  Hide;
  Form7 := TForm7.Create(nil);
  Form7.Show;

end;

procedure TForm3.Image13Click(Sender: TObject);
begin
   Application.Terminate;
end;

procedure TForm3.Image10Click(Sender: TObject);
var
  Form5: TForm5;
begin

  Hide;
  Form5:=TForm5.Create(nil);
  Form5.Show;


end;

procedure TForm3.Image11Click(Sender: TObject);
var
  Form6:TForm6;
begin

  Hide;
  Form6:=TForm6.Create(nil);
  Form6.Show;


end;

end.

