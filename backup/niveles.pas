unit niveles;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,bass,funciones;

type

  { TForm7 }

  TForm7 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Sonido: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label1MouseEnter(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure SonidoClick(Sender: TObject);
  private

  public
     rutaImg: String;//para obtener la ruta de las imagenes a cargar
   fname:String;
   Bstream: dword; // Canal del audio
   isPaused: boolean;
  end;

var
  Form7: TForm7;

implementation

{$R *.lfm}
uses
  main,mainAtm,menuInicio;

{ TForm7 }

procedure TForm7.Label1Click(Sender: TObject);
var
  Form1: TForm1;
  numDisc: integer;
begin
  numDisc:=3;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form1 := TForm1.Create(false);

  // Pasar el número como parámetro al formulario Form2
  Form1.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form1.Show;
end;

procedure TForm7.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
      Application.Terminate;
end;

procedure TForm7.FormCreate(Sender: TObject);
begin

end;

procedure TForm7.FormShow(Sender: TObject);
begin
        BASS_Free;
      // Inicializa el sistema de audio BASS con la configuración predeterminada
  BASS_Init(-1, 44100, 0, nil, nil);
  fname:=ExtractFilePath(Application.ExeName)+'/Audios/AudioMenu.mp3';
       //ShowMessage(fname);
      PlayMP3(fname);
       rutaImg := obtenerRutaImagen(Application.ExeName);
     Sonido.Picture.LoadFromFile(rutaImg+'/fondos/sinsonido.png');
      isPaused := false;
end;

procedure TForm7.Image2Click(Sender: TObject);
var
  Form3:TForm3;
begin
      Hide;
      Form3:=TForm3.Create(nil);
      Form3.Show;
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
  Form1 := TForm1.Create(false);

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
  Form1 := TForm1.Create(false);

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
  Form1 := TForm1.Create(false);

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
  Form1 := TForm1.Create(false);

  // Pasar el número como parámetro al formulario Form2
  Form1.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form1.Show;
end;

procedure TForm7.Label6Click(Sender: TObject);
var
  Form1: TForm1;
  numDisc: integer;
begin
  numDisc:=8;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form1 := TForm1.Create(True);

  // Pasar el número como parámetro al formulario Form2
  Form1.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form1.Show;
end;

procedure TForm7.SonidoClick(Sender: TObject);
begin
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

end.

