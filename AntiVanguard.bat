@echo off
title Valorant Anticheat

:OPTION
mode con cols=49 lines=8
cls
echo ...............................................
echo    		    Option
echo ...............................................
echo.
echo 1 - Turn on Anticheat
echo 2 - Turn off Anticheat

choice /C:12 /N /M " Choose One : "
IF ERRORLEVEL 1 SET M=1
IF ERRORLEVEL 2 SET M=2
IF %M%==1 goto ON
IF %M%==2 goto OFF

:ON
cls
echo @echo off > %tmp%\AntiSpyVanOn.bat
echo sc config vgk start=system ^& sc config vgc start=demand >> %tmp%\AntiSpyVanOn.bat
echo cd "C:\Program Files\" >> %tmp%\AntiSpyVanOn.bat
echo if exist AntiVanCheatSpy ( >> %tmp%\AntiSpyVanOn.bat
echo     rename AntiVanCheatSpy "Riot Vanguard" >> %tmp%\AntiSpyVanOn.bat
echo ) >> %tmp%\AntiSpyVanOn.bat
echo cd /d "G:\Riot Games\" >> %tmp%\AntiSpyVanOn.bat
echo if exist AntiClient ( >> %tmp%\AntiSpyVanOn.bat
echo     rename AntiClient "Riot Client" >> %tmp%\AntiSpyVanOn.bat
echo ) >> %tmp%\AntiSpyVanOn.bat
echo shutdown /s /f /t 00 >> %tmp%\AntiSpyVanOn.bat

powershell start-process -wait "%tmp%\AntiSpyVanOn.bat" -verb runas >NUL
timeout /t 3 /nobreak >NUL
del %tmp%\AntiSpyVanOn.bat
goto OPTION

:OFF
cls
echo @echo off > %tmp%\AntiSpyVanOff.bat
echo sc stop vgk >> %tmp%\AntiSpyVanOff.bat
echo sc config vgk start=disabled ^& sc config vgc start=disabled >> %tmp%\AntiSpyVanOff.bat
echo cd "C:\Program Files\" >> %tmp%\AntiSpyVanOff.bat
echo if exist "Riot Vanguard" ( >> %tmp%\AntiSpyVanOff.bat
echo     rename "Riot Vanguard" AntiVanCheatSpy >> %tmp%\AntiSpyVanOff.bat
echo ) >> %tmp%\AntiSpyVanOff.bat
echo cd /d "G:\Riot Games\" >> %tmp%\AntiSpyVanOff.bat
echo if exist "Riot Client" ( >> %tmp%\AntiSpyVanOff.bat
echo     rename "Riot Client" AntiClient >> %tmp%\AntiSpyVanOff.bat
echo ) >> %tmp%\AntiSpyVanOff.bat

powershell start-process -wait "%tmp%\AntiSpyVanOff.bat" -verb runas >NUL
timeout /t 3 /nobreak >NUL
del %tmp%\AntiSpyVanOff.bat
goto OPTION