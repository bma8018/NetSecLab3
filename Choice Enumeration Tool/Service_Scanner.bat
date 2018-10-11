@echo off
set hostnames=machines.txt
FOR /F %%i in ('machines.txt') do call :lookup_service %%i
goto :eof
:lookup_service
set machine=%1
FOR /F "tokens=2" %%j in ('systeminfo /s %machine%^|find /i "OS Version:"') do echo %machine% - %%j >> system_info.txt