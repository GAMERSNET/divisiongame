unit clubmap;

interface
  uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Effects, FMX.Ani
  , dateUtils, IdBaseComponent, IdComponent, system.JSON,
  IdTCPConnection, IdTCPClient;

  const                                                               //  FF176bab
        comp_status   : array[1..4] of Talphacolor=($FFc9cbd2, $FF85bab5, $FFd25a5e , $FFebb700);
        weekday_name  : array[1..7] of string=('Пн','Вт','Ср','Чт','Пт','Сб','Вс');

  procedure drawMap;
  procedure select_zone (zone   : integer); //указываем какую зону выделить
  procedure date_reserv;
  procedure zoneDraw; // рисуем выбор зоны ПК
  procedure zoneDrawTariff;
  procedure draw_time_comp_load_(i, col : integer);
  procedure mapInfoServer( cToken   : string);// запрос информации по пк

  var
           // карта
            comp                  : array   [1..100] of Trectangle;
            chair                 : array   [1..100] of Trectangle;
            chair2                : array   [1..100] of Trectangle;
            visual_id             : array   [1..100] of TText;
            visual_status         : array   [1..200] of TCircle;
            comp_anim             : array   [1..100] of TFloatanimation;
            comp_anim2            : array   [1..100] of TFloatanimation;
           // выбор дня недели резервации
            date_res              : array   [1..7] of Trectangle;
            date_res_layout       : array   [1..7] of TLayout;
            date_res_weekday      : array   [1..7] of TText;
            date_res_week         : array   [1..7] of TText;

            time_res              : array   [1..7] of Trectangle;
            time_res_weekday      : array   [1..7] of TText;
            time_res_week         : array   [1..7] of TText;

            date_res_ani          : array   [1..7] of TFloatanimation;

            zone_rect             : array   [1..100] of Trectangle;
            zone_name             : array   [1..100] of TText;
            zone_ani              : array   [1..100] of TFloatanimation;

            tzone_rect             : array  [1..100] of Trectangle;
            tzone_name             : array  [1..100] of TText;
            tzone_ani              : array  [1..100] of TFloatanimation;


            map_layout      : array[1..200] of Tlayout;
            map_rect        : array[1..200] of TRectangle;
            map_rectL       : array[1..200] of TRectangle;

            map_Uid         : array[1..200] of Ttext;
            map_zone        : array[1..200] of Ttext;
            map_user_id     : array[1..200] of Ttext;
            map_resr_start  : array[1..200] of Ttext;
            map_duration    : array[1..200] of Ttext;
            map_status      : array[1..200] of TCircle;
            map_tariff      : array[1..200] of Ttext;
            map_money       : array[1..200] of Ttext;
            map_Bonus       : array[1..200] of Ttext;
            map_Min         : array[1..200] of Ttext;
            map_ip          : array[1..200] of Ttext;

            map_r1          : array[1..200] of Tlayout;

            map_pc_zone     : TstringList;
            map_pc_select   : integer=0;

            map_ip_list     : TstringList;
            map_id          : TstringList;
            tcp_ping        : TIdTCPClient;

            comp_load_layout  : array   [1..13] of TLayout;
            comp_load_time    : array   [1..13] of TText;
            comp_load_rect    : array   [1..13] of TRectangle;
            comp_load_rect2   : array   [1..13] of TRectangle;
            comp_load_anim    : array   [1..13] of TFloatanimation;

            mapreport         : string='';

implementation
  uses db, msoft,datam, ping2, UserUnit;

  procedure payTypeDraw;
  begin

  end;

  procedure draw_time_comp_load_(i, col : integer);
  begin

            comp_load_layout[i]:=TLayout.Create(FormManager.GridLayout_pctimeload);
            comp_load_layout[i].Parent:=FormManager.GridLayout_pctimeload;
            comp_load_layout[i].Tag:=i;

            comp_load_time[i]:=TText.Create(comp_load_layout[i]);
            comp_load_time[i].Parent:=comp_load_layout[i];
            comp_load_time[i].Align:=talignLayout.MostBottom;
            comp_load_time[i].Text:=(i-1).ToString+':00';
            comp_load_time[i].Color:=$FF6B6B6B;
            comp_load_time[i].TextSettings.font.Size:=10;
            comp_load_time[i].TextSettings.font.family:='Russia';
            comp_load_time[i].OnClick:=FormManager.ZoneNameClick;
            comp_load_time[i].Cursor:=crHandPoint;
            comp_load_time[i].Height:=30;
            comp_load_time[i].Tag:=i;

            comp_load_rect[i]:=Trectangle.Create(comp_load_layout[i]);
            comp_load_rect[i].Parent:=comp_load_layout[i];
            comp_load_rect[i].Align:=talignLayout.HorzCenter;
            comp_load_rect[i].XRadius:=4;
            comp_load_rect[i].YRadius:=4;
            comp_load_rect[i].Width:=10;
            comp_load_rect[i].Stroke.Thickness:=0;
            comp_load_rect[i].Fill.Color:=$FFF2F3F3;
            comp_load_rect[i].Opacity:=1;
            comp_load_rect[i].Tag:=i;

            comp_load_rect2[i]:=Trectangle.Create(comp_load_rect[i]);
            comp_load_rect2[i].Parent:=comp_load_rect[i];
            comp_load_rect2[i].Align:=talignLayout.Bottom;
            comp_load_rect2[i].XRadius:=4;
            comp_load_rect2[i].YRadius:=4;
            comp_load_rect2[i].Height:=0;
            comp_load_rect2[i].Stroke.Thickness:=0;
            comp_load_rect2[i].Fill.Color:=$FF185590;
            comp_load_rect2[i].Opacity:=1;
            comp_load_rect2[i].Tag:=i;

            comp_load_anim [i]:=TFloatanimation.Create(comp_load_rect2[i]);
            comp_load_anim [i].Parent:=comp_load_rect2[i];
            comp_load_anim [i].Delay:=0;
            comp_load_anim [i].startValue:=0;
            comp_load_anim [i].StopValue:=col;
            comp_load_anim [i].Enabled:=true;
            comp_load_anim [i].PropertyName:='Height';
            comp_load_anim [i].Duration:=random(3)+1;
            comp_load_anim [i].Tag:=i;
            comp_load_anim [i].Start;

  end;

  procedure zoneDraw;
  begin
    DModule.FDQZone.sql.clear;
    DModule.FDQZone.SQL.Add('SELECT * FROM g_zone_name WHERE club_id='+club_id.ToString+' ORDER BY zone_id ASC');
    DModule.FDQZone.Open;

    FormManager.Rectangle_zonename.Width:=(DModule.FDQZone.recordCount)*80;

    map_pc_zone:=TstringList.Create;

    for  var I2 :=1 to DModule.FDQZone.recordCount do
    begin

            zone_rect[i2]:=Trectangle.Create(FormManager.Rectangle_zonename);
            zone_rect[i2].Parent:=FormManager.Rectangle_zonename;
            zone_rect[i2].Align:=talignLayout.Vertical;
            zone_rect[i2].XRadius:=4;
            zone_rect[i2].YRadius:=4;
            zone_rect[i2].Width:=80;
            zone_rect[i2].Stroke.Thickness:=0;
            zone_rect[i2].Position.X:=((i2-1)*80);
            zone_rect[i2].Fill.Color:=$FFd25a5e;
            zone_rect[i2].Opacity:=0;
            zone_rect[i2].Tag:=i2;

            zone_name[i2]:=TText.Create(FormManager.Rectangle_zonename);
            zone_name[i2].Parent:=FormManager.Rectangle_zonename;
            zone_name[i2].Align:=talignLayout.Vertical;
            zone_name[i2].Text:=DModule.FDQZone.FieldByName('zone_name').AsString;
            zone_name[i2].Position.x:=((i2-1)*80);
            zone_name[i2].Width:=80;
            zone_name[i2].Color:=$FF6B6B6B;
            zone_name[i2].TextSettings.font.Size:=13;
            zone_name[i2].TextSettings.font.family:='Russia';
            zone_name[i2].OnClick:=FormManager.ZoneNameClick;
            zone_name[i2].Cursor:=crHandPoint;
            zone_name[i2].Tag:=i2;

            zone_ani [i2]:=TFloatanimation.Create(zone_rect[i2]);
            zone_ani [i2].Parent:=zone_rect[i2];
            zone_ani [i2].Delay:=0;
            zone_ani [i2].startValue:=1;
            zone_ani [i2].StopValue:=0.5;
            zone_ani [i2].Enabled:=false;
            zone_ani [i2].PropertyName:='Opacity';
            zone_ani [i2].Duration:=0.7;
            zone_ani [i2].Tag:=i2;

            map_pc_zone.Add(DModule.FDQZone.FieldByName('zone_name').AsString);

            DModule.FDQZone.next;
    end;

  end;

  procedure zoneDrawTariff;
  begin
    DModule.FDQZone.sql.clear;
    DModule.FDQZone.SQL.Add('SELECT * FROM g_zone_name WHERE club_id='+club_id.ToString+' ORDER BY zone_id ASC');
    DModule.FDQZone.Open;

    FormManager.Rectangle_tariff.Width:=(DModule.FDQZone.recordCount)*80;

    for  var I2 :=1 to DModule.FDQZone.recordCount do
    begin

            tzone_rect[i2]:=Trectangle.Create(FormManager.Rectangle_tariff);
            tzone_rect[i2].Parent:=FormManager.Rectangle_tariff;
            tzone_rect[i2].Align:=talignLayout.Vertical;
            tzone_rect[i2].XRadius:=4;
            tzone_rect[i2].YRadius:=4;
            tzone_rect[i2].Width:=80;
            tzone_rect[i2].Stroke.Thickness:=0;
            tzone_rect[i2].Position.X:=((i2-1)*80);
            tzone_rect[i2].Fill.Color:=$FFd25a5e;
            tzone_rect[i2].Opacity:=0;
            tzone_rect[i2].Tag:=i2;

            tzone_name[i2]:=TText.Create(FormManager.Rectangle_tariff);
            tzone_name[i2].Parent:=FormManager.Rectangle_tariff;
            tzone_name[i2].Align:=talignLayout.Vertical;
            tzone_name[i2].Text:=DModule.FDQZone.FieldByName('zone_name').AsString;
            tzone_name[i2].Position.x:=((i2-1)*80);
            tzone_name[i2].Width:=80;
            tzone_name[i2].Color:=$FF6B6B6B;
            tzone_name[i2].TextSettings.font.Size:=13;
            tzone_name[i2].TextSettings.font.family:='Russia';
            tzone_name[i2].OnClick:=FormManager.tZoneNameClick;
            tzone_name[i2].Cursor:=crHandPoint;
            tzone_name[i2].Tag:=i2;

            tzone_ani [i2]:=TFloatanimation.Create(tzone_rect[i2]);
            tzone_ani [i2].Parent:=tzone_rect[i2];
            tzone_ani [i2].Delay:=0;
            tzone_ani [i2].startValue:=1;
            tzone_ani [i2].StopValue:=0.5;
            tzone_ani [i2].Enabled:=false;
            tzone_ani [i2].PropertyName:='Opacity';
            tzone_ani [i2].Duration:=0.7;
            tzone_ani [i2].Tag:=i2;

            DModule.FDQZone.next;
    end;

  end;

  procedure select_zone (zone   : integer);
  begin
        case zone of

             0: begin

                 for var I1 :=1 to 100 do
                 begin

                    if Assigned(comp[i1]) then comp[i1].Enabled:=true;

                 end;

             end;

             1..4: begin

                 for var I1 :=1 to 100 do
                 begin

                    if Assigned(comp[i1]) then
                          if comp[i1].TagFloat<>zone
                              then
                              begin
                                comp[i1].Enabled:=false;
                                comp[i1].Opacity:=0.5;
                              end
                              else
                              begin
                                  comp[i1].Enabled:=true;
                                  comp[i1].Opacity:=1;
                              end;

                 end;

             end;

        end;
  end;

  procedure date_reserv;
  begin
         for var I :=0 to 6 do
         begin

          //  date_res_layout[i+1]:=TLayout.Create(FormManager.Layout_reservationDate);
           // date_res_layout[i+1].Parent:=FormManager.Layout_reservationDate;
            date_res_layout[i+1].Align:=talignLayout.Vertical;
            date_res_layout[i+1].Position.X:=(48*i)+8;
            date_res_layout[i+1].Width:=40;
            date_res_layout[i+1].Height:=80;
            date_res_layout[i+1].Tag:=i+1;

            date_res[i+1]:=Trectangle.Create(date_res_layout[i+1]);
            date_res[i+1].Parent:=date_res_layout[i+1];
            date_res[i+1].Align:=talignLayout.Client;
            date_res[i+1].XRadius:=20;
            date_res[i+1].YRadius:=20;
            date_res[i+1].Stroke.Thickness:=0;
            date_res[i+1].Fill.Color:=$FFAB1717;
            date_res[i+1].Opacity:=0;
            date_res[i+1].Tag:=i+1;

            date_res_weekday[i+1]:=TText.Create(date_res_layout[i+1]);
            date_res_weekday[i+1].Parent:=date_res_layout[i+1];
            date_res_weekday[i+1].Align:=talignLayout.Horizontal;
            date_res_weekday[i+1].Text:=formatDateTime('dd',incday(now,i));
            date_res_weekday[i+1].Position.y:=25;
            date_res_weekday[i+1].Color:=$FFC6C6C6;
            date_res_weekday[i+1].TextSettings.font.Size:=16;
            date_res_weekday[i+1].TextSettings.font.family:='Russia';
            date_res_weekday[i+1].Tag:=i+1;

            date_res_week[i+1]:=TText.Create(date_res_layout[i+1]);
            date_res_week[i+1].Parent:=date_res_layout[i+1];
            date_res_week[i+1].Align:=talignLayout.Horizontal;
            date_res_week[i+1].Text:=weekday_name[DayOfTheWeek(incday(now,i))];
            date_res_week[i+1].Position.y:=3;
            date_res_week[i+1].Color:=$FFC6C6C6;
            date_res_week[i+1].TextSettings.font.Size:=12;
            date_res_week[i+1].TextSettings.font.family:='Russia';
           // date_res_week[i+1].OnClick:=FormScreen.ReservDayClick;
           /// date_res_week[i+1].Cursor:=crHandPoint;
            date_res_week[i+1].Tag:=i+1;

            date_res_ani [i+1]:=TFloatanimation.Create(date_res[i+1]);
            date_res_ani [i+1].Parent:=date_res[i+1];
            date_res_ani [i+1].Delay:=0;
            date_res_ani [i+1].startValue:=1;
            date_res_ani [i+1].StopValue:=0.5;
            date_res_ani [i+1].Enabled:=false;
            date_res_ani [i+1].PropertyName:='Opacity';
            date_res_ani [i+1].Duration:=0.7;
            date_res_ani [i+1].Tag:=i+1;

         end;
  end;

  procedure mapInfoServer(cToken  : string);
  var
    JsonValue                    : TJSONValue;
    s                            : string;
    st                           : TstringList;
  begin

       TThread.CreateAnonymousThread(procedure ()
       begin

             DataM.DModule.RESTRequest1.Params[0].Value:='{"cmd":"compinfo","data":{"info":"'+mapreport+'"},"token":"'+cToken+'"}';
             DataM.DModule.RESTRequest1.Execute;

             JsonValue:= TJSONValue.Create;
             JsonValue:= TJSonObject.ParseJSONValue(DataM.DModule.RESTResponse1.JSONText);

             TThread.Synchronize(nil,
             procedure
             begin

                   case JsonValue.GetValue<integer>('error') of

                        0 : begin
                            st:=TstringList.Create;
                            st.Delimiter:='#';
                            st.DelimitedText:=JsonValue.GetValue<string>('data.info');

                            for var I :=1 to st.Count do
                            begin
                                map_duration[i].Text:=st[i-1];
                            end;

                            st.Delimiter:='#';
                            st.DelimitedText:=JsonValue.GetValue<string>('data.users');

                            for var I :=1 to st.Count do
                            begin

                                if map_user_id[i].Text='0' then begin
                                      map_tariff[i].Text:='';
                                      map_user_id[i].Text:='';
                                      map_resr_start[i].Text:='';
                                      map_money [i].Text:='';
                                      map_Bonus [i].Text:='';
                                      map_Min   [i].Text:='';
                                      map_duration[i].Text:='';
                                end else map_user_id[i].Text:=st[i-1];

                            end;


                            st.Free;
                        end;

                        806 :  begin
                            showText('Ошибка!');
                        end;

                        805 :  begin

                            showText('Ошибка доступа: устаревший токен!');

                        end;

                   end;

             end);

             TThread.Synchronize(nil,
             procedure
             begin

             end);

             freeAndNil(JsonValue);

       end).Start;




  end;

  procedure drawMap;
  begin
    DModule.FDQuery1.SQL.Clear;
    DModule.FDQuery1.SQL.Add('SELECT * FROM g_map ORDER BY comp_id ASC');
    DModule.FDQuery1.Open;

    FormManager.GridLayout_mapList.Height:=DModule.FDQuery1.RecordCount*51;

    map_ip_list:=tStringList.Create;
    map_id:=tStringList.Create;

    for var I :=1 to DModule.FDQuery1.RecordCount do
    begin
            map_ip_list.Add(DModule.FDQuery1.FieldByName('ip').AsString);
            map_id.Add(DModule.FDQuery1.FieldByName('id').AsString);

            mapreport:=mapreport+DModule.FDQuery1.FieldByName('id').AsString;

            if i<>DModule.FDQuery1.RecordCount then mapreport:=mapreport+'#';

            comp[i]:=Trectangle.Create(FormManager.ScrollBox_Map);
            comp[i].Parent:=FormManager.ScrollBox_Map;
            comp[i].Position.X:=DModule.FDQuery1.FieldByName('pos_x').AsInteger;
            comp[i].Position.y:=DModule.FDQuery1.FieldByName('pos_y').AsInteger;
            comp[i].Width:=40;
            comp[i].Height:=40;
            comp[i].XRadius:=5;
            comp[i].YRadius:=5;
            comp[i].Stroke.Thickness:=1;
            comp[i].Fill.Color:=comp_status[DModule.FDQuery1.FieldByName('status').AsInteger];
            comp[i].Stroke.Color:=$006B6B6B;
            comp[i].Tag:=i; // num comp
            comp[i].TagFloat:=DModule.FDQuery1.FieldByName('zone').AsInteger;// game zone
            comp[i].TagString:=DModule.FDQuery1.FieldByName('status').AsString;// status comp

            comp_anim[i]:=TFloatanimation.Create(comp[i]);
            comp_anim[i].Parent:=comp[i];
            comp_anim[i].Delay:=0;
            comp_anim[i].Loop:=true;
            comp_anim[i].AutoReverse:=true;
            comp_anim[i].startValue:=0.3;
            comp_anim[i].StopValue:=1;
            comp_anim[i].Enabled:=false;
            comp_anim[i].PropertyName:='Opacity';
            comp_anim[i].Duration:=0.8;
            comp_anim[i].Tag:=i;

            chair[i]:=Trectangle.Create(FormManager.ScrollBox_Map);
            chair[i].Parent:=FormManager.ScrollBox_Map;

            case DModule.FDQuery1.FieldByName('armchair_pos').AsInteger of

                  1: begin // UP
                      chair[i].Position.X:=DModule.FDQuery1.FieldByName('pos_x').AsInteger+10;
                      chair[i].Position.y:=DModule.FDQuery1.FieldByName('pos_y').AsInteger-25;
                  end;

                  2: begin // down
                      chair[i].Position.X:=DModule.FDQuery1.FieldByName('pos_x').AsInteger+10;
                      chair[i].Position.y:=DModule.FDQuery1.FieldByName('pos_y').AsInteger+45;
                  end;

                  3: begin // left
                      chair[i].Position.X:=DModule.FDQuery1.FieldByName('pos_x').AsInteger-30;
                      chair[i].Position.y:=DModule.FDQuery1.FieldByName('pos_y').AsInteger+10;
                  end;

                  4: begin // right
                      chair[i].Position.X:=DModule.FDQuery1.FieldByName('pos_x').AsInteger+45;
                      chair[i].Position.y:=DModule.FDQuery1.FieldByName('pos_y').AsInteger+10;
                  end;

            end;

            chair[i].Width:=20;
            chair[i].Height:=20;
            chair[i].XRadius:=5;
            chair[i].YRadius:=5;
            chair[i].Stroke.Thickness:=0;
            chair[i].Fill.Color:=$FFCACACA;
            chair[i].Tag:=i;

            chair[i]:=Trectangle.Create(FormManager.ScrollBox_Map);
            chair[i].Parent:=FormManager.ScrollBox_Map;

            case DModule.FDQuery1.FieldByName('armchair_pos').AsInteger of

                  1: begin // UP
                      chair[i].Position.X:=DModule.FDQuery1.FieldByName('pos_x').AsInteger+10;
                      chair[i].Position.y:=DModule.FDQuery1.FieldByName('pos_y').AsInteger-25;
                  end;

                  2: begin // down
                      chair[i].Position.X:=DModule.FDQuery1.FieldByName('pos_x').AsInteger+10;
                      chair[i].Position.y:=DModule.FDQuery1.FieldByName('pos_y').AsInteger+45;
                  end;

                  3: begin // left
                      chair[i].Position.X:=DModule.FDQuery1.FieldByName('pos_x').AsInteger-30;
                      chair[i].Position.y:=DModule.FDQuery1.FieldByName('pos_y').AsInteger+10;
                  end;

                  4: begin // right
                      chair[i].Position.X:=DModule.FDQuery1.FieldByName('pos_x').AsInteger+45;
                      chair[i].Position.y:=DModule.FDQuery1.FieldByName('pos_y').AsInteger+10;
                  end;


            end;

            chair[i].Width:=20;
            chair[i].Height:=20;
            chair[i].XRadius:=5;
            chair[i].YRadius:=5;
            chair[i].Stroke.Thickness:=0;
            chair[i].Fill.Color:=$FFCACACA;
            chair[i].Tag:=i;
            /////
            chair2[i]:=Trectangle.Create(chair[i]);
            chair2[i].Parent:=chair[i];
            chair2[i].Width:=5;
            chair2[i].Height:=5;

            case DModule.FDQuery1.FieldByName('armchair_pos').AsInteger of

                  1: begin // UP

                      chair2[i].Align:=tAlignLayout.Top;
                  end;

                  2: begin // down

                      chair2[i].Align:=tAlignLayout.Bottom;
                  end;

                  3: begin // left

                      chair2[i].Align:=tAlignLayout.Left;
                  end;

                  4: begin // right

                      chair2[i].Align:=tAlignLayout.Right;
                  end;

            end;

            chair2[i].XRadius:=5;
            chair2[i].YRadius:=5;
            chair2[i].Stroke.Thickness:=0;
            chair2[i].Fill.Color:=$FFE0E0E0;
            chair2[i].Tag:=i;

            visual_status[i]:=TCircle.Create(comp[i]);
            visual_status[i].Parent:=comp[i];
            visual_status[i].Width:=8;
            visual_status[i].Height:=8;
            visual_status[i].Position.x:=28;
            visual_status[i].Position.y:=28;
            visual_status[i].Tag:=i;
            visual_status[i].Opacity:=0;
            visual_status[i].Stroke.Thickness:=0;
            visual_status[i].Fill.Color:=$FF6B6B6B;

            visual_id[i]:=Ttext.Create(comp[i]);
            visual_id[i].Parent:=comp[i];
            visual_id[i].Align:=tAlignlayout.Client;
            visual_id[i].TextSettings.FontColor:=$FF333333;
            visual_id[i].TextSettings.Font.Family:='Russia';
            visual_id[i].TextSettings.Font.Size:=14;
            visual_id[i].Tag:=i;
            visual_id[i].TagString:=DModule.FDQuery1.FieldByName('id').AsString;
            visual_id[i].Text:=DModule.FDQuery1.FieldByName('visual_id').AsString;
            visual_id[i].OnClick:=FormManager.MapListClick;
            visual_id[i].Cursor:=crHandPoint;
    /// MAP -------------------------------------------------------------------------------------------- MAP
            map_layout[i]:=TLayout.Create(FormManager.GridLayout_mapList);
            map_layout[i].Parent:=FormManager.GridLayout_mapList;
            map_layout[i].Tag:=i;
            map_layout[i].Opacity:=1;

            map_rect[i]:=Trectangle.Create(map_layout[i]);
            map_rect[i].Parent:=map_layout[i];
            map_rect[i].XRadius:=4;
            map_rect[i].YRadius:=4;
            map_rect[i].Stroke.Thickness:=0;

            if DModule.FDQuery1.FieldByName('status').AsInteger=1 then
            begin
                          if i mod 2=1 then
                          map_rect[i].Fill.Color:=$FFECECEC
                                     else
                          map_rect[i].Fill.Color:=$FFedeeee;
            end else
                          map_rect[i].Fill.Color:=comp_status[DModule.FDQuery1.FieldByName('status').AsInteger];

            map_rect[i].Opacity:=1;
            map_rect[i].Tag:=i;
            map_rect[i].Align:=TAlignlayout.Top;

            //-------------------------------------
            comp_anim2[i]:=TFloatanimation.Create(map_rect[i]);
            comp_anim2[i].Parent:=map_rect[i];
            comp_anim2[i].Delay:=0;
            comp_anim2[i].Loop:=true;
            comp_anim2[i].AutoReverse:=true;
            comp_anim2[i].startValue:=0.3;
            comp_anim2[i].StopValue:=1;
            comp_anim2[i].Enabled:=false;
            comp_anim2[i].PropertyName:='Opacity';
            comp_anim2[i].Duration:=0.8;
            comp_anim2[i].Tag:=i;



            map_rectl[i]:=Trectangle.Create(map_rect[i]);
            map_rectl[i].Parent:=map_rect[i];
            map_rectl[i].XRadius:=4;
            map_rectl[i].YRadius:=4;
            map_rectl[i].Corners:=[TCorner.TopLeft,TCorner.BottomLeft];
            map_rectl[i].Width:=10;
            map_rectl[i].Stroke.Thickness:=0;

                      if DModule.FDQuery1.FieldByName('status').AsInteger=1 then
                      begin
                          if i mod 2=1 then
                          map_rectl[i].Fill.Color:=$FFE0E0E0
                                     else
                          map_rectl[i].Fill.Color:=$FFe5e5e5;
                      end else

                      map_rectl[i].Fill.Color:=comp_status[DModule.FDQuery1.FieldByName('status').AsInteger];

                      map_rectl[i].Opacity:=1;
                      map_rectl[i].Tag:=i;
                      map_rectl[i].TagString:=DModule.FDQuery1.FieldByName('id').AsString;
                      map_rectl[i].Align:=TAlignlayout.MostLeft;

                      //----ip----------------------------------------------------------------
                      map_ip[i]:=TText.Create(map_rect[i]);
                      map_ip[i].Parent:=map_rect[i];
                      map_ip[i].Align:=talignLayout.Left;
                      map_ip[i].HorzTextAlign:= TTextAlign.Trailing;
                      map_ip[i].Text:=DModule.FDQuery1.FieldByName('ip').AsString;
                      map_ip[i].TagFloat:=DModule.FDQuery1.FieldByName('id').AsInteger;
                      map_ip[i].Color:=$FF2C2C2C;
                      map_ip[i].TextSettings.font.Size:=16;
                      map_ip[i].TextSettings.font.family:='Russia';
                      map_ip[i].Tag:=i;
                      map_ip[i].TagString:=DModule.FDQuery1.FieldByName('mac').AsString;
                      map_ip[i].Cursor:=crHandPoint;
                      map_ip[i].Width:=150;
                      map_ip[i].OnClick:=FormManager.MapListClick;

                      //----min----------------------------------------------------------------
                      map_Min[i]:=TText.Create(map_rect[i]);
                      map_Min[i].Parent:=map_rect[i];
                      map_Min[i].Align:=talignLayout.Left;
                      map_Min[i].HorzTextAlign:= TTextAlign.Trailing;
                      map_Min[i].Text:='МИН';
                      map_Min[i].Color:=$FF2C2C2C;
                      map_Min[i].TextSettings.font.Size:=16;
                      map_Min[i].TextSettings.font.family:='Russia';
                      map_Min[i].Tag:=i;
                      map_Min[i].Cursor:=crHandPoint;
                      map_Min[i].Width:=75;
                      map_Min[i].OnClick:=FormManager.MapListClick;

                      //----bonus----------------------------------------------------------------
                      map_Bonus[i]:=TText.Create(map_rect[i]);
                      map_Bonus[i].Parent:=map_rect[i];
                      map_Bonus[i].Align:=talignLayout.Left;
                      map_Bonus[i].HorzTextAlign:= TTextAlign.Trailing;
                      map_Bonus[i].Text:='БОНУС';
                      map_Bonus[i].Color:=$FF2C2C2C;
                      map_Bonus[i].TextSettings.font.Size:=16;
                      map_Bonus[i].TextSettings.font.family:='Russia';
                      map_Bonus[i].Tag:=i;
                      map_Bonus[i].Cursor:=crHandPoint;
                      map_Bonus[i].Width:=75;
                      map_Bonus[i].OnClick:=FormManager.MapListClick;

                      //----money---------------------------------------------------------------
                      map_money[i]:=TText.Create(map_rect[i]);
                      map_money[i].Parent:=map_rect[i];
                      map_money[i].Align:=talignLayout.Left;
                      map_money[i].HorzTextAlign:= TTextAlign.Trailing;
                      map_money[i].Text:='РУБ.';
                      map_money[i].Color:=$FF2C2C2C;
                      map_money[i].TextSettings.font.Size:=16;
                      map_money[i].TextSettings.font.family:='Russia';
                      map_money[i].Tag:=i;
                      map_money[i].Cursor:=crHandPoint;
                      map_money[i].Width:=75;
                      map_money[i].OnClick:=FormManager.MapListClick;
                      //--------------------------------------------------
                      map_tariff[i]:=TText.Create(map_rect[i]);
                      map_tariff[i].Parent:=map_rect[i];
                      map_tariff[i].Align:=talignLayout.Left;
                      map_tariff[i].HorzTextAlign:= TTextAlign.Center;
                      map_tariff[i].Text:='Поминутный';
                      map_tariff[i].Color:=$FF2C2C2C;
                      map_tariff[i].TextSettings.font.Size:=16;
                      map_tariff[i].TextSettings.font.family:='Russia';
                      map_tariff[i].Tag:=i;
                      map_tariff[i].Cursor:=crHandPoint;
                      map_tariff[i].Width:=250;
                      map_tariff[i].OnClick:=FormManager.MapListClick;

                      ///  ----status--------------------------------------------------------

                      map_status[i]:=TCircle.Create(map_rect[i]);
                      map_status[i].Parent:=map_rect[i];
                      map_status[i].Width:=25;
                      map_status[i].Tag:=i;
                      map_status[i].Align:=talignLayout.Left;
                      map_status[i].Opacity:=0;
                      map_status[i].Stroke.Thickness:=0;
                      map_status[i].Fill.Color:=$FF6B6B6B;

                      //----last----------------------------------------------------------------
                      map_duration[i]:=TText.Create(map_rect[i]);
                      map_duration[i].Parent:=map_rect[i];
                      map_duration[i].Align:=talignLayout.Left;
                      map_duration[i].HorzTextAlign:= TTextAlign.Center;
                      map_duration[i].Text:=DModule.FDQuery1.FieldByName('duration').AsString;
                      map_duration[i].Color:=$FF2C2C2C;
                      map_duration[i].TextSettings.font.Size:=16;
                      map_duration[i].TextSettings.font.family:='Russia';
                      map_duration[i].Tag:=i;
                      map_duration[i].Cursor:=crHandPoint;
                      map_duration[i].Width:=50;
                      map_duration[i].OnClick:=FormManager.MapListClick;

                      //----phone----------------------------------------------------------------
                      map_resr_start[i]:=TText.Create(map_rect[i]);
                      map_resr_start[i].Parent:=map_rect[i];
                      map_resr_start[i].Align:=talignLayout.Left;
                      map_resr_start[i].HorzTextAlign:= TTextAlign.Leading;

                      if DModule.FDQuery1.FieldByName('reservation_start').AsDateTime<>null then
                      map_resr_start[i].Text:=DModule.FDQuery1.FieldByName('reservation_start').AsString
                      else map_resr_start[i].Text:='';

                      map_resr_start[i].Color:=$FF2C2C2C;
                      map_resr_start[i].TextSettings.font.Size:=16;
                      map_resr_start[i].TextSettings.font.family:='Russia';
                      map_resr_start[i].Tag:=DModule.FDQuery1.FieldByName('comp_id').AsInteger;
                      map_resr_start[i].Cursor:=crHandPoint;
                      map_resr_start[i].Width:=150;
                      map_resr_start[i].OnClick:=FormManager.MapListClick;

                      //----email----------------------------------------------------------------
                      map_user_id[i]:=TText.Create(map_rect[i]);
                      map_user_id[i].Parent:=map_rect[i];
                      map_user_id[i].Align:=talignLayout.Left;
                      map_user_id[i].HorzTextAlign:= TTextAlign.Leading;
                      map_user_id[i].Text:=DModule.FDQuery1.FieldByName('user_id').AsString;
                      map_user_id[i].Color:=$FF2C2C2C;
                      map_user_id[i].TextSettings.font.Size:=16;
                      map_user_id[i].TextSettings.font.family:='Russia';
                      map_user_id[i].Tag:=i;
                      map_user_id[i].Cursor:=crHandPoint;
                      map_user_id[i].Width:=150;
                      map_user_id[i].OnClick:=FormManager.MapListClick;
                      //----login---------------------------------------------------------------------

                      map_zone[i]:=TText.Create(map_rect[i]);
                      map_zone[i].Parent:=map_rect[i];
                      map_zone[i].Align:=talignLayout.Left;
                      map_zone[i].HorzTextAlign:= TTextAlign.Leading;
                      map_zone[i].Text:=map_pc_zone[ DModule.FDQuery1.FieldByName('zone').AsInteger-1];
                      map_zone[i].Color:=$FF2C2C2C;
                      map_zone[i].TextSettings.font.Size:=16;
                      map_zone[i].TextSettings.font.family:='Russia';
                      map_zone[i].Tag:=i;
                      map_zone[i].Cursor:=crHandPoint;
                      map_zone[i].Width:=150;
                      map_zone[i].OnClick:=FormManager.MapListClick;

                      //// ----id -----------------------------------------------------------------------------

                      map_Uid[i]:=TText.Create(map_rect[i]);
                      map_Uid[i].Parent:=map_rect[i];
                      map_Uid[i].Align:=talignLayout.Left;
                      map_Uid[i].HorzTextAlign:= TTextAlign.Leading;
                      map_Uid[i].Text:=DModule.FDQuery1.FieldByName('comp_id').AsString;

                      map_Uid[i].Color:=$FF2C2C2C;
                      map_Uid[i].TextSettings.font.Size:=16;
                      map_Uid[i].TextSettings.font.family:='Russia';
                      map_Uid[i].Tag:=i;
                      map_Uid[i].TagString:=DModule.FDQuery1.FieldByName('id').AsString;
                      map_Uid[i].Cursor:=crHandPoint;
                      map_Uid[i].Width:=50;
                      map_Uid[i].OnClick:=FormManager.MapListClick;
                      //-----------------------------------------------------------
                      map_r1[i]:=TLayout.Create(map_rect[i]);
                      map_r1[i].Parent:=map_rect[i];
                      map_r1[i].Tag:=i;
                      map_r1[i].Width:=25;
                      map_r1[i].Align:=talignLayout.MostLeft;

                      //-----------------------------------------------------------------------------

            DModule.FDQuery1.Next;

    end;
//       showmessage(mapreport);
  end;


end.
