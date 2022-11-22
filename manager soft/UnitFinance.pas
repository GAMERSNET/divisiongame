unit UnitFinance;

interface
  uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Effects, System.Rtti, FMX.Grid.Style, FMX.Grid, system.JSON,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Edit, FMX.StdCtrls, FMX.Ani
  ,system.Threading;

  const
       operType     : array [1..2] of string=('Пополнение','Возврат');
       oper         : array [1..4] of string=('Наличные','Безнал','Бонусы','Минуты');
       paytypecolor : array[1..4] of Talphacolor=($FFd25a5e, $FFebb700, $FF85bab5 , $FF185590);

  procedure balanceUpdate_ (user_id, shift_id, payType, admin_id, amount, club_id, operation: string);
  function  balance_  (user_id, user_token, clietn_id, payT,amount, clubToken, descr, shiftnum: string): integer;

  procedure updateBalanceAni(amount, start :integer; name :Ttext);
  Procedure shiftInfo (shift_id, club_id :integer ; fieldName : string; obj : Ttext; st : integer);
  procedure shiftStatistic (shift_id, club_id :integer);

  procedure shiftOperationList_ (m,y,shift_id, club, user_id :integer);

  function  shiftClose     (ctoken, admin, shift : string) : string;

  procedure payTypeDraw;
  var
      pt_rect         : array [1..4] of Trectangle;
      pt_name         : array [1..4] of TText;
      pt_ani          : array [1..4] of TFloatanimation;
      shift_num       : integer=0;
implementation

  uses userUnit, datam, clubmap, bUpdate, msoft, CasboxOperation, shoftClose;

  function shiftClose     (ctoken, admin, shift : string) : string;
  var
    JsonValue                    : TJSONValue;
    s                            : string;
  begin

       TThread.Synchronize(nil,
       procedure
       begin

          Form_shiftclose.Rectangle_yes.Enabled:=false;
          Form_shiftclose.AniIndicator_shiftClose.Enabled:=true;
          Form_shiftclose.AniIndicator_shiftClose.Visible:=true;

       end);

       TThread.CreateAnonymousThread(procedure ()
       begin
             DataM.DModule.RESTRequest1.Params[0].Value:='{"cmd":"closeshift","data":{""},"token":"'+ctoken+'"}';
             DataM.DModule.RESTRequest1.Execute;

             JsonValue:= TJSONValue.Create;
             JsonValue := TJSonObject.ParseJSONValue(DataM.DModule.RESTResponse1.JSONText);


             TThread.Synchronize(nil,
             procedure
             begin

                   case JsonValue.GetValue<integer>('error') of
                       0: begin

                       end;
                   end;
             end);
       end);

       TThread.Synchronize(nil,
       procedure
       begin

          Form_shiftclose.Rectangle_yes.Enabled:=true;
          Form_shiftclose.AniIndicator_shiftClose.Enabled:=false;
          Form_shiftclose.AniIndicator_shiftClose.Visible:=false;

       end);

  end;

  procedure payTypeDraw;
  begin

    for  var I2 :=1 to 4 do
    begin

            pt_rect[i2]:=Trectangle.Create(Form_bUpdate.Rectangle_paytype);
            pt_rect[i2].Parent:=Form_bUpdate.Rectangle_paytype;
            pt_rect[i2].Align:=talignLayout.Vertical;
            pt_rect[i2].XRadius:=4;
            pt_rect[i2].YRadius:=4;
            pt_rect[i2].Width:=94.5;
            pt_rect[i2].Stroke.Thickness:=0;
            pt_rect[i2].Position.X:=((i2-1)*94.5);
            pt_rect[i2].Fill.Color:=$FFd25a5e;
            pt_rect[i2].Opacity:=0;
            pt_rect[i2].Tag:=i2;

            pt_name[i2]:=TText.Create(Form_bUpdate.Rectangle_paytype);
            pt_name[i2].Parent:=Form_bUpdate.Rectangle_paytype;
            pt_name[i2].Align:=talignLayout.Vertical;
            pt_name[i2].Text:=oper[i2];
            pt_name[i2].Position.x:=((i2-1)*94.5);
            pt_name[i2].Width:=94.5;
            pt_name[i2].Color:=$FF6B6B6B;
            pt_name[i2].TextSettings.font.Size:=13;
            pt_name[i2].TextSettings.font.family:='Russia';
            pt_name[i2].OnClick:=FormManager.ptNameClick;
            pt_name[i2].Cursor:=crHandPoint;
            pt_name[i2].Tag:=i2;

            pt_ani [i2]:=TFloatanimation.Create(pt_rect[i2]);
            pt_ani [i2].Parent:=pt_rect[i2];
            pt_ani [i2].Delay:=0;
            pt_ani [i2].startValue:=1;
            pt_ani [i2].StopValue:=0.5;
            pt_ani [i2].Enabled:=false;
            pt_ani [i2].PropertyName:='Opacity';
            pt_ani [i2].Duration:=0.7;
            pt_ani [i2].Tag:=i2;

    end;

  end;

procedure updateBalanceAni(amount, start :integer; name :Ttext);
var
        aTask           : ITask;
begin

   aTask := TTask.Create (procedure ()
   var
        x       : integer;
        begin
                     x:=start;

                     repeat
                         sleep(5);
                         TThread.Synchronize(nil,
                         procedure
                         begin
                              name.Text:=floattostr(x/100);
                              FormManager.Text_cashbox.Text:=FloatToStrF(FormManager.Text_cash.Text.ToSingle+FormManager.Text_nocash.Text.ToSingle, ffGeneral, 6, 2);
                         end);
                         inc(x,2333);

                     until x>=amount;

                     TThread.Synchronize(nil,
                     procedure
                     begin
                            name.Text:=floattostr(amount/100);
                            FormManager.Text_cashbox.Text:=FloatToStrF(FormManager.Text_cash.Text.ToSingle+FormManager.Text_nocash.Text.ToSingle, ffGeneral, 6, 2);
                     end);

        end);

   aTask.Start;
end;


  procedure shiftStatistic (shift_id, club_id :integer);
  begin

    if shift_id=0 then
    begin
        DModule.FDShiftInfo.sql.clear;
        DModule.FDShiftInfo.SQL.Add('SELECT * FROM g_cashbox_shift WHERE club_id='+club_id.ToString+' ORDER BY id ASC');
        DModule.FDShiftInfo.Open;

        FormManager.SG_shiftSt.RowCount:=DModule.FDShiftInfo.RecordCount;

        for var I3 :=0 to DModule.FDShiftInfo.RecordCount-1 do
        begin
            FormManager.SG_shiftSt.Cells[0,i3]:=DModule.FDShiftInfo.FieldByName('d_start').AsString;
            FormManager.SG_shiftSt.Cells[1,i3]:=DModule.FDShiftInfo.FieldByName('d_end').AsString;
            FormManager.SG_shiftSt.Cells[2,i3]:=DModule.FDShiftInfo.FieldByName('admin_id').AsString;

            FormManager.SG_shiftSt.Cells[3,i3]:=DModule.FDShiftInfo.FieldByName('cash').AsString;
            FormManager.SG_shiftSt.Cells[4,i3]:=DModule.FDShiftInfo.FieldByName('cash_operation').AsString;

            FormManager.SG_shiftSt.Cells[5,i3]:=DModule.FDShiftInfo.FieldByName('nocash').AsString;
            FormManager.SG_shiftSt.Cells[6,i3]:=DModule.FDShiftInfo.FieldByName('nocash_operation').AsString;

            FormManager.SG_shiftSt.Cells[7,i3]:=DModule.FDShiftInfo.FieldByName('bonus').AsString;
            FormManager.SG_shiftSt.Cells[8,i3]:=DModule.FDShiftInfo.FieldByName('bonus_operation').AsString;

            FormManager.SG_shiftSt.Cells[9,i3]:=DModule.FDShiftInfo.FieldByName('mins').AsString;
            FormManager.SG_shiftSt.Cells[10,i3]:=DModule.FDShiftInfo.FieldByName('min_operation').AsString;

            FormManager.SG_shiftSt.Cells[11,i3]:=DModule.FDShiftInfo.FieldByName('bar_cash').AsString;
            FormManager.SG_shiftSt.Cells[12,i3]:=DModule.FDShiftInfo.FieldByName('bar_cash_operation').AsString;

            FormManager.SG_shiftSt.Cells[13,i3]:=DModule.FDShiftInfo.FieldByName('bar_nocash').AsString;
            FormManager.SG_shiftSt.Cells[14,i3]:=DModule.FDShiftInfo.FieldByName('bar_nocash_operation').AsString;

            FormManager.SG_shiftSt.Cells[15,i3]:=DModule.FDShiftInfo.FieldByName('r_cash').AsString;
            FormManager.SG_shiftSt.Cells[16,i3]:=DModule.FDShiftInfo.FieldByName('r_cash_operation').AsString;
            FormManager.SG_shiftSt.Cells[17,i3]:=DModule.FDShiftInfo.FieldByName('shift_id').AsString;

            DModule.FDShiftInfo.Next
        end;

    end;

  end;

  procedure shiftOperationList_ (m,y,shift_id, club, user_id :integer);
  begin

     if (user_id=0) and (shift_id=0)  then
     begin

        DModule.FDShiftInfo.sql.clear;
        DModule.FDShiftInfo.SQL.Add('SELECT * FROM g_cashbox_operation WHERE dt_operation>='''+y.ToString+'.'+m.ToString+'.01 00:00:00'' AND dt_operation<='''+y.ToString+'.'+m.ToString+'.'+IntToStr(MonthDays[IsLeapYear(y)][m])+' 23:59:59'' AND club_id='+club.ToString+' ORDER BY id ASC');
        DModule.FDShiftInfo.Open;

     end;

     if (user_id<>0)  and (shift_id=0) then
     begin

        DModule.FDShiftInfo.sql.clear;
        DModule.FDShiftInfo.SQL.Add('SELECT * FROM g_cashbox_operation WHERE dt_operation>='''+y.ToString+'.'+m.ToString+'.01 00:00:00'' AND dt_operation<='''+y.ToString+'.'+m.ToString+'.'+IntToStr(MonthDays[IsLeapYear(y)][m])+' 23:59:59'' AND user_id='+user_id.ToString+' ORDER BY id ASC');
        DModule.FDShiftInfo.Open;

     end;

     if shift_id<>0 then
     begin

        DModule.FDShiftInfo.sql.clear;
        DModule.FDShiftInfo.SQL.Add('SELECT * FROM g_cashbox_operation WHERE shift_id='+shift_id.ToString+' AND club_id='+club.ToString+' ORDER BY id ASC');
        DModule.FDShiftInfo.Open;

     end;

     Form_CBoperation.SG_shiftSt.RowCount:=DModule.FDShiftInfo.RecordCount;

     for var I3 :=0 to DModule.FDShiftInfo.RecordCount-1 do
     begin

            Form_CBoperation.SG_shiftSt.Cells[0,i3]:=DModule.FDShiftInfo.FieldByName('dt_operation').AsString;
            Form_CBoperation.SG_shiftSt.Cells[1,i3]:=DModule.FDShiftInfo.FieldByName('admin_id').AsString;
            Form_CBoperation.SG_shiftSt.Cells[2,i3]:=DModule.FDShiftInfo.FieldByName('value').AsString;
            Form_CBoperation.SG_shiftSt.Cells[3,i3]:=operType[dModule.FDShiftInfo.FieldByName('type_operation').AsInteger];
            Form_CBoperation.SG_shiftSt.Cells[4,i3]:=oper[DModule.FDShiftInfo.FieldByName('operation').Asinteger];
            Form_CBoperation.SG_shiftSt.Cells[6,i3]:=DModule.FDShiftInfo.FieldByName('user_id').AsString;
            Form_CBoperation.SG_shiftSt.Cells[7,i3]:=DModule.FDShiftInfo.FieldByName('description').AsString;
           //paytypecolor
            DModule.FDShiftInfo.Next
     end;

  end;

  procedure shiftInfo (shift_id, club_id :integer ; fieldName : string; obj : Ttext; st : integer);
  begin

    if shift_id=0 then
    begin

        DModule.FDShiftInfo.sql.clear;
        DModule.FDShiftInfo.SQL.Add('SELECT * FROM g_cashbox_shift WHERE status=true AND club_id='+club_id.ToString+' ORDER BY id ASC');
        DModule.FDShiftInfo.Open;

        FormManager.Text_cashOp.Text:=DModule.FDShiftInfo.FieldByName('cash_operation').AsString;
        FormManager.Text_nocashOp.Text:=DModule.FDShiftInfo.FieldByName('nocash_operation').AsString;

        

        FormManager.Text_totalPay.Text:=(DModule.FDShiftInfo.FieldByName('nocash_operation').AsInteger+dModule.FDShiftInfo.FieldByName('cash_operation').AsInteger).ToString;
        FormManager.Text_totalBonus.Text:=DModule.FDShiftInfo.FieldByName('bonus_operation').AsString;
        //-----------------------------------------------------------------------------------------
        FormManager.Arc_cash.StartAngle:=0;
        FormManager.Arc_cash.EndAngle:=(360/(DModule.FDShiftInfo.FieldByName('cash').AsInteger+DModule.FDShiftInfo.FieldByName('nocash').AsInteger))*DModule.FDShiftInfo.FieldByName('cash').AsInteger;

        FormManager.Arc_noncash.StartAngle:=FormManager.Arc_cash.EndAngle+10;
        FormManager.Arc_noncash.EndAngle:=((360/(DModule.FDShiftInfo.FieldByName('cash').AsInteger+DModule.FDShiftInfo.FieldByName('nocash').AsInteger))*DModule.FDShiftInfo.FieldByName('nocash').AsInteger)-20;
        //-----------------------------------------------------------------------------------------
        FormManager.Text_dateShift.Text:=formatdatetime('yyyy.mm.dd',DModule.FDShiftInfo.FieldByName('d_start').AsDateTime);
        FormManager.Text_timeShift.Text:=formatdatetime('hh:mm',DModule.FDShiftInfo.FieldByName('d_start').AsDateTime);
        shift_num:=DModule.FDShiftInfo.FieldByName('shift_id').AsInteger;

        if DModule.FDShiftInfo.RecordCount>0 then
        begin

             updateBalanceAni(round(strtofloat(stringReplace(DModule.FDShiftInfo.FieldByName(fieldName).AsString,'.',',',[]))*100),st,obj);

        end;

    end;

  end;


  function balance_  (user_id, user_token, clietn_id, payT,amount, clubToken, descr, shiftnum: string): integer;
  var
    JsonValue                    : TJSONValue;
    s                            : string;
  begin

       TThread.Synchronize(nil,
       procedure
       begin

          Form_bUpdate.Rectangle_cashbox.Enabled:=false;
          Form_bUpdate.AniIndicator_userSearch.Enabled:=true;
          Form_bUpdate.AniIndicator_userSearch.Visible:=true;

       end);

       TThread.CreateAnonymousThread(procedure ()
       begin
             DataM.DModule.RESTRequest1.Params[0].Value:='{"cmd":"updatebalance","data":{"user_id":"'+user_id+'", "user_token":"'+user_token+'","client_id":'+clietn_id+',"paytype":'+payT+', "amount":"'+amount+'","descr":"'+descr+'", "shiftnum":'+shiftnum+'},"token":"'+clubToken+'"}';
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

                Form_bUpdate.Rectangle_cashbox.Enabled:=true;
                Form_bUpdate.AniIndicator_userSearch.Enabled:=false;
                Form_bUpdate.AniIndicator_userSearch.Visible:=false;

                case payT.ToInteger of
                  1 :  shiftInfo (0,5,'cash',FormManager.Text_cash, round(strtofloat( FormManager.Text_cash.Text)));
                  2 :  shiftInfo (0,5,'nocash',FormManager.Text_nocash, round(strtofloat( FormManager.Text_nocash.Text)));
                  3 :  shiftInfo (0,5,'bonus',FormManager.Text_bonus, round(strtofloat( FormManager.Text_bonus.Text)));
                end;

             end);

       end).Start;

  end;

  procedure balanceUpdate_ (user_id, shift_id, payType, admin_id, amount, club_id, operation: string);
  var
        err       : byte;
        atask     : ITask;
  begin

      err:=0;

      TThread.Synchronize(nil,
      procedure
      begin

        Form_bUpdate.Rectangle_cashbox.Enabled:=false;
        Form_bUpdate.AniIndicator_userSearch.Enabled:=true;
        Form_bUpdate.AniIndicator_userSearch.Visible:=true;

      end);

     aTask := TTask.Create (procedure ()
     begin

            DModule.FDBalance.sql.clear;
            DModule.FDBalance.SQL.Add('INSERT INTO g_cashbox_operation '+
            '       (club_id,       shift_id,    admin_id, type_operation, value,        operation, check_id, user_id) '+
            'VALUES ('+club_id+', '+shift_id+', '+admin_id+', '+PayType+', '+amount+'::money, '+operation+', 0,'+user_id+')');
            DModule.FDBalance.ExecSQL;

            DModule.FDBalance.sql.clear;

            case operation.ToInteger of

                  1 : DModule.FDBalance.SQL.Add('UPDATE g_cashbox_shift SET cash=cash+'+amount+'::money, cash_operation=cash_operation+1          WHERE status=true AND club_id='+club_id); //нал
                  2 : DModule.FDBalance.SQL.Add('UPDATE g_cashbox_shift SET nocash=nocash+'+amount+'::money, nocash_operation=nocash_operation+1  WHERE status=true AND club_id='+club_id); //безнал
                  3 : DModule.FDBalance.SQL.Add('UPDATE g_cashbox_shift SET bonus=bonus+'+amount+'::money, bonus_operation=bonus_operation+1      WHERE status=true AND club_id='+club_id); //бонусы
                  4 : DModule.FDBalance.SQL.Add('UPDATE g_cashbox_shift SET mins=mins+'+amount+', min_operation=min_operation+1                   WHERE status=true AND club_id='+club_id); //бонусы

            end;

            DModule.FDBalance.ExecSQL;

            DModule.FDBalance.sql.clear;
            case operation.ToInteger of

                  1..2 : DModule.FDBalance.SQL.Add('UPDATE g_users SET amount=amount+'+amount+'::money WHERE id='+user_id); //нал
                  3    : DModule.FDBalance.SQL.Add('UPDATE g_users SET bonus=bonus+'+amount+'::money WHERE id='+user_id); //нал
                  4    : DModule.FDBalance.SQL.Add('UPDATE g_users SET bonus_min=bonus_min+'+amount+' WHERE id='+user_id); //нал
            end;

            DModule.FDBalance.ExecSQL;

        TThread.Synchronize(nil,
        procedure
        begin

            Form_bUpdate.Rectangle_cashbox.Enabled:=true;
            Form_bUpdate.AniIndicator_userSearch.Enabled:=false;
            Form_bUpdate.AniIndicator_userSearch.Visible:=false;
            Form_bUpdate.Close;

            FormManager.Text_alert.Text:='Успешно выполнено!';
            FormManager.FloatAnim_alert.Enabled:=false;
            FormManager.FloatAnim_alert.Enabled:=true;

        end);

     end);
     aTask.Start;
  end;

end.
