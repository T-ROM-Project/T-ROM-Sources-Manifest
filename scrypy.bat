@echo off
cls
echo Checking if scrcpy already exists ...

if not exist "%SCRCPY%\scrcpy.exe" (
    cls
    echo scrcpy does not exist yet , downloading...
    goto notexist
)else (
 goto exist
)
:notexist
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
echo Plug in your Timmkoo to your Computer now , press any key when done ...
pause >nul
cls 
echo done 
timeout /t 2 >nul
echo Extracting scrcpy ...
powershell.exe -c "Expand-Archive -Path '%FILETEMP%\scrcpy.zip' -DestinationPath '%SCRCPY%' -Force"
echo Done 
:exist
cls
timeout /t 2 >nul
echo Please go into settings / about device  then tap the build number until it says "You are now a developer"
echo Then go back and open Developer Settings and enable usb debuging
echo Press any key when you have done this steps ...
pause >nul
echo Running adb connect command...
cd %SCRCPY%
cls
echo Please click on enable press any key when enabled on your Computer ...
adb devices 
pause >nul
cls
echo Starting scrcpy%PROCESSOR_ARCHITECTURE%.exe ...
timeout /t 2 >nul
start "" "%SCRCPY%\scrcpy.exe"
:detect
cls
echo This script detects when its closed and goes straight to main menu
tasklist /FI "IMAGENAME eq scrcpy.exe" | find /I "scrcpy.exe" >nul
if %errorlevel% neq 0 (
    echo Closed! Back to main menu...
    goto closed
)
timeout /t 2 >nul
goto detect

:closed
cls
echo Closing service worker ...
taskkill /F /IM adb.exe
cd %USERPROFILE%
echo done
cls


