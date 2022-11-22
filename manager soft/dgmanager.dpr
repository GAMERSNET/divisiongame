program dgmanager;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  System.StartUpCopy,
  FMX.Forms,
  msoft in 'msoft.pas' {FormManager},
  datam in 'datam.pas' {DModule: TDataModule},
  UserUnit in 'UserUnit.pas',
  clubmap in 'clubmap.pas',
  bUpdate in 'bUpdate.pas' {Form_bUpdate},
  AnimProgress in 'AnimProgress.pas',
  UnitFinance in 'UnitFinance.pas',
  CasboxOperation in 'CasboxOperation.pas' {Form_CBoperation},
  UnitGames in 'UnitGames.pas',
  UnitGameCreate in 'UnitGameCreate.pas' {FormGames},
  bookinginfo in 'bookinginfo.pas' {Form_booking},
  Tariff in 'Tariff.pas' {Form_tarif},
  shoftClose in 'shoftClose.pas' {Form_shiftclose};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormManager, FormManager);
  Application.CreateForm(TDModule, DModule);
  Application.CreateForm(TForm_bUpdate, Form_bUpdate);
  Application.CreateForm(TForm_CBoperation, Form_CBoperation);
  Application.CreateForm(TFormGames, FormGames);
  Application.CreateForm(TForm_booking, Form_booking);
  Application.CreateForm(TForm_tarif, Form_tarif);
  Application.CreateForm(TForm_shiftclose, Form_shiftclose);
  Application.Run;
end.
