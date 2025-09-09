@echo off
:clean
cls
echo Do you want to clean temponary files (y/n)
SET /P C=Type one option then press ENTER:
IF "%C%"=="y" (
cls
echo Cleaning temp files ...
del %FILETEMP%
start cmd.exe /c "powershell -WindowStyle Minimized -Command "Start-Sleep -Seconds 0" && powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/T-Start.bat' -OutFile '%FILETEMP%\T-Start.bat'" >nul 2>&1"
timeout /t 1 >nul
cls
echo Done
cls
goto clexit
) ELSE IF "%C%"=="n" (
cls
:clexit
echo Going back to main menu ...
timeout /t 1 >nul
goto menu
)
:menu
echo.
