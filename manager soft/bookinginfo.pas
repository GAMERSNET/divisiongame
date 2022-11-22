unit bookinginfo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Effects, FMX.Grid, FMX.ScrollBox, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;
  const
              mounthName        : array [1..12] of string=('Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь');
              bookingstatus     : array [0..5] of string=('','','','','Завершена админом', 'Завершено клиентом');
type
  TForm_booking = class(TForm)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Button1: TButton;
    Button2: TButton;
    Layout3: TLayout;
    Text_booking: TText;
    Layout2: TLayout;
    SG_booking: TStringGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    StringColumn5: TStringColumn;
    StringColumn6: TStringColumn;
    StringColumn7: TStringColumn;
    StringColumn8: TStringColumn;
    ShadowEffect1: TShadowEffect;
    StringColumn9: TStringColumn;
    Layout4: TLayout;
    Circle1: TCircle;
    Text_down: TText;
    Layout5: TLayout;
    Circle2: TCircle;
    Text_up: TText;
    Text_mounthNow: TText;
    StringColumn10: TStringColumn;
    StringColumn11: TStringColumn;
    procedure Button2Click(Sender: TObject);
    procedure Text_upMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Text_downMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure bookingInfo_(m,y,user, comp, club : string);

var
  Form_booking: TForm_booking;

implementation


{$R *.fmx}

 uses userUnit, datam, clubmap, bUpdate, msoft, CasboxOperation;

procedure bookingInfo_(m,y,user, comp, club : string);
begin

    if user<>'' then
    begin

        DModule.FDQBooking.sql.clear;
        DModule.FDQBooking.SQL.Add('SELECT * FROM g_reservation WHERE d_start>='''+y+'.'+m+'.01 00:00:00'' AND d_start<='''+y+'.'+m+'.'+IntToStr(MonthDays[IsLeapYear(y.ToInteger)][m.ToInteger])+' 23:59:59'' AND user_id='+user+' AND club_id='+club+' ORDER BY id ASC');
        DModule.FDQBooking.Open;

    end else
    begin

        DModule.FDQBooking.sql.clear;
        DModule.FDQBooking.SQL.Add('SELECT * FROM g_reservation WHERE d_start>='''+y+'.'+m+'.01 00:00:00'' AND d_start<='''+y+'.'+m+'.'+IntToStr(MonthDays[IsLeapYear(y.ToInteger)][m.ToInteger])+' 23:59:59'' AND comp_id='+comp+' AND club_id='+club+' ORDER BY id ASC');
        DModule.FDQBooking.Open;

    end;

    Form_booking.SG_booking.RowCount:=DModule.FDQBooking.recordCount;
    for var I :=1 to DModule.FDQBooking.recordCount do
    begin

      Form_booking.SG_booking.Cells[0,i-1]:=DModule.FDQBooking.fieldByName('d_start').asstring;
      Form_booking.SG_booking.Cells[1,i-1]:=DModule.FDQBooking.fieldByName('d_end').asstring;

      Form_booking.SG_booking.Cells[2,i-1]:=DModule.FDQBooking.fieldByName('duration').asstring;

      Form_booking.SG_booking.Cells[3,i-1]:=DModule.FDQBooking.fieldByName('amount').asstring;
      Form_booking.SG_booking.Cells[4,i-1]:=DModule.FDQBooking.fieldByName('bonus').asstring;
      Form_booking.SG_booking.Cells[5,i-1]:=DModule.FDQBooking.fieldByName('mins').asstring;

      Form_booking.SG_booking.Cells[6,i-1]:=DModule.FDQBooking.fieldByName('tariff_name').asstring;
      Form_booking.SG_booking.Cells[7,i-1]:=DModule.FDQBooking.fieldByName('comp_id').asstring;
      Form_booking.SG_booking.Cells[8,i-1]:=DModule.FDQBooking.fieldByName('user_id').asstring;  //bookingstatus

      Form_booking.SG_booking.Cells[9,i-1]:=bookingstatus[DModule.FDQBooking.fieldByName('status').asInteger];
      DModule.FDQBooking.next;

    end;


end;

procedure TForm_booking.Button2Click(Sender: TObject);
begin
      close;
end;

procedure TForm_booking.Text_downMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
          if Text_mounthNow.TagString='1' then
          begin
                Text_mounthNow.TagString:='13';
                Text_mounthNow.Tag:=Text_mounthNow.Tag-1;
          end;

          Text_mounthNow.TagString:=inttostr(Text_mounthNow.TagString.ToInteger-1);
          Text_mounthNow.Text:=mounthName[Text_mounthNow.TagString.ToInteger]+' '+Text_mounthNow.Tag.ToString;

          if form_booking.Text_booking.Tag=1 then bookingInfo_(Text_mounthNow.TagString,Text_mounthNow.Tag.ToString, User_Uid[userSearch_id].Text, '', club_id.ToString)
          else bookingInfo_(Text_mounthNow.TagString,Text_mounthNow.Tag.ToString, '', map_pc_select.ToString, club_id.ToString);

end;

procedure TForm_booking.Text_upMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
          if Text_mounthNow.TagString='12' then
          begin
                Text_mounthNow.TagString:='0';
                Text_mounthNow.Tag:=Text_mounthNow.Tag+1;
          end;

          Text_mounthNow.TagString:=inttostr(Text_mounthNow.TagString.ToInteger+1);
          Text_mounthNow.Text:=mounthName[Text_mounthNow.TagString.ToInteger]+' '+Text_mounthNow.Tag.ToString;

          if form_booking.Text_booking.Tag=1 then bookingInfo_(Text_mounthNow.TagString,Text_mounthNow.Tag.ToString, User_Uid[userSearch_id].Text, '', club_id.ToString)
          else bookingInfo_(Text_mounthNow.TagString,Text_mounthNow.Tag.ToString, '', map_pc_select.ToString, club_id.ToString);


end;

end.
