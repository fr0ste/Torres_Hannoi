 (*
  fecha de creacion: 26/05/2023
  fecha de actualización:29/06/2023
  descripción:
*)
unit DBConection;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  SQLDB, TransaccionesMySQL,
  mysql80conn;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  listarUsuarios;
end;

end.
