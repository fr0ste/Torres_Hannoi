(*
  fecha de creacion: 26/05/2023
  fecha de actualización:29/06/2023
  descripción:
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

constructor TTiempoCronometro.Create;
begin
  inherited Create(nil);
  StartTime := 0;
  ElapsedTime := 0;
  Paused := False;
end;

//procedure TTiempoCronometro.IniciarTimer(var labelTiempo: TLabel);
//var
//  Hours, Minutes, Seconds, Milliseconds: word;
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


procedure TTiempoCronometro.Pausar;
begin
  Paused := True;
  Enabled := False;

end;

procedure TTiempoCronometro.Reiniciar;
begin
  Paused := True;
  Enabled := False;
  StartTime := 0;
  ElapsedTime := 0;
end;

procedure TTiempoCronometro.Continuar;
begin
  if Paused then
  begin
    StartTime := Now - ElapsedTime;
    Paused := False;
    Enabled := True;

  end;
end;


function TTiempoCronometro.MillisecondsBetween(const DT1, DT2: TDateTime): int64;
begin
  Result := Round(MillisecondsBetweenFloat(DT1, DT2));
end;

function TTiempoCronometro.MillisecondsBetweenFloat(const DT1, DT2: TDateTime): double;
begin
  Result := (DT2 - DT1) * MSecsPerDay;
end;

function TTiempoCronometro.ObtenerTiempo: integer;
begin
  Result := MillisecondsBetween(StartTime, Now) div 1000;
end;

procedure TTiempoCronometro.setTiempo(tiempo: integer);
var
  Horas, Minutos, segundos: Word;
begin

  horas := tiempo div 3600; // Obtener las horas
  minutos := (tiempo mod 3600) div 60; // Obtener los minutos
  segundos := (tiempo mod 3600) mod 60; // Obtener los segundos

  // Crear el valor de tiempo TDateTime utilizando EncodeTime
  ElapsedTime := EncodeTime(0, Minutos, segundos, 0);
end;

end.
