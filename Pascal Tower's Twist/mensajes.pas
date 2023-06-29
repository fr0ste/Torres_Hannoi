(*
  fecha de creacion: 26/05/2023
  fecha de actualización:29/06/2023
  descripción: En esta unidad se modifican las vistas dandole una sola medida y
  estilo a cada una, asi como el diseño de los mensajes emergentes en las vistas
*)
unit mensajes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

procedure MostrarImagenEmergente(const RutaImagen: string; ParentComponent: TComponent);
function fMostrarImagenEmergente(const imagen: string;
  ParentComponent: TComponent): boolean;


implementation

procedure MostrarImagenEmergente(const RutaImagen: string; ParentComponent: TComponent);
var
  FormImagen: TForm;
  Imagen: TImage;
  ButtonAceptar: TButton;
begin
  (*Creamos el formulario personalizado sin barra superior*)
  FormImagen := TForm.CreateNew(nil, 0);
  try
    (*Configuramos las propiedades del formulario*)
    FormImagen.BorderStyle := bsNone; (*Sin borde*)
    //FormImagen.Position := poScreenCenter;(*Centramos el formulario en la pantalla*)
    FormImagen.Position := poDesigned;(*Posición relativa al formulario padre*)
    FormImagen.Width := 400;
    FormImagen.Height := 250;

    (*Ajustamos la posición del formulario para centrarlo en el padre*)
    FormImagen.Left := TForm(ParentComponent).Left +
      (TForm(ParentComponent).Width - FormImagen.Width) div 2;
    FormImagen.Top := TForm(ParentComponent).Top +
      (TForm(ParentComponent).Height - FormImagen.Height) div 2;


    (*Creamos un componente TImage y lo agregamos al formulario*)
    Imagen := TImage.Create(FormImagen);
    Imagen.Parent := FormImagen;
    Imagen.Align := alClient;
    Imagen.Stretch := True;

    (*Cargamos la imagen en el componente TImage*)
    Imagen.Picture.LoadFromFile(RutaImagen);

    (*Creamos un botón de aceptar y lo agregamos al formulario*)
    ButtonAceptar := TButton.Create(FormImagen);
    ButtonAceptar.Parent := FormImagen;
    ButtonAceptar.Caption := 'Aceptar';
    ButtonAceptar.Left := (FormImagen.Width - ButtonAceptar.Width) div 2;
    ButtonAceptar.Top := FormImagen.Height - ButtonAceptar.Height - 20;
    ButtonAceptar.ModalResult := mrOk; (*Asignamos el resultado modal al botón Aceptar*)

    (*Mostramos el formulario emergente de forma modal*)
    if FormImagen.ShowModal = mrOk then
    begin

    end;

  finally
    (*Liberamos los recursos del formulario*)
    FormImagen.Free;
  end;
end;

function fMostrarImagenEmergente(const imagen: string;
  ParentComponent: TComponent): boolean;
var
  FormImagen: TForm;
  Image1: TImage;
  ButtonAceptar, ButtonCancelar: TButton;

begin
  Result := False;


  (*Creamos el formulario personalizado sin barra superior*)
  FormImagen := TForm.CreateNew(nil, 0);
  try
    (*Configuramos las propiedades del formulario*)
    FormImagen.BorderStyle := bsNone;(*Sin borde*)
    FormImagen.Position := poScreenCenter;(*Centramos el formulario en la pantalla*)
    FormImagen.Width := 400;
    FormImagen.Height := 300;

    (*Ajustamos la posición del formulario para centrarlo en el formulario padre*)
    FormImagen.Left := TForm(ParentComponent).Left +
      (TForm(ParentComponent).Width - FormImagen.Width) div 2;
    FormImagen.Top := TForm(ParentComponent).Top +
      (TForm(ParentComponent).Height - FormImagen.Height) div 2;


    (*Creamos un componente TImage y lo agregamos al formulario*)
    Image1 := TImage.Create(FormImagen);
    Image1.Parent := FormImagen;
    Image1.Align := alClient;
    Image1.Stretch := True;

    (*Cargamos la imagen en el componente TImage*)
    Image1.Picture.LoadFromFile(imagen);

    ButtonAceptar := TButton.Create(FormImagen);
    ButtonAceptar.Parent := FormImagen;
    ButtonAceptar.Caption := 'Aceptar';
    ButtonAceptar.Left := (FormImagen.Width div 2) - 100;
    ButtonAceptar.Top := FormImagen.Height - ButtonAceptar.Height - 20;
    ButtonAceptar.ModalResult := mrOk;(*Asignamos el resultado modal al botón Aceptar*)

    ButtonCancelar := TButton.Create(FormImagen);
    ButtonCancelar.Parent := FormImagen;
    ButtonCancelar.Caption := 'Cancelar';
    ButtonCancelar.Left := (FormImagen.Width div 2) + 20;
    ButtonCancelar.Top := FormImagen.Height - ButtonCancelar.Height - 20;
    ButtonCancelar.ModalResult := mrCancel;
    (*Asignamos el resultado modal al botón Cancelar*)


    (*Mostramos el formulario emergente de forma modal*)

    if FormImagen.ShowModal = mrOk then
      Result := True;

  finally
    (*Liberamos los recursos del formulario*)
    FormImagen.Free;
  end;
end;


end.
