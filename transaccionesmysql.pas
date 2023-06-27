unit TransaccionesMySQL;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, mysql80conn, Dialogs, PilaTorre, Funciones, mensajes;

type
  TIntegerArray = array of integer;
  TStringArray = array of array of string;


function EstablecerConexionBD: TMySQL80Connection;
procedure CerrarConexionDB(SQLTransaction: TSQLTransaction; SQLQuery: TSQLQuery;
  Connection: TMySQL80Connection);
function ObtenerDiscos(id: integer; idPila: integer): TIntegerArray;
procedure PrintIntegerArray(var arr: TIntegerArray);
function obtenerIdPartida(const idUsuario: integer): integer;
function ValidarUsuario(const nombre, contrasena: string): integer;
procedure guardarPartida(idUsuario, tiempo,nivel: integer; pila1, pila2, pila3: TPilaTorre; ParentComponent: TComponent; rutaImg: String);
procedure guardarPila(idPartida: integer; pila: TPilaTorre);
procedure guardarDisco(idPartida, idDisco, idPila: integer);
procedure borrarJuego(idPartida: integer);
function crearUsuario(user, pwd: string): integer;
function obtenerPuntaje(nivel: integer): TStringArray;
function existePartida(idUsuario: integer): integer;
function obtenerNumeroDiscos(idPartida: integer): integer;
procedure guardarTiempoNivel(idUsuario,tiempo,nivel: Integer);
function obtenerTiempoBD(idUsuario: integer): integer;
procedure guardarPuntajeTiempo(idUsuario,tiempo,nivel: Integer);

implementation

function EstablecerConexionBD: TMySQL80Connection;
var
  Connection: TMySQL80Connection;
begin
  Connection := TMySQL80Connection.Create(nil);
  try
    Connection.HostName := 'localhost'; // Configura la conexión a la base de datos
    Connection.DatabaseName := 'Hanoi';
    Connection.UserName := 'root';
    Connection.Password := 'Oscar12';
    Connection.Open;
    Result := Connection;
  except
    Connection.Free;
    raise;
  end;
end;



//procedimiento para cerrar la conexion
procedure CerrarConexionDB(SQLTransaction: TSQLTransaction;
  SQLQuery: TSQLQuery; Connection: TMySQL80Connection);
begin
  SQLQuery.Free;
  SQLTransaction.Free;
  Connection.Free;
end;


//devolvemos un arreglo con los numeros del disco de la pila
function ObtenerDiscos(id: integer; idPila: integer): TIntegerArray;
var
  arr: TIntegerArray;
  SQLTransaction: TSQLTransaction;
  SQLQuery: TSQLQuery;
  Connection: TMySQL80Connection;
  i: integer = 0;
begin

  SQLTransaction := TSQLTransaction.Create(nil);
  SQLQuery := TSQLQuery.Create(nil);
  //abrimos la conexion a la base de datos
  Connection := EstablecerConexionBD;

  //iniciamos la transaccion
  if Connection.Connected then
  begin
    SQLTransaction.Database := Connection;
    SQLQuery.Database := Connection;
    SQLQuery.Transaction := SQLTransaction;

    SQLTransaction.StartTransaction;

    try
      SQLQuery.SQL.Text := 'call Hanoi.spObtenerDiscosPartida(' +
        IntToStr(id) + ',' + IntToStr(idPila) + ')';
      // Consulta SQL que deseas ejecutar
      SQLQuery.Open;
      SetLength(arr, SQLQuery.RecordCount);

      while not SQLQuery.EOF do
      begin
        // Accede a los campos de cada registro
        // ...
        arr[i] := SQLQuery.FieldByName('disco').AsInteger;

        SQLQuery.Next;
        i := i + 1;
      end;

      SQLQuery.Close;
      SQLTransaction.Commit;
    except
      SQLTransaction.Rollback;
      raise;
    end;
  end
  else
  begin
    ShowMessage('No se pudo establecer la conexión a la base de datos');

  end;

  Result := arr;
  CerrarConexionDB(SQLTransaction, SQLQuery, Connection);
end;

procedure PrintIntegerArray(var arr: TIntegerArray);
var
  i: integer;
begin
  for i := 0 to 1 do
  begin
    // Imprime cada elemento del arreglo
    ShowMessage(IntToStr(arr[i]));
  end;
end;

function obtenerIdPartida(const idUsuario: integer): integer;
var
  SQLTransaction: TSQLTransaction;
  SQLQuery: TSQLQuery;
  Connection: TMySQL80Connection;
  id: integer = 0;
begin

  SQLTransaction := TSQLTransaction.Create(nil);
  SQLQuery := TSQLQuery.Create(nil);
  //abrimos la conexion a la base de datos
  Connection := EstablecerConexionBD;

  //iniciamos la transaccion
  if Connection.Connected then
  begin
    SQLTransaction.Database := Connection;
    SQLQuery.Database := Connection;
    SQLQuery.Transaction := SQLTransaction;

    SQLTransaction.StartTransaction;

    try
<<<<<<< HEAD
      SQLQuery.SQL.Text := 'select Hanoi.obtenerIdPartida(' +
        IntToStr(idUsuario) + ') as id;';
=======
      SQLQuery.SQL.Text := 'select Hanoi.obtenerIdPartida(' + IntToStr(1) + ') as partida;';
>>>>>>> cdd3736eb7c9e0135070fb9f863ef3a7020d34a5
      // Consulta SQL que deseas ejecutar
      SQLQuery.Open;


<<<<<<< HEAD

      id := SQLQuery.FieldByName('id').AsInteger;
=======
      id := SQLQuery.FieldByName('partida').AsInteger;
>>>>>>> cdd3736eb7c9e0135070fb9f863ef3a7020d34a5


      SQLQuery.Close;
      SQLTransaction.Commit;
    except
      SQLTransaction.Rollback;
      raise;
    end;
  end
  else
  begin
    ShowMessage('No se pudo establecer la conexión a la base de datos');
  end;

  Result := id;
  CerrarConexionDB(SQLTransaction, SQLQuery, Connection);
end;

procedure guardarDisco(idPartida, idDisco, idPila: integer);
var

  SQLTransaction: TSQLTransaction;
  SQLQuery: TSQLQuery;
  Connection: TMySQL80Connection;
begin

  SQLTransaction := TSQLTransaction.Create(nil);
  SQLQuery := TSQLQuery.Create(nil);
  //abrimos la conexion a la base de datos
  Connection := EstablecerConexionBD;

  //iniciamos la transaccion
  if Connection.Connected then
  begin
    SQLTransaction.Database := Connection;
    SQLQuery.Database := Connection;
    SQLQuery.Transaction := SQLTransaction;

    SQLTransaction.StartTransaction;

    try
      SQLQuery.SQL.Text := 'CALL Hanoi.actualizarJuego(:partida, :disco, :pila)';
      // Consulta SQL que deseas ejecutar
      SQLQuery.Params.ParamByName('partida').AsInteger := idPartida;
      SQLQuery.Params.ParamByName('disco').AsInteger := idDisco;
      SQLQuery.Params.ParamByName('pila').AsInteger := idPila;

      SQLQuery.ExecSQL; // Ejecutamos la consulta

      SQLTransaction.Commit;

    except
      SQLTransaction.Rollback;
      raise;
    end;
  end
  else
  begin
    ShowMessage('No se pudo establecer la conexión a la base de datos');
  end;

  CerrarConexionDB(SQLTransaction, SQLQuery, Connection);
end;

 (*
 *
 *
 *)
procedure guardarPartida(idUsuario, tiempo,nivel: integer; pila1, pila2, pila3: TPilaTorre; ParentComponent: TComponent; rutaImg: String);
var
  idPartida: integer;
begin
  idPartida := obtenerIdPartida(idUsuario);

  //guardar los discos de la torre 1
  guardarPila(idPartida, pila1);
  guardarPila(idPartida, pila2);
  guardarPila(idPartida, pila3);
  guardarTiempoNivel(idUsuario,tiempo,nivel);
  MostrarImagenEmergente(rutaImg + '/mensajes/partidaGuardada.png', ParentComponent);

end;

procedure guardarPila(idPartida: integer; pila: TPilaTorre);
begin
  while not pila.EsVacia do
  begin
    guardarDisco(idPartida, pila.GetTope.numDisco, pila.GetId);
    pila.Pop;
  end;
end;

procedure borrarJuego(idPartida: integer);
var

  SQLTransaction: TSQLTransaction;
  SQLQuery: TSQLQuery;
  Connection: TMySQL80Connection;
begin

  SQLTransaction := TSQLTransaction.Create(nil);
  SQLQuery := TSQLQuery.Create(nil);
  //abrimos la conexion a la base de datos
  Connection := EstablecerConexionBD;

  //iniciamos la transaccion
  if Connection.Connected then
  begin
    SQLTransaction.Database := Connection;
    SQLQuery.Database := Connection;
    SQLQuery.Transaction := SQLTransaction;

    SQLTransaction.StartTransaction;

    try
      SQLQuery.SQL.Text := 'call Hanoi.borrarJuego(:partida)';
      // Consulta SQL que deseas ejecutar
      SQLQuery.Params.ParamByName('partida').AsInteger := idPartida;

      SQLQuery.ExecSQL; // Ejecutamos la consulta

      SQLTransaction.Commit;

    except
      SQLTransaction.Rollback;
      raise;
    end;
  end
  else
  begin
    ShowMessage('No se pudo establecer la conexión a la base de datos');
  end;

  CerrarConexionDB(SQLTransaction, SQLQuery, Connection);
end;


function ValidarUsuario(const nombre, contrasena: string): integer;
var
  id: integer = 0;
  SQLTransaction: TSQLTransaction;
  SQLQuery: TSQLQuery;
  Connection: TMySQL80Connection;
begin

  SQLTransaction := TSQLTransaction.Create(nil);
  SQLQuery := TSQLQuery.Create(nil);
  //abrimos la conexion a la base de datos
  Connection := EstablecerConexionBD;

  //iniciamos la transaccion
  if Connection.Connected then
  begin
    SQLTransaction.Database := Connection;
    SQLQuery.Database := Connection;
    SQLQuery.Transaction := SQLTransaction;

    SQLTransaction.StartTransaction;

    try
      SQLQuery.SQL.Text := 'select Hanoi.userExist(:nombre, :contrasena) as existe';
      // Consulta SQL que deseas ejecutar
      SQLQuery.Params.ParamByName('nombre').AsString := nombre;
      SQLQuery.Params.ParamByName('contrasena').AsString := contrasena;


      // Consulta SQL que deseas ejecutar
      SQLQuery.Open;



      id := SQLQuery.FieldByName('existe').AsInteger;


      SQLQuery.Close;
      SQLTransaction.Commit;
    except
      SQLTransaction.Rollback;
      raise;
    end;

  end
  else
  begin
    ShowMessage('No se pudo establecer la conexión a la base de datos');

  end;

  Result := id;
  CerrarConexionDB(SQLTransaction, SQLQuery, Connection);
end;

//devolvemos un 1 si ya existe el usuario y un 0 si se pudo crear
function crearUsuario(user, pwd: string): integer;
var
  SQLTransaction: TSQLTransaction;
  SQLQuery: TSQLQuery;
  Connection: TMySQL80Connection;
  bandera: integer;
begin
  SQLTransaction := TSQLTransaction.Create(nil);
  SQLQuery := TSQLQuery.Create(nil);
  //abrimos la conexion a la base de datos
  Connection := EstablecerConexionBD;

  //iniciamos la transaccion
  if Connection.Connected then
  begin
    SQLTransaction.Database := Connection;
    SQLQuery.Database := Connection;
    SQLQuery.Transaction := SQLTransaction;

    SQLTransaction.StartTransaction;

    try
      SQLQuery.SQL.Text := 'call Hanoi.crearUsuario(:user, :pwd)';
      // Consulta SQL que deseas ejecutar
      SQLQuery.Params.ParamByName('user').AsString := user;
      SQLQuery.Params.ParamByName('pwd').AsString := pwd;
      // Consulta SQL que deseas ejecutar
      SQLQuery.Open;

      bandera := SQLQuery.FieldByName('userExists').AsInteger;

      SQLQuery.Close;
      SQLTransaction.Commit;
    except
      SQLTransaction.Rollback;
      raise;
    end;
  end
  else
  begin
    ShowMessage('No se pudo establecer la conexión a la base de datos');
  end;

  Result := bandera;
  CerrarConexionDB(SQLTransaction, SQLQuery, Connection);
end;


function obtenerPuntaje(nivel: integer): TStringArray;
var
  arr: TStringArray;
  SQLTransaction: TSQLTransaction;
  SQLQuery: TSQLQuery;
  Connection: TMySQL80Connection;
  i: integer = 0;
begin

  SQLTransaction := TSQLTransaction.Create(nil);
  SQLQuery := TSQLQuery.Create(nil);
  //abrimos la conexion a la base de datos
  Connection := EstablecerConexionBD;

  //iniciamos la transaccion
  if Connection.Connected then
  begin
    SQLTransaction.Database := Connection;
    SQLQuery.Database := Connection;
    SQLQuery.Transaction := SQLTransaction;

    SQLTransaction.StartTransaction;

    try
      SQLQuery.SQL.Text := 'call Hanoi.obtenerTiempoPuntaje(' + IntToStr(nivel) + ')';
      // Consulta SQL que deseas ejecutar
      SQLQuery.Open;
      SetLength(arr, SQLQuery.RecordCount);
      i := 0;
      while not SQLQuery.EOF do
      begin


        SetLength(arr[i], 2); // Inicializar cada elemento como un array de longitud 2
        arr[i][0] := SQLQuery.FieldByName('nombre').AsString;
        arr[i][1] := IntToStr(CalcularPuntaje(
          StrToInt(SQLQuery.FieldByName('tiempo').AsString), nivel));
        SQLQuery.Next;
        Inc(i);

      end;

      SQLQuery.Close;
      SQLTransaction.Commit;
    except
      SQLTransaction.Rollback;
      raise;
    end;
  end
  else
  begin
    ShowMessage('No se pudo establecer la conexión a la base de datos');

  end;

  Result := arr;
  CerrarConexionDB(SQLTransaction, SQLQuery, Connection);
end;

function existePartida(idUsuario: integer): integer;
var
  SQLTransaction: TSQLTransaction;
  SQLQuery: TSQLQuery;
  Connection: TMySQL80Connection;
  id: integer = 0;
begin

  SQLTransaction := TSQLTransaction.Create(nil);
  SQLQuery := TSQLQuery.Create(nil);
  //abrimos la conexion a la base de datos
  Connection := EstablecerConexionBD;

  //iniciamos la transaccion
  if Connection.Connected then
  begin
    SQLTransaction.Database := Connection;
    SQLQuery.Database := Connection;
    SQLQuery.Transaction := SQLTransaction;

    SQLTransaction.StartTransaction;

    try
      SQLQuery.SQL.Text := 'select Hanoi.existPartida(' +
        IntToStr(idUsuario) + ') as id;';
      // Consulta SQL que deseas ejecutar
      SQLQuery.Open;
      id := SQLQuery.FieldByName('id').AsInteger;

      SQLQuery.Close;
      SQLTransaction.Commit;
    except
      SQLTransaction.Rollback;
      raise;
    end;
  end
  else
  begin
    ShowMessage('No se pudo establecer la conexión a la base de datos');
  end;

  Result := id;
  CerrarConexionDB(SQLTransaction, SQLQuery, Connection);
end;

function obtenerNumeroDiscos(idPartida: integer): integer;
var
  SQLTransaction: TSQLTransaction;
  SQLQuery: TSQLQuery;
  Connection: TMySQL80Connection;
  discos: integer = 0;
begin

  SQLTransaction := TSQLTransaction.Create(nil);
  SQLQuery := TSQLQuery.Create(nil);
  //abrimos la conexion a la base de datos
  Connection := EstablecerConexionBD;

  //iniciamos la transaccion
  if Connection.Connected then
  begin
    SQLTransaction.Database := Connection;
    SQLQuery.Database := Connection;
    SQLQuery.Transaction := SQLTransaction;

    SQLTransaction.StartTransaction;

    try
      SQLQuery.SQL.Text := 'select Hanoi.obtenerNumeroDiscos(' +
        IntToStr(idPartida) + ')as total;';
      // Consulta SQL que deseas ejecutar
      SQLQuery.Open;



      discos := SQLQuery.FieldByName('total').AsInteger;


      SQLQuery.Close;
      SQLTransaction.Commit;
    except
      SQLTransaction.Rollback;
      raise;
    end;
  end
  else
  begin
    ShowMessage('No se pudo establecer la conexión a la base de datos');
  end;

  Result := discos;
  CerrarConexionDB(SQLTransaction, SQLQuery, Connection);
end;

procedure guardarTiempoNivel(idUsuario,tiempo,nivel: Integer);
var
  SQLTransaction: TSQLTransaction;
  SQLQuery: TSQLQuery;
  Connection: TMySQL80Connection;
begin
  SQLTransaction := TSQLTransaction.Create(nil);
  SQLQuery := TSQLQuery.Create(nil);
  //abrimos la conexion a la base de datos
  Connection := EstablecerConexionBD;

  //iniciamos la transaccion
  if Connection.Connected then
  begin
    SQLTransaction.Database := Connection;
    SQLQuery.Database := Connection;
    SQLQuery.Transaction := SQLTransaction;

    SQLTransaction.StartTransaction;

    try
      SQLQuery.SQL.Text := 'call Hanoi.actualizarTiempoNivel(:idUsuario, :tiempo, :nivel);';
      // Consulta SQL que deseas ejecutar
      SQLQuery.Params.ParamByName('idUsuario').AsInteger := idUsuario;
      SQLQuery.Params.ParamByName('tiempo').AsInteger := tiempo;
      SQLQuery.Params.ParamByName('nivel').AsInteger := nivel;
      // Consulta SQL que deseas ejecutar


      SQLQuery.ExecSQL; // Ejecutamos la consulta

      SQLTransaction.Commit;
    except
      SQLTransaction.Rollback;
      raise;
    end;
  end
  else
  begin
    ShowMessage('No se pudo establecer la conexión a la base de datos');
  end;


  CerrarConexionDB(SQLTransaction, SQLQuery, Connection);
end;

function obtenerTiempoBD(idUsuario: integer): integer;
var
  SQLTransaction: TSQLTransaction;
  SQLQuery: TSQLQuery;
  Connection: TMySQL80Connection;
  tiempo: integer = 0;
begin

  SQLTransaction := TSQLTransaction.Create(nil);
  SQLQuery := TSQLQuery.Create(nil);
  //abrimos la conexion a la base de datos
  Connection := EstablecerConexionBD;

  //iniciamos la transaccion
  if Connection.Connected then
  begin
    SQLTransaction.Database := Connection;
    SQLQuery.Database := Connection;
    SQLQuery.Transaction := SQLTransaction;

    SQLTransaction.StartTransaction;

    try
      SQLQuery.SQL.Text := 'select Hanoi.obtenerTiempo('+IntToStr(idUsuario)+') as tiempo;';
      // Consulta SQL que deseas ejecutar
      SQLQuery.Open;



      tiempo := SQLQuery.FieldByName('tiempo').AsInteger;


      SQLQuery.Close;
      SQLTransaction.Commit;
    except
      SQLTransaction.Rollback;
      raise;
    end;
  end
  else
  begin
    ShowMessage('No se pudo establecer la conexión a la base de datos');
  end;

  Result := tiempo;
  CerrarConexionDB(SQLTransaction, SQLQuery, Connection);
end;


procedure guardarPuntajeTiempo(idUsuario,tiempo,nivel: Integer);
var
  SQLTransaction: TSQLTransaction;
  SQLQuery: TSQLQuery;
  Connection: TMySQL80Connection;
begin
  SQLTransaction := TSQLTransaction.Create(nil);
  SQLQuery := TSQLQuery.Create(nil);
  //abrimos la conexion a la base de datos
  Connection := EstablecerConexionBD;

  //iniciamos la transaccion
  if Connection.Connected then
  begin
    SQLTransaction.Database := Connection;
    SQLQuery.Database := Connection;
    SQLQuery.Transaction := SQLTransaction;

    SQLTransaction.StartTransaction;

    try
      SQLQuery.SQL.Text := 'call Hanoi.guardarPuntajeTiempo(:idUsuario, :tiempo, :nivel);';
      // Consulta SQL que deseas ejecutar
      SQLQuery.Params.ParamByName('idUsuario').AsInteger := idUsuario;
      SQLQuery.Params.ParamByName('tiempo').AsInteger := tiempo;
      SQLQuery.Params.ParamByName('nivel').AsInteger := nivel;
      // Consulta SQL que deseas ejecutar


      SQLQuery.ExecSQL; // Ejecutamos la consulta

      SQLTransaction.Commit;
    except
      SQLTransaction.Rollback;
      raise;
    end;
  end
  else
  begin
    ShowMessage('No se pudo establecer la conexión a la base de datos');
  end;


  CerrarConexionDB(SQLTransaction, SQLQuery, Connection);
end;



end.
