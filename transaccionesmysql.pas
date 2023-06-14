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
procedure guardarPartida(idUsuario, tiempo: integer; pila1, pila2, pila3: TPilaTorre);
procedure guardarPila(idPartida: integer; pila: TPilaTorre);

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
    Connection.Password := 'froste';
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
      SQLQuery.SQL.Text := 'call Hanoi.actualizarJuego(' + IntToStr(
        idPartida) + ',' + IntToStr(idDisco) + ',' + IntToStr(idPila) + ');';
      // Consulta SQL que deseas ejecutar
      SQLQuery.Open;
      SetLength(arr, SQLQuery.RecordCount);
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

  CerrarConexionDB(SQLTransaction, SQLQuery, Connection);
end;

 (*
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

end;

procedure guardarPila(idPartida: integer; pila: TPilaTorre);
begin
  while not pila.EsVacia do
  begin
    guardarDisco(idPartida, pila.GetTope.numDisco, pila.GetId);
    pila.Pop;
  end;
end;

end.
