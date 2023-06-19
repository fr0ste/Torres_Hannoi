unit puntajes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Grids,
  Funciones,Math;

type

  { TForm6 }

  TForm6 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Sonido: TImage;
    Image3: TImage;
    Imagen1:Timage;

    Imagen3:Timage;
    Grid: TStringGrid;


    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure SonidoClick(Sender: TObject);


  private

  public
    rutaImg: String;//para obtener la ruta de las imagenes a cargar
   isPaused: boolean;
  end;
 const

   rows=10; //filas

   cols=1;  //columnas
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

procedure TForm6.SonidoClick(Sender: TObject);
begin
  // Si la reproducción está pausada, se reanuda la reproducción
  if isPaused then
  begin
       Pause(isPaused);
    rutaImg := obtenerRutaImagen(Application.ExeName);
     Sonido.Picture.LoadFromFile(rutaImg+'/fondos/sinsonido.png');
    //BtnPausePlay.Caption := 'Pause';
    isPaused := false;
  end
  else
  begin
    // Si la reproducción está en curso, se pausa la reproducción

    Pause(isPaused);
    rutaImg := obtenerRutaImagen(Application.ExeName);
     Sonido.Picture.LoadFromFile(rutaImg+'/fondos/sonido.png');
    //BtnPausePlay.Caption := 'Reanudar';
    isPaused := true;
  end;
end;

procedure TForm6.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Terminate;
end;

procedure TForm6.FormCreate(Sender: TObject);
begin

end;

procedure TForm6.FormShow(Sender: TObject);
var
    i,j:Integer;

begin
  rutaImg := obtenerRutaImagen(Application.ExeName);
     Sonido.Picture.LoadFromFile(rutaImg+'/fondos/sinsonido.png');
      isPaused := false;
      //====================Tabla puntajes=======//
     Tabla(Grid);



end;


end.

