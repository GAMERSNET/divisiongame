unit bUpdate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Effects, FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls;
  const
            bt      : array [1..12] of string=('1','2','3','4','5','6','7','8','9','0','.','C');
type
  TForm_bUpdate = class(TForm)
    Rectangle_cashbox: TRectangle;
    ShadowEffect1: TShadowEffect;
    Layout1: TLayout;
    GridLayout_button: TGridLayout;
    Layout14: TLayout;
    Rectangle_paytype: TRectangle;
    Layout15: TLayout;
    Rectangle15: TRectangle;
    Edit_amount: TEdit;
    Layout16: TLayout;
    Rectangle16: TRectangle;
    Text17: TText;
    Rectangle17: TRectangle;
    Text18: TText;
    Layout_UserSearch: TLayout;
    AniIndicator_userSearch: TAniIndicator;
    Layout2: TLayout;
    Text_errorText: TText;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Edit_descr: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Text18Click(Sender: TObject);
    procedure ButtonNumClick(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Single);
    procedure Text17Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


  procedure payButton;

  var
          b_layout        : array [1..12] of Tlayout;
          b_rect          : array [1..12] of TRectangle;
          b_txt           : array [1..12] of TText;

var
  Form_bUpdate: TForm_bUpdate;

implementation

{$R *.fmx}

  uses msoft, UserUnit, UnitFinance;

procedure TForm_bUpdate.FormClose(Sender: TObject; var Action: TCloseAction);
begin

    Edit_amount.Text:='';

end;

procedure TForm_bUpdate.FormShow(Sender: TObject);
begin
    Edit_amount.SetFocus;
end;

procedure payButton;
begin

    for var I :=1 to 12 do
    begin
            b_layout[i]:=TLayout.Create(Form_bUpdate.GridLayout_button);
            b_layout[i].Parent:=Form_bUpdate.GridLayout_button;
            b_layout[i].Tag:=i;
            b_layout[i].Opacity:=1;

            b_rect[i]:=Trectangle.Create(b_layout[i]);
            b_rect[i].Parent:=b_layout[i];
            b_rect[i].XRadius:=4;
            b_rect[i].YRadius:=4;
            b_rect[i].Stroke.Thickness:=0;
            b_rect[i].Fill.Color:=$FFE0E0E0;
            b_rect[i].Cursor:=crHandPoint;
            b_rect[i].Opacity:=1;
            b_rect[i].Tag:=i+1;
            b_rect[i].Align:=TAlignlayout.Center;

            b_txt[i]:=TText.Create(b_rect[i]);
            b_txt[i].Parent:=b_rect[i];
            b_txt[i].Align:=talignLayout.Center;
            b_txt[i].Text:=bt[i];
            b_txt[i].Color:=$FF4E4E4E;
            b_txt[i].TextSettings.font.Size:=22;
            b_txt[i].TextSettings.font.family:='Russia';
            b_txt[i].OnMouseDown:=Form_bUpdate.ButtonNumClick;
            b_txt[i].Cursor:=crHandPoint;
            b_txt[i].Tag:=i;

    end;

end;

procedure TForm_bUpdate.ButtonNumClick(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Single);
begin
    if b_txt[(sender as Ttext).Tag].Text<>'C' then
    Edit_amount.Text:=Edit_amount.Text+b_txt[(sender as Ttext).Tag].Text
      else Edit_amount.Text:='';

end;

procedure TForm_bUpdate.Text17Click(Sender: TObject);
begin

  if (Edit_amount.Text<>'') AND (payTypeSelect<>0) then
       //     balanceUpdate_ (User_Uid[userSearch_id].Text, '0', '1', '1', Edit_amount.Text, '1', payTypeSelect.ToString);


            begin

              balance_  (admin_id.ToString, admin_token, User_Uid[userSearch_id].Text, payTypeSelect.ToString ,Edit_amount.Text, c_Token, Edit_descr.Text, shift_num.ToString);

            end;
end;

procedure TForm_bUpdate.Text18Click(Sender: TObject);
begin
    Form_bUpdate.Close;
end;

end.
