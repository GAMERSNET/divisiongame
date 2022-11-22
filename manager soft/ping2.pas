unit ping2;


interface

  procedure pingpclist;
  function  PingHost(const HostName: AnsiString; TimeoutMS: cardinal = 500): boolean;

implementation

uses  Windows, SysUtils, WinSock, system.Threading, system.Classes, msoft, clubmap;

function IcmpCreateFile: THandle; stdcall; external 'iphlpapi.dll';
function IcmpCloseHandle(icmpHandle: THandle): boolean; stdcall;
  external 'iphlpapi.dll';
function IcmpSendEcho(icmpHandle: THandle; DestinationAddress: In_Addr;
  RequestData: Pointer; RequestSize: Smallint; RequestOptions: Pointer;
  ReplyBuffer: Pointer; ReplySize: DWORD; Timeout: DWORD): DWORD; stdcall;
  external 'iphlpapi.dll';

type
  TEchoReply = packed record
    Addr: In_Addr;
    Status: DWORD;
    RoundTripTime: DWORD;
  end;

  PEchoReply = ^TEchoReply;

var
  WSAData: TWSAData;

procedure Startup;
begin
  if WSAStartup($0101, WSAData) <> 0 then
    raise Exception.Create('WSAStartup');
end;

procedure Cleanup;
begin
  if WSACleanup <> 0 then
    raise Exception.Create('WSACleanup');
end;

function PingHost(const HostName: AnsiString;
  TimeoutMS: cardinal = 500): boolean;
const
  rSize = $400;
var
  e: PHostEnt;
  a: PInAddr;
  h: THandle;
  d: string;
  r: array [0 .. rSize - 1] of byte;
  i: cardinal;
begin
  Startup;
  e := gethostbyname(PAnsiChar(HostName));
  if e = nil then
   // RaiseLastOSError;
   begin
    result := false;
    exit;
   end;
  if e.h_addrtype = AF_INET then
    Pointer(a) := e.h_addr^
  else
   // raise Exception.Create('Name doesn''t resolve to an IPv4 address');
     begin
    result := false;
    exit;
   end;

  d := FormatDateTime('yyyymmddhhnnsszzz', Now);

  h := IcmpCreateFile;
  if h = INVALID_HANDLE_VALUE then
    RaiseLastOSError;
  try
    i := IcmpSendEcho(h, a^, PChar(d), Length(d), nil, @r[0], rSize, TimeoutMS);
    Result := (i <> 0) and (PEchoReply(@r[0]).Status = 0);
  finally
    IcmpCloseHandle(h);
  end;
  Cleanup;
end;

procedure pingpclist;
begin

 TThread.CreateAnonymousThread(procedure ()
 begin

      for var I09 :=1 to map_ip_list.Count do
      begin

          if PingHost(map_ip_list[i09-1],300)=true then begin

              TThread.Synchronize (nil,
              procedure ()
              begin
                   map_status[map_ip[i09].tag].Opacity:=0;
                   visual_status[map_ip[i09].tag].Opacity:=0;
              end);

          end

          else begin

              TThread.Synchronize (nil,
              procedure ()
              begin

                    map_status[map_ip[i09].tag].Opacity:=1;
                    visual_status[map_ip[i09].tag].Opacity:=1;
              end);

          end;

      end;

 end).Start;


end;

end.
