unit Funciones;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Controls, Disco,BASS, Grids,Math;

function crearImagen(AOwner: TWinControl; ancho: integer): TImgDisco;
function obtenerRutaImagen(rutaApp: String): String;
function ValidarDisco(disco,discoenTop:TImgDisco):boolean;
procedure PlayMP3(FileName: string);
procedure Pause(isPause: Boolean);
procedure Tabla(Grid:TStringGrid);
var
 Bstream: dword; // Canal del audio
implementation


function crearImagen(AOwner: TWinControl; ancho: integer): TImgDisco;
begin
  Result := TImgDisco.Create(AOwner,ancho);
end;

function obtenerRutaImagen(rutaApp: String): String;
var
  ruta: String;
begin
  ruta := ExtractFilePath(rutaApp);
  ruta := IncludeTrailingPathDelimiter(ruta) + 'img' + PathDelim;
  Result:=ruta;
end;
 function ValidarDisco(disco,discoenTop:TImgDisco):boolean;
 var
    bandera:boolean;
 begin
   bandera:=false;
     if disco.numDisco < discoenTop.numDisco then
       bandera := false
     else
       bandera:= true;
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
  flags := flags or  BASS_SAMPLE_LOOP;

  // Crea un canal de transmisión de audio a partir del archivo especificado
  BStream := BASS_StreamCreateFile(False, PChar(Filename), 0, 0, flags);


  // Establece el volumen del canal de audio
  BASS_ChannelSetAttribute(BStream, BASS_ATTRIB_VOL, 1);

  // Obtiene el código de error actual (si lo hay)
  err := BASS_ErrorGetCode;

  // Reproduce el canal de audio
  BASS_ChannelPlay(BStream, False);
end;
 procedure Pause(isPause: Boolean);
 begin
   if isPause then
  begin
    BASS_ChannelPlay(Bstream, false);
    //BtnPausePlay.Caption := 'Pause';

  end
  else
  begin
    // Si la reproducción está en curso, se pausa la reproducción
    BASS_ChannelPause(Bstream);
    //BtnPausePlay.Caption := 'Reanudar';

  end;
 end;
 procedure Tabla(Grid:TStringGrid);
 var
 rows:Integer;
 cols:Integer;
 i,j:Integer;
 begin
      rows := 10;
      cols:=1;
    Randomize;//generador de semillas para numeros aleatorios
       Grid.RowCount:=rows+1;//se le agrega uno mas para los titulos
    Grid.ColCount:=cols+1;//
    //asignar titulos
    for i:=1 to rows do
        Grid.Cells[0,i]:='Jose'+ IntToStr(i);

        Grid.Cells[0,0]:='Nombre';
        Grid.Cells[1,0]:='Puntaje';

     for i:=1 to rows do
         for j:=1 to cols do
         Grid.Cells[j,i]:=IntToStr(RandomRange(18,57));
 end;

end.

