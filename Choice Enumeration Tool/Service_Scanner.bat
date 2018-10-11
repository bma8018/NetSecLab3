@echo off
set hostnames=machines.txt
FOR /F %%i in (%hostnames%) do call :lookup_service %%i
goto :eof
:lookup_service
set machine=%1
FOR /f (tokens=*) %%j in ('systeminfo /s %machine%^|findstr /B /C:"OS Version"') do echo %machine% - %%j >> system_info.txt

