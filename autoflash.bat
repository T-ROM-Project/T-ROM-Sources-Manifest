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

echo %scriptPath% >path.txt
start cmd.exe /c "timeout /t 2 & xcopy %FILETEMP%\autostart.bat \"%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" /Y && xcopy \"%USERPROFILE%\path.txt\" \"%FILETEMP%\" /Y && shutdown /r"
exit

