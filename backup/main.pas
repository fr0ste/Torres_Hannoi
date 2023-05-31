unit main;

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
  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    torre1: TImage;
    torre2: TImage;
    torre3: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private


    procedure CheckIfImageCenterInsideTower1(image: TImage);
    procedure SetTowerPosition(var bandera: boolean; disco, towerImage: TImage);
    procedure hacerPop(pila, pilaOrigen: TPilaTorre; nuevoNumeroPila: integer);



  public
    procedure cargarTorre(numPila, numDisco: integer; pila: TPilaTorre);
    procedure crearPilas(tamanio: integer);
    function obtenerTorre(numTorre: integer): TImage;
    function obtenerPila(numPila: integer): TPilaTorre;
    //resolver automatico

    procedure MoverDisco(var Origen, Destino, Auxiliar: TPilaTorre);
    procedure cargarDatosJuego;
    function obtenerVelocidad(numDiscos: integer): integer;

  end;

var
  Form1: TForm1;
  arrastrar: boolean = False;
  DragOffset: TPoint;
  //pilas para las torres
  pilaTorre1, pilaTorre2, pilaTorre3: TPilaTorre;
  origX, origY: integer; // Variables para guardar la posición original (X, Y)
  posX, posY: integer;
  numeroPila: integer;
  hiloLeerMovs: TReadThread;

  //variables resoslucion automatica
  Movimientos: integer;
  nDiscos: integer = 6;

  archivoMovimientos: string;



implementation

    {$R *.lfm}

{ TForm1 }

constructor TMoveThread.Create(var ASource, ADestination: TPilaTorre);
begin
  inherited Create(False);
  FreeOnTerminate := True;
  FSource := ASource;
  FDestination := ADestination;

end;

constructor TReadThread.Create(var ASource, ADestination, Aaux: TPilaTorre;
  var AFileName: string);
begin
  inherited Create(False);
  FreeOnTerminate := True;
  FSource := ASource;
  FDestination := ADestination;
  FAux := Aaux;
  FFileName := AFileName;

end;



procedure TForm1.Button1Click(Sender: TObject);

begin

  //LeerMovimientos(archivoMovimientos);
  hiloLeerMovs := TReadThread.Create(pilaTorre1, pilaTorre3, pilaTorre2,
    archivoMovimientos);
  hiloLeerMovs.Start;
  hiloLeerMovs.WaitFor;

end;



procedure TForm1.FormCreate(Sender: TObject);
var
  F: file of TMovimientos;
begin
  crearPilas(nDiscos);
  cargarTorre(1, ndiscos, pilaTorre1);
  cargarDatosJuego;
  //se crea el archivo que contendra los movimientos
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
  incremento: integer = 10;

begin

  i := incremento;
  j := incremento;

  Disco := FSource.Pop;

  //Movimientos:=Movimientos+1;

  //Actualizar la interfaz gráfica: Mover el disco visualmente

  //animar el alzar el disco (movimiento en el eje y)
  while disco.top - disco.Height > FSource.GetCoordenadaY -
    FSource.GetContenedor.Top do

  begin
    //movimiento en y
    disco.posicionDisco(disco.Left, disco.top - i);
    Disco.Repaint;

    i := i + incremento;
  end;


  //movimiento en x
  if FSource.GetCoordenadaX < FDestination.GetCoordenadaX then
  begin
    while disco.Left < FDestination.GetCoordenadaX do
    begin

      disco.posicionDisco(disco.Left + j, disco.top);

      disco.Repaint;
      j := j + incremento;

    end;
  end
  else
  begin

    while disco.Left > FDestination.GetCoordenadaX do
    begin
      disco.posicionDisco(disco.Left - j, disco.top);
      Disco.Repaint;


      j := j + incremento;

    end;

  end;

  FDestination.Push(Disco);

end;


//fin Resolver el juego de las Torres de Hanoi de manera automatica


procedure TForm1.cargarTorre(numPila, numDisco: integer; pila: TPilaTorre);
var
  ancho, i: integer;
  rutaImg: string;
  discoAux: TImgDisco;
begin
  rutaImg := obtenerRutaImagen(Application.ExeName);
  ancho := 300;
  for i := 0 to numDisco - 1 do
  begin


    // Crea y configura los discos
    discoAux := TImgDisco.Create(Self, ancho);
    // Asignamos la pila de origen al disco
    discoAux.numPila := numPila;
    //asignamos el numero de disco
    discoAux.numDisco := (i + 1);
    // Cargamos la imagen con la ruta
    discoAux.Picture.LoadFromFile(rutaImg + 'i' + IntToStr(i + 1) + '.png');
    // Asignamos propiedades de movimiento al disco creado

    // Guardamos el disco en la pila
    pila.Push(discoAux);
    ancho := ancho - 30;

  end;
end;

function Tform1.obtenerTorre(numTorre: integer): TImage;
begin
  case numTorre of
    1:
      Result := torre1;
    2:
      Result := torre2;
    3:
      Result := torre3;
  end;

end;

procedure TForm1.crearPilas(tamanio: integer);
begin
  pilaTorre1 := TPilaTorre.Create(1, tamanio, (torre1.Left + 30),
    (torre1.Top + torre1.Height), torre1);
  pilaTorre2 := TPilaTorre.Create(2, tamanio, (torre2.Left + 30),
    (torre1.Top + torre2.Height), torre2);
  pilaTorre3 := TPilaTorre.Create(3, tamanio, (torre3.Left + 30),
    (torre1.Top + torre3.Height), torre3);
end;

procedure TForm1.CheckIfImageCenterInsideTower1(image: TImage);
var
  bandera: boolean;
  disco: TImgDisco;
  nuevoNumeroPila: integer;
begin
  nuevoNumeroPila := 0;
  disco := TImgDisco(image);
  numeroPila := disco.numPila;
  SetTowerPosition(bandera, image, torre1);
  if bandera then
  begin
    // El centro de la imagen está dentro de la torre1
    nuevoNumeroPila := 1;
    hacerPop(pilaTorre1, obtenerPila(numeroPila), nuevoNumeroPila);
  end
  else
  begin
    SetTowerPosition(bandera, image, torre2);
    if bandera then
    begin
      // El centro de la imagen está dentro de la torre1
      nuevoNumeroPila := 2;
      hacerPop(pilaTorre2, obtenerPila(numeroPila), nuevoNumeroPila);
      //     pilaTorre2.Push(pilaTorre1.Pop);
      //       AssignDragPropertiesToImage(pilaTorre2.GetTope);
    end
    else
    begin
      SetTowerPosition(bandera, image, torre3);
      if bandera then
      begin
        // El centro de la imagen está dentro de la torre1
        //            ShowMessage('imagen dentro de torre3.');
        //          pilaTorre3.Push(pilaTorre1.Pop);
        nuevoNumeroPila := 3;
        hacerPop(pilaTorre3, obtenerPila(numeroPila), nuevoNumeroPila);
      end
      else
      begin
        image.Left := origX;
        image.Top := origY;
        ShowMessage(
          'El centro de la imagen no está dentro de la torre1 ni la 2 ni la 3.');
      end;
    end;
  end;

end;

procedure TForm1.SetTowerPosition(var bandera: boolean; disco, towerImage: TImage);
var
  imageCenterX, imageCenterY: integer;
  towerLeft, towerRight, towerTop, towerBottom: integer;
begin
  // Calcula las coordenadas del centro de la imagen
  imageCenterX := disco.Left + disco.Width div 2;
  imageCenterY := disco.Top + disco.Height div 2;

  // Obtiene las coordenadas del área de la torre1
  towerLeft := towerImage.Left;
  towerRight := towerImage.Left + towerImage.Width;
  towerTop := towerImage.Top;
  towerBottom := towerImage.Top + towerImage.Height;

  // Verifica si el centro de la imagen está dentro del área de la torre1
  if (imageCenterX >= towerLeft) and (imageCenterX <= towerRight) and
    (imageCenterY >= towerTop) and (imageCenterY <= towerBottom) then
  begin
    bandera := True;
  end
  else
  begin
    bandera := False;
  end;
end;

procedure TForm1.hacerPop(pila, pilaorigen: TPilaTorre; nuevoNumeroPila: integer);
var
  disco: TImgDisco;
begin
  if pila = pilaOrigen then
  begin
    disco := pilaOrigen.GetTope;
    //showMessage('pilas iguales');
    disco.posicionDisco(origX, origY);
  end
  else if pila.EsVacia then
  begin
    // Si la pila está vacía, solo se agrega el disco
    disco := pilaOrigen.Pop;
    if pilaOrigen.EsVacia = False then
      //AssignDragPropertiesToImage(pilaOrigen.GetTope);
    //AssignDragPropertiesToImage(disco);
    disco.numPila := nuevoNumeroPila;
    pila.Push(disco);
  end
  else if pila.EsLlena then
  begin
    // Si la pila está llena, se regresa el disco a su posición original
    disco.Left := origX;
    disco.Top := origY;
  end
  else
  begin
    disco := pilaOrigen.GetTope;
    if ValidarDisco(disco, pila.GetTope) then
    begin
      // Si la pila no está vacía ni llena, se quita el movimiento al disco del tope,
      // se agrega el nuevo disco y se le asigna movimiento al disco agregado
      disco := pilaOrigen.Pop;
      if pilaOrigen.EsVacia = False then
        //AssignDragPropertiesToImage(pilaOrigen.GetTope);
      //RemoveDragPropertiesFromImage(pila.GetTope);
      //AssignDragPropertiesToImage(disco);
      disco.numPila := nuevoNumeroPila;
      pila.Push(disco);
    end
    else
      disco.posicionDisco(origX, origY);
  end;

end;


function TForm1.obtenerPila(numPila: integer): TPilaTorre;
begin
  case numPila of
    1: Result := pilaTorre1;
    2: Result := pilaTorre2;
    3: Result := pilaTorre3;
    else
      Result := nil; // Retornar nil en caso de que el número de pila no sea válido
  end;
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

function TForm1.obtenerVelocidad(numDiscos: integer): integer;
begin

  if numDiscos > 6 then
    Result := 50
  else if numDiscos > 4 then
    Result := 10
  else
    Result := 1;

end;



procedure TForm1.cargarDatosJuego;
begin
  archivoMovimientos := 'lvl' + IntToStr(nDiscos - 2) + '.dat';
end;

end.
