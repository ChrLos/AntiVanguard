set "VanguardClientDir="        &:: Example: "VanguardClientDir=C:\Riot Games\"
set "VanguardDir=%PROGRAMFILES%\Riot Vanguard"

@echo off
title Valorant Anticheat
cls

REM Checks if path has been changed
if "%VanguardClientDir%"=="" (
    echo Set the location to "Riot Games" first
    pause
    exit /b
)

REM Run the script as admin
fsutil dirty query %systemdrive% >NUL
if NOT %ERRORLEVEL% == 0 (
    powershell start-process -wait "%cd%/AntiVanguard.bat" -verb runas >NUL
    exit /b
)

REM Check if Anticheat already is deactivated
if exist "%VanguardDir%\vgk.sys" (
    set "Option=Anticheat is Activated"
) else (
    set "Option=Anticheat is Deactivated"
)

:OPTION
mode con cols=49 lines=8
cls
echo =================================================
echo     %Option%
echo =================================================
echo.
echo 1 - Turn on Anticheat
echo 2 - Turn off Anticheat

choice /C:12 /N /M " Choose One : "
IF %ERRORLEVEL% == 1 GOTO ON
IF %ERRORLEVEL% == 2 GOTO OFF

:ON
sc config vgk start=system
sc config vgc start=demand

cd "%VanguardDir%\.."
if exist AntiVanCheatSpy (
    rename AntiVanCheatSpy "Riot Vanguard"
)
cd /d "%VanguardClientDir%"
if exist AntiClient (
    rename AntiClient "Riot Client"
)

echo.
echo Press any key to shutdown
echo Exit the app to cancel
pause >NUL

shutdown /s /f /t 00
goto OPTION

:OFF
sc stop vgk
sc config vgk start=disabled
sc config vgc start=disabled

net stop vgk
net stop vgc

taskkill /f /im vgtray.exe
taskkill /f /im RiotClientServices.exe
taskkill /f /im RiotClientCrashHandler.exe
del /q "Logs"

timeout /t 3

cd "%VanguardDir%\.."
if exist "Riot Vanguard" (
    rename "Riot Vanguard" AntiVanCheatSpy
)
cd /d "%VanguardClientDir%"
if exist "Riot Client" (
    rename "Riot Client" AntiClient
)

pause
goto OPTION