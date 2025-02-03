@echo off
title Valorant Anticheat

set "VanguardDir=%PROGRAMFILES%"
set "VanguardClientDir=SET THE LOCATION HERE"

if "%VanguardClientDir%"=="SET THE LOCATION HERE" (
    echo Set the location to "Riot Games" first
    pause
    exit /b
)

:ADMINCHECK
fsutil dirty query %systemdrive% >NUL
if NOT %ERRORLEVEL% == 0 (
    powershell start-process -wait "%cd%/AntiVanguard.bat" -verb runas >NUL
)

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
@echo off

sc config vgk start=system
sc config vgc start=demand

cd "%VanguardDir%"
if exist AntiVanCheatSpy (
    rename AntiVanCheatSpy "Riot Vanguard"
)
cd /d "%VanguardClientDir%"
if exist AntiClient (
    rename AntiClient "Riot Client"
)

pause
shutdown /s /f /t 00
goto OPTION

:OFF
cls
@echo off

sc stop vgk
sc config vgk start=disabled
sc config vgc start=disabled

net stop vgk ^& net stop vgc
taskkill /f /im vgtray.exe
taskkill /f /im RiotClientServices.exe
taskkill /f /im RiotClientCrashHandler.exe
del /q "Logs"

cd "%VanguardDir%"
if exist "Riot Vanguard" (
    rename "Riot Vanguard" AntiVanCheatSpy
)
cd /d "%VanguardClientDir%"
if exist "Riot Client" (
    rename "Riot Client" AntiClient
)

pause
goto OPTION