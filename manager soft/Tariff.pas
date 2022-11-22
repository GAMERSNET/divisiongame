unit Tariff;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox, system.JSON,
  FMX.Edit, FMX.Effects, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Layouts, FMX.DateTimeCtrls;

type
  TForm_tarif = class(TForm)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Button1: TButton;
    Button2: TButton;
    Layout3: TLayout;
    Text1: TText;
    Layout2: TLayout;
    Layout8: TLayout;
    Rectangle6: TRectangle;
    Text7: TText;
    ShadowEffect1: TShadowEffect;
    Layout4: TLayout;
    Text2: TText;
    Rectangle_userSearch: TRectangle;
    Edit_name: TEdit;
    Layout5: TLayout;
    Text3: TText;
    Rectangle2: TRectangle;
    Edit_price: TEdit;
    Layout6: TLayout;
    Text4: TText;
    Layout7: TLayout;
    Text5: TText;
    Rectangle4: TRectangle;
    Edit_duration: TEdit;
    TimeEdit_start: TTimeEdit;
    StyleBook1: TStyleBook;
    Text9: TText;
    TimeEdit_end: TTimeEdit;
    AniIndicator_tariff: TAniIndicator;
    procedure Button2Click(Sender: TObject);
    procedure Text7Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function tariffList_(club_id, day, zone   : integer) : integer;

var
  Form_tarif: TForm_tarif;

implementation

{$R *.fmx}

uses bUpdate, datam, msoft, UserUnit;

procedure TForm_tarif.Button2Click(Sender: TObject);
begin
    close;
end;

function tariffList_(club_id, day, zone   : integer) : integer;
begin
  TThread.CreateAnonymousThread(procedure ()
  begin

    DModule.FDQtariff.sql.clear;
    DModule.FDQtariff.SQL.Add('SELECT * FROM g_price WHERE club_id='+club_id.ToString+' AND zone_id='+zone.ToString+' AND week_day='+day.ToString+' ORDER BY zone_id ASC');
    DModule.FDQtariff.Open;

       TThread.Synchronize(nil,
       procedure
       begin
         FormManager.StringGrid_tariff.RowCount:=DModule.FDQtariff.RecordCount;

         for var x :=1 to DModule.FDQtariff.RecordCount do
         begin

           FormManager.StringGrid_tariff.Cells[0,x-1]:=DModule.FDQtariff.FieldByName('tariff').AsString;
           FormManager.StringGrid_tariff.Cells[1,x-1]:=DModule.FDQtariff.FieldByName('price').AsString;
           FormManager.StringGrid_tariff.Cells[2,x-1]:=formatDateTime('hh:mm',DModule.FDQtariff.FieldByName('time_start').AsDateTime);
           FormManager.StringGrid_tariff.Cells[3,x-1]:=formatDateTime('hh:mm',DModule.FDQtariff.FieldByName('time_stop').AsDateTime);
           FormManager.StringGrid_tariff.Cells[4,x-1]:=DModule.FDQtariff.FieldByName('duration').AsString;

           if DModule.FDQtariff.FieldByName('tariff_type').AsInteger=0 then
                      FormManager.StringGrid_tariff.Cells[5,x-1]:='Поминутный'
                      else
                      FormManager.StringGrid_tariff.Cells[5,x-1]:='Пакет минут';


           DModule.FDQtariff.Next;

         end;

       end);

  end).Start;

end;

function newtariff_  ( user_token, admin_id, clubToken, tariff, price, start, end_, duration, dayof, zone: string): integer;
  var
    JsonValue                    : TJSONValue;
    s                            : string;
  begin

       TThread.Synchronize(nil,
       procedure
       begin
            Form_tarif.AniIndicator_tariff.Visible:=true;
            Form_tarif.AniIndicator_tariff.Enabled:=true;

       end);

       TThread.CreateAnonymousThread(procedure ()
       begin
             DataM.DModule.RESTRequest1.Params[0].Value:='{"cmd":"tariffcreate","data":{"user_id":"'+admin_id+'", "user_token":"'+user_token+'","tariff":"'+tariff+'", "price":"'+price+'","start":"'+start+'","end":"'+end_+'", "duration":'+duration+',"dayof":'+dayof+', "zone":'+zone+'},"token":"'+clubToken+'"}';
             DataM.DModule.RESTRequest1.Execute;

             JsonValue:= TJSONValue.Create;
             JsonValue := TJSonObject.ParseJSONValue(DataM.DModule.RESTResponse1.JSONText);

             TThread.Synchronize(nil,
             procedure
             begin

                   case JsonValue.GetValue<integer>('error') of

                        0 : begin
                            Form_bUpdate.Close;
                            showText('Операция выполнена успешно!');
                        end;
                        1..2000 : begin

                            Form_bUpdate.Close;
                            showText('Ошибка при создании тарифа! Error: '+JsonValue.GetValue<string>('error'));

                        end;
                   end;

             end);

             TThread.Synchronize(nil,
             procedure
             begin

                Form_tarif.AniIndicator_tariff.Visible:=false;
                Form_tarif.AniIndicator_tariff.Enabled:=false;
                Form_tarif.Close;

             end);

       end).Start;

  end;


procedure TForm_tarif.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Edit_name.Text:='';
  Edit_price.Text:='';
  Edit_duration.Text:='';

end;

procedure TForm_tarif.Text7Click(Sender: TObject);
var
      dd        : string;
begin

   if (Edit_name.Text='') or  (Edit_price.Text='')  then
   begin
       showText('Заполните необходимые поля!');
   end else
   begin

      dd:=Edit_duration.Text;
      if (dd='') then dd:='0';

      newtariff_( admin_token, admin_id.ToString, c_Token, Edit_name.Text, Edit_price.Text, timetostr(TimeEdit_start.Time), timetostr(TimeEdit_end.Time), dd, '1', tzoneSelect.ToString);
      tariffList_(club_id, 1, tzoneSelect);

   end;

end;

end.
