unit datam;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.FMXUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, IdBaseComponent, IdComponent, idGlobal,
  IdTCPConnection, IdTCPClient, IdCustomTCPServer, IdTCPServer, IdContext;

type
  TDModule = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDQZone: TFDQuery;
    FDQTariff: TFDQuery;
    FDQSoft: TFDQuery;
    FDQRegUser: TFDQuery;
    FDQToken: TFDQuery;
    FDUseerSearch: TFDQuery;
    FDBalance: TFDQuery;
    FDShiftInfo: TFDQuery;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    FDGames: TFDQuery;
    IdTCPClient: TIdTCPClient;
    FDQClubStatistic: TFDQuery;
    FDQBooking: TFDQuery;
    IdTCPServer: TIdTCPServer;
    procedure IdTCPServerExecute(AContext: TIdContext);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function sendToClient (text      , host :string) : integer;

var
  DModule: TDModule;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses msoft;

{$R *.dfm}

procedure TDModule.IdTCPServerExecute(AContext: TIdContext);
var
   strText                            : String;
   ParsMess                           : TStringList;
   msg                                : string;

   ParsMess2 : TStringList;
begin

   strText := AContext.Connection.Socket.ReadLn;

   ParsMess2 := TStringList.Create;
   ParsMess2.Delimiter := '#';
   ParsMess2.StrictDelimiter := True;
   ParsMess2.DelimitedText := strText;


   if ParsMess2[0]='sos' then
   begin
     TThread.Synchronize (nil,
     procedure ()
     begin

      FormManager.Rectangle_SOS.Visible:=true;
      FormManager.FloatAnimSOS.Enabled:=false;
      FormManager.FloatAnimSOS.Enabled:=true;
      FormManager.FloatAnimSOS.Start;


     end);
     AContext.Connection.Socket.WriteLn('done');
   end;
   ParsMess2.Free;

end;

  function sendToClient (text      , host :string) : integer;
  var
        resp2       : string;
        err         : integer;
  begin

    err:=0;
    try
      DModule.IdTCPClient.Host:=host;
      DModule.IdTCPClient.Connect;
      DModule.IdTCPClient.Socket.WriteLn(text,IndyTextEncoding(IdTextEncodingType.encUTF8));
      resp2:=DModule.IdTCPClient.Socket.ReadLn(IndyTextEncoding_UTF8);
      DModule.IdTCPClient.Disconnect;

    except
       err:=1;
    end;

    result:=err;

  end;

end.
