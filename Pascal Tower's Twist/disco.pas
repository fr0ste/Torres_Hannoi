(*
  fecha de creacion: 26/05/2023
  fecha de actualización:29/06/2023
  descripción: Caracteristicas del disco para su comparacion, creacion y
               posicionamiento
*)
unit Disco;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Controls;

{creamos un tipo de dato TImageDisco de tipo clase, tiene un constructor y un
procedimiento para posicionar la imagen dentro de la vista}
type
  TImgDisco = class(TImage)
  private
  public
    numPila: integer; // Nueva propiedad para almacenar la pila de origen
    numDisco: integer;//Numero de disco
    constructor Create(AOwner: TComponent; ancho: integer); reintroduce;
    procedure posicionDisco(x, y: integer);
    function getWidth(): integer;
  end;

implementation
(*
Crea un disco con todas sus caracteristicas
*)
constructor TImgDisco.Create(AOwner: TComponent; ancho: integer);
begin
  inherited Create(AOwner);
  Width := ancho;
  Height := 80;
  Left := 0;
  Top := 0;
  Parent := AOwner as TWinControl;
end;
 (*
 determina la posicion del disco en los ejes "X" y "Y"
 *)
procedure TImgDisco.posicionDisco(x, y: integer);
begin
  Left := x;
  Top := y;
end;
  (*
    Nos da el tamaño del disco para compararlo con otro disco y saber cuyal es
    mas grande
  *)
function TImgDisco.getWidth(): integer;
begin
  Result := Width;
end;

end.
