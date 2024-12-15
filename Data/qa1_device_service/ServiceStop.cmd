@echo off
setlocal

for /F %%S in ('Net.exe Start ^| Findstr.exe /c:"%~1"') do set found=True
if "%found%"=="" (
	echo The service wasn't running. Doing nothing
	exit 0
)

rem Define service PID
for /F "tokens=2 delims=: " %%H in ('sc queryex "%~1" ^| findstr "PID"') do set pid=%%H

echo The service is running with PID %pid% Stopping it
sc stop "%~1"

echo Waiting for process end up to 20 sec
for /L %%i in (1,1,20) do (
	echo %%i sec
	ping 1.1.1.1 -n 1 -w 1000 > nul
	set ERRORLEVEL=0
	
	tasklist /fi "pid eq %pid%"  |find ":" > nul
	if not errorlevel 1 exit 0
)

echo Terminate remaining service process
taskkill /F /pid %pid%
