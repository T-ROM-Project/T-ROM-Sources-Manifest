@echo off
set "tempFile1=%FILETEMP%\mtkdriv.txt"
set "tempFile2=%FILETEMP%\usbdkdriv.txt"

for /f "usebackq delims=" %%a in ("%tempFile1%") do set "inst1=%%a"
for /f "usebackq delims=" %%a in ("%tempFile2%") do set "inst2=%%a"

set "inst1=%inst1: =%"
set "inst2=%inst2: =%"

if /i "%inst1%"=="Y" if /i "%inst2%"=="Y" goto go


if /i "%inst1%"=="Y" (
   echo MTK Drivers are installed
) else if /i "%inst1%"=="N" (
   echo MTK Drivers are not installed , installing ...
   timeout /t 2 >nul
start "" /wait "%FILETEMP%\mtkdriv.exe"
cls
echo Done
timeout /t 2 >nul
) else (
   exit
)

if /i "%inst2%"=="Y" (
   echo UsbDk Drivers are installed
) else if /i "%inst2%"=="N" (
   msiexec /i "%FILETEMP%\UsbDk.msi" /qn /norestart
cls
echo Done
timeout /t 2 >nul

) else (
  exit
)

:reboot
cls
echo Adding Autostart script and rebooting ...
echo %scriptPath% >"%FILETEMP%\path.txt"
start cmd.exe /c "powershell -WindowStyle Minimized -Command "Start-Sleep -Seconds 1" && @echo off && echo Making final setup ... && timeout /t 2 >nul && xcopy "%FILETEMP%\T-Start.bat" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" /Y" && start cmd.exe /c "@echo off && echo Waiting until other steps are finished && timeout /t 9 && cls && echo Rebooting... && shutdown /r /t 1 "
exit

:go 
CALL "%SCRIPTS%\flash.bat"
echo.

