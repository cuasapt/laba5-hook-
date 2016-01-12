library KeyHook;

uses
  Windows,
  SysUtils;
const
  { ������� ��� }
  Du = 262; // ��
  Re = 294; // ��
  Mi = 330; // ��
  Fa = 349; // ��
  So = 392; // ����
  La = 440; // ��
  Si = 494; // ��
  {
   ������������ ��� ����������� ��������. 
  }
  
  Chars = 'ZXCVBNM,./';
  Freqs : array[1..Length(Chars)] of word =
  (
  du,re,mi,fa,so,la,si,du,re, mi
  );
  key_down = $40000000; // ��������� ��� ��������, ��� ������� ������.
var
  SysHook : HHook = 0; // ������������� ������ ����
function SysMsgProc(code : integer; wParam : word;
  lParam : longint) : longint; stdcall;
var
  N : integer;
begin
  Result := CallNextHookEx(SysHook, Code, wParam, lParam);
// �������� ��������� ��� � �������.
  if code = HC_ACTION then
    if lParam or key_down = lParam // ���� ������� ������
      then
        begin            
          N := Pos(Uppercase(chr(WParam)), Chars); // ��������� � ������� � ����� ������
          if N <> 0 // ���� �����
            then Windows.Beep(Freqs[N], 40); // �� ������ �������� ������
        end;
end;
{ ��������� ������� � ��������� }
procedure RunStopHook(State : Boolean) export; stdcall;
begin
  //���� State = true, �� ...
  if State
then
      begin
        // ��������� ���
        SysHook := SetWindowsHookEx(WH_KeyBoard, @SysMsgProc, HInstance, 0);
end
    else
      begin
        // ��������� ���
        UnhookWindowsHookEx(SysHook);
        SysHook := 0;
end
end;
exports RunStopHook name 'RunStopHook'; // �������� ���� ��������� �� �������,
// ����� � ����� ������������ ��������� ����������
end.
