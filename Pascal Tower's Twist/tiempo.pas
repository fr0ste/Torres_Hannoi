(*
  fecha de creacion: 26/05/2023
  fecha de actualización:29/06/2023
  descripción: Esta clase se encarga de controlar la ejecución del tiempo en
  las partidas
*)
unit Tiempo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type
  TTiempoCronometro = class(TTimer)
  private

  public
    StartTime: TDateTime;
    ElapsedTime: TDateTime;
    Paused: boolean;
    constructor Create;
    procedure IniciarTimer(var labelTiempo: TLabel);
    procedure Pausar;
    procedure Reiniciar;
    procedure Continuar;
    function MillisecondsBetween(const DT1, DT2: TDateTime): int64;
    function MillisecondsBetweenFloat(const DT1, DT2: TDateTime): double;
    function ObtenerTiempo: integer;
    procedure setTiempo(tiempo: integer);
  end;

implementation

(*
  Crea el cornometro
*)
constructor TTiempoCronometro.Create;
begin
  inherited Create(nil);
  StartTime := 0;
  ElapsedTime := 0;
  Paused := False;
end;

(*
Inicializa el timer para su reproduccion
*)
procedure TTiempoCronometro.IniciarTimer(var labelTiempo: TLabel);
var
  Hours, Minutes, Seconds, Milliseconds: word;
begin
  if Paused and not Enabled then
  begin
    StartTime := Now - (ElapsedTime - StartTime);
    Paused := False;

  end
  else
  begin
    StartTime := Now;
    ElapsedTime := 0;
  end;

  Enabled := True;


  DecodeTime(ElapsedTime, Hours, Minutes, Seconds, Milliseconds);
  labelTiempo.Caption := Format('%.2d:%.2d:%.2d', [Hours, Minutes, Seconds]);
end;

 (*
 Pausa el timer para que no se pierda el tiempo
 *)
procedure TTiempoCronometro.Pausar;
begin
  Paused := True;
  Enabled := False;

end;

   (*
   Reinicia el timer cada que se inicia un nuevo nivel
   *)
procedure TTiempoCronometro.Reiniciar;
begin
  Paused := True;
  Enabled := False;
  StartTime := 0;
  ElapsedTime := 0;
end;

    (*
    Cuando se reanuda se toma el tiempo que se dejo
    *)
procedure TTiempoCronometro.Continuar;
begin
  if Paused then
  begin
    StartTime := Now - ElapsedTime;
    Paused := False;
    Enabled := True;

  end;
end;
(*
  Devuelve el tiempo en milisegundos
*)
function TTiempoCronometro.MillisecondsBetween(const DT1, DT2: TDateTime): int64;
begin
  Result := Round(MillisecondsBetweenFloat(DT1, DT2));
end;
(*
Devuelve el tiempo en floats
*)
function TTiempoCronometro.MillisecondsBetweenFloat(const DT1, DT2: TDateTime): double;
begin
  Result := (DT2 - DT1) * MSecsPerDay;
end;

function TTiempoCronometro.ObtenerTiempo: integer;
begin
  Result := MillisecondsBetween(StartTime, Now) div 1000;
end;
(*
Establece un tiempo en el cronometro
*)
procedure TTiempoCronometro.setTiempo(tiempo: integer);
var
  Horas, Minutos, segundos: word;
begin

  horas := tiempo div 3600; // Obtener las horas
  minutos := (tiempo mod 3600) div 60; // Obtener los minutos
  segundos := (tiempo mod 3600) mod 60; // Obtener los segundos

  // Crear el valor de tiempo TDateTime utilizando EncodeTime
  ElapsedTime := EncodeTime(0, Minutos, segundos, 0);
end;

end.
