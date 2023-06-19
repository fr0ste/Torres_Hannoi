unit TransaccionesMySQL;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, mysql80conn, Dialogs, PilaTorre;

type
  TIntegerArray = array of integer;


function EstablecerConexionBD: TMySQL80Connection;
procedure CerrarConexionDB(SQLTransaction: TSQLTransaction; SQLQuery: TSQLQuery;
  Connection: TMySQL80Connection);
function ObtenerDiscos(id: integer; idPila: integer): TIntegerArray;
procedure PrintIntegerArray(var arr: TIntegerArray);
function obtenerIdPartida(const idUsuario: integer): integer;
function ValidarUsuario(const nombre,contrasena:String): Integer ;
procedure guardarPartida(idUsuario, tiempo: integer; pila1, pila2, pila3: TPilaTorre);
procedure guardarPila(idPartida: integer; pila: TPilaTorre);
procedure guardarDisco(idPartida, idDisco, idPila: integer);
procedure borrarJuego(idPartida: Integer);
function crearUsuario(user, pwd: string): Integer;

implementation

function EstablecerConexionBD: TMySQL80Connection;
var
  Connection: TMySQL80Connection;
begin
  Connection := TMySQL80Connection.Create(nil);
  try
    Connection.HostName := 'localhost'; // Configura la conexión a la base de datos
    Connection.DatabaseName := 'Hanoi';
    Connection.UserName := 'Carlos';
    Connection.Password := 'C4ntr4x123#';
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
  arr: TIntegerArray;
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
      SQLQuery.SQL.Text := 'select Hanoi.obtenerIdPartida(' + IntToStr(1) + ');';
      // Consulta SQL que deseas ejecutar
      SQLQuery.Open;
      SetLength(arr, SQLQuery.RecordCount);


      id := SQLQuery.FieldByName('Hanoi.obtenerIdPartida(1)').AsInteger;


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

 (*
 *
 *
 *
 *)
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
procedure guardarPartida(idUsuario, tiempo: integer; pila1, pila2, pila3: TPilaTorre);
var
  idPartida: integer;
begin
  idPartida := obtenerIdPartida(idUsuario);

  //guardar los discos de la torre 1
  guardarPila(idPartida, pila1);
  guardarPila(idPartida, pila2);
  guardarPila(idPartida, pila3);
  ShowMessage('partida guardada');
end;

procedure guardarPila(idPartida: integer; pila: TPilaTorre);
begin
  while not pila.EsVacia do
  begin
    guardarDisco(idPartida, pila.GetTope.numDisco, pila.GetId);
    pila.Pop;
  end;
end;

procedure borrarJuego(idPartida: Integer);
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


Function ValidarUsuario(const nombre, contrasena: String): Integer;
var
       id: Integer = 0;
  SQLTransaction: TSQLTransaction;
  SQLQuery: TSQLQuery;
  Connection: TMySQL80Connection;
begin

  SQLTransaction := TSQLTransaction.Create(nil);
  SQLQuery := TSQLQuery.Create(nil);
  //abrimos la conexion a la base de datos
  Connection:=EstablecerConexionBD;

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

     // SQLQuery.SQL.Text := 'select Hanoi.userExist('+ nombre+ ','+ contrasena +') as existe;';
       //SQLQuery.SQL.Text := 'select Hanoi.userExist('+'d'+', '+'d'+') as existe;';


      // Consulta SQL que deseas ejecutar
      SQLQuery.Open;



       id:= SQLQuery.FieldByName('existe').AsInteger;


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

   Result:= id;
  CerrarConexionDB(SQLTransaction,SQLQuery,Connection);
end;

//devolvemos un 1 si ya existe el usuario y un 0 si se pudo crear
function crearUsuario(user, pwd: string): Integer;
var
  SQLTransaction: TSQLTransaction;
  SQLQuery: TSQLQuery;
  Connection: TMySQL80Connection;
  bandera: Integer;
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



end.
