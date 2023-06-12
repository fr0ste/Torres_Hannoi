unit registro;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm8 }

  TForm8 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Image3: TImage;
    Image2: TImage;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
  private

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
var
  Form4 :TForm4;
begin
  Hide;
  Form4:=TForm4.Create(nil);
  Form4.Show;

end;

procedure TForm8.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Terminate;
end;

procedure TForm8.Image4Click(Sender: TObject);
begin
      Application.Terminate;
end;

end.

