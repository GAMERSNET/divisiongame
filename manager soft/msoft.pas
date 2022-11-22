unit msoft;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,   FMX.TextLayout,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Effects, System.Rtti, FMX.Grid.Style, FMX.Grid,  Winapi.Windows, FMX.Platform.Win,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Edit, FMX.StdCtrls, FMX.Ani, system.Threading;

type
  TFormManager = class(TForm)
    Layout_topMenu: TLayout;
    Rect_topMenu: TRectangle;
    Layout_infoPanel: TLayout;
    Rect_infoPanel: TRectangle;
    Rect_tmp: TRectangle;
    Rectangle1: TRectangle;
    Layout_work: TLayout;
    Rect_work: TRectangle;
    ShadowEffect1: TShadowEffect;
    Layout1: TLayout;
    Text_Mclient: TText;
    Layout_admninInfo: TLayout;
    Layout_avatar: TLayout;
    Circle1: TCircle;
    Text_adminname: TText;
    Layout2: TLayout;
    Text_mMap: TText;
    Layout3: TLayout;
    Text_mTariff: TText;
    Layout4: TLayout;
    Layout5: TLayout;
    Rectangle2: TRectangle;
    Text4: TText;
    Text_dateShift: TText;
    Text_timeShift: TText;
    Layout6: TLayout;
    Text_cash: TText;
    Text8: TText;
    Layout8: TLayout;
    Circle2: TCircle;
    Arc_cash: TArc;
    Arc_noncash: TArc;
    Layout_total: TLayout;
    Text_cashOp: TText;
    Text_nocashOp: TText;
    Layout9: TLayout;
    Rectangle3: TRectangle;
    Text_nocash: TText;
    Text9: TText;
    Layout7: TLayout;
    Circle3: TCircle;
    Arc_bonus: TArc;
    Arc_cashbox: TArc;
    Layout10: TLayout;
    Text_totalPay: TText;
    Text_totalBonus: TText;
    Layout11: TLayout;
    Rectangle4: TRectangle;
    Layout12: TLayout;
    Text_cashbox: TText;
    Text15: TText;
    Text_bonus: TText;
    Text17: TText;
    Layout13: TLayout;
    Rectangle5: TRectangle;
    Layout14: TLayout;
    Rectangle6: TRectangle;
    Layout15: TLayout;
    Rectangle7: TRectangle;
    Rectangle8: TRectangle;
    Layout16: TLayout;
    Text19: TText;
    Text20: TText;
    Layout17: TLayout;
    Text18: TText;
    Text21: TText;
    Layout18: TLayout;
    Rectangle9: TRectangle;
    Rectangle10: TRectangle;
    Layout_clients: TLayout;
    Layout19: TLayout;
    Layout20: TLayout;
    Rectangle_userSearch: TRectangle;
    Layout21: TLayout;
    Rectangle12: TRectangle;
    Edit_search: TEdit;
    Layout22: TLayout;
    Layout23: TLayout;
    Layout_r2: TLayout;
    Layout_r3: TLayout;
    Layout_r4: TLayout;
    Layout_r5: TLayout;
    Layout_r1: TLayout;
    Layout29: TLayout;
    SizeGrip1: TSizeGrip;
    Layout24: TLayout;
    ScrollBox_userSearch: TScrollBox;
    GridLayout_userList: TGridLayout;
    Layout27: TLayout;
    Layout28: TLayout;
    Button_menuOnOff: TButton;
    FloatAnimation_panel_onOff: TFloatAnimation;
    FloatAnimation1: TFloatAnimation;
    Layout25: TLayout;
    Rectangle13: TRectangle;
    Text22: TText;
    Layout26: TLayout;
    Layout30: TLayout;
    Layout31: TLayout;
    Text_Msoft: TText;
    Layout32: TLayout;
    Layout_map: TLayout;
    Layout34: TLayout;
    Layout35: TLayout;
    Layout36: TLayout;
    Rectangle_zonename: TRectangle;
    Layout40: TLayout;
    Layout41: TLayout;
    ScrollBox_Map: TScrollBox;
    Layout38: TLayout;
    Rectangle_mapType: TRectangle;
    Rectangle_switch_map: TRectangle;
    Text27: TText;
    Text28: TText;
    Layout39: TLayout;
    Layout43: TLayout;
    Layout_reserv: TLayout;
    Layout45: TLayout;
    Layout46: TLayout;
    Layout37: TLayout;
    Button_USearch: TButton;
    Layout33: TLayout;
    Text_mFin: TText;
    Layout_UserSearch: TLayout;
    AniIndicator_userSearch: TAniIndicator;
    Rectangle_alert: TRectangle;
    FloatAnim_alert: TFloatAnimation;
    Layout42: TLayout;
    Text_alert: TText;
    Layout47: TLayout;
    Layout_newUser: TLayout;
    Layout_reservHistory: TLayout;
    Layout_PayHistory: TLayout;
    ScrollBox_mapList: TScrollBox;
    GridLayout_mapList: TGridLayout;
    Layout_pcOff: TLayout;
    Layout_screen: TLayout;
    Layout_reboot: TLayout;
    Layout_alert: TLayout;
    Rectangle_login: TRectangle;
    Layout44: TLayout;
    Rectangle14: TRectangle;
    Layout48: TLayout;
    Rectangle15: TRectangle;
    edit_authLogin: TEdit;
    Layout49: TLayout;
    Rectangle16: TRectangle;
    Edit_authPass: TEdit;
    Layout50: TLayout;
    Text6: TText;
    Layout51: TLayout;
    Layout_button_auth: TLayout;
    Rectangle17: TRectangle;
    Text_loginb: TText;
    Layout52: TLayout;
    Layout53: TLayout;
    Text14: TText;
    Layout54: TLayout;
    AniIndicator_login: TAniIndicator;
    Layout55: TLayout;
    Layout56: TLayout;
    Text24: TText;
    Layout57: TLayout;
    Layout58: TLayout;
    Text16: TText;
    Layout_shift: TLayout;
    Layout60: TLayout;
    Layout71: TLayout;
    ScrollBox1: TScrollBox;
    Layout72: TLayout;
    Layout73: TLayout;
    Layout61: TLayout;
    Layout62: TLayout;
    SG_shiftSt: TStringGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    StringColumn5: TStringColumn;
    StringColumn6: TStringColumn;
    Column1: TColumn;
    StringColumn7: TStringColumn;
    StringColumn8: TStringColumn;
    StringColumn9: TStringColumn;
    StringColumn10: TStringColumn;
    StringColumn11: TStringColumn;
    StringColumn12: TStringColumn;
    StringColumn13: TStringColumn;
    StringColumn14: TStringColumn;
    StringColumn15: TStringColumn;
    StringColumn16: TStringColumn;
    StyleBook1: TStyleBook;
    StringColumn17: TStringColumn;
    Button2: TButton;
    Layout_games: TLayout;
    Layout63: TLayout;
    Layout64: TLayout;
    ScrollBox2: TScrollBox;
    SGGames: TStringGrid;
    StringColumn18: TStringColumn;
    Layout65: TLayout;
    Layout66: TLayout;
    Layout_game: TLayout;
    Layout68: TLayout;
    StringColumn19: TStringColumn;
    StringColumn20: TStringColumn;
    StringColumn21: TStringColumn;
    StringColumn22: TStringColumn;
    StringColumn23: TStringColumn;
    Layout_gameCreate: TLayout;
    Layout70: TLayout;
    Layout_gameTest: TLayout;
    Layout75: TLayout;
    Layout_gameDel: TLayout;
    Layout77: TLayout;
    StringColumn24: TStringColumn;
    Image1: TImage;
    Text_comp_num_select: TText;
    Timer_ping: TTimer;
    Layout59: TLayout;
    Rectangle_mapListHeader: TRectangle;
    Text5: TText;
    Text10: TText;
    Text11: TText;
    Text12: TText;
    Text23: TText;
    Text26: TText;
    Text29: TText;
    Text30: TText;
    Text31: TText;
    Rectangle11: TRectangle;
    Text32: TText;
    ShadowEffect2: TShadowEffect;
    Text_loginError: TText;
    Layout67: TLayout;
    Rectangle18: TRectangle;
    Text_uid: TText;
    Text_ulogin: TText;
    Text_Uemail: TText;
    Text_uPhone: TText;
    Text_uVisit: TText;
    Text_uBalance: TText;
    Text_Ubonus: TText;
    Text_Umin: TText;
    Layout69: TLayout;
    Layout74: TLayout;
    Layout76: TLayout;
    Layout_dashboard: TLayout;
    Layout79: TLayout;
    Layout95: TLayout;
    Layout96: TLayout;
    ScrollBox3: TScrollBox;
    Layout78: TLayout;
    Layout80: TLayout;
    Layout81: TLayout;
    Rectangle19: TRectangle;
    Layout83: TLayout;
    Rectangle20: TRectangle;
    Text2: TText;
    Layout82: TLayout;
    Layout84: TLayout;
    Layout85: TLayout;
    Rectangle21: TRectangle;
    Rectangle22: TRectangle;
    Layout86: TLayout;
    Layout87: TLayout;
    GridLayout_pctimeload: TGridLayout;
    Layout88: TLayout;
    Arc_totalUser: TArc;
    Arc_NewUser: TArc;
    FloatAnimation_userTotal: TFloatAnimation;
    FloatAnimation_userNew: TFloatAnimation;
    Layout89: TLayout;
    Text1: TText;
    Text3: TText;
    Layout90: TLayout;
    Rectangle23: TRectangle;
    Rectangle24: TRectangle;
    Text25: TText;
    GridLayout_compFree: TGridLayout;
    Layout91: TLayout;
    Text7: TText;
    Rectangle25: TRectangle;
    Rectangle26: TRectangle;
    Text33: TText;
    Text34: TText;
    Layout92: TLayout;
    Text35: TText;
    Rectangle27: TRectangle;
    Rectangle28: TRectangle;
    Text36: TText;
    Text37: TText;
    Layout93: TLayout;
    Text38: TText;
    Rectangle29: TRectangle;
    Rectangle30: TRectangle;
    Text39: TText;
    Text40: TText;
    Layout94: TLayout;
    Text41: TText;
    Rectangle31: TRectangle;
    Rectangle32: TRectangle;
    Text42: TText;
    Text43: TText;
    Layout97: TLayout;
    Layout98: TLayout;
    Layout99: TLayout;
    Layout100: TLayout;
    Rectangle33: TRectangle;
    Layout101: TLayout;
    Arc1: TArc;
    FloatAnimation2: TFloatAnimation;
    Arc3: TArc;
    FloatAnimation3: TFloatAnimation;
    Layout102: TLayout;
    Text44: TText;
    Text45: TText;
    Layout103: TLayout;
    Rectangle34: TRectangle;
    Layout104: TLayout;
    Rectangle35: TRectangle;
    Text46: TText;
    Layout_tariff: TLayout;
    Layout106: TLayout;
    Layout107: TLayout;
    ScrollBox4: TScrollBox;
    StringGrid_tariff: TStringGrid;
    StringColumn25: TStringColumn;
    Layout108: TLayout;
    Layout109: TLayout;
    Layout110: TLayout;
    Layout111: TLayout;
    StringColumn26: TStringColumn;
    StringColumn27: TStringColumn;
    StringColumn28: TStringColumn;
    StringColumn29: TStringColumn;
    StringColumn30: TStringColumn;
    Rectangle_tariff: TRectangle;
    StringColumn31: TStringColumn;
    Layout105: TLayout;
    Layout_newTariff: TLayout;
    Layout112: TLayout;
    Layout113: TLayout;
    Image2: TImage;
    Layout114: TLayout;
    Layout115: TLayout;
    Rectangle_SOS: TRectangle;
    Text_SOS: TText;
    FloatAnimSOS: TFloatAnimation;

    procedure newButtonClick(Sender: TObject);

    procedure FormResize(Sender: TObject);
    procedure Button_menuOnOffClick(Sender: TObject);
    procedure ZoneNameClick(Sender: TObject);
    procedure tZoneNameClick(Sender: TObject);
    procedure ptNameClick(Sender: TObject);
    ///
    procedure userSearchClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button_USearchClick(Sender: TObject);
    procedure Text22Click(Sender: TObject);
    procedure Rect_topMenuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Rect_topMenuDblClick(Sender: TObject);
    procedure mapListClick(Sender: TObject);
    procedure Text28Click(Sender: TObject);
    procedure Text27Click(Sender: TObject);
    procedure Text_loginbClick(Sender: TObject);
    procedure SG_shiftStCellDblClick(const Column: TColumn; const Row: Integer);
    procedure Button2Click(Sender: TObject);
    procedure SGGamesCellDblClick(const Column: TColumn; const Row: Integer);
    procedure Text_mMapClick(Sender: TObject);
    procedure Text_MsoftClick(Sender: TObject);
    procedure Timer_pingTimer(Sender: TObject);
    procedure edit_authLoginMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Edit_authPassMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FloatAnimation_userTotalProcess(Sender: TObject);
    procedure FloatAnimation_userNewProcess(Sender: TObject);
    procedure Text_MclientClick(Sender: TObject);
    procedure Text_mFinClick(Sender: TObject);
    procedure Text_uidClick(Sender: TObject);
    procedure SG_shiftStDrawColumnCell(Sender: TObject; const Canvas: TCanvas;
      const Column: TColumn; const Bounds: TRectF; const Row: Integer;
      const Value: TValue; const State: TGridDrawStates);
    procedure Text25Click(Sender: TObject);
    ///
  private
  taskLogin: ITask;
    { Private declarations }
  public
    { Public declarations }
  end;
procedure showText (txt  : STRING);
procedure newButton (nameButton  : string; id: integer; obj :TComponent; FMXobj: TFMXobject; text : string; color, textColor : TalphaColor; sizeText : integer; img : string );

var
  FormManager: TFormManager;
  userSearch_id       : integer=0;
  zoneSelect          : integer=0;
  tzoneSelect         : integer=0;
  payTypeSelect       : integer=0;
  buttonTo            : array  [1..100] of Trectangle;
  buttonToText        : array  [1..100] of Ttext;
  buttonToAnim        : array  [1..100] of TfloatAnimation;
  buttonToAnimW       : array  [1..100] of TfloatAnimation;
  buttonToImg         : array  [1..100] of TImage;

implementation

{$R *.fmx}
    uses userUnit,
    datam,
    clubmap,
    bUpdate,
    UnitFinance,
    CasboxOperation,
    unitGames
    , UnitGameCreate
    , ping2, bookinginfo, Tariff, shoftClose;
                    //MapListClick
procedure TFormManager.Button_USearchClick(Sender: TObject);
begin

    userSearch(Edit_search.Text);

end;

procedure TFormManager.edit_authLoginMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
    Text_loginError.Text:='';
end;

procedure TFormManager.Edit_authPassMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Text_loginError.Text:='';
end;

procedure TFormManager.mapListClick(Sender: TObject);
begin
    if map_pc_select<>0 then
    begin

      comp_anim[map_pc_select].Enabled:=false;
      comp_anim2[map_pc_select].Enabled:=false;
    end;

    map_pc_select:=(sender as Ttext).Tag;
    FormManager.Text_comp_num_select.Text:=map_pc_select.ToString;
    comp_anim[map_pc_select].Enabled:=true;
    comp_anim2[map_pc_select].Enabled:=true;

end;

procedure TFormManager.newButtonClick(Sender: TObject);
begin

           buttonToAnim[(sender as TImage).Tag].Enabled:=false;
      //     buttonToAnimw[(sender as Ttext).Tag].Enabled:=false;

           buttonToAnim[(sender as TImage).Tag].Enabled:=true;
     //      buttonToAnimw[(sender as Ttext).Tag].Enabled:=true;
    case (sender as TImage).Tag of

        3: begin        // истори€ пополнений

           if userSearch_id<>0 then
           begin
              Form_CBoperation.Tag:=2 ;
           //   shiftOperationList_ (m,y,shift_id, club, user_id :integer);
              shiftOperationList_ (formatdatetime('mm',now).ToInteger,formatdatetime('yyyy',now).ToInteger,0,  5, User_Uid[userSearch_id].Text.ToInteger);
              Form_CBoperation.ShowModal;

           end;

        end;

        10: FormGames.ShowModal;

        8: begin

            form_booking.Text_booking.Tag:=2;
            bookingInfo_(formatdatetime('mm',now),formatdatetime('yyyy',now), '', map_pc_select.ToString, club_id.ToString);
            form_booking.ShowModal;

        end;

        2: begin

            form_booking.Text_booking.Tag:=1;
            bookingInfo_(formatdatetime('mm',now),formatdatetime('yyyy',now), user_Uid[userSearch_id].Text, '', club_id.ToString);
            form_booking.ShowModal;

        end;
        13: begin

          if tzoneSelect>0 then form_tarif.ShowModal;

        end;
        5: BEGIN //OFF
          if map_pc_select<>0 then
             sendToClient ('poweroff#'      , map_ip[map_pc_select].Text)
        END;

        7: BEGIN //REBOOT
          if map_pc_select<>0 then
             sendToClient ('reboot#'      , map_ip[map_pc_select].Text)
        END;

    end;


end;

procedure newButton (nameButton  : string; id: integer; obj :TComponent; FMXobj: TFMXobject; text : string; color, textColor : TalphaColor; sizeText : integer; img : string );
        var
              w,h     : single;
begin

      buttonTo[id]:=Trectangle.Create(Obj);
      buttonTo[id].Parent:=FMXobj;
      buttonTo[id].Align:=TalignLayout.Client;
      w:=buttonTo[id].Width;
      h:=buttonTo[id].Height;
      buttonTo[id].Align:=talignLayout.Center;
      buttonTo[id].Width:=w-3;
      buttonTo[id].Height:=h-3;
      buttonTo[id].XRadius:=4;
      buttonTo[id].YRadius:=4;
      buttonTo[id].Stroke.Thickness:=0;
      buttonTo[id].Fill.Color:=color;
      buttonTo[id].Opacity:=1;
      buttonTo[id].Tag:=id;
      buttonTo[id].Cursor:=crHandPoint;

      if text='' then
      begin
            buttonToImg[id]:=Timage.Create(buttonTo[id]);
            buttonToImg[id].Parent:=buttonTo[id];
            buttonToImg[id].Align:=talignLayout.Client;
            buttonToImg[id].Tag:=id;
            buttonToImg[id].Bitmap.LoadFromFile(img);
            buttonToImg[id].OnClick:=FormManager.newButtonClick;
            buttonToImg[id].WrapMode:=TimageWrapMode.Center;
            buttonToImg[id].Opacity:=0.6;

      end else
      begin

            buttonToText[id]:=TText.Create(buttonTo[id]);
            buttonToText[id].Parent:=buttonTo[id];
            buttonToText[id].Align:=talignLayout.Client;
            buttonToText[id].Text:=text;
            buttonToText[id].Color:=textColor;
            buttonToText[id].TextSettings.font.Size:=sizeText;
            buttonToText[id].TextSettings.font.family:='Russia';
            buttonToText[id].OnClick:=FormManager.newButtonClick;
            buttonToText[id].Cursor:=crHandPoint;
            buttonToText[id].Tag:=id;

      end;

      buttonToAnim[id]:=TFloatanimation.Create(buttonTo[id]);
      buttonToAnim[id].Parent:=buttonTo[id];
      buttonToAnim[id].Delay:=0;
      buttonToAnim[id].startValue:=1;
      buttonToAnim[id].StopValue:=0.3;
      buttonToAnim[id].AutoReverse:=true;
      buttonToAnim[id].Enabled:=false;
      buttonToAnim[id].PropertyName:='Opacity';
      buttonToAnim[id].Duration:=0.3;
      buttonToAnim[id].Tag:=id;




  {    buttonToAnimw[id]:=TFloatanimation.Create(buttonToText[id]);
      buttonToAnimw[id].Parent:=buttonToText[id];
      buttonToAnimw[id].Delay:=0;
      buttonToAnimw[id].startValue:=SizeText;
      buttonToAnimw[id].StopValue:=SizeText-2;
      buttonToAnimw[id].AutoReverse:=true;
      buttonToAnimw[id].Enabled:=false;
      buttonToAnimw[id].PropertyName:='Size';
      buttonToAnimw[id].Duration:=0.3;
      buttonToAnimw[id].Tag:=id;}

end;

procedure TFormManager.Button2Click(Sender: TObject);
begin
    FormManager.Close;
end;

procedure TFormManager.Button_menuOnOffClick(Sender: TObject);
begin

 if Button_menuOnOff.Tag=1 then
 begin
    FloatAnimation_panel_onOff.StopValue:=0;
    FloatAnimation_panel_onOff.StartValue:=136;
    FloatAnimation1.StopValue:=0;
    FloatAnimation1.StartValue:=1;

    FloatAnimation1.Enabled:=false;
    FloatAnimation_panel_onOff.Enabled:=false;
    FloatAnimation_panel_onOff.Enabled:=true;
    FloatAnimation1.Enabled:=true;
    Button_menuOnOff.Tag:=2;
 end else
 begin
     FloatAnimation_panel_onOff.StopValue:=136;
    FloatAnimation_panel_onOff.StartValue:=0;
    FloatAnimation1.StopValue:=1;
    FloatAnimation1.StartValue:=0;

    FloatAnimation1.Enabled:=false;
    FloatAnimation_panel_onOff.Enabled:=false;
    FloatAnimation1.Enabled:=true;
    FloatAnimation_panel_onOff.Enabled:=true;
    Button_menuOnOff.Tag:=1;
 end;

end;

procedure TFormManager.FloatAnimation_userNewProcess(Sender: TObject);
begin
  Arc_NewUser.StartAngle:=Arc_totalUser.EndAngle+10;
end;

procedure TFormManager.FloatAnimation_userTotalProcess(Sender: TObject);
begin
    Arc_NewUser.StartAngle:=Arc_totalUser.EndAngle+10;
end;

procedure TFormManager.FormResize(Sender: TObject);
begin
    {  Layout_r1.Width:=(FormManager.Width/100)*2.6;
      Layout_r2.Width:=(FormManager.Width/100)*2.6;
      Layout_r3.Width:=(FormManager.Width/100)*2.6;
      Layout_r4.Width:=(FormManager.Width/100)*2.6;
      Layout_r5.Width:=(FormManager.Width/100)*2.6;

      Text_u1.Width:=50+((FormManager.Width/100)*3.3);
      Text_u2.Width:=50+((FormManager.Width/100)*3.3);
      Text_u3.Width:=110+((FormManager.Width/100)*3.3);
      Text_u4.Width:=50+((FormManager.Width/100)*3.3);
      Text_u5.Width:=50+((FormManager.Width/100)*3.3);
      Text_u6.Width:=50+((FormManager.Width/100)*3.3);
      Text_u7.Width:=50+((FormManager.Width/100)*3.3);
      Text_u8.Width:=50+((FormManager.Width/100)*3.3);}

      GridLayout_userList.BeginUpdate;
      GridLayout_userList.ItemWidth:=FormManager.Width-120;
      GridLayout_userList.EndUpdate;

      if user_found>0 then
      for var I :=0 to user_found-1 do
      begin

         if assigned(User_Uid      [i+1]) then
         begin
          User_Uid      [i+1].BeginUpdate;
          User_Uid      [i+1].Width:=70+((FormManager.Width/100)*3);
          User_Uid      [i+1].EndUpdate;

          User_login    [i+1].BeginUpdate;
          User_login    [i+1].Width:=200+((FormManager.Width/100)*3);
          User_login    [i+1].EndUpdate;

          User_Email    [i+1].BeginUpdate;
          User_Email    [i+1].Width:=200+((FormManager.Width/100)*3);
          User_Email    [i+1].EndUpdate;

          User_phone    [i+1].BeginUpdate;
          User_phone    [i+1].Width:=100+((FormManager.Width/100)*3);
          User_phone    [i+1].EndUpdate;

          User_lastVisit[i+1].BeginUpdate;
          User_lastVisit[i+1].Width:=100+((FormManager.Width/100)*3);
          User_lastVisit[i+1].EndUpdate;

          User_money    [i+1].BeginUpdate;
          User_money    [i+1].Width:=75+((FormManager.Width/100)*3);
          User_money    [i+1].EndUpdate;

          User_Bonus    [i+1].BeginUpdate;
          User_Bonus    [i+1].Width:=75+((FormManager.Width/100)*3);
          User_Bonus    [i+1].EndUpdate;

          User_Min      [i+1].BeginUpdate;
          User_Min      [i+1].Width:=75+((FormManager.Width/100)*3);
          User_Min      [i+1].EndUpdate;
         end;

      end;

      Text_uid.Width:=70+((FormManager.Width/100)*3);
      Text_ulogin.Width:=200+((FormManager.Width/100)*3);
      Text_Uemail.Width:=200+((FormManager.Width/100)*3);
      Text_Uphone.Width:=100+((FormManager.Width/100)*3);
      Text_Uvisit.Width:=100+((FormManager.Width/100)*3);
      Text_Ubonus.Width:=75+((FormManager.Width/100)*3);
      Text_Ubalance.Width:=75+((FormManager.Width/100)*3);
      Text_Umin.Width:=75+((FormManager.Width/100)*3);
end;

procedure TFormManager.FormShow(Sender: TObject);
begin
  dmodule.FDConnection1.Connected:=true;
  Form_booking.Text_mounthNow.Text:=formatdatetime('mmmm yyyy',now);
  Form_booking.Text_mounthNow.TagString:=formatdatetime('mm',now);
  Form_booking.Text_mounthNow.Tag:=strtoint(formatdatetime('yyyy',now));



  Form_CBoperation.Text_mounthNow.Text:=formatdatetime('mmmm yyyy',now);
  Form_CBoperation.Text_mounthNow.TagString:=formatdatetime('mm',now);
  Form_CBoperation.Text_mounthNow.Tag:=strtoint(formatdatetime('yyyy',now));


 // select_zone (1); //указываем какую зону выделить

  payButton;
  shiftInfo (0,5,'cash',FormManager.Text_cash, round(strtofloat( Text_cash.Text)));
  shiftInfo (0,5,'nocash',FormManager.Text_nocash, round(strtofloat( Text_nocash.Text)));
  shiftInfo (0,5,'bonus',FormManager.Text_bonus, round(strtofloat( Text_bonus.Text)));
  shiftStatistic (0,5);

  newButton ('Button_1',1, FormManager.Layout_newUser, FormManager.Layout_newUser,'',$FFE0E0E0,$FF185590, 16,'C:\Users\den2\Desktop\GAME soft\manager soft\icons\PNGs\PNGs\General\Users 1.png');//Layout_reservHistory
  newButton ('Button_1',2, FormManager.Layout_reservHistory, FormManager.Layout_reservHistory,'',$FFE0E0E0,$FF185590, 16,'C:\Users\den2\Desktop\GAME soft\manager soft\icons\PNGs\PNGs\General\Calendar 2.png');
  newButton ('Button_1',3, FormManager.Layout_PayHistory, FormManager.Layout_PayHistory,'',$FFE0E0E0,$FF185590, 16,'C:\Users\den2\Desktop\GAME soft\manager soft\icons\PNGs\PNGs\E-Commerce\Receipt.png');

  newButton ('Button_1',5, FormManager.Layout_pcOff, FormManager.Layout_pcOff,'',$FFE0E0E0,$FF185590, 16,'C:\Users\den2\Desktop\GAME soft\manager soft\icons\PNGs\PNGs\Electronics\Power.png');
  newButton ('Button_1',6, FormManager.Layout_screen, FormManager.Layout_screen,'',$FFE0E0E0,$FF185590, 16,'C:\Users\den2\Desktop\GAME soft\manager soft\icons\PNGs\PNGs\Electronics\Camera.png'); //
  newButton ('Button_1',7, FormManager.Layout_reboot, FormManager.Layout_reboot,'',$FFE0E0E0,$FF185590, 16,'C:\Users\den2\Desktop\GAME soft\manager soft\icons\PNGs\PNGs\Web\Refresh 2.png');
  newButton ('Button_1',8, FormManager.Layout_reserv, FormManager.Layout_reserv,'',$FFE0E0E0,$FF185590, 16,'C:\Users\den2\Desktop\GAME soft\manager soft\icons\PNGs\PNGs\General\Calendar 2.png');
  newButton ('Button_1',9, FormManager.Layout_alert, FormManager.Layout_alert,'',$FFE0E0E0,$FF185590, 16,'C:\Users\den2\Desktop\GAME soft\manager soft\icons\PNGs\PNGs\General\Chat Bubble Dots.png');

  newButton ('Button_1',10, FormManager.Layout_gameCreate, FormManager.Layout_gameCreate,'',$FFE0E0E0,$FF185590, 16,'C:\Users\den2\Desktop\GAME soft\manager soft\icons\PNGs\PNGs\Health Circle.png'); //
  newButton ('Button_1',11, FormManager.Layout_gameTest, FormManager.Layout_gameTest,'',$FFE0E0E0,$FF185590, 16,'C:\Users\den2\Desktop\GAME soft\manager soft\icons\PNGs\PNGs\Command Line.png');
  newButton ('Button_1',12, FormManager.Layout_gameDel, FormManager.Layout_gameDel,'',$FFE0E0E0,$FF185590, 16,'C:\Users\den2\Desktop\GAME soft\manager soft\icons\PNGs\PNGs\Trash.png');

  newButton ('Button_1',13, FormManager.Layout_newTariff, FormManager.Layout_newTariff,'',$FFE0E0E0,$FF185590, 16,'C:\Users\den2\Desktop\GAME soft\manager soft\icons\PNGs\PNGs\add.png');


  payTypeDraw;

  //  предупреждение         Layout_gameEdit
  Button_USearch.OnClick(Sender);
  draw_time_comp_load_(1, 20);
  Rectangle_login.Visible:=true;
  DModule.IdTCPServer.Active:=true;
end;

procedure TFormManager.Rect_topMenuDblClick(Sender: TObject);
begin

      FormManager.WindowState:=tWindowState.wsMaximized;

end;

procedure TFormManager.Rect_topMenuMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
if Button = TMouseButton.mbLeft then
  begin
    ReleaseCapture;
    SendMessage(FmxHandleToHWND(Self.Handle), $0112 { WM_SYSCOMMAND } ,
      $F012 { SC_DRAGMOVE } , 0);
  end;
end;

procedure TFormManager.SGGamesCellDblClick(const Column: TColumn;
  const Row: Integer);
begin

  FormGames.Edit_name.Text:=FormManager.SGGames.Cells[0, FormManager.SGGames.Selected];
  FormGames.EditLink.Text:=FormManager.SGGames.Cells[1, FormManager.SGGames.Selected];
  FormGames.Edit_icon.Text:=FormManager.SGGames.Cells[2, FormManager.SGGames.Selected];
  FormGames.Edit_param.Text:=FormManager.SGGames.Cells[3, FormManager.SGGames.Selected];
  FormGames.Edit_steam_id.Text:=FormManager.SGGames.Cells[5, FormManager.SGGames.Selected];

  FormGames.ShowModal;

end;

procedure TFormManager.SG_shiftStCellDblClick(const Column: TColumn;
  const Row: Integer);
begin


//  shiftOperationList_ (m,y,shift_id, club, user_id :integer);
  shiftOperationList_ (0,0,sG_shiftSt.Cells[17, SG_shiftSt.Selected].ToInteger,  club_id,0);
  Form_CBoperation.Tag:=1;
  Form_CBoperation.ShowModal;

end;


procedure TFormManager.SG_shiftStDrawColumnCell(Sender: TObject;
  const Canvas: TCanvas; const Column: TColumn; const Bounds: TRectF;
  const Row: Integer; const Value: TValue; const State: TGridDrawStates);

begin


  // «десь определ€ем какую €чейку будем перерисовывать
 {*  if (Column = StringColumn1) and (Row = 1) then
  begin
    TextRect := Bounds;
    TextRect.Left := TextRect.Left + 1;
    TextRect.Bottom := TextRect.Bottom -1;
    TextRect.Inflate(-HorzTextMargin, -VertTextMargin);
    Canvas.FillRect(TextRect, 0, 0, AllCorners, 1);
    TextLayout := TTextLayoutManager.DefaultTextLayout.Create;
    try
      TextLayout.BeginUpdate;
      try
        TextLayout.WordWrap := False;
        TextLayout.Opacity := Column.AbsoluteOpacity;
        TextLayout.HorizontalAlign := SG_shiftSt.TextSettings.HorzAlign;
        TextLayout.VerticalAlign := SG_shiftSt.TextSettings.VertAlign;
        TextLayout.Trimming := TTextTrimming.Character;
        TextLayout.TopLeft := TextRect.TopLeft;
        TextLayout.Text := Value.ToString;
        TextLayout.MaxSize := PointF(TextRect.Width, TextRect.Height);


        TextLayout.Font.Family := 'Times New Roman';
        TextLayout.Font.Style := [ TFontStyle.fsBold ];
        TextLayout.Font.Size := 14;
        TextLayout.Color := $FF329312;
      finally
        TextLayout.EndUpdate;
      end;
      TextLayout.RenderLayout(Canvas);
    finally
      TextLayout.Free;
    end;
  end;*}

end;

procedure TFormManager.tZoneNameClick(Sender: TObject);
begin

  if tzoneSelect<>0 then begin

        tzone_ani[tzoneSelect].Enabled:=false;
        tzone_ani[tzoneSelect].StartValue:=1;
        tzone_ani[tzoneSelect].StopValue:=0;
        tzone_ani[tzoneSelect].Enabled:=true;
        tzone_name[tzoneSelect].Color:=$FF6B6B6B;
  end;

        tzoneSelect:=(sender as Ttext).Tag;
        tzone_ani[tzoneSelect].Enabled:=false;
        tzone_ani[tzoneSelect].StartValue:=0;
        tzone_ani[tzoneSelect].StopValue:=1;
        tzone_ani[tzoneSelect].Enabled:=true;
        tzone_name[tzoneSelect].Color:=$FFE0E0E0;

        tariffList_(club_id, 1, tzoneSelect);
end;

procedure TFormManager.ZoneNameClick(Sender: TObject);
begin

  if zoneSelect<>0 then begin
       // date_res[zoneSelect].Fill.Color:=$FF202223;
        zone_ani[zoneSelect].Enabled:=false;
        zone_ani[zoneSelect].StartValue:=1;
        zone_ani[zoneSelect].StopValue:=0;
        zone_ani[zoneSelect].Enabled:=true;
        zone_name[zoneSelect].Color:=$FF6B6B6B;
  end;
    //    date_res[(sender as Ttext).Tag].Fill.Color:=$FFAB1717;
        zoneSelect:=(sender as Ttext).Tag;
        zone_ani[zoneSelect].Enabled:=false;
        zone_ani[zoneSelect].StartValue:=0;
        zone_ani[zoneSelect].StopValue:=1;
        zone_ani[zoneSelect].Enabled:=true;
        zone_name[zoneSelect].Color:=$FFE0E0E0;
        select_zone (zoneSelect);
end;

procedure TFormManager.ptNameClick(Sender: TObject);
begin

  if payTypeSelect<>0 then begin

        pt_ani[payTypeSelect].Enabled:=false;
        pt_ani[payTypeSelect].StartValue:=1;
        pt_ani[payTypeSelect].StopValue:=0;
        pt_ani[payTypeSelect].Enabled:=true;
        pt_name[payTypeSelect].Color:=$FF6B6B6B;
  end;

        payTypeSelect:=(sender as Ttext).Tag;
        pt_ani[payTypeSelect].Enabled:=false;
        pt_ani[payTypeSelect].StartValue:=0;
        pt_ani[payTypeSelect].StopValue:=1;
        pt_ani[payTypeSelect].Enabled:=true;
        pt_name[payTypeSelect].Color:=$FFE0E0E0;
        if payTypeSelect=4 then Form_bUpdate.Edit_amount.Text:='';

end;

procedure TFormManager.userSearchClick(Sender: TObject);
begin

    if userSearch_id<>0 then
    begin

        if userSearch_id mod 2=1 then
        begin
            User_rect[userSearch_id].Fill.Color:=$FFECECEC;
            User_Uid     [userSearch_id].TextSettings.FontColor:=$FF8F8484;
            User_login   [userSearch_id].TextSettings.FontColor:=$FF8F8484;
            User_Email   [userSearch_id].TextSettings.FontColor:=$FF8F8484;
            User_phone   [userSearch_id].TextSettings.FontColor:=$FF8F8484;
            User_lastVisit[userSearch_id].TextSettings.FontColor:=$FF8F8484;
            User_money   [userSearch_id].TextSettings.FontColor:=$FF8F8484;
            User_Bonus   [userSearch_id].TextSettings.FontColor:=$FF8F8484;
            User_Min     [userSearch_id].TextSettings.FontColor:=$FF8F8484;

        end
           else
        begin
            User_Uid     [userSearch_id].TextSettings.FontColor:=$FF2C2C2C;
            User_login   [userSearch_id].TextSettings.FontColor:=$FF2C2C2C;
            User_Email   [userSearch_id].TextSettings.FontColor:=$FF2C2C2C;
            User_phone   [userSearch_id].TextSettings.FontColor:=$FF2C2C2C;
            User_lastVisit[userSearch_id].TextSettings.FontColor:=$FF2C2C2C;
            User_money   [userSearch_id].TextSettings.FontColor:=$FF2C2C2C;
            User_Bonus   [userSearch_id].TextSettings.FontColor:=$FF2C2C2C;
            User_Min     [userSearch_id].TextSettings.FontColor:=$FF2C2C2C;

            User_rect[userSearch_id].Fill.Color:=$FFedeeee;
            
        end;

    end;

    userSearch_id:=(sender as Ttext).Tag;
         User_rect[userSearch_id].Fill.Color:=$FF185590;

    User_Uid     [userSearch_id].TextSettings.FontColor:=$FFFFFFFF;
    User_login   [userSearch_id].TextSettings.FontColor:=$FFFFFFFF;
    User_Email   [userSearch_id].TextSettings.FontColor:=$FFFFFFFF;
    User_phone   [userSearch_id].TextSettings.FontColor:=$FFFFFFFF;
    User_lastVisit[userSearch_id].TextSettings.FontColor:=$FFFFFFFF;
    User_money   [userSearch_id].TextSettings.FontColor:=$FFFFFFFF;
    User_Bonus   [userSearch_id].TextSettings.FontColor:=$FFFFFFFF;
    User_Min     [userSearch_id].TextSettings.FontColor:=$FFFFFFFF;

end;

procedure showText (txt  : STRING);
begin
        TThread.Synchronize(nil,
        procedure
        begin

            Form_bUpdate.Rectangle_cashbox.Enabled:=true;
            Form_bUpdate.AniIndicator_userSearch.Enabled:=false;
            Form_bUpdate.AniIndicator_userSearch.Visible:=false;
            Form_bUpdate.Close;

            FormManager.Text_alert.Text:=txt;
            FormManager.FloatAnim_alert.Enabled:=false;
            FormManager.FloatAnim_alert.Enabled:=true;

        end);
end;

procedure TFormManager.Text22Click(Sender: TObject);
begin

    if userSearch_id<>0 then
                  Form_bUpdate.ShowModal;
end;

procedure TFormManager.Text25Click(Sender: TObject);
begin
      Form_shiftclose.ShowModal;
end;

procedure TFormManager.Text_MsoftClick(Sender: TObject);
begin
      Layout_shift.Visible:=false;
      Layout_map.Visible:=false;
      Layout_games.Visible:=true;
      Layout_dashboard.Visible:=false;
      Layout_clients.Visible:=false;

      gameList( 5, map_pc_select,0);
end;

procedure TFormManager.Text_uidClick(Sender: TObject);
begin

  form_booking.Text_booking.Tag:=1;
  bookingInfo_('11','2022',User_Uid[userSearch_id].Text, '1', club_id.ToString);

  form_booking.ShowModal;
end;

procedure TFormManager.Text27Click(Sender: TObject);
begin

  Rectangle_switch_map.Align:=TalignLayout.Left;
  ScrollBox_mapList.Visible:=false;
  ScrollBox_Map.Visible:=true;
  Rectangle_mapListHeader.Visible:=false;

end;

procedure TFormManager.Text28Click(Sender: TObject);
begin

  Rectangle_switch_map.Align:=TalignLayout.Right;
  ScrollBox_Map.Visible:=false;
  ScrollBox_mapList.Visible:=TRUE;
  Rectangle_mapListHeader.Visible:=true;

end;

procedure TFormManager.Text_mFinClick(Sender: TObject);
begin

  Layout_shift.Visible:=true;
  Layout_map.Visible:=false;
  Layout_games.Visible:=false;
  Layout_dashboard.Visible:=false;
  Layout_clients.Visible:=false;

end;

procedure TFormManager.Text_mMapClick(Sender: TObject);
begin

  Layout_shift.Visible:=false;
  Layout_map.Visible:=true;
  Layout_games.Visible:=false;
  Layout_dashboard.Visible:=false;
  Layout_clients.Visible:=false;

end;

procedure TFormManager.Text_loginbClick(Sender: TObject);
begin
    FormManager.AniIndicator_login.Visible:=true;
    FormManager.AniIndicator_login.Enabled:=true;
    FormManager.Text_loginb.Enabled:=false;

    userlogin (ansiUpperCase(Edit_authLogin.Text), Edit_authPass.Text,  c_token)


end;

procedure TFormManager.Text_MclientClick(Sender: TObject);
begin

  Layout_shift.Visible:=false;
  Layout_map.Visible:=false;
  Layout_games.Visible:=false;
  Layout_dashboard.Visible:=false;
  Layout_clients.Visible:=true;

end;

procedure TFormManager.Timer_pingTimer(Sender: TObject);
begin
    pingpclist;
    mapInfoServer(c_Token);
end;

end.
