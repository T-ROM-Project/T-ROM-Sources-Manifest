@echo off
cls
echo Checking if MTK Drivers already exists
if not exist "%MTKCHECk%\mtk_etw_log.exe" (
    cls
    echo MTK Drivers does not exist yet , downloading...
    goto mtkdriv
)else (
 goto reboot
)
:mtkdriv
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/DriverInstall.exe' -OutFile '%MDRI%\mtkdriv.exe'" >nul 2>&1
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/autostart.bat' -OutFile '%FILETEMP%\autostart.bat'" >nul 2>&1
echo Done 
cls
echo Starting Driver Setup...
timeout /t 2 >nul
start "" "%MDRI%\mtkdriv.exe"
:detect
cls
echo Waiting until the Driver is installed ...
echo Please finish the Setup ...
tasklist /FI "IMAGENAME eq mtkdriv.exe" | find /I "mtkdriv.exe" >nul
if %errorlevel% neq 0 (
    echo Done
    goto reboot
)
timeout /t 2 >nul
goto detect

:reboot
cls
echo Adding Autostart script ...
echo %scriptPath% %~n0%~x0> "%FILETEMP%\path.txt"
start cmd.exe /c "@echo off && echo Making final setup ... && timeout /t 2 >nul && xcopy "%FILETEMP%\T-Start.bat" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" /Y" && start cmd.exe /c "@echo off && echo Waiting until other steps are finished && timeout /t 9 && cls && echo Rebooting... && shutdown /r /t 1 "
exit
