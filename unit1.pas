unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  MMSystem, Windows, Messages, ExtCtrls, Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls;

type

  { Tfrm1 }

  Tfrm1 = class(TForm)
    btnGo: TButton;
    btnStart: TButton;
    gbxMenu: TGroupBox;
    imgKotik: TImage;
    lblBegin: TLabel;
    lblCount: TLabel;
    lblEnd: TLabel;
    lblHero: TLabel;
    lblRetry: TLabel;
    lblSound: TLabel;
    lblSpeed: TLabel;
    lblSpeedHint: TLabel;
    shpAnimation: TShape;
    shpDrawer: TShape;
    shpEnd: TShape;
    shpFatty: TShape;
    shpHealth: TShape;
    shpHealZone: TShape;
    shpMain: TShape;
    shpRisky: TShape;
    tbrSpeed: TTrackBar;
    tmrAnimation: TTimer;
    tmrBegin: TTimer;
    tmrCount: TTimer;
    tmrDrag: TTimer;
    tmrEnd: TTimer;
    tmrGo: TTimer;
    tmrKotik: TTimer;
    tmrMenu: TTimer;
    tmrMusic: TTimer;
    tmrSpeed: TTimer;
    procedure btnGoClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblRetryMouseEnter(Sender: TObject);
    procedure lblRetryMouseLeave(Sender: TObject);
    procedure lblRetryMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblSoundMouseEnter(Sender: TObject);
    procedure lblSoundMouseLeave(Sender: TObject);
    procedure lblSoundMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shpFattyMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shpMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shpRiskyMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tmrAnimationTimer(Sender: TObject);
    procedure tmrBeginTimer(Sender: TObject);
    procedure tmrCountTimer(Sender: TObject);
    procedure tmrDragTimer(Sender: TObject);
    procedure tmrEndTimer(Sender: TObject);
    procedure tmrGoTimer(Sender: TObject);
    procedure tmrKotikTimer(Sender: TObject);
    procedure tmrMenuTimer(Sender: TObject);
    procedure tmrMusicTimer(Sender: TObject);
    procedure tmrSpeedTimer(Sender: TObject);
  private
    Gif : TGifImage;
    { private declarations }
  public
    { public declarations }
  end;

var
  frm1: Tfrm1;
  topBorder, leftBorder : boolean;
  menuSpeed, btnSpeed, speed, randomSpeedX, randomSpeedY, beginSpeed : integer;
  time, kotikX, kotikY, mainX, mainY, endX, endY, healthBar : integer;
  count, sound : integer;


implementation

{$R *.lfm}

{ Tfrm1 }

procedure Tfrm1.FormCreate(Sender: TObject); //Allignment
begin

  //Allignment Begin
  btnStart.Left := round(frm1.Width / 2 - btnStart.Width / 2);
  btnStart.Top := round(frm1.Height / 2 - btnStart.Height / 2);
  lblHero.Left := gbxMenu.Left + round(frm1.Width / 3 - lblHero.Width / 2);
  lblHero.Top := frm1.Height div 4;
  shpFatty.Left := gbxMenu.Left + round(frm1.Width / 4.1);
  shpFatty.Top := round(frm1.Height / 2.3);
  shpRisky.Left := shpFatty.Left + shpFatty.Width + 54;
  shpRisky.Top := round(frm1.Height / 2.8);
  lblSpeed.Left := round(frm1.Width * 1.8 / 3);
  lblSpeed.Top := lblHero.Top;
  tbrSpeed.Left := lblSpeed.Left;
  tbrSpeed.Top := shpRisky.Top;
  lblSpeedHint.Top := tbrSpeed.Top + 20;
  lblSpeedHint.Left := tbrSpeed.Left + 15;
  btnGo.Left := round(frm1.Width * 6.55 / 4);  //lblSpeedHint.Left + 20;
  btnGo.Top := shpFatty.Top + 5;
  lblCount.Left := frm1.Width div 2;
  lblEnd.Left := round((frm1.Width - lblEnd.Width) / 2);
  shpAnimation.Top := btnGo.Top - 40;
  shpAnimation.Left := tbrSpeed.Left - 35;
  shpHealth.Top := 25;
  shpHealth.Left := frm1.Width - shpHealth.Width - 20;
  shpHealZone.Left := round((frm1.Width - shpHealZone.Width) / 2);
  shpHealZone.Top := round((frm1.Height - shpHealZone.Height) / 2);
  lblRetry.Left := round((frm1.Width - lblRetry.Width) / 2);
  lblRetry.Top := frm1.Height - 100;

  kotikX := imgKotik.Left;
  kotikY := imgKotik.Top;
  mainX := shpMain.Left;
  mainY := shpMain.Top;

  endX := shpEnd.Left;
  endY := shpEnd.Top;

  healthBar := shpHealth.Width;

  gbxMenu.Left := frm1.Width + 10;
  frm1.Color := ClWhite;

  lblSound.Top := frm1.Height - 100;
  lblSound.Left := 40;
  //Allignment End

  imgKotik.Picture.LoadFromFile('Cat-150.png');

  //Constants Begin
  menuSpeed := 1;
  btnSpeed := 1;
  randomSpeedX := random(10);
  randomSpeedY := random(10);
  count := 0;
  sound := 1;
  //Constants End

end;

procedure Tfrm1.lblSoundMouseEnter(Sender: TObject);
begin
  lblSound.Font.Color := ClGray;
end;

procedure Tfrm1.lblSoundMouseLeave(Sender: TObject);
begin
  lblSound.Font.Color := ClBlack;
end;

procedure Tfrm1.lblSoundMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  sound := -sound;
  If sound = -1 then
    lblSound.Font.Style := [fsStrikeOut]
  else
    lblSound.Font.Style := [];
end;

procedure Tfrm1.shpFattyMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  shpFatty.Brush.Style := bsDiagCross;
  shpRisky.Brush.Style := bsSolid;

  shpMain.Brush.Color := shpFatty.Brush.Color;
  shpMain.Height := shpFatty.Height;
  shpMain.Width := shpFatty.Width;

end;

procedure Tfrm1.shpRiskyMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  shpRisky.Brush.Style := bsDiagCross;
  shpFatty.Brush.Style := bsSolid;

  shpMain.Brush.Color := shpRisky.Brush.Color;
  shpMain.Height := shpRisky.Height;
  shpMain.Width := shpRisky.Width;
end;

procedure Tfrm1.btnStartClick(Sender: TObject);
begin
  tmrMenu.Enabled := True;
  if sound = 1 then
    tmrMusic.Enabled := True;
end;

procedure Tfrm1.tmrMenuTimer(Sender: TObject); //Menu transitions
begin
  menuSpeed := menuSpeed + 4;
  btnStart.Left := btnStart.Left - round(menuSpeed/1.5);
  gbxMenu.Left := gbxMenu.Left - menuSpeed;
  btnGo.Left := btnGo.Left - menuSpeed;

  if (gbxMenu.Left <= imgKotik.Left + imgKotik.Width) then
   begin
     tmrKotik.Enabled := False;
     imgKotik.Left := imgKotik.Left - menuSpeed;
     if count = 0 then
     count := 1;
   end;
  if gbxMenu.Left <= 0 then
   begin
     shpEnd.Left := endX;
     shpEnd.Top := endY;
     shpEnd.Width := 1;
     shpEnd.Height := 1;

     imgKotik.Left := kotikX;
     imgKotik.Top := kotikY;
     shpMain.Left := mainX;
     shpMain.Top := mainY;

     tmrMenu.enabled := False;

     lblEnd.Visible := False;
     lblCount.Caption := '0';
     lblCount.Font.Color := ClBlack;
     lblCount.Top := 8;
     lblCount.Left := round((frm1.Width - lblCount.Width) / 2);
     shpHealth.Width := healthBar;
     lblCount.Visible := True;

     time := 0;

     lblRetry.Visible := False;
     lblEnd.Visible := False;
     lblCount.Visible := False;

     lblSound.Visible := False;
   end;
end;

procedure Tfrm1.tmrMusicTimer(Sender: TObject);
 var c : integer;
begin
  c := random(5);
  Case c of
    1 : sndPlaySound('Sound Pack\C', snd_Async or snd_NoDefault);
    2 : sndPlaySound('Sound Pack\Am', snd_Async or snd_NoDefault);
    3 : sndPlaySound('Sound Pack\Dm', snd_Async or snd_NoDefault);
    4 : sndPlaySound('Sound Pack\Em', snd_Async or snd_NoDefault);
    5 : sndPlaySound('Sound Pack\Bdim', snd_Async or snd_NoDefault);
    0 : sndPlaySound('Sound Pack\G', snd_Async or snd_NoDefault);
  end;
end;

procedure Tfrm1.btnGoClick(Sender: TObject);
begin
  speed := tbrSpeed.Position;
  tmrGo.Enabled := True;

  imgKotik.Left := frm1.Width;
  imgKotik.Top := 0;
end;

procedure Tfrm1.tmrGoTimer(Sender: TObject);
begin
  btnSpeed := btnSpeed + 2;
  btnGo.Height := btnGo.Height div 2;
  btnGo.Width := btnGo.Width div 2;
  btnGo.Left := btnGo.Left - btnSpeed;
  btnGo.Top := btnGo.Top - btnSpeed;
  tmrAnimation.Enabled := True;
  if (btnGo.Left < frm1.Width / 2) and (btnGo.Top < frm1.Height / 2) then
     tmrGo.Enabled := False;
end;

procedure Tfrm1.tmrAnimationTimer(Sender: TObject);
begin
  shpAnimation.Width := round(shpAnimation.Width * 1.5);
  shpAnimation.Height := round(shpAnimation.Height * 1.5);
  shpAnimation.Left := shpAnimation.Left - round(shpAnimation.Width / 6);
  shpAnimation.Top := shpAnimation.Top - round(shpAnimation.Height / 6);
  if shpAnimation.Width >= 2.5 * frm1.Width then
   begin
     shpMain.Visible := True;
     lblCount.Visible := True;
     lblBegin.Visible := True;
     shpHealth.Visible := True;
     shpHealZone.Visible := True;

     gbxMenu.Visible := False;
     shpAnimation.Width := 1;
     shpAnimation.Height := 1;
     shpAnimation.Top := btnGo.Top - 40;
     shpAnimation.Left := btnGo.Left - 40;
     tmrAnimation.Enabled := False;
   end;
end;

procedure Tfrm1.shpMainMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  tmrKotik.Enabled := True;
  tmrDrag.Enabled := True;
  tmrBegin.Enabled := True;
  tmrCount.Enabled := True;
  tmrSpeed.Enabled := True;
end;

procedure Tfrm1.tmrSpeedTimer(Sender: TObject); //HealZone timer also included
begin
  inc(speed);

  If (shpMain.Left < shpHealZone.Left + shpHealZone.Width) and (shpMain.Left + shpMain.Width > shpHealZone.Left) and (shpMain.Top < shpHealZone.Top + shpHealZone.Height) and (shpMain.Top + shpMain.Height > shpHealZone.Top) then
    shpHealth.Width := shpHealth.Width + 5;

end;

procedure Tfrm1.tmrKotikTimer(Sender: TObject); //Catball's movement
begin
  If topBorder then //Moving the CatBall
    imgKotik.Top := imgKotik.Top + speed + randomSpeedY
  else
    imgKotik.Top := imgKotik.Top - speed - randomSpeedY;
  If leftBorder then
    imgKotik.Left := imgKotik.Left + speed + randomSpeedX
  else
    imgKotik.Left := imgKotik.Left - speed - randomSpeedX;

  if imgKotik.Top <= 0 then //Checking if the CatBall hits the sides
   begin
    topBorder := True;
    randomSpeedY := random((tbrSpeed.Position + speed) div 2);
   end;
  if imgKotik.Top + imgKotik.Height >= frm1.Height then
   begin
    topBorder := False;
    randomSpeedY := random((tbrSpeed.Position + speed) div 2);
   end;
  if imgKotik.Left <= 0 then
   begin
    leftBorder := True;
    randomSpeedX := random((tbrSpeed.Position + speed) div 2);
   end;
  if imgKotik.Left + imgKotik.Width >= frm1.Width then
   begin
    leftBorder := False;
    randomSpeedX := random((tbrSpeed.Position + speed) div 2);
   end;
end;

procedure Tfrm1.tmrDragTimer(Sender: TObject);
begin
  shpMain.Top := Mouse.CursorPos.Y - frm1.Top - 20 - shpMain.Height + round(shpMain.Height / 2);
  shpMain.Left := Mouse.CursorPos.X - frm1.Left - round(shpMain.Width / 2);

  If (Mouse.CursorPos.Y >= frm1.Height - 5) or (Mouse.CursorPos.Y <= 5) or (Mouse.CursorPos.X >= frm1.Width - 5) or (Mouse.CursorPos.X <= 5) then
   begin
     shpHealth.Width := shpHealth.Width - 1;
   end;
  If (shpMain.Left < imgKotik.Left + imgKotik.Width) and (shpMain.Left + shpMain.Width > imgKotik.Left) and (shpMain.Top < imgKotik.Top + imgKotik.Height) and (shpMain.Top + shpMain.Height > imgKotik.Top) then
   begin
     shpHealth.Width := shpHealth.Width - round(speed*speed / 100);
   end;

  If shpHealth.Width <= 0 then
   begin
      shpHealth.Visible := False;
      shpEnd.Visible := True;
      shpEnd.Left := shpMain.Left + round(shpMain.Width / 2);
      shpEnd.Top := shpMain.Top + round(shpMain.Width / 2);
      tmrEnd.Enabled := True;

      tmrKotik.Enabled := False;
      tmrCount.Enabled := False;
      tmrDrag.Enabled := False;
      tmrSpeed.Enabled := False;
   end;
end;

procedure Tfrm1.tmrBeginTimer(Sender: TObject);
begin
  beginSpeed := beginSpeed + 4;
  lblBegin.Top := lblBegin.Top - beginSpeed;
  if lblBegin.Top + lblBegin.Height <= 0 then
   begin
      tmrBegin.Enabled := False;
      lblBegin.Visible := False;
   end;
end;

procedure Tfrm1.tmrCountTimer(Sender: TObject);
 var s : string;
begin
  time := time + 1;
  Str(time, s);
  lblCount.Caption := s;
end;

procedure Tfrm1.tmrEndTimer(Sender: TObject); //Counting the scores here
begin
  shpEnd.Width := round(shpEnd.Width * 1.5);
  shpEnd.Height := round(shpEnd.Height * 1.5);
  shpEnd.Left := shpEnd.Left - round(shpEnd.Width / 6);
  shpEnd.Top := shpEnd.Top - round(shpEnd.Height / 6);

  if shpEnd.Width >= 2.5 * frm1.Width then
   begin
     lblRetry.Visible := True;
     lblEnd.Visible := True;
     lblCount.Font.Color := ClWhite;
     lblCount.Caption := 'Your score : ' + IntToStr(tbrSpeed.Position*2 + StrToInt(lblCount.Caption)*4);

     lblCount.Top := lblEnd.Top + 85;
     lblCount.Left := round((frm1.Width - lblCount.Width) / 2);
     tmrEnd.Enabled := False;
   end;
end;


procedure Tfrm1.lblRetryMouseEnter(Sender: TObject);
begin
  lblRetry.Font.Color := ClGray;
end;

procedure Tfrm1.lblRetryMouseLeave(Sender: TObject);
begin
  lblRetry.Font.Color := ClWhite;
end;

procedure Tfrm1.lblRetryMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //Reassigning constants Begin
  gbxMenu.Left := frm1.Width + 10;
  btnGo.Left := round(frm1.Width * 6.55 / 4);
  btnGo.Top := shpFatty.Top + 5;
  btnGo.Height := 97;
  btnGo.Width := 257;
  btnGo.Visible := True;

  menuSpeed := 1;
  btnSpeed := 1;

  shpAnimation.Top := btnGo.Top - 40;
  shpAnimation.Left := tbrSpeed.Left - 35;
  gbxMenu.Visible := True;
//Reassigning constants End


  tmrMenu.Enabled := True;
end;

end.
