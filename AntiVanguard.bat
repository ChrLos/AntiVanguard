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
(
    echo @echo off
    echo sc config vgk start=system ^& sc config vgc start=demand
    echo cd "C:\Program Files\"
    echo if exist AntiVanCheatSpy (
    echo     rename AntiVanCheatSpy "Riot Vanguard"
    echo )
    echo cd /d "G:\Riot Games\"
    echo if exist AntiClient (
    echo     rename AntiClient "Riot Client"
    echo )
    echo shutdown /s /f /t 00
) > %tmp%\AntiSpyVanSwitch.bat
pause

goto FINALLY

:OFF
cls
(
    echo @echo off
    echo sc stop vgk
    echo sc config vgk start=disabled ^& sc config vgc start=disabled
    echo cd "C:\Program Files\"
    echo if exist "Riot Vanguard" (
    echo     rename "Riot Vanguard" AntiVanCheatSpy
    echo )
    echo cd /d "G:\Riot Games\"
    echo if exist "Riot Client" (
    echo     rename "Riot Client" AntiClient
    echo )
) > %tmp%\AntiSpyVanSwitch.bat
pause

goto FINALLY

:FINALLY
powershell start-process -wait "%tmp%\AntiSpyVanSwitch.bat" -verb runas >NUL
timeout /t 3 /nobreak >NUL
del %tmp%\AntiSpyVanSwitch.bat
goto OPTION