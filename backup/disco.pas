unit Disco;

{$mode objfpc}{$H+}

interface

uses
 Classes, SysUtils, extctrls, Controls;
{creamos un tipo de dato TImageDisco de tipo clase, tiene un constructor y un
procedimiento para posicionar la imagen dentro de la vista}
type
 TImgDisco = class(TImage)
 private
 public
   numPila: integer; // Nueva propiedad para almacenar la pila de origen
   numDisco: integer;//Numero de disco
   constructor Create(AOwner: TComponent;ancho:integer); reintroduce;
   procedure posicionDisco(x,y:Integer);
   function getWidth():Integer;
 end;

implementation
constructor TImgDisco.Create(AOwner: TComponent; ancho: integer);
begin
 inherited Create(AOwner);
 Width := ancho;
 Height := 80;
 Left := 0;
 Top := 0;
 Parent := AOwner as TWinControl;
end;
procedure TImgDisco.posicionDisco(x,y:Integer);
begin
  Left := x;
  Top := y;
end;
function TImgDisco.getWidth(): integer;
begin
     Result:= Width;
end;

end.
