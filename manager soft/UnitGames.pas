unit UnitGames;

interface
      uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Effects, System.Rtti, FMX.Grid.Style, FMX.Grid,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Edit, FMX.StdCtrls, FMX.Ani
  ,system.Threading;


  procedure gameList( club_id, comp_id, category : integer);
  function  gameCreate( club_id, comp_id, category : integer ; name, link, icon, param, steam_id : string) : integer;

implementation

   uses userUnit, datam, clubmap, bUpdate, msoft, CasboxOperation;

   function gameCreate( club_id, comp_id, category : integer ; name, link, icon, param, steam_id : string) : integer;
   var
        e     : integer;
   begin
     e:=0;


            DModule.FDGames.SQL.Clear;
            DModule.FDGames.SQL.Add('SELECT * FROM g_game_list WHERE club_id='+club_id.ToString+' AND comp_id='+comp_id.ToString+' AND name='''+ansiUpperCase(name)+'''');
            DModule.FDGames.Open;

            if DModule.FDGames.RecordCount=0 then
            begin

                DModule.FDGames.SQL.Clear;
                DModule.FDGames.SQL.Add('insert into g_game_list (club_id, comp_id, category, name, link, icon, param, steam_id) '+
                ' values ('+club_id.ToString+', '+comp_id.ToString+', '+category.ToString+', '''+ansiUpperCase(name)+''', '''+link+''', '''+icon+''', '''+param+''', '''+steam_id+'''); ');
                DModule.FDGames.ExecSQL

            end else
            begin

                DModule.FDGames.SQL.Clear;
                DModule.FDGames.SQL.Add('UPDATE g_game_list SET category='+category.ToString+', name='''+ansiUpperCase(name)+''',  '+
                'link='''+link+''', icon='''+icon+''', param='''+param+''', steam_id='''+steam_id+''' WHERE id='+FormManager.SGGames.Cells[6, FormManager.SGGames.Selected]);
                DModule.FDGames.ExecSQL;

            end;

   end;

   procedure gameList( club_id, comp_id, category : integer);
   begin

      DModule.FDGames.SQL.Clear;
      DModule.FDGames.SQL.Add('SELECT * FROM g_game_list WHERE club_id='+club_id.ToString+' AND comp_id='+comp_id.ToString+' ORDER BY category ASC');
      DModule.FDGames.Open;

      FormManager.SGGames.RowCount:=DModule.FDGames.RecordCount;

      for var I3 :=0 to DModule.FDGames.RecordCount-1 do
      begin

            FormManager.SGGames.Cells[0,i3]:=DModule.FDGames.FieldByName('name').AsString;
            FormManager.SGGames.Cells[1,i3]:=DModule.FDGames.FieldByName('link').AsString;
            FormManager.SGGames.Cells[2,i3]:=DModule.FDGames.FieldByName('icon').AsString;

            FormManager.SGGames.Cells[3,i3]:=DModule.FDGames.FieldByName('param').AsString;
            FormManager.SGGames.Cells[4,i3]:=DModule.FDGames.FieldByName('category').AsString;
            FormManager.SGGames.Cells[5,i3]:=DModule.FDGames.FieldByName('steam_id').AsString;
            FormManager.SGGames.Cells[6,i3]:=DModule.FDGames.FieldByName('id').AsString;
            DModule.FDGames.Next
      end;


   end;

end.
