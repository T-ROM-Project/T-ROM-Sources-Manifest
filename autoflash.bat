@echo off

cls
echo Checking if MTK Drivers already exists
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

)

if "%D%"=="2" (
    cls

)

if "%D%"=="3" (
    cls

)

if "%D%"=="4" (
    cls

)

if "%D%"=="5" (
    cls

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


