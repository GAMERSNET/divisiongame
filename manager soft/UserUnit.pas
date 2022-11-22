unit UserUnit;

interface
  uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Effects, System.Rtti, FMX.Grid.Style, FMX.Grid,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Edit, FMX.StdCtrls, FMX.Ani
  , system.Threading
  , system.JSON
  , DateUtils;

  const
        c_token  : string='12345';

  function userSearch(text     : string) : integer;
  function userlogin (login, pass, clubToken: string): integer;
  var
        User_layout   : array[1..200] of Tlayout;
        User_rect     : array[1..200] of TRectangle;
        User_rectL    : array[1..200] of TRectangle;

        User_Uid      : array[1..200] of Ttext;
        User_login    : array[1..200] of Ttext;
        User_Email    : array[1..200] of Ttext;
        User_phone    : array[1..200] of Ttext;
        User_lastVisit: array[1..200] of Ttext;
        User_status   : array[1..200] of TCircle;
        User_money    : array[1..200] of Ttext;
        User_Bonus    : array[1..200] of Ttext;
        User_Min      : array[1..200] of Ttext;

        User_r1       : array[1..200] of Tlayout;

        user_found    : integer=0;
        admin_token   : string;
        admin_id      : integer=0;
        club_id      : integer=0;
implementation

  uses
        msoft, datam,UnitFinance, clubmap;

  function userlogin  (login, pass, clubToken: string): integer;
  var
    JsonValue                    : TJSONValue;
    s                            : string;
    e                            : integer;
  begin

       e:=0;

       TThread.CreateAnonymousThread(procedure ()
       begin

           try

             DataM.DModule.RESTRequest1.Params[0].Value:='{"cmd":"adminlogin","data":{"login":"'+login+'", "pass":"'+pass+'"},"token":"'+clubToken+'"}';
             DataM.DModule.RESTRequest1.Execute;

             JsonValue:= TJSONValue.Create;
             JsonValue := TJSonObject.ParseJSONValue(DataM.DModule.RESTResponse1.JSONText);

           except
               e:=1;
           end;

           if e=0 then
           begin

                 TThread.Synchronize(nil,
                 procedure
                 begin

                       case JsonValue.GetValue<integer>('error') of

                            0 : begin
                                admin_token:=JsonValue.GetValue<string>('data.token');
                                FormManager.Text_adminname.Text:=JsonValue.GetValue<string>('data.full_name');
                                FormManager.Rectangle_login.Visible:=false;
                                admin_id:=JsonValue.GetValue<integer>('data.user_id');
                                club_id:=JsonValue.GetValue<integer>('data.club_id');

                                FormManager.AniIndicator_login.Visible:=false;
                                FormManager.AniIndicator_login.Enabled:=false;
                                FormManager.Text_loginb.Enabled:=true;
                                zoneDraw;
                                drawMap;
                                zoneDrawTariff;
                                shiftOperationList_ (strtoint(formatDatetime('mm',now)),strtoint(formatDatetime('yyyy',now)), 0,  club_id, 0);
                                mapInfoServer(c_Token);
                                FormManager.Timer_ping.Enabled:=true;
                            end;

                            303 :  begin
                                FormManager.Text_loginError.Text:='Ошибка логина или пароля!';
                            end;

                            300 :  begin
                                FormManager.Text_loginError.Text:='Ошибка логина или пароля!';
                            end;

                       end;

                 end);

           end else
           begin
                FormManager.Text_loginError.Text:='Сервер недоступен!';
           end;

       end).Start;

  end;

   function userSearch(text     : string) : integer;
   var
        err    : integer;
        atask  : ITask;
   begin
      userSearch_id:=0;
      TThread.Synchronize(nil,
      procedure
      begin
        FormManager.AniIndicator_userSearch.Enabled:=true;
        FormManager.AniIndicator_userSearch.Visible:=true;
        FormManager.Rectangle_userSearch.Enabled:=false;
      end);

     aTask := TTask.Create (procedure ()
     begin

        if text='' then
        begin
            DModule.FDUseerSearch.sql.clear;
            DModule.FDUseerSearch.SQL.Add('SELECT * FROM g_users WHERE club_id=5 ORDER BY id ASC LIMIT 100');
            DModule.FDUseerSearch.Open;
        end else
        begin

           err:=0;
           try
               strtoint(text);
           except
             err:=1;
           end;

           if err=0 then
           begin

            DModule.FDUseerSearch.sql.clear;
            DModule.FDUseerSearch.SQL.Add('SELECT * FROM g_users WHERE club_id=5 AND (id='+tExt+' or login LIKE ''%'+text+'%'' or phone LIKE ''%'+text+'%''or email LIKE ''%'+text+'%''or club_card LIKE ''%'+text+'%'') ORDER BY id ASC LIMIT 100');
            DModule.FDUseerSearch.Open;

           end else
           begin

            DModule.FDUseerSearch.sql.clear;
            DModule.FDUseerSearch.SQL.Add('SELECT * FROM g_users WHERE club_id=5 AND (login LIKE ''%'+text+'%'' or phone LIKE ''%'+text+'%''or email LIKE ''%'+text+'%''or club_card LIKE ''%'+text+'%'') ORDER BY id ASC LIMIT 100');
            DModule.FDUseerSearch.Open;


           end;

        end;

        TThread.Synchronize(nil,
        procedure
        begin


                  if user_found>0 then
                  begin

                        for var I2 :=1 to user_found do
                        begin
                          freeandNil(User_r1[i2]);
                          freeandNil(User_Uid[i2]  );
                          freeandNil(user_login[i2]  );
                          freeandNil(User_email[i2]  );
                          freeandNil(User_phone[i2]  );
                          freeandNil(User_lastVisit[i2]);
                          freeandNil(User_status[i2] );
                          freeandNil(User_money[i2]  );
                          freeandNil(User_Bonus[i2]  );
                          freeandNil(User_Min[i2]    );
                          freeandNil(User_rectl[i2]  );
                          freeandNil(User_rect[i2]   );
                          freeandNil(User_layout[i2] );
                        end;
                  end;

                  user_found:=DModule.FDUseerSearch.RecordCount;
                  FormManager.GridLayout_userList.BeginUpdate;
                  FormManager.GridLayout_userList.Height:=user_found*51;
                  FormManager.GridLayout_userList.EndUpdate;
            for var I :=0 to DModule.FDUseerSearch.RecordCount-1 do
            begin

                      User_layout[i+1]:=TLayout.Create(FormManager.GridLayout_userList);
                      User_layout[i+1].Parent:=FormManager.GridLayout_userList;
                      User_layout[i+1].Tag:=i+1;
                      User_layout[i+1].Opacity:=1;

                      User_rect[i+1]:=Trectangle.Create(User_layout[i+1]);
                      User_rect[i+1].Parent:=User_layout[i+1];
                      User_rect[i+1].XRadius:=4;
                      User_rect[i+1].YRadius:=4;
                      User_rect[i+1].Stroke.Thickness:=0;
                      if i mod 2=1 then
                      User_rect[i+1].Fill.Color:=$FFECECEC
                                 else
                      User_rect[i+1].Fill.Color:=$FFedeeee;
                      User_rect[i+1].Opacity:=1;
                      User_rect[i+1].Tag:=i+1;
                      User_rect[i+1].Align:=TAlignlayout.Top;

                      User_rectl[i+1]:=Trectangle.Create(User_rect[i+1]);
                      User_rectl[i+1].Parent:=User_rect[i+1];
                      User_rectl[i+1].XRadius:=4;
                      User_rectl[i+1].YRadius:=4;
                      User_rectl[i+1].Corners:=[TCorner.TopLeft,TCorner.BottomLeft];
                      User_rectl[i+1].Width:=10;
                      User_rectl[i+1].Stroke.Thickness:=0;

                      if i mod 2=1 then
                      User_rectl[i+1].Fill.Color:=$FFE0E0E0
                                 else
                      User_rectl[i+1].Fill.Color:=$FFe5e5e5;

                      User_rectl[i+1].Opacity:=1;
                      User_rectl[i+1].Tag:=i+1;
                      User_rectl[i+1].Align:=TAlignlayout.MostLeft;

                      //----min----------------------------------------------------------------
                      User_Min[i+1]:=TText.Create(User_rect[i+1]);
                      User_Min[i+1].Parent:=User_rect[i+1];
                      User_Min[i+1].Align:=talignLayout.Left;
                      User_Min[i+1].HorzTextAlign:= TTextAlign.Trailing;
                      User_Min[i+1].Text:=DModule.FDUseerSearch.FieldByName('bonus_min').AsString;

                      if i mod 2=1 then
                         User_Min[i+1].Color:=$FF2C2C2C
                         else
                         User_Min[i+1].Color:=$FF8F8484;

                      User_Min[i+1].TextSettings.font.Size:=16;
                      User_Min[i+1].TextSettings.font.family:='Russia';
                      User_Min[i+1].Tag:=i+1;
                      User_Min[i+1].Cursor:=crHandPoint;
                      User_Min[i+1].Width:=75+((FormManager.Width/100)*3);
                      User_Min[i+1].OnClick:=FormManager.UserSearchClick;
                      //----bonus----------------------------------------------------------------
                      User_Bonus[i+1]:=TText.Create(User_rect[i+1]);
                      User_Bonus[i+1].Parent:=User_rect[i+1];
                      User_Bonus[i+1].Align:=talignLayout.Left;
                      User_Bonus[i+1].HorzTextAlign:= TTextAlign.Trailing;
                      User_Bonus[i+1].Text:=DModule.FDUseerSearch.FieldByName('bonus').AsString;

                      if i mod 2=1 then
                         User_Bonus[i+1].Color:=$FF2C2C2C
                         else
                         User_Bonus[i+1].Color:=$FF8F8484;

                      User_Bonus[i+1].TextSettings.font.Size:=16;
                      User_Bonus[i+1].TextSettings.font.family:='Russia';
                      User_Bonus[i+1].Tag:=i+1;
                      User_Bonus[i+1].Cursor:=crHandPoint;
                      User_Bonus[i+1].Width:=75+((FormManager.Width/100)*3);
                      User_Bonus[i+1].OnClick:=FormManager.UserSearchClick;
                      //----money---------------------------------------------------------------
                      User_money[i+1]:=TText.Create(User_rect[i+1]);
                      User_money[i+1].Parent:=User_rect[i+1];
                      User_money[i+1].Align:=talignLayout.Left;
                      User_money[i+1].HorzTextAlign:= TTextAlign.Trailing;
                      User_money[i+1].Text:=DModule.FDUseerSearch.FieldByName('amount').AsString;

                      if i mod 2=1 then
                         User_money[i+1].Color:=$FF2C2C2C
                         else
                         User_money[i+1].Color:=$FF8F8484;

                      User_money[i+1].TextSettings.font.Size:=16;
                      User_money[i+1].TextSettings.font.family:='Russia';
                      User_money[i+1].Tag:=i+1;
                      User_money[i+1].Cursor:=crHandPoint;
                      User_money[i+1].Width:=75+((FormManager.Width/100)*3);
                      User_money[i+1].OnClick:=FormManager.UserSearchClick;
                      ////////////////////////////////////////////////////
                      ///  ----status--------------------------------------------------------

                      User_status[i+1]:=TCircle.Create(User_rect[i+1]);
                      User_status[i+1].Parent:=User_rect[i+1];
                      User_status[i+1].Width:=25;
                      User_status[i+1].Tag:=i+1;
                      User_status[i+1].Align:=talignLayout.Left;

                      //----last----------------------------------------------------------------
                      User_lastVisit[i+1]:=TText.Create(User_rect[i+1]);
                      User_lastVisit[i+1].Parent:=User_rect[i+1];
                      User_lastVisit[i+1].Align:=talignLayout.Left;
                      User_lastVisit[i+1].HorzTextAlign:= TTextAlign.Leading;
                      User_lastVisit[i+1].Text:=DModule.FDUseerSearch.FieldByName('last_visit').AsString;

                      if i mod 2=1 then
                         User_lastVisit[i+1].Color:=$FF2C2C2C
                         else
                         User_lastVisit[i+1].Color:=$FF8F8484;

                      User_lastVisit[i+1].TextSettings.font.Size:=16;
                      User_lastVisit[i+1].TextSettings.font.family:='Russia';
                      User_lastVisit[i+1].Tag:=i+1;
                      User_lastVisit[i+1].Cursor:=crHandPoint;
                      User_lastVisit[i+1].Width:=100+((FormManager.Width/100)*3);
                      User_lastVisit[i+1].OnClick:=FormManager.UserSearchClick;
                      //----phone----------------------------------------------------------------
                      User_phone[i+1]:=TText.Create(User_rect[i+1]);
                      User_phone[i+1].Parent:=User_rect[i+1];
                      User_phone[i+1].Align:=talignLayout.Left;
                      User_phone[i+1].HorzTextAlign:= TTextAlign.Leading;
                      User_phone[i+1].Text:=DModule.FDUseerSearch.FieldByName('phone').AsString;

                      if i mod 2=1 then
                         User_phone[i+1].Color:=$FF2C2C2C
                         else
                         User_phone[i+1].Color:=$FF8F8484;

                      User_phone[i+1].TextSettings.font.Size:=16;
                      User_phone[i+1].TextSettings.font.family:='Russia';
                      User_phone[i+1].Tag:=i+1;
                      User_phone[i+1].Cursor:=crHandPoint;
                      User_phone[i+1].Width:=100+((FormManager.Width/100)*3);
                      User_phone[i+1].OnClick:=FormManager.UserSearchClick;
                      //----email----------------------------------------------------------------
                      User_email[i+1]:=TText.Create(User_rect[i+1]);
                      User_email[i+1].Parent:=User_rect[i+1];
                      User_email[i+1].Align:=talignLayout.Left;
                      User_email[i+1].HorzTextAlign:= TTextAlign.Leading;
                      User_email[i+1].Text:=DModule.FDUseerSearch.FieldByName('email').AsString;

                      if i mod 2=1 then
                         User_email[i+1].Color:=$FF2C2C2C
                         else
                         User_email[i+1].Color:=$FF8F8484;

                      User_email[i+1].TextSettings.font.Size:=16;
                      User_email[i+1].TextSettings.font.family:='Russia';
                      User_email[i+1].Tag:=i+1;
                      User_email[i+1].Cursor:=crHandPoint;
                      User_email[i+1].Width:=200+((FormManager.Width/100)*3);
                      User_email[i+1].OnClick:=FormManager.UserSearchClick;
                      //----login---------------------------------------------------------------------

                      User_login[i+1]:=TText.Create(User_rect[i+1]);
                      User_login[i+1].Parent:=User_rect[i+1];
                      User_login[i+1].Align:=talignLayout.Left;
                      User_login[i+1].HorzTextAlign:= TTextAlign.Leading;
                      User_login[i+1].Text:=DModule.FDUseerSearch.FieldByName('login').AsString;

                      if i mod 2=1 then
                         User_login[i+1].Color:=$FF2C2C2C
                         else
                         User_login[i+1].Color:=$FF8F8484;

                      User_login[i+1].TextSettings.font.Size:=16;
                      User_login[i+1].TextSettings.font.family:='Russia';
                      User_login[i+1].Tag:=i+1;
                      User_login[i+1].Cursor:=crHandPoint;
                      User_login[i+1].Width:=200+((FormManager.Width/100)*3);
                      user_login[i+1].OnClick:=FormManager.UserSearchClick;

                      //// ----id -----------------------------------------------------------------------------

                      User_Uid[i+1]:=TText.Create(User_rect[i+1]);
                      User_Uid[i+1].Parent:=User_rect[i+1];
                      User_Uid[i+1].Align:=talignLayout.Left;
                      User_Uid[i+1].HorzTextAlign:= TTextAlign.Leading;
                      User_Uid[i+1].Text:=DModule.FDUseerSearch.FieldByName('id').AsString;
                      if i mod 2=1 then
                         User_Uid[i+1].Color:=$FF2C2C2C
                         else
                         User_Uid[i+1].Color:=$FF646464;
                      User_Uid[i+1].TextSettings.font.Size:=16;
                      User_Uid[i+1].TextSettings.font.family:='Russia';
                      User_Uid[i+1].Tag:=i+1;
                      User_Uid[i+1].Cursor:=crHandPoint;
                      User_Uid[i+1].Width:=70+((FormManager.Width/100)*3);
                      User_Uid[i+1].OnClick:=FormManager.UserSearchClick;
                      //-----------------------------------------------------------
                      User_r1[i+1]:=TLayout.Create(User_rect[i+1]);
                      User_r1[i+1].Parent:=User_rect[i+1];
                      User_r1[i+1].Tag:=i+1;
                      User_r1[i+1].Width:=24;
                      User_r1[i+1].Align:=talignLayout.MostLeft;

                      DModule.FDUseerSearch.Next;
                      //-----------------------------------------------------------------------------


            end;

            FormManager.AniIndicator_userSearch.Enabled:=false;
            FormManager.AniIndicator_userSearch.Visible:=false;
            FormManager.Rectangle_userSearch.Enabled:=true;

        end);


     end);

     aTask.Start;

   end;

end.
