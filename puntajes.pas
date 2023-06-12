unit puntajes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TForm6 }

  TForm6 = class(TForm)
    Imagen1:Timage;

    Imagen3:Timage;


    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure Image3Click(Sender: TObject);


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


procedure TForm6.Image3Click(Sender: TObject);
var
   Form3:TForm3;
begin
  Hide;
  Form3:=TForm3.Create(nil);
  Form3.Show;
end;

procedure TForm6.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Terminate;
end;


end.

