@echo off
cls

echo Fonter - ng7

setlocal enabledelayedexpansion
set "_drvs=Z: Y: X: W: V: U: T: S: R: Q: P: O: N: M: L: K: J: I: H: G: F: E: D: "

for /f "skip=1" %%u in ('wmic logicaldisk get deviceid') do set "_drvs=!_drvs:%%u =!"

set _drv=%_drvs:~0,2%
set _idir=%~dp0

if %_idir:~-1%==\ (set _bdir=%_idir:~0,-1%) else (set _bdir=%_idir%)

if %_bdir:~0,2%==\\ goto nas

:local
set condition=


set _fdir=%_bdir%
goto process

:nas
set condition=nas

net use %_drv% "%_bdir%"
set _fdir=%_drv%
%_drv%

:process
for /r %%f in (*.ttf *.ttc *.otf) do %_fdir%\RegisterFont.exe add "%%f"

:exit
echo Well that was fun, we're done now, thanks.
pause

if defined condition net use %_drv% /delete /y