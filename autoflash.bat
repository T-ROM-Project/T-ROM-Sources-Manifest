@echo off

cls
echo Checking if MTK Drivers already exists ...
if not exist "%MTKCHECk%\mtk_etw_log.exe" (
    cls
    echo MTK Drivers does not exist yet , installing...
    goto mtkinst
)else ( 
cls
 echo MTK Drivers already installed , going ahead...
 cls
 goto device
)

echo Checking if UsbDk Drivers already exists ...
if not exist "C:\Windows\System32\drivers\UsbDk.sys" (
    cls
    echo UsbDk Drivers does not exist , installing ...
    goto UsbDkinst
)else ( 
cls
 echo MTK Drivers already installed , going ahead...
 cls
 goto device
)

:mtkinst
cls
echo Starting Driver Setup...
timeout /t 2 >nul
start "" "%FILETEMP%\mtkdriv.exe"
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
echo %scriptPath% >"%FILETEMP%\path.txt"
start cmd.exe /c "powershell -WindowStyle Minimized -Command "Start-Sleep -Seconds 1" && @echo off && echo Making final setup ... && timeout /t 2 >nul && xcopy "%FILETEMP%\T-Start.bat" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" /Y" && start cmd.exe /c "@echo off && echo Waiting until other steps are finished && timeout /t 9 && cls && echo Rebooting... && shutdown /r /t 1 "
exit

:UsbDkinst
cls
echo Installing UsbDk Driver ...
msiexec /x "%FILETEMP%\UsbDk.msi" /qn /norestart
cls
echo Done 
timeout /t 2 >nul
echo Rebooting...
goto reboot


:device
echo Which Device do you want to flash a Custom ROM for it
echo 1. Q3e/Q5 (New Gen) MT6735
echo 2. Q3e/Q5 (Old Gen) MT6582
echo 3. Y1 (Type a)
echo 4. Y1 (Type b)
echo 5. Q8
echo 6. I dont know which version i have ? 
SET /P D=Type one option then press ENTER:
if "%D%"=="1" (
    cls
    echo d1 >"%FILETEMP%\d.txt"
    call %SCRIPTS%\flash.bat
)

if "%D%"=="2" (
    cls
echo d2 >"%FILETEMP%\d.txt"
call %SCRIPTS%\flash.bat
)

if "%D%"=="3" (
    cls
echo d3 >"%FILETEMP%\d.txt"
call %SCRIPTS%\flash.bat
)

if "%D%"=="4" (
    cls
echo d4 >"%FILETEMP%\d.txt"
call %SCRIPTS%\flash.bat
)

if "%D%"=="5" (
    cls
    echo Sorry there is no Custom Rom for the Q8 yet.
    timeout /t 3 >nul
    cls
    echo Going back to main menu ...
    goto exit
)

if "%D%"=="6" (
    cls
echo Press any Key to open a webpage to verify your Device Type / Gen ...
pause >nul
start https://timmkoomodding.carrd.co/
cls
echo Press any Key when done to return to Device Selection Menu...
pause >nul
cls
goto device
)

:exit
echo.
