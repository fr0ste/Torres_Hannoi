unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Funciones, PilaTorre, Disco, Tiempo, bass, TransaccionesMySQL;

type
  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Sonido: TImage;
    LabelTiempo: TLabel;
    PausaPlay: TImage;
    torre1: TImage;
    torre2: TImage;
    torre3: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    TimerCronometro: TTiempoCronometro;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PausaPlayClick(Sender: TObject);
    procedure SonidoClick(Sender: TObject);
    procedure torre1Click(Sender: TObject);
  private
    procedure AssignDragPropertiesToImage(image: TImage);
    procedure RemoveDragPropertiesFromImage(image: TImage);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure CheckIfImageCenterInsideTower1(image: TImage);
    procedure SetTowerPosition(var bandera: boolean; disco, towerImage: TImage);
    procedure hacerPop(pila, pilaOrigen: TPilaTorre; nuevoNumeroPila: integer);
    procedure cargarPartida(pila1, pila2, pila3: TPilaTorre);

  public
    procedure cargarTorre(numPila, numDisco: integer; pila: TPilaTorre);
    function crearDisco(rutaImg: string;
      ancho, imgDisco, numPila, numDisco: integer): TImgDisco;
    procedure crearPilas(tamanio: integer);
    function obtenerTorre(numTorre: integer): TImage;
    function obtenerPila(numPila: integer): TPilaTorre;
    procedure SetNumero(Numero: integer);
    procedure TimerCronometroTimer(Sender: TObject);
    procedure nuevoJuego();
    procedure cargarCursor(ruta: string);
    procedure MostrarImagenEmergente(const RutaImagen: string);

    //base de datos
    procedure cargarTorreDesdeDB(torre: TPilaTorre);
    constructor Create(nuevo: boolean);
  end;
const
  crMyCursor = 1;
  crMyCursor2 = 2;


var
  Form1: TForm1;
  JuegoNuevo: boolean;
  FNumero: integer;//numero para cargar los fondos
  arrastrar: boolean = False;
  DragOffset: TPoint;
  //pilas para las torres
  pilaTorre1, pilaTorre2, pilaTorre3: TPilaTorre;
  origX, origY: integer; // Variables para guardar la posición original (X, Y)
  posX, posY: integer;
  numeroPila: integer;
  rutaImg: string;//para obtener la ruta de las imagenes a cargar
  idUsuario: integer = 1;
  Pausado: string;
  fname: string;
  isPaused: boolean;
  Bstream: dword; // Canal del audio
    //Cursor
  CursorImage: TCursorImage;
  CursorImage2: TCursorImage;
  time: Integer;

implementation

{$R *.lfm}
uses
  Iniciar, niveles, menuInicio;

{ TForm1 }

constructor TForm1.Create(nuevo: boolean);
begin
  inherited Create(nil);
  JuegoNuevo := nuevo;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
opcion: integer;
begin


  // Mostrar el mensaje de acuerdo a la opción seleccionada
  opcion := MessageDlg('¿Desea guardar la partida?', mtConfirmation, [mbOK, mbCancel], 0);
  if opcion = mrOk then
  begin

    guardarPartida(idUsuario,time,pilaTorre1,pilaTorre2,pilaTorre3);

  end;

   Hide;
  Form3.Show;
  Pause(isPaused);

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  MostrarImagenEmergente('bicho.png');
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BASS_Free;
  // Inicializa el sistema de audio BASS con la configuración predeterminada
  BASS_Init(-1, 44100, 0, nil, nil);
end;

procedure TForm1.FormShow(Sender: TObject);
begin

  //********************************************************************************************************************
  if JuegoNuevo then
  begin
    //********************************************************************************************************************
    rutaImg := obtenerRutaImagen(Application.ExeName);
    // Cargamos la imagen con la ruta
    Image1.Picture.LoadFromFile(rutaImg + 'fondos/fondo' + IntToStr(FNumero) + '.png');
    crearPilas(FNumero);
    cargarPartida(pilaTorre1, pilaTorre2, pilaTorre3);
    Sonido.Picture.LoadFromFile(rutaImg + 'fondos/sinsonido.png');
    isPaused := False;
    PausaPlay.Picture.LoadFromFile(rutaImg + 'fondos/Pausa.png');
    Pausado := 'Pausa';
    TimerCronometro := TTiempoCronometro.Create;
    TimerCronometro.Interval := 1000;
    // Intervalo del temporizador en milisegundos (1 segundo)
    TimerCronometro.OnTimer := @TimerCronometroTimer;
    TimerCronometro.IniciarTimer(LabelTiempo);
    fname := ExtractFilePath(Application.ExeName) + '/Audios/Audio' +
      IntToStr(FNumero - 2) + '.mp3';
    //ShowMessage(fname);
    PlayMP3(fname);
    // Cargar cursor
       cargarCursor(rutaImg+'cursor/');
  end
  else
  begin
    //********************************************************************************************************************
    rutaImg := obtenerRutaImagen(Application.ExeName);
    // Cargamos la imagen con la ruta
    Image1.Picture.LoadFromFile(rutaImg + 'fondos/fondo' + IntToStr(FNumero) + '.png');
    crearPilas(FNumero);
    cargarTorre(pilaTorre1.Getid, FNumero, pilaTorre1);
    Sonido.Picture.LoadFromFile(rutaImg + 'fondos/sinsonido.png');
    isPaused := False;
    PausaPlay.Picture.LoadFromFile(rutaImg + 'fondos/Pausa.png');
    Pausado := 'Pausa';
    TimerCronometro := TTiempoCronometro.Create;
    TimerCronometro.Interval := 1000;
    // Intervalo del temporizador en milisegundos (1 segundo)
    TimerCronometro.OnTimer := @TimerCronometroTimer;
    TimerCronometro.IniciarTimer(LabelTiempo);
    fname := ExtractFilePath(Application.ExeName) + '/Audios/Audio' +
      IntToStr(FNumero - 2) + '.mp3';
    //ShowMessage(fname);
    PlayMP3(fname);
    //ShowMessage(IntToStr(FNumero));
        // Cargar cursor
       cargarCursor(rutaImg+'cursor/');
  end;

end;



procedure TForm1.PausaPlayClick(Sender: TObject);
begin
  if Pausado = 'Pausa' then
  begin
    Pausado := 'Play';
    TimerCronometro.Pausar;
    PausaPlay.Picture.LoadFromFile(rutaImg + '/fondos/PLAY.png');
  end
  else if Pausado = 'Play' then
  begin
    TimerCronometro.Continuar;
    PausaPlay.Picture.LoadFromFile(rutaImg + '/fondos/Pausa.png');
    Pausado := 'Pausa';
  end;
end;

procedure TForm1.SonidoClick(Sender: TObject);
begin
  if isPaused then
  begin
    Pause(isPaused);
    rutaImg := obtenerRutaImagen(Application.ExeName);
    Sonido.Picture.LoadFromFile(rutaImg + '/fondos/sinsonido.png');
    //BtnPausePlay.Caption := 'Pause';
    isPaused := False;
  end
  else
  begin
    // Si la reproducción está en curso, se pausa la reproducción

    Pause(isPaused);
    rutaImg := obtenerRutaImagen(Application.ExeName);

    Sonido.Picture.LoadFromFile(rutaImg + '/fondos/sonido.png');
    //BtnPausePlay.Caption := 'Reanudar';
    isPaused := True;
  end;
end;


procedure TForm1.TimerCronometroTimer(Sender: TObject);
begin
  TimerCronometro.ElapsedTime := Now - TimerCronometro.StartTime;
  LabelTiempo.Caption := FormatDateTime('hh:nn:ss', TimerCronometro.ElapsedTime);
end;



procedure TForm1.torre1Click(Sender: TObject);
begin

end;

procedure TForm1.cargarTorre(numPila, numDisco: integer; pila: TPilaTorre);
var
  ancho, i: integer;
  imgDisco: integer;
  discoAux: TImgDisco;
begin
  rutaImg := obtenerRutaImagen(Application.ExeName);
  ancho := 60 + (numDisco * 30);
  imgDisco := 8 - (numDisco - 1);
  for i := 0 to numDisco - 1 do
  begin
    // Verificamos si la pila está vacía, de lo contrario le quitamos las
    // propiedades de movimiento al disco que está en el tope de la pila
    if not pila.EsVacia then
      RemoveDragPropertiesFromImage(pila.GetTope);
    // Crea y configura los discos
    discoAux := TImgDisco.Create(Self, ancho);
    // Asignamos la pila de origen al disco
    discoAux.numPila := numPila;
    //asignamos el numero de disco
    discoAux.numDisco := (i + 1);
    // Cargamos la imagen con la ruta
    discoAux.Picture.LoadFromFile(rutaImg + '/discos/i' + IntToStr(imgDisco) + '.png');
    // Asignamos propiedades de movimiento al disco creado
    AssignDragPropertiesToImage(discoAux);
    // Guardamos el disco en la pila
    pila.Push(discoAux);
    ancho := ancho - 30;
    imgDisco := imgDisco + 1;
  end;
end;

function TForm1.crearDisco(rutaImg: string;
  ancho, imgDisco, numPila, numDisco: integer): TImgDisco;
var
  discoAux: TImgDisco;
begin
  // Crea y configura los discos
  discoAux := TImgDisco.Create(Self, ancho);
  // Asignamos la pila de origen al disco
  discoAux.numPila := numPila;
  //asignamos el numero de disco
  discoAux.numDisco := (numDisco);
  // Cargamos la imagen con la ruta
  discoAux.Picture.LoadFromFile(rutaImg);
  // Asignamos propiedades de movimiento al disco creado
  AssignDragPropertiesToImage(discoAux);

  Result := discoAux;
end;




procedure TForm1.AssignDragPropertiesToImage(image: TImage);
begin
  image.OnMouseDown := @ImageMouseDown;
  image.OnMouseMove := @ImageMouseMove;
  image.OnMouseUp := @ImageMouseUp;
  image.DragMode := dmAutomatic;
  //cursor
    image.Cursor:=crMyCursor;
end;

procedure TForm1.RemoveDragPropertiesFromImage(image: TImage);
begin
  image.OnMouseDown := nil;
  image.OnMouseMove := nil;
  image.OnMouseUp := nil;
  image.DragMode := dmManual;
end;

procedure TForm1.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  arrastrar := True;
  DragOffset := Point(X, Y);
  TImage(Sender).BringToFront;
  // Guarda la posición original (X, Y) de la imagen
  origX := TImage(Sender).Left;
  origY := TImage(Sender).Top;
    //cursor
  Cursor := crMyCursor2;
end;

procedure TForm1.ImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  if arrastrar then
  begin
    TImage(Sender).Left := TImage(Sender).Left + X - DragOffset.X;
    TImage(Sender).Top := TImage(Sender).Top + Y - DragOffset.Y;
        //cursor
    Cursor := crMyCursor2;
  end;
end;

procedure TForm1.ImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  arrastrar := False;
  CheckIfImageCenterInsideTower1(TImage(Sender));
    //cursor
  Cursor := crMyCursor;
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

    end
    else
    begin
      SetTowerPosition(bandera, image, torre3);
      if bandera then
      begin
        // El centro de la imagen está dentro de la torre1

        nuevoNumeroPila := 3;
        hacerPop(pilaTorre3, obtenerPila(numeroPila), nuevoNumeroPila);
      end
      else
      begin
        image.Left := origX;
        image.Top := origY;

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
      AssignDragPropertiesToImage(pilaOrigen.GetTope);
    AssignDragPropertiesToImage(disco);
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
        AssignDragPropertiesToImage(pilaOrigen.GetTope);
      RemoveDragPropertiesFromImage(pila.GetTope);
      AssignDragPropertiesToImage(disco);
      disco.numPila := nuevoNumeroPila;
      pila.Push(disco);
    end
    else
    begin
      disco.posicionDisco(origX, origY);

      //muestra una ventana emergente cuando se realiza un movimiento no valido
      MostrarImagenEmergente('bicho.png');
    end;
  end;

  //validamos cuando ya gane el juego
  if pilaTorre3.EsLlena then
  begin
    ShowMessage('Felicidades');
    if FNumero <> 8 then
    begin
      SetNumero(FNumero + 1);
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

procedure TForm1.SetNumero(Numero: integer);
begin
  FNumero := Numero;
end;


procedure TForm1.nuevoJuego();
var
  Form1: TForm1;
  numDisc: integer;
  opcion: integer;
begin
  // Mostrar el mensaje de acuerdo a la opción seleccionada
  opcion := MessageDlg('¿Desea continuar?', mtConfirmation, [mbOK, mbCancel], 0);
  if opcion = mrOk then
  begin
    // Continuar

  end
  else if opcion = mrCancel then
  begin
    Application.Terminate; // Terminar el programa
  end
  else
  begin
    // Opción inválida o cerrada, mostrar nuevamente el formulario actual
    Show;
    Exit;
  end;

  // Ocultar el formulario actual (Form1)
  numDisc := FNumero;
  Hide;

  // Crear una instancia del formulario controlado por el controlador central (Form2)
  Form1 := TForm1.Create(False);

  // Pasar el número como parámetro al formulario Form2
  Form1.SetNumero(numDisc);


  // Mostrar el formulario Form2
  Form1.Show;
end;



procedure TForm1.cargarPartida(pila1, pila2, pila3: TPilaTorre);
begin
  //obtenemos un arreglo con los numeros de los discos de la torre 1
  cargarTorreDesdeDB(pila1);
  cargarTorreDesdeDB(pila2);
  cargarTorreDesdeDB(pila3);
end;


procedure TForm1.cargarTorreDesdeDB(torre: TPilaTorre);
var
  arr: TIntegerArray;
  ancho, i: integer;
  imgDisco: integer = 1;
  discoAux: TImgDisco;
  rutaAux: string;
begin
  arr := ObtenerDiscos(1, torre.GetId);

  for i := 0 to Length(arr) - 1 do
  begin
    // Verificamos si la pila está vacía, de lo contrario le quitamos las
    // propiedades de movimiento al disco que está en el tope de la pila
    if not torre.EsVacia then
      RemoveDragPropertiesFromImage(torre.GetTope);
    imgDisco := 8 - (Arr[i] - 1);
    //calculamos el ancho del disco de acuerdo a su número
    ancho := 60 + (imgDisco * 30);

    // Cargamos la imagen con la ruta
    rutaAux := rutaImg + '/discos/i' + IntToStr(Arr[i]) + '.png';


    discoAux := crearDisco(rutaAux, ancho, imgDisco, torre.GetId, Arr[i]);
    // Guardamos el disco en la pila
    torre.Push(discoAux);

  end;
end;
procedure TForm1.cargarCursor(ruta:String);
begin
  CursorImage := TCursorImage.Create;
  CursorImage.LoadFromFile(ruta+'Cursor3.cur');
  Screen.Cursors[crMyCursor] := CursorImage.Handle;
  Form1.Cursor := crMyCursor;

  CursorImage2 := TCursorImage.Create;
  CursorImage2.LoadFromFile(ruta+'Cursor.cur');
  Screen.Cursors[crMyCursor2] := CursorImage2.Handle;
  Image1.Cursor:=crMyCursor;
  Image5.Cursor:=crMyCursor;
  Image6.Cursor:=crMyCursor;
  Image7.Cursor:=crMyCursor;
  torre1.Cursor:=crMyCursor;
  torre2.Cursor:=crMyCursor;
  torre3.Cursor:=crMyCursor;

  LabelTiempo.Cursor:=crMyCursor;

  Form1.Cursor := crMyCursor;

end;


procedure TForm1.MostrarImagenEmergente(const RutaImagen: string);
var
  FormImagen: TForm;
  Imagen: TImage;
  ButtonAceptar: TButton;
begin
  // Creamos el formulario personalizado sin barra superior
  FormImagen := TForm.CreateNew(nil, 0);
  try
    // Configuramos las propiedades del formulario
    FormImagen.BorderStyle := bsNone;  // Sin borde
    //FormImagen.Position := poScreenCenter; // Centramos el formulario en la pantalla
    FormImagen.Position := poDesigned; // Posición relativa al formulario padre
    FormImagen.Width := 400;
    FormImagen.Height := 250;

    // Ajustamos la posición del formulario para centrarlo en el formulario padre
    FormImagen.Left := Self.Left + (Self.Width - FormImagen.Width) div 2;
    FormImagen.Top := Self.Top + (Self.Height - FormImagen.Height) div 2;

    // Registramos el evento OnMove del formulario principal
    Self.OnMove := SelfFormMove;


    // Creamos un componente TImage y lo agregamos al formulario
    Imagen := TImage.Create(FormImagen);
    Imagen.Parent := FormImagen;
    Imagen.Align := alClient;
    Imagen.Stretch := True;

    // Cargamos la imagen en el componente TImage
    Imagen.Picture.LoadFromFile(RutaImagen);

    // Creamos un botón de aceptar y lo agregamos al formulario
    ButtonAceptar := TButton.Create(FormImagen);
    ButtonAceptar.Parent := FormImagen;
    ButtonAceptar.Caption := 'Aceptar';
    ButtonAceptar.Left := (FormImagen.Width - ButtonAceptar.Width) div 2;
    ButtonAceptar.Top := FormImagen.Height - ButtonAceptar.Height - 20;
    ButtonAceptar.ModalResult := mrOk;  // Asignamos el resultado modal al botón Aceptar

    // Mostramos el formulario emergente de forma modal
    if FormImagen.ShowModal = mrOk then
    begin

    end;

  finally
    // Liberamos los recursos del formulario
    FormImagen.Free;
  end;
end;


end.
