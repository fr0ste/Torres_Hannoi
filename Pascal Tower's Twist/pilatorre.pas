(*
  fecha de creacion: 26/05/2023
  fecha de actualización:29/06/2023
  descripción:
*)
unit PilaTorre;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Disco, ExtCtrls, Controls;

type
  TPilaTorre = class
  private
    elementos: array of TImgDisco;
    tope: integer;
    coordenadaX, coordenadaY: integer;
    contenedor: TImage;
    idPila: integer;
  public
    constructor Create(id, tamanio, posX, posY: integer; contenedorImg: TImage);
    procedure Push(disco: TImgDisco);
    function Pop: TImgDisco;
    function EsVacia: boolean;
    function EsLlena: boolean;
    function GetCoordenadaX: integer;
    function GetCoordenadaY: integer;
    function GetTope: TImgDisco;
    function GetContenedor: TImage;
    function GetId: integer;

  end;

implementation

constructor TPilaTorre.Create(id, tamanio, posX, posY: integer; contenedorImg: TImage);
begin
  SetLength(elementos, tamanio);
  tope := -1;
  coordenadaX := posX;
  coordenadaY := posY - 60;
  contenedor := contenedorImg;
  idPila := id;
end;

procedure TPilaTorre.Push(disco: TImgDisco);
begin
  if not EsLlena then
  begin

    //coordenadaX := coordenadaX + 15;

    disco.posicionDisco((coordenadaX - (disco.getWidth() div 2)), coordenadaY);
    coordenadaY := coordenadaY - 40;
    Inc(tope);
    elementos[tope] := disco;
  end
  else
    Writeln('La pila está llena. No se puede agregar más elementos.');
end;

function TPilaTorre.Pop: TImgDisco;
begin
  if not EsVacia then
  begin
    //coordenadaX := coordenadaX - 15;
    coordenadaY := coordenadaY + 40;
    Result := elementos[tope];
    Dec(tope);
  end
  else
    Writeln('La pila está vacía. No se puede extraer ningún elemento.');
end;

function TPilaTorre.EsVacia: boolean;
begin
  Result := tope = -1;
end;

function TPilaTorre.EsLlena: boolean;
begin
  Result := tope = High(elementos);
end;

function TPilaTorre.GetCoordenadaX: integer;
begin
  Result := coordenadaX;
end;

function TPilaTorre.GetCoordenadaY: integer;
begin
  Result := coordenadaY;
end;

function TPilaTorre.GetTope: TImgDisco;
begin
  Result := elementos[tope];
end;

function TPilaTorre.GetContenedor: TImage;
begin
  Result := contenedor;
end;

function TPilaTorre.GetId: integer;
begin
  Result := idPila;
end;

end.
