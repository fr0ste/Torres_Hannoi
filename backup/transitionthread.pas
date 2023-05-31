unit TransitionThread;

{$mode ObjFPC}{$H+}

interface

 uses
 Classes, SysUtils, ExtCtrls, Controls;

 type
      TTransicionThread = class(TThread)
        private
       nDiscos : integer;
       pilaTorre1,pilaTorre3,pilaTorre2 : TPilaTorre;
       procedure ResolverTorresHanoi()
      protected
        procedure Execute; override;
     end;
uses
  Classes, SysUtils;

implementation
procedure TTransicionThread.Execute;
   begin

     ResolverTorresHanoi();

     end;
end.

