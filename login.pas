unit login;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm4 }

  TForm4 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);

  private

  public

  end;

var
  Form4: TForm4;

implementation

{$R *.lfm}

uses
  menuInicio,registro;

{ TForm4 }

procedure TForm4.Image2Click(Sender: TObject);
var
  Form3:TForm3;
begin
  Hide;
  Form3:=TForm3.Create(nil);
  Form3.Show;

end;

procedure TForm4.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
     Application.Terminate;
end;

procedure TForm4.Image3Click(Sender: TObject);
var
  Form8: TForm8;
begin
  Hide;
  Form8:=TForm8.Create(nil);
  Form8.Show;

end;

procedure TForm4.Image4Click(Sender: TObject);
begin
  Close;
end;

{ TForm4 }



end.

