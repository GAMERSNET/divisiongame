unit UnitGameCreate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit,
  FMX.ListBox;

type
  TFormGames = class(TForm)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Button1: TButton;
    Button2: TButton;
    Layout3: TLayout;
    Text1: TText;
    Layout2: TLayout;
    ShadowEffect1: TShadowEffect;
    Layout4: TLayout;
    Text2: TText;
    Rectangle_userSearch: TRectangle;
    Edit_name: TEdit;
    Layout5: TLayout;
    Text3: TText;
    Rectangle2: TRectangle;
    EditLink: TEdit;
    Button3: TButton;
    Layout6: TLayout;
    Text4: TText;
    Rectangle3: TRectangle;
    Edit_icon: TEdit;
    Layout7: TLayout;
    Text5: TText;
    Rectangle4: TRectangle;
    Edit_param: TEdit;
    Text6: TText;
    Rectangle5: TRectangle;
    Edit_steam_id: TEdit;
    Layout8: TLayout;
    Rectangle6: TRectangle;
    Text7: TText;
    ComboBox1: TComboBox;
    StyleBook1: TStyleBook;
    Text8: TText;
    procedure Button2Click(Sender: TObject);
    procedure Text7Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGames: TFormGames;

implementation

{$R *.fmx}
      uses unitGames, msoft ,clubmap;
procedure TFormGames.Button2Click(Sender: TObject);
begin
      close;
end;

procedure TFormGames.FormClose(Sender: TObject; var Action: TCloseAction);
begin

    for var i:=0 to FormGames.ComponentCount-1 do
        if FormGames.Components[i].ClassType=TEdit then (FormGames.Components[i] as TEdit).Text:='';

end;

procedure TFormGames.Text7Click(Sender: TObject);
begin

    if (Edit_name.Text<>'') and (EditLink.Text<>'') and (Edit_icon.Text<>'') and (FormGames.ComboBox1.ItemIndex>=0) then
    begin

      gameCreate(5, map_pc_select, FormGames.ComboBox1.ItemIndex, edit_name.Text, editlink.Text, edit_icon.Text, edit_param.Text, edit_steam_id.Text);
      gameList( 5, map_pc_select,0);
      FormGames.Close;

    end else showText ('Заполните обязательные поля');

end;

end.
