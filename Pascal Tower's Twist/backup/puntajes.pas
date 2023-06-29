(*
  fecha de creacion:
  fecha de actualización:
  descripción:
*)

unit puntajes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Grids,
  StdCtrls, Funciones, Math, TransaccionesMySQL;

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
    Imagen1: Timage;

    Imagen3: Timage;
    StringGrid1: TStringGrid;


    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure SonidoClick(Sender: TObject);
    constructor Create(UserID: Integer); // Constructor personalizado

  private

  public
    rutaImg: string;//para obtener la ruta de las imagenes a cargar
    isPaused: boolean;
    fname: string;
    IdUsuario:Integer;
  end;

const

  rows = 10; //filas

  cols = 1;  //columnas

var
  Form6: TForm6;

implementation

{$R *.lfm}

uses
  menuInicio;


{ TForm6 }


procedure TForm6.Image3Click(Sender: TObject);
var
  Form3: TForm3;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  Hide;
  Form3 := TForm3.Create(IdUsuario);
  Form3.Show;
end;

procedure TForm6.Image4Click(Sender: TObject);
var
  puntajes: TStringArray;
  i: integer;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  puntajes := obtenerPuntaje(2); // Pasa el nivel deseado como argumento

  // Borra los elementos existentes en el TStringGrid
  StringGrid1.Clear;

  // Establece el número de filas en función de la longitud de la matriz puntajes
  StringGrid1.RowCount := Length(puntajes) + 1;

  // Agrega los elementos de la matriz al TStringGrid
  for i := 0 to Length(puntajes) - 1 do
  begin

    StringGrid1.Cells[1, 0] := 'Nombre';
    StringGrid1.Cells[0, 0] := 'No.';
    StringGrid1.Cells[2, 0] := 'Puntaje';
    StringGrid1.Cells[0, i + 1] := IntToStr(i+1); // Columna 0: nombre
    StringGrid1.Cells[1, i + 1] := puntajes[i][0]; // Columna 0: nombre
    StringGrid1.Cells[2, i + 1] := puntajes[i][1]; // Columna 1: puntaje

  end;
end;

procedure TForm6.Image5Click(Sender: TObject);
var
  puntajes: TStringArray;
  i: integer;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  puntajes := obtenerPuntaje(3); // Pasa el nivel deseado como argumento

  // Borra los elementos existentes en el TStringGrid
  StringGrid1.Clear;

  // Establece el número de filas en función de la longitud de la matriz puntajes
  StringGrid1.RowCount := Length(puntajes) + 1;

  // Agrega los elementos de la matriz al TStringGrid
  for i := 0 to Length(puntajes) - 1 do
  begin

    StringGrid1.Cells[1, 0] := 'Nombre';
    StringGrid1.Cells[0, 0] := 'No.';
    StringGrid1.Cells[2, 0] := 'Puntaje';
    StringGrid1.Cells[0, i + 1] := IntToStr(i+1); // Columna 0: nombre
    StringGrid1.Cells[1, i + 1] := puntajes[i][0]; // Columna 0: nombre
    StringGrid1.Cells[2, i + 1] := puntajes[i][1]; // Columna 1: puntaje

  end;
end;

procedure TForm6.Image6Click(Sender: TObject);
var
  puntajes: TStringArray;
  i: integer;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  puntajes := obtenerPuntaje(4); // Pasa el nivel deseado como argumento

  // Borra los elementos existentes en el TStringGrid
  StringGrid1.Clear;

  // Establece el número de filas en función de la longitud de la matriz puntajes
  StringGrid1.RowCount := Length(puntajes) + 1;

  // Agrega los elementos de la matriz al TStringGrid
  for i := 0 to Length(puntajes) - 1 do
  begin

    StringGrid1.Cells[1, 0] := 'Nombre';
    StringGrid1.Cells[0, 0] := 'No.';
    StringGrid1.Cells[2, 0] := 'Puntaje';
    StringGrid1.Cells[0, i + 1] := IntToStr(i+1); // Columna 0: nombre
    StringGrid1.Cells[1, i + 1] := puntajes[i][0]; // Columna 0: nombre
    StringGrid1.Cells[2, i + 1] := puntajes[i][1]; // Columna 1: puntaje

  end;
end;

procedure TForm6.Image7Click(Sender: TObject);
var
  puntajes: TStringArray;
  i: integer;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  puntajes := obtenerPuntaje(5); // Pasa el nivel deseado como argumento

  // Borra los elementos existentes en el TStringGrid
  StringGrid1.Clear;

  // Establece el número de filas en función de la longitud de la matriz puntajes
  StringGrid1.RowCount := Length(puntajes) + 1;

  // Agrega los elementos de la matriz al TStringGrid
  for i := 0 to Length(puntajes) - 1 do
  begin

    StringGrid1.Cells[1, 0] := 'Nombre';
    StringGrid1.Cells[0, 0] := 'No.';
    StringGrid1.Cells[2, 0] := 'Puntaje';
    StringGrid1.Cells[0, i + 1] := IntToStr(i+1); // Columna 0: nombre
    StringGrid1.Cells[1, i + 1] := puntajes[i][0]; // Columna 0: nombre
    StringGrid1.Cells[2, i + 1] := puntajes[i][1]; // Columna 1: puntaje

  end;
end;

procedure TForm6.Image8Click(Sender: TObject);
var
  puntajes: TStringArray;
  i: integer;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  puntajes := obtenerPuntaje(6); // Pasa el nivel deseado como argumento

  // Borra los elementos existentes en el TStringGrid
  StringGrid1.Clear;

  // Establece el número de filas en función de la longitud de la matriz puntajes
  StringGrid1.RowCount := Length(puntajes) + 1;

  // Agrega los elementos de la matriz al TStringGrid
  for i := 0 to Length(puntajes) - 1 do
  begin

    StringGrid1.Cells[1, 0] := 'Nombre';
    StringGrid1.Cells[0, 0] := 'No.';
    StringGrid1.Cells[2, 0] := 'Puntaje';
    StringGrid1.Cells[0, i + 1] := IntToStr(i+1); // Columna 0: nombre
    StringGrid1.Cells[1, i + 1] := puntajes[i][0]; // Columna 0: nombre
    StringGrid1.Cells[2, i + 1] := puntajes[i][1]; // Columna 1: puntaje

  end;
end;

procedure TForm6.SonidoClick(Sender: TObject);

begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  // Si la reproducción está pausada, se reanuda la reproducción
  if isPaused then
  begin
    Pause(isPaused);
    rutaImg := obtenerRutaImagen(Application.ExeName);
    Sonido.Picture.LoadFromFile(rutaImg + '/fondos/sinsonido.png');
    //BtnPausePlay.Caption := 'Pause';
    isPaused := False;
  end
  else
  begin
    // Si la reproducción está en curso, se pausa la reproducción

    Pause(isPaused);
    rutaImg := obtenerRutaImagen(Application.ExeName);
    Sonido.Picture.LoadFromFile(rutaImg + '/fondos/sonido.png');
    //BtnPausePlay.Caption := 'Reanudar';
    isPaused := True;
  end;
end;

procedure TForm6.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Terminate;
end;

procedure TForm6.FormCreate(Sender: TObject);
var
  puntajes: TStringArray;
  i: integer;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  puntajes := obtenerPuntaje(1); // Pasa el nivel deseado como argumento

  // Borra los elementos existentes en el TStringGrid
  StringGrid1.Clear;

  // Establece el número de filas en función de la longitud de la matriz puntajes
  StringGrid1.RowCount := Length(puntajes) + 1;

  // Agrega los elementos de la matriz al TStringGrid
  for i := 0 to Length(puntajes) - 1 do
  begin

    StringGrid1.Cells[1, 0] := 'Nombre';
    StringGrid1.Cells[0, 0] := 'No.';
    StringGrid1.Cells[2, 0] := 'Puntaje';
    StringGrid1.Cells[0, i + 1] := IntToStr(i+1); // Columna 0: nombre
    StringGrid1.Cells[1, i + 1] := puntajes[i][0]; // Columna 0: nombre
    StringGrid1.Cells[2, i + 1] := puntajes[i][1]; // Columna 1: puntaje

  end;
end;

procedure TForm6.FormShow(Sender: TObject);
var
  i, j: integer;

begin
  rutaImg := obtenerRutaImagen(Application.ExeName);
  Sonido.Picture.LoadFromFile(rutaImg + '/fondos/sinsonido.png');
  isPaused := False;

end;

procedure TForm6.Image2Click(Sender: TObject);
var
  puntajes: TStringArray;
  i: integer;
begin
  fname := ExtractFilePath(Application.ExeName) + '/Audios/SonidoBoton.mp3';
  //ShowMessage(fname);
  PlayBoton(fname);
  puntajes := obtenerPuntaje(1); // Pasa el nivel deseado como argumento

  // Borra los elementos existentes en el TStringGrid
  StringGrid1.Clear;

  // Establece el número de filas en función de la longitud de la matriz puntajes
  StringGrid1.RowCount := Length(puntajes) + 1;

  // Agrega los elementos de la matriz al TStringGrid
  for i := 0 to Length(puntajes) - 1 do
  begin

    StringGrid1.Cells[1, 0] := 'Nombre';
    StringGrid1.Cells[0, 0] := 'No.';
    StringGrid1.Cells[2, 0] := 'Puntaje';
    StringGrid1.Cells[0, i + 1] := IntToStr(i+1); // Columna 0: nombre
    StringGrid1.Cells[1, i + 1] := puntajes[i][0]; // Columna 0: nombre
    StringGrid1.Cells[2, i + 1] := puntajes[i][1]; // Columna 1: puntaje

  end;
end;


constructor TForm6.Create(UserID: Integer);
begin
  inherited Create(nil);
  IdUsuario:= UserID;
  // Resto del código de inicialización del formulario...
end;

end.
