unit mainAtm;

    {$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Funciones, PilaTorre, Disco;

type
  TMovimientos = record
    MovOrigen: integer;
    MovDestino: integer;
  end;


type
  TReadThread = class(TThread)
  public
    FDestination: TPilaTorre;
    FSource, FAux: TPilaTorre;
    FFileName: string;
    constructor Create(var ASource, ADestination, Aaux: TPilaTorre;
      var AFileName: string);

  private
    function obtenerPila(numPila: integer): TPilaTorre;
  protected
    procedure Execute; override;
  end;

type
  TMoveThread = class(TThread)
  public


    constructor Create(var ASource, ADestination: TPilaTorre);
  private
    FDestination: TPilaTorre;
    FSource: TPilaTorre;
  protected
    procedure Execute; override;
  end;

type
  { TForm9 }

  TForm9 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    torre1: TImage;
    torre2: TImage;
    torre3: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    procedure Button1Click(Sender: TObject);
   // procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private

  public
    procedure cargarTorre(numPila, numDisco: integer; pila: TPilaTorre);
    procedure crearPilas(tamanio: integer);

    //resolver automatico
     procedure SetNumero(Numero: Integer);
    procedure nuevoJuego();
    procedure cargarDatosJuego;
    function obtenerVelocidad(numDiscos: integer): integer;

  end;

var
  Form9: TForm9;

  //pilas para las torres
  pilaTorre1, pilaTorre2, pilaTorre3: TPilaTorre;
  FNumero: Integer;//numero para cargar los fondos
  //variables para la resolucion automatica
  hiloLeerMovs: TReadThread;
  velocidad: integer;
  rutaImg: String;//para obtener la ruta de las imagenes a cargar


  archivoMovimientos: string;
  maxVelocidad: integer = 6;



implementation

    {$R *.lfm}

{ TForm9 }

constructor TMoveThread.Create(var ASource, ADestination: TPilaTorre);
begin
  inherited Create(False);

  FSource := ASource;
  FDestination := ADestination;

end;

constructor TReadThread.Create(var ASource, ADestination, Aaux: TPilaTorre;
  var AFileName: string);
begin
  inherited Create(False);

  FSource := ASource;
  FDestination := ADestination;
  FAux := Aaux;
  FFileName := AFileName;

end;



procedure TForm9.Button1Click(Sender: TObject);

begin

  //LeerMovimientos(archivoMovimientos);
  hiloLeerMovs := TReadThread.Create(pilaTorre1, pilaTorre3, pilaTorre2,
    archivoMovimientos);
  hiloLeerMovs.Start;
  hiloLeerMovs.WaitFor;

end;


procedure TForm9.FormShow(Sender: TObject);
var
  F: file of TMovimientos;
begin
     //********************************************************************************************************************
    rutaImg := obtenerRutaImagen(Application.ExeName);
        // Cargamos la imagen con la ruta
    Image1.Picture.LoadFromFile(rutaImg + '/fondos/fondo' + IntToStr(FNumero) + '.png');
        crearPilas(FNumero);
        cargarDatosJuego;
        cargarTorre(1,FNumero,pilaTorre1);
   // cargarTorre(1,FNumero,pilaTorre1);



    velocidad := 16;
     //se crea el archivo que contendra los movimientos en caso de que no exista
  if not FileExists(archivoMovimientos) then
  begin
    AssignFile(F, archivoMovimientos);
    Rewrite(F);
    CloseFile(F);
  end;
end;


procedure TReadThread.Execute;

var
  F: file of TMovimientos;
  movimiento: TMovimientos;
  hiloMoveDisco: TMoveThread;
  TorreOrigen, TorreDestino: TPilaTorre;
begin
  AssignFile(F, FFileName);
  Reset(F);
  try
    while not EOF(F) do
    begin
      Read(F, movimiento);


      TorreOrigen := obtenerPila(movimiento.MovOrigen);
      TorreDestino := obtenerPila(movimiento.MovDestino);

      hiloMoveDisco := TMoveThread.Create(TorreOrigen, TorreDestino);
      hiloMoveDisco.Start;
      hiloMoveDisco.WaitFor;

    end;
  finally
    CloseFile(F);
  end;

end;

//hilo que ejecta el moviemiento de los discos
procedure TMoveThread.Execute;

var
  Disco: TImgDisco;
  i, j: integer;

begin

  i := velocidad;
  j := velocidad;

  Disco := FSource.Pop;

  //Movimientos:=Movimientos+1;

  //Actualizar la interfaz gráfica: Mover el disco visualmente

  if FNumero < maxVelocidad then

  begin

    //animar el alzar el disco (movimiento en el eje y)
  while disco.top - disco.Height > FSource.GetCoordenadaY -
    FSource.GetContenedor.Top do

  begin
    //movimiento en y
    disco.posicionDisco(disco.Left, disco.top - i);
    Disco.Repaint;

    i := i + velocidad;
  end;
    //fin de animar en y

  //movimiento en x
  if FSource.GetCoordenadaX < FDestination.GetCoordenadaX then
  begin
    while disco.Left < FDestination.GetCoordenadaX do
    begin

      disco.posicionDisco(disco.Left + j, disco.top);

      disco.Repaint;
      j := j + velocidad;

    end;
  end
  else

  begin

    while disco.Left > FDestination.GetCoordenadaX do
    begin
      disco.posicionDisco(disco.Left - j, disco.top);
      Disco.Repaint;


      j := j + velocidad;

    end;

  end;

  FDestination.Push(Disco);
  end
  else
  begin
    //animar el alzar el disco (movimiento en el eje y)

    //movimiento en y
    disco.posicionDisco(disco.Left, disco.top - FSource.GetCoordenadaY -
    FSource.GetContenedor.Top);
    Disco.Repaint;


  FDestination.Push(Disco);
  end;

end;



//fin Resolver el juego de las Torres de Hanoi de manera automatica


procedure TForm9.cargarTorre(numPila,numDisco: Integer; pila: TPilaTorre);
var
  ancho, i: integer;
  imgDisco: integer;
  discoAux: TImgDisco;
begin
  rutaImg := obtenerRutaImagen(Application.ExeName);
  ancho := 60+(numDisco*30);
  imgDisco:= 8 - (numDisco-1);
  for i := 0 to numDisco - 1 do
  begin

    discoAux := TImgDisco.Create(Self,ancho);

    // Cargamos la imagen con la ruta
    discoAux.Picture.LoadFromFile(rutaImg + '/discos/i' + IntToStr(imgDisco) + '.png');

    // Guardamos el disco en la pila
    pila.Push(discoAux);
    ancho := ancho - 30;
    imgDisco:=imgDisco+1;
  end;
end;

procedure TForm9.crearPilas(tamanio: integer);
begin
  pilaTorre1 := TPilaTorre.Create(1, tamanio, (torre1.Left + 30),
    (torre1.Top + torre1.Height), torre1);
  pilaTorre2 := TPilaTorre.Create(2, tamanio, (torre2.Left + 30),
    (torre1.Top + torre2.Height), torre2);
  pilaTorre3 := TPilaTorre.Create(3, tamanio, (torre3.Left + 30),
    (torre1.Top + torre3.Height), torre3);
end;

function TReadThread.obtenerPila(numPila: integer): TPilaTorre;
begin
  case numPila of
    1: Result := FSource;
    2: Result := FAux;
    3: Result := FDestination;
    else
      Result := nil; // Retornar nil en caso de que el número de pila no sea válido
  end;
end;

function TForm9.obtenerVelocidad(numDiscos: integer): integer;
begin

  if numDiscos > maxVelocidad then
    Result := 100
  else if numDiscos > 3 then
    Result := 10
  else
    Result := 1;

end;



procedure TForm9.cargarDatosJuego;
begin
  archivoMovimientos := 'lvl' + IntToStr(FNumero - 2) + '.dat';
end;

    procedure TForm9.SetNumero(Numero: Integer);
begin
  FNumero := Numero;
end;

procedure TForm9.nuevoJuego();
var
  Form9: TForm9;
  numDisc: integer;
begin
  // Ocultar el formulario actual (Form9)
  numDisc:= FNumero;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form9 := TForm9.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form9.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form9.Show;
end;



end.



