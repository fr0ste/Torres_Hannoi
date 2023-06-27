unit Funciones;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Controls, Disco, BASS, Grids, Math;

function crearImagen(AOwner: TWinControl; ancho: integer): TImgDisco;
function obtenerRutaImagen(rutaApp: string): string;
function ValidarDisco(disco, discoenTop: TImgDisco): boolean;
procedure PlayMP3(FileName: string);
procedure PlayBoton(FileName: string);
procedure Pause(isPause: boolean);
procedure Tabla(Grid: TStringGrid);
function EsAlfaNumerico(ch: char): boolean;
function EsLetra(ch: char): boolean;
function EsDigito(ch: char): boolean;
function EsCaracterEspecial(ch: char): boolean;
function CalcularPuntaje(tiempo, nivel: integer): integer;

var
  Bstream: dword; // Canal del audio
  BstreamBoton: dword;

implementation


function crearImagen(AOwner: TWinControl; ancho: integer): TImgDisco;
begin
  Result := TImgDisco.Create(AOwner, ancho);
end;

function obtenerRutaImagen(rutaApp: string): string;
var
  ruta: string;
begin
  ruta := ExtractFilePath(rutaApp);
  ruta := IncludeTrailingPathDelimiter(ruta) + 'img' + PathDelim;
  Result := ruta;
end;

function ValidarDisco(disco, discoenTop: TImgDisco): boolean;
var
  bandera: boolean;
begin
  bandera := False;
  if disco.numDisco < discoenTop.numDisco then
    bandera := False
  else
    bandera := True;
  Result := bandera;
end;
// Este procedimiento se encarga de reproducir el archivo de audio especificado
procedure PlayMP3(FileName: string);
var
  flags: DWORD;
  err: integer;
  Vol: single;

begin
  // Configura las opciones de reproducción
  flags := BASS_STREAM_PRESCAN;
  flags := flags or BASS_SAMPLE_LOOP;

  // Crea un canal de transmisión de audio a partir del archivo especificado
  BStream := BASS_StreamCreateFile(False, PChar(Filename), 0, 0, flags);


  // Establece el volumen del canal de audio
  BASS_ChannelSetAttribute(BStream, BASS_ATTRIB_VOL, 1);

  // Obtiene el código de error actual (si lo hay)
  err := BASS_ErrorGetCode;

  // Reproduce el canal de audio
  BASS_ChannelPlay(BStream, False);
end;

procedure PlayBoton(FileName: string);
var
  flags: DWORD;
  err: integer;
  Vol: single;

begin
  // Configura las opciones de reproducción
  flags := BASS_STREAM_PRESCAN;
  flags := flags or BASS_Sample_Float;

  // Crea un canal de transmisión de audio a partir del archivo especificado
  BstreamBoton := BASS_StreamCreateFile(False, PChar(Filename), 0, 0, flags);


  // Establece el volumen del canal de audio
  BASS_ChannelSetAttribute(BstreamBoton, BASS_ATTRIB_VOL, 0.3);

  // Obtiene el código de error actual (si lo hay)
  err := BASS_ErrorGetCode;

  // Reproduce el canal de audio
  BASS_ChannelPlay(BstreamBoton, False);
end;

procedure Pause(isPause: boolean);
begin
  if isPause then
  begin
    BASS_ChannelPlay(Bstream, False);
    //BtnPausePlay.Caption := 'Pause';

  end
  else
  begin
    // Si la reproducción está en curso, se pausa la reproducción
    BASS_ChannelPause(Bstream);
    //BtnPausePlay.Caption := 'Reanudar';

  end;
end;

procedure Tabla(Grid: TStringGrid);
var
  rows: integer;
  cols: integer;
  i, j: integer;
begin
  rows := 10;
  cols := 1;
  Randomize;//generador de semillas para numeros aleatorios
  Grid.RowCount := rows + 1;//se le agrega uno mas para los titulos
  Grid.ColCount := cols + 1;
  Grid.Cells[0, 0] := 'Nombre';
  Grid.Cells[1, 0] := 'Puntaje';
  //asignar titulos
  for i := 1 to rows do
    Grid.Cells[0, i] := 'Jose' + IntToStr(i);
  for i := 1 to rows do
    for j := 1 to cols do
      Grid.Cells[j, i] := IntToStr(RandomRange(18, 57));
end;


function EsAlfaNumerico(ch: char): boolean;
begin
  Result := EsLetra(ch) or EsDigito(ch);
end;

function EsLetra(ch: char): boolean;
begin
  Result := (ch >= 'A') and (ch <= 'Z') or (ch >= 'a') and (ch <= 'z');
end;

function EsDigito(ch: char): boolean;
begin
  Result := (ch >= '0') and (ch <= '9');
end;

function EsCaracterEspecial(ch: char): boolean;
const
  CaracteresEspeciales = ['!', '@', '#', '$', '%', '&'];
  // Caracteres especiales permitidos
begin
  Result := ch in CaracteresEspeciales;
end;

function CalcularPuntaje(tiempo, nivel: integer): integer;
const
  ValorBaseNivel: array[1..6] of integer = (100, 200, 300, 400, 500, 600);
  FactorConversion: real = 0.5;
var
  puntaje: integer;
begin
  if (tiempo >= 0) and (nivel >= 1) and (nivel <= 6) then
  begin
    puntaje := ValorBaseNivel[nivel] - Round(tiempo * FactorConversion);
    if (puntaje < 0) then
      puntaje := 0;
  end
  else
    puntaje := 0;

  Result := puntaje;
end;


end.
