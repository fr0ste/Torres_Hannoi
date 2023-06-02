unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Funciones, PilaTorre, Disco;

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
    procedure FormShow(Sender: TObject);
    procedure torre1Click(Sender: TObject);
  private
    procedure AssignDragPropertiesToImage(image: TImage);
    procedure RemoveDragPropertiesFromImage(image: TImage);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckIfImageCenterInsideTower1(image: TImage);
    procedure SetTowerPosition(var bandera: Boolean; disco,towerImage: TImage);
    procedure hacerPop(pila,pilaOrigen: TPilaTorre; nuevoNumeroPila: Integer);

  public
    procedure cargarTorre(numPila,numDisco: Integer;pila: TPilaTorre);
    procedure crearPilas(tamanio: integer);
    function obtenerTorre(numTorre: integer): TImage;
    function obtenerPila(numPila: integer): TPilaTorre;
    procedure SetNumero(Numero: Integer);

    procedure nuevoJuego();
  end;

var
  Form1: TForm1;
  FNumero: Integer;//numero para cargar los fondos
  arrastrar: Boolean = False;
  DragOffset: TPoint;
  //pilas para las torres
  pilaTorre1, pilaTorre2, pilaTorre3: TPilaTorre;
  origX, origY: Integer; // Variables para guardar la posición original (X, Y)
  posX,posY: Integer;
  numeroPila: Integer;
  rutaImg: String;//para obtener la ruta de las imagenes a cargar

implementation

{$R *.lfm}
uses
  Iniciar,niveles;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  Hide;
  Form7.Show;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
    //********************************************************************************************************************
    rutaImg := obtenerRutaImagen(Application.ExeName);
        // Cargamos la imagen con la ruta
    Image1.Picture.LoadFromFile(rutaImg + '/fondos/fondo' + IntToStr(FNumero) + '.png');
    crearPilas(FNumero);
    cargarTorre(pilaTorre1.Getid,FNumero,pilaTorre1);
end;

procedure TForm1.torre1Click(Sender: TObject);
begin

end;

procedure TForm1.cargarTorre(numPila,numDisco: Integer; pila: TPilaTorre);
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
    // Verificamos si la pila está vacía, de lo contrario le quitamos las
    // propiedades de movimiento al disco que está en el tope de la pila
    if not pila.EsVacia then
      RemoveDragPropertiesFromImage(pila.GetTope);
    // Crea y configura los discos
    discoAux := TImgDisco.Create(Self,ancho);
    // Asignamos la pila de origen al disco
    discoAux.numPila := numPila;
    //asignamos el numero de disco
    discoAux.numDisco:= (i+1);
    // Cargamos la imagen con la ruta
    discoAux.Picture.LoadFromFile(rutaImg + '/discos/i' + IntToStr(imgDisco) + '.png');
    // Asignamos propiedades de movimiento al disco creado
    AssignDragPropertiesToImage(discoAux);
    // Guardamos el disco en la pila
    pila.Push(discoAux);
    ancho := ancho - 30;
    imgDisco:=imgDisco+1;
  end;
end;

procedure TForm1.AssignDragPropertiesToImage(image: TImage);
begin
  image.OnMouseDown := @ImageMouseDown;
  image.OnMouseMove := @ImageMouseMove;
  image.OnMouseUp := @ImageMouseUp;
  image.DragMode := dmAutomatic;
end;
procedure TForm1.RemoveDragPropertiesFromImage(image: TImage);
begin
  image.OnMouseDown := nil;
  image.OnMouseMove := nil;
  image.OnMouseUp := nil;
  image.DragMode := dmManual;
end;

procedure TForm1.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  arrastrar := True;
  DragOffset := Point(X, Y);
  TImage(Sender).BringToFront;
  // Guarda la posición original (X, Y) de la imagen
  origX := TImage(Sender).Left;
  origY := TImage(Sender).Top;
end;

procedure TForm1.ImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if arrastrar then
  begin
    TImage(Sender).Left := TImage(Sender).Left + X - DragOffset.X;
    TImage(Sender).Top := TImage(Sender).Top + Y - DragOffset.Y;
  end;
end;

procedure TForm1.ImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  arrastrar := False;
  CheckIfImageCenterInsideTower1(TImage(Sender));
end;

Function Tform1.obtenerTorre(numTorre: integer): TImage;
begin
  case numTorre of
      1:
        Result:= torre1;
      2:
        Result:= torre2;
      3:
        Result:= torre3;
    end;

end;
procedure TForm1.crearPilas(tamanio: integer);
begin
     pilaTorre1:=TPilaTorre.Create(1,tamanio,(torre1.Left+30),(torre1.Top+torre1.Height), torre1);
     pilaTorre2:=TPilaTorre.Create(2,tamanio,(torre2.Left+30),(torre1.Top+torre2.Height), torre2);
     pilaTorre3:=TPilaTorre.Create(3,tamanio,(torre3.Left+30),(torre1.Top+torre3.Height), torre3);
end;

procedure TForm1.CheckIfImageCenterInsideTower1(image: TImage);
var
  bandera: boolean;
  disco: TImgDisco;
  nuevoNumeroPila: integer;
begin
  nuevoNumeroPila:=0;
  disco:=TImgDisco(image);
  numeroPila:=disco.numPila;
  SetTowerPosition(bandera,image,torre1);
  if bandera then
  begin
    // El centro de la imagen está dentro de la torre1
    nuevoNumeroPila:=1;
    hacerPop(pilaTorre1,obtenerPila(numeroPila),nuevoNumeroPila);
  end
  else
  begin
    SetTowerPosition(bandera,image,torre2);
    if bandera then
    begin
         // El centro de la imagen está dentro de la torre1
       nuevoNumeroPila:=2;
       hacerPop(pilaTorre2,obtenerPila(numeroPila),nuevoNumeroPila);
  //     pilaTorre2.Push(pilaTorre1.Pop);
//       AssignDragPropertiesToImage(pilaTorre2.GetTope);
    end
    else
    begin
         SetTowerPosition(bandera,image,torre3);
         if bandera then
         begin
              // El centro de la imagen está dentro de la torre1
//            ShowMessage('imagen dentro de torre3.');
  //          pilaTorre3.Push(pilaTorre1.Pop);
              nuevoNumeroPila:=3;
              hacerPop(pilaTorre3,obtenerPila(numeroPila),nuevoNumeroPila);
         end
         else
         begin
              image.Left:=origX;
              image.Top:=origY;
              ShowMessage('El centro de la imagen no está dentro de la torre1 ni la 2 ni la 3.');
         end;
    end;
  end;

end;

procedure TForm1.SetTowerPosition(var bandera: Boolean; disco,towerImage: TImage);
  var
    imageCenterX, imageCenterY: Integer;
    towerLeft, towerRight, towerTop, towerBottom: Integer;
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
         bandera:=true;
    end
    else
    begin
         bandera:=false;
    end;
end;
procedure TForm1.hacerPop(pila,pilaorigen: TPilaTorre;nuevoNumeroPila: Integer);
var
  disco: TImgDisco;
begin
  if pila=pilaOrigen then
     begin
          disco:=pilaOrigen.GetTope;
          //showMessage('pilas iguales');
          disco.posicionDisco(origX,origY);
     end
  else if pila.EsVacia then
  begin
    // Si la pila está vacía, solo se agrega el disco
    disco:=pilaOrigen.Pop;
    if pilaOrigen.EsVacia=false then
        AssignDragPropertiesToImage(pilaOrigen.GetTope);
    AssignDragPropertiesToImage(disco);
    disco.numPila:=nuevoNumeroPila;
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
       disco:=pilaOrigen.GetTope;
       if  ValidarDisco(disco,pila.GetTope) then
      begin
         // Si la pila no está vacía ni llena, se quita el movimiento al disco del tope,
    // se agrega el nuevo disco y se le asigna movimiento al disco agregado
    disco:=pilaOrigen.Pop;
    if pilaOrigen.EsVacia=false then
        AssignDragPropertiesToImage(pilaOrigen.GetTope);
    RemoveDragPropertiesFromImage(pila.GetTope);
    AssignDragPropertiesToImage(disco);
    disco.numPila:=nuevoNumeroPila;
    pila.Push(disco);
      end
      else
       disco.posicionDisco(origX,origY);
  end;

  //validamos cuando ya gane el juego
  if pilaTorre3.EsLlena then
  begin
    showMessage('Felicidades');
    if FNumero<>8 then
    begin
      SetNumero(FNumero+1);
    end;
    Hide;
    nuevoJuego();
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
procedure TForm1.SetNumero(Numero: Integer);
begin
  FNumero := Numero;
end;

procedure TForm1.nuevoJuego();
var
  Form1: TForm1;
  numDisc: integer;
begin
  // Ocultar el formulario actual (Form1)
  numDisc:= FNumero;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form1 := TForm1.Create(nil);

  // Pasar el número como parámetro al formulario Form2
  Form1.SetNumero(numDisc);

  // Mostrar el formulario Form2
  Form1.Show;
end;

end.

