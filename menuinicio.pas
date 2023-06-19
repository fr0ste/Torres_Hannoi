unit menuInicio;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,stdctrls,bass,funciones;

type

  { TForm3 }

  TForm3 = class(TForm)
    Image1: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Sonido: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image12Click(Sender: TObject);
    procedure Image13Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure SonidoClick(Sender: TObject);

  private

  public
   rutaImg: String;//para obtener la ruta de las imagenes a cargar
   isPaused: boolean;
  end;

var
  Form3: TForm3;

implementation


{$R *.lfm}

uses
  Iniciar,historia,puntajes,niveles,creditos,ManualOAutomatico,login;

{ TForm3 }

procedure TForm3.Image8Click(Sender: TObject);
var
  Form11:TForm11;
begin

  Hide;
  Form11:= TForm11.Create(nil);
  Form11.Show;

end;

procedure TForm3.SonidoClick(Sender: TObject);
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

procedure TForm3.Image13Click(Sender: TObject);
var
  Form4: TForm4;
begin
  Hide;
  Form4:=TForm4.Create(nil);
  Form4.Show;
end;

procedure TForm3.Image10Click(Sender: TObject);
var
  Form5: TForm5;
begin

  Hide;
  Form5:=TForm5.Create(nil);
  Form5.Show;


end;

procedure TForm3.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
      Application.Terminate;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
       //BASS_Free;

  //BASS_Init(-1, 44100, 0, nil, nil);

end;



procedure TForm3.FormShow(Sender: TObject);
begin
     rutaImg := obtenerRutaImagen(Application.ExeName);
     Sonido.Picture.LoadFromFile(rutaImg+'/fondos/sinsonido.png');
      isPaused := false;
   //fname:=ExtractFilePath(Application.ExeName)+'Cancion2.mp3';
       //ShowMessage(fname);
      //PlayMP3(fname);
end;



procedure TForm3.Image11Click(Sender: TObject);
var
  Form6:TForm6;
begin

  Hide;
  Form6:=TForm6.Create(nil);
  Form6.Show;


end;

procedure TForm3.Image12Click(Sender: TObject);
var
  Form10:TForm10;
begin
  Hide;
  Form10:=TForm10.Create(nil);
  Form10.Show;


end;

end.

