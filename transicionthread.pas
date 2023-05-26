unit TransicionThread;

{$mode ObjFPC}{$H+}

interface

uses
   Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, extctrls, PilaTorre, Disco;

type
  TTransicionThread = class(TThread)
  private

    nDiscos: Integer;
    Origen, Destino, Auxiliar: TPilaTorre ;

  protected
    procedure Execute; override;
  public
    constructor Create(
    inNDiscos: Integer;
    var inOrigen, inDestino, inAuxiliar: TPilaTorre
    );

  //resolver automatico
    procedure ResolverTorresHanoi(N: Integer; var inOrigen, inDestino, inAuxiliar: TPilaTorre);
    procedure MoverDisco(var inOrigen, inDestino, inAuxiliar: TPilaTorre);
  end;

implementation

    constructor TTransicionThread.Create(inNDiscos: Integer;
    var inOrigen, inDestino, inAuxiliar: TPilaTorre);
begin
  inherited Create(False);
   Origen:= inOrigen;
   Auxiliar:= inAuxiliar;
   Destino:= inDestino;
   nDiscos:= inNDiscos;
end;

procedure TTransicionThread.Execute;
begin

  //Movimientos := 0;


  //Inicio Resolver el juego de las Torres de Hanoi de manera automatica
   ShowMessage('si');
  //ResolverTorresHanoi(nDiscos,Origen,Destino,Auxiliar);
  //ShowMessage('Total de movimientos realizados: ' + IntToStr(Movimientos));


  end;


procedure TTransicionThread.ResolverTorresHanoi(N: Integer; var inOrigen, inDestino, inAuxiliar: TPilaTorre);
begin
  if N > 0 then
  begin
    ResolverTorresHanoi(N - 1, inOrigen, inAuxiliar, inDestino);
    MoverDisco(inOrigen, inDestino, inAuxiliar);
    ResolverTorresHanoi(N - 1, inAuxiliar, inDestino, inOrigen);
  end;
end;


procedure TTransicionThread.MoverDisco(var inOrigen, inDestino, inAuxiliar: TPilaTorre);
var
  Disco: TImgDisco;
  i, j: Integer;
begin


  Disco := inOrigen.Pop;

  //Movimientos:=Movimientos+1

  // Actualizar la interfaz gráfica: Mover el disco visualmente

  //animar el alzar el disco (movimiento en el eje y)
  for i := 0 to inOrigen.GetCoordenadaY - inOrigen.GetContenedor.Top do
  //for i := 0 to 100 do
  begin
       //movimiento en x
    disco.posicionDisco(disco.Left, disco.top-1);
      Disco.Repaint;
      Sleep(1);
    end;


    if inOrigen.GetCoordenadaX < inDestino.GetCoordenadaX then
    begin
    for j := 0 to inDestino.GetCoordenadaX - inOrigen.GetCoordenadaX do
  //for i := 0 to 100 do
    begin

      disco.posicionDisco(disco.Left+1, disco.top);
      Disco.Repaint;
      Sleep(1);

  end;
    end
    else
       begin
         for j := inOrigen.GetCoordenadaX downto inDestino.GetCoordenadaX do
           begin
           disco.posicionDisco(disco.Left-1, disco.top);
           Disco.Repaint;
           Sleep(1);
           end

    end;

  inDestino.Push(Disco);

end;

end.

