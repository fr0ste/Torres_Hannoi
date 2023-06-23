unit historia;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,Funciones;

type

  { TForm5 }

  TForm5 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Sonido: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private

  public
     rutaImg: String;//para obtener la ruta de las imagenes a cargar


   isPaused: boolean;
  end;

var
  Form5: TForm5;

implementation

{$R *.lfm}

uses
  menuInicio;

{ TForm5 }

procedure TForm5.Button1Click(Sender: TObject);
var
  Form3:TForm3;
begin
  Hide;
  Form3:=TForm3.Create(nil);
  Form3.Show;

end;

procedure TForm5.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Terminate;
end;

procedure TForm5.FormShow(Sender: TObject);
begin
      rutaImg := obtenerRutaImagen(Application.ExeName);
     Sonido.Picture.LoadFromFile(rutaImg+'/fondos/sinsonido.png');
      isPaused := false;
end;

procedure TForm5.Image1Click(Sender: TObject);
begin

end;

end.

