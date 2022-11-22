unit shoftClose;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.Edit, FMX.Effects, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Layouts;

type
  TForm_shiftclose = class(TForm)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Button1: TButton;
    Button2: TButton;
    Layout3: TLayout;
    Layout2: TLayout;
    Layout8: TLayout;
    Rectangle_yes: TRectangle;
    Text_yes: TText;
    Layout4: TLayout;
    Text2: TText;
    Layout5: TLayout;
    AniIndicator_shiftClose: TAniIndicator;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_shiftclose: TForm_shiftclose;

implementation

{$R *.fmx}

procedure TForm_shiftclose.Button2Click(Sender: TObject);
begin
      CLOSE;
end;

end.
