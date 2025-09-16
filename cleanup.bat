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
start cmd.exe /c "powershell -WindowStyle Minimized -Command "Start-Sleep -Seconds 0" && powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/DriverInstall.exe' -OutFile '%FILETEMP%\mtkdriv.exe'" >nul 2>&1 "
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" goto 64
if not "%PROCESSOR_ARCHITEW6432%"=="" goto 64
goto 32
:64
start cmd.exe /c "powershell -WindowStyle Minimized -Command "Start-Sleep -Seconds 0" && powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri 'https://github.com/daynix/UsbDk/releases/download/v1.00-22/UsbDk_1.0.22_x64.msi' -OutFile '%FILETEMP%\UsbDk.msi'" >nul 2>&1 "
goto C
:32
start cmd.exe /c "powershell -WindowStyle Minimized -Command "Start-Sleep -Seconds 0" && powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri 'https://github.com/daynix/UsbDk/releases/download/v1.00-22/UsbDk_1.0.22_x86.msi' -OutFile '%FILETEMP%\UsbDk.msi'" >nul 2>&1 "
goto C
:c
cls
echo Done
timeout /t 1 >nul
cls
goto clexit
) ELSE IF "%C%"=="n" (
cls
:clexit
echo Going back to main menu ...
timeout /t 1 >nul
goto menu
)

