unit Funciones;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Controls, Disco;

function crearImagen(AOwner: TWinControl; ancho: integer): TImgDisco;
function obtenerRutaImagen(rutaApp: String): String;
function ValidarDisco(disco,discoenTop:TImgDisco):boolean;
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
     if disco.numDisco > discoenTop.numDisco then
       bandera := false
     else
       bandera:= true;
     Result := bandera;
  end;

end.

