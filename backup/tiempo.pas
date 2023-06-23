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
    Paused: Boolean;
    constructor Create;
    procedure IniciarTimer(var labelTiempo: TLabel);
    procedure Pausar;
    procedure Reiniciar;
    procedure Continuar;
  end;

implementation

constructor TTiempoCronometro.Create;
begin
  inherited Create(nil);
  StartTime := 0;
  ElapsedTime := 0;
  Paused := false;
end;

procedure TTiempoCronometro.IniciarTimer(var labelTiempo: TLabel);
var
  Hours, Minutes, Seconds, Milliseconds: Word;
begin
  if Paused and not enabled then
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
  labelTiempo.Caption := Format('Tiempo transcurrido: %.2d:%.2d:%.2d', [Hours, Minutes, Seconds]);
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

end.

