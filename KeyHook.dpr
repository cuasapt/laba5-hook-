library KeyHook;

uses
  Windows,
  SysUtils;
const
  { частоты нот }
  Du = 262; // до
  Re = 294; // ре
  Mi = 330; // ми
  Fa = 349; // фа
  So = 392; // соль
  La = 440; // ля
  Si = 494; // си
  {
   соответствие нот определённым клавишам. 
  }
  
  Chars = 'ZXCVBNM,./';
  Freqs : array[1..Length(Chars)] of word =
  (
  du,re,mi,fa,so,la,si,du,re, mi
  );
  key_down = $40000000; // константа для проверки, что клавиша нажата.
var
  SysHook : HHook = 0; // идентификатор нашего хука
function SysMsgProc(code : integer; wParam : word;
  lParam : longint) : longint; stdcall;
var
  N : integer;
begin
  Result := CallNextHookEx(SysHook, Code, wParam, lParam);
// вызываем следующий хук в системе.
  if code = HC_ACTION then
    if lParam or key_down = lParam // если клавиша нажата
      then
        begin            
          N := Pos(Uppercase(chr(WParam)), Chars); // проверяем её наличие в нашем списке
          if N <> 0 // если нашли
            then Windows.Beep(Freqs[N], 40); // то делаем звуковой сигнал
        end;
end;
{ процедура запуска и остановки }
procedure RunStopHook(State : Boolean) export; stdcall;
begin
  //Если State = true, то ...
  if State
then
      begin
        // запускаем хук
        SysHook := SetWindowsHookEx(WH_KeyBoard, @SysMsgProc, HInstance, 0);
end
    else
      begin
        // отключаем хук
        UnhookWindowsHookEx(SysHook);
        SysHook := 0;
end
end;
exports RunStopHook name 'RunStopHook'; // помещаем нашу процедуру на экспорт,
// чтобы её могло использовать стороннее приложение
end.
