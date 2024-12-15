@ECHO OFF
SETLOCAL

rem The first parameter should be the name of the service

ECHO Uninstalling the existing Service (if this fails, no biggie)
sc delete "%~1"

ECHO Installing the Service
sc create "%~1" binPath= %~dp0%~2 start= auto

ECHO Starting the Service
sc start "%~1" 
