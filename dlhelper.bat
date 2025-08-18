:: T-ROM Project (palutenfan123) 2025 (Please do not delete this !! , Thanks  : ) )
@echo off
if exist "%~dp0restart.txt" (
    set /p RESTARTFLAG=<"%~dp0restart.txt"
    if "%RESTARTFLAG%"=="1" (
        echo Restart required. Relaunching as admin...
        del "%~dp0restart.txt" >nul 2>&1
        :: Relaunch the current script as admin
        powershell -Command "Start-Process -FilePath '%~f0' -Verb runAs"
        exit /b
    )
)

cls
echo Checking if porttool already exists ...

if not exist "%PORT%\Porttool.exe" (
    cls
    echo Porttool does not exist yet , downloading...
    powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri 'https://github.com/NoahDomingues/MTK-ROM-Porter/releases/download/v1.0/MTK.ROM.Porter.exe' -OutFile '%PORT%\Porttool.exe'" >nul 2>&1
    if not exist "%PORT%\Porttool.exe" (
        echo  Failed to download Porttool.
        pause
        exit /b 1
    )
    echo Done
)

if not exist "%SYS%" if not exist "%BOOT%" (
    echo.
    set /p CHOICE="Do you want to use the default T-ROM system.img and boot.img? (Y/N): "
    if /i "!CHOICE!"=="Y" (
        echo Downloading system.img ...
        powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri 'https://dl.timmkoo.de/trom/res/system.img' -OutFile '%SYS%'" >nul 2>&1
        cls
        echo Downloading boot.img ...
        powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri 'https://dl.timmkoo.de/trom/res/boot.img' -OutFile '%BOOT%'" >nul 2>&1

        if not exist "%SYS%" (
            echo Failed to download system.img!
            pause
            exit /b 1
        )
        if not exist "%BOOT%" (
            echo Failed to download boot.img!
            pause
            exit /b 1
        )
        echo Done.
    ) else (
        echo Using your own system.img and boot.img.
    )
)

cls
echo Done.
timeout /t 2 >nul
cls
echo Starting Auto Porttool ...
start "" "%PORT%\Porttool.exe"
timeout /t 5 >nul
cls
:detect
cls
echo system.img = %SYS%
echo boot.img   = %BOOT%
echo Mode    : Replace Kernel only (Recommended for Timmkoo)
echo Output  : As IMG File 
echo Kernel  : 3.10.54
echo Chipset : MT6582
echo.
echo The Custom ROM needs to match the kernel and chipset above (Timmkoo Oldgen).
echo Settings must be exactly as displayed.
echo This script detects when its closed and goes straight to main menu
tasklist /FI "IMAGENAME eq python.exe" | find /I "python.exe" >nul
if %errorlevel% neq 0 (
    echo Closed! Back to main menu...
    goto closed
)
timeout /t 2 >nul
goto detect

:closed
echo Done...
cls



