unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure z(Sender: TObject);
    end;
 var
  Form1: TForm1;
procedure RunStopHook(State : Boolean); stdcall; external 'KeyHook.dll' name 'RunStopHook';
implementation
{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
   RunStopHook(true);
end;

procedure TForm1.z(Sender: TObject);
begin
  RunStopHook(false);
end;

end.
