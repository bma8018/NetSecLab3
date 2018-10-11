@echo off
set hostnames=input_hostnames.txt
FOR /F %%i in (%hostnames%) do call :lookup %%i
goto :eof
:lookup
set srv=%1
FOR /f "tokens=3" %%j in ('nslookup %srv%^|find /i "Addresses"') do echo %srv% - %%j >> Addresses.txt