unit nivelesAutomatico;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,bass,funciones;

type

  { TForm12 }

  TForm12 = class(TForm)
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
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure SonidoClick(Sender: TObject);
  private

  public
   fname:String;
    rutaImg: String;//para obtener la ruta de las imagenes a cargar
   isPaused: boolean;
  end;

var
  Form12: TForm12;

implementation

{$R *.lfm}
uses
  mainAtm,menuInicio;

{ TForm12 }

procedure TForm12.Image2Click(Sender: TObject);
var
  Form3:TForm3;
begin
  Hide;
  Form3:=TForm3.Create(nil);
  Form3.Show;

end;

procedure TForm12.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
     Application.Terminate;
end;

procedure TForm12.FormCreate(Sender: TObject);
begin
  //BASS_Free;
      // Inicializa el sistema de audio BASS con la configuración predeterminada
  //BASS_Init(-1, 44100, 0, nil, nil);
end;

procedure TForm12.FormShow(Sender: TObject);
begin
       rutaImg := obtenerRutaImagen(Application.ExeName);
     Sonido.Picture.LoadFromFile(rutaImg+'/fondos/sinsonido.png');
      isPaused := false;
   //fname:=ExtractFilePath(Application.ExeName)+'BandaMisteriosaRango.mp3';
       //ShowMessage(fname);
       //PlayMP3(fname);
end;

procedure TForm12.Label1Click(Sender: TObject);
var
  Farm9:TForm9;
  numDisc: integer;
begin
  numDisc:=3;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form9 := TForm9.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form9.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form9.Show;

end;

procedure TForm12.Label2Click(Sender: TObject);
var
  Farm9:TForm9;
  numDisc: integer;
begin
  numDisc:=4;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form9 := TForm9.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form9.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form9.Show;
end;

procedure TForm12.Label3Click(Sender: TObject);
var
  Farm9:TForm9;
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

procedure TForm12.Label4Click(Sender: TObject);
var
  Farm9:TForm9;
  numDisc: integer;
begin
  numDisc:=6;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form9 := TForm9.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form9.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form9.Show;
end;

procedure TForm12.Label5Click(Sender: TObject);
var
  Farm9:TForm9;
  numDisc: integer;
begin
  numDisc:=7;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form9 := TForm9.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form9.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form9.Show;
end;

procedure TForm12.Label6Click(Sender: TObject);
var
  Farm9:TForm9;
  numDisc: integer;
begin
  numDisc:=8;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form9 := TForm9.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form9.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form9.Show;
end;

procedure TForm12.SonidoClick(Sender: TObject);
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

end.

