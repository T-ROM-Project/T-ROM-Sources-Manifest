@echo off
cls
echo Detecting processor architecture ...
timeout /t 2 >nul
cls
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" goto 64
if not "%PROCESSOR_ARCHITEW6432%"=="" goto 64
goto 32

:64
echo 64 bit architecture detected
timeout /t 2 >nul
cls
echo Downloading scrcpy 64 bit ...
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/scrcpy64.zip' -OutFile '%FILETEMP%\scrcpy.zip'" >nul 2>&1
goto extract

:32
echo 32 bit architecture detected
timeout /t 2 >nul
cls
echo Downloading scrcpy 32 bit ...
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/scrcpy32.zip' -OutFile '%FILETEMP%\scrcpy.zip'" >nul 2>&1
goto extract

:extract
cls 
echo done 
timeout /t 2 >nul
echo Extracting scrcpy ...
powershell.exe -c "Expand-Archive -Path '%FILETEMP%\scrcpy.zip' -DestinationPath '%SCRCPY%' -Force"
echo Done 
timeout /t 2 >nul
echo Please go into settings / about device  then tap the build number until it says You are now a developer
echo Then go back and open Developer Settings and enable usb debuging
echo Press any key when you have done this steps ...
pause
echo Running adb test command...
cd %SCRCPY%
adb reboot
pause
:scrcpy
start "" "%SCRCPY%\scrcpy.exe"

