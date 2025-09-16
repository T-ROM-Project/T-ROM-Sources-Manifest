@echo off
cls

:: Check if MTK Drivers exist
echo Checking if MTK Drivers already exists...
if not exist "%MTKCHECk%\mtk_etw_log.exe" (
    cls
    echo MTK Drivers does not exist yet, installing...
    goto mtkinst
) else ( 
    cls
    echo MTK Drivers already installed, continuing...
)

:: Check if UsbDk Drivers exist
echo Checking if UsbDk Drivers already exists...
if not exist "C:\Windows\System32\drivers\UsbDk.sys" (
    cls
    echo UsbDk Drivers does not exist, installing...
    goto UsbDkinst
) else ( 
    cls
    echo UsbDk Drivers already installed, continuing...
    goto device
)

:mtkinst
cls
echo Starting Driver Setup...
timeout /t 2 >nul
start "" /wait "%FILETEMP%\mtkdriv.exe"
cls
echo MTK Driver installation completed.
goto check2

:check2
cls
echo Checking if UsbDk Drivers already exists...
if not exist "C:\Windows\System32\drivers\UsbDk.sys" (
    cls
    echo UsbDk Drivers does not exist, installing...
    goto UsbDkinst
) else ( 
    cls
    echo UsbDk Drivers already installed, continuing...
    goto device
)

:UsbDkinst
cls
echo Installing UsbDk Driver...
msiexec /i "%FILETEMP%\UsbDk.msi" /qn /norestart
cls
echo UsbDk Driver installation completed.
timeout /t 2 >nul
goto device

:device
cls
echo Which Device do you want to flash a Custom ROM for?
echo 1. Q3e/Q5 (New Gen) MT6735
echo 2. Q3e/Q5 (Old Gen) MT6582
echo 3. Y1 (Type a)
echo 4. Y1 (Type b)
echo 5. Q8
echo 6. I don't know which version I have?
SET /P D=Type one option then press ENTER:

if "%D%"=="1" (
    cls
    echo d1 >"%FILETEMP%\d.txt"
    call "%SCRIPTS%\flash.bat"
    goto :eof
)

if "%D%"=="2" (
    cls
    echo d2 >"%FILETEMP%\d.txt"
    call "%SCRIPTS%\flash.bat"
    goto :eof
)

if "%D%"=="3" (
    cls
    echo d3 >"%FILETEMP%\d.txt"
    call "%SCRIPTS%\flash.bat"
    goto :eof
)

if "%D%"=="4" (
    cls
    echo d4 >"%FILETEMP%\d.txt"
    call "%SCRIPTS%\flash.bat"
    goto :eof
)

if "%D%"=="5" (
    cls
    echo Sorry there is no Custom Rom for the Q8 yet.
    timeout /t 3 >nul
    cls
    echo Going back to main menu...
    goto device
)

if "%D%"=="6" (
    cls
    echo Press any Key to open a webpage to verify your Device Type/Gen...
    pause >nul
    start "" "https://timmkoomodding.carrd.co/"
    cls
    echo Press any Key when done to return to Device Selection Menu...
    pause >nul
    cls
    goto device
)

:exit
exit /b 0
