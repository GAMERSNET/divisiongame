unit CasboxOperation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Effects, FMX.StdCtrls, FMX.TextLayout;
const
              mounthName        : array [1..12] of string=('Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь');

type
  TForm_CBoperation = class(TForm)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Layout2: TLayout;
    SG_shiftSt: TStringGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    StringColumn5: TStringColumn;
    StringColumn6: TStringColumn;
    StringColumn7: TStringColumn;
    ShadowEffect1: TShadowEffect;
    Button1: TButton;
    Button2: TButton;
    Layout3: TLayout;
    Text1: TText;
    StringColumn8: TStringColumn;
    Layout4: TLayout;
    Circle1: TCircle;
    Text_down: TText;
    Text_mounthNow: TText;
    Layout5: TLayout;
    Circle2: TCircle;
    Text_up: TText;
    procedure Button2Click(Sender: TObject);
    procedure Text_upMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure SG_shiftStDrawColumnCell(Sender: TObject; const Canvas: TCanvas;
      const Column: TColumn; const Bounds: TRectF; const Row: Integer;
      const Value: TValue; const State: TGridDrawStates);
    procedure Text_downClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_CBoperation: TForm_CBoperation;

implementation

{$R *.fmx}
      uses UnitFinance, db, msoft,datam, ping2, UserUnit;
procedure TForm_CBoperation.Button2Click(Sender: TObject);
begin
  Form_CBoperation.Close;
end;

procedure TForm_CBoperation.SG_shiftStDrawColumnCell(Sender: TObject;
  const Canvas: TCanvas; const Column: TColumn; const Bounds: TRectF;
  const Row: Integer; const Value: TValue; const State: TGridDrawStates);
const
  HorzTextMargin = 2;
  VertTextMargin = 1;
var
  TextLayout : TTextLayout;
  TextRect   : TRectF;

  aRowColor  : TBrush;
  aNewRectF  : TRectF;
begin
  aRowColor := TBrush.Create(TBrushKind.Solid, TAlphaColors.Alpha);
  //=('Наличные','Безнал','Бонусы','Минуты');

  if (SG_shiftSt.Cells[4, Row] = 'Минуты') then aRowColor.Color := $FFD88A8D;
  if (SG_shiftSt.Cells[4, Row] = 'Бонусы') then aRowColor.Color := $FFebb700;

  if (SG_shiftSt.Cells[4, Row] = 'Безнал') or (SG_shiftSt.Cells[4, Row] = 'Наличные') then aRowColor.Color := $FFf2f3f3;
  if (SG_shiftSt.Cells[3, Row] = 'Возврат') then aRowColor.Color := $FF85bab5;

  if row= SG_shiftSt.Selected then  aRowColor.Color := $0067b2fb;


  aNewRectF := Bounds;
  aNewRectF.Inflate(3, 3);
  Canvas.FillRect(aNewRectF, 0, 0, [], 1, aRowColor);
  Column.DefaultDrawCell(Canvas, Bounds, Row, Value, State);

  aRowColor.free;

end;

procedure TForm_CBoperation.Text_downClick(Sender: TObject);
begin
if Text_mounthNow.TagString='1' then
          begin
                Text_mounthNow.TagString:='13';
                Text_mounthNow.Tag:=Text_mounthNow.Tag-1;
          end;

          Text_mounthNow.TagString:=inttostr(Text_mounthNow.TagString.ToInteger-1);
          Text_mounthNow.Text:=mounthName[Text_mounthNow.TagString.ToInteger]+' '+Text_mounthNow.Tag.ToString;
          if Form_CBoperation.Tag=1 then shiftOperationList_ (Text_mounthNow.TagString.ToInteger,Text_mounthNow.Tag, 0,  club_id, 0);
          if Form_CBoperation.Tag=2 then shiftOperationList_ (Text_mounthNow.TagString.ToInteger,Text_mounthNow.Tag,0,  club_id, User_Uid[userSearch_id].Text.ToInteger);
end;

procedure TForm_CBoperation.Text_upMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
          if Text_mounthNow.TagString='12' then
          begin
                Text_mounthNow.TagString:='0';
                Text_mounthNow.Tag:=Text_mounthNow.Tag+1;
          end;

          Text_mounthNow.TagString:=inttostr(Text_mounthNow.TagString.ToInteger+1);
          Text_mounthNow.Text:=mounthName[Text_mounthNow.TagString.ToInteger]+' '+Text_mounthNow.Tag.ToString;

          if Form_CBoperation.Tag=1 then shiftOperationList_ (Text_mounthNow.TagString.ToInteger,Text_mounthNow.Tag, 0,  club_id, 0);
          if Form_CBoperation.Tag=2 then shiftOperationList_ (Text_mounthNow.TagString.ToInteger,Text_mounthNow.Tag,0,  club_id, User_Uid[userSearch_id].Text.ToInteger);

end;

end.
