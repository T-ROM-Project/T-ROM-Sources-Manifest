:: T-ROM Project (palutenfan123) 2025 (Please do not delete this !! , Thanks  : ) )
@echo off
cls
:: Requesting admin rights
:-------------------------------------
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:: Admin rights request finished
:: Making Open it in Fullscreen
powershell -WindowStyle Maximized -Command "Start-Sleep -Seconds 1"
:: Start of Script
setlocal
setlocal EnableDelayedExpansion
:: Version of the script
set "VER=1.7"
:: Filepaths (If anyone wants to change it)
set "ROOT=%USERPROFILE%\Desktop\trom"
set "RES=%ROOT%\res"
set "TOOLS=%ROOT%\tools"
set "SYS=%RES%\system.img"
set "BOOT=%RES%\boot.img"
set "KITCHEN=%TOOLS%\Kitchen"
set "FTOOL=%TOOLS%\Flashtool"
set "PORT=%TOOLS%\Porttool"
set "MDRI=%RES%\Driver"
set "PYTHON_EXE=%FILETEMP%\python-latest.exe"
set "SCRIPTS=%ROOT%\scripts"
set "FILETEMP=%ROOT%\temp"
set "BASEURL=https://github.com/T-ROM-Project/T-ROM-Sources-Manifest/raw/refs/heads/main"
set "SCRCPY=%TOOLS%\scrpy"
set "MTKCHECK=C:\Program Files\MediaTek\SP Driver\Tools"
set "USBCHECK=C:\Windows\System32\drivers"
set scriptPath=%~dp0
set "AUTOSTART=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"
set "MTKCLI=%TOOLS%\mtkcli"
set "DEVICE=%FILETEMP%\d.txt"
set "YEAR=%FILETEMP%\y.txt"
set  "RP=%FILETEMP%\RP.hta"
set "MTKCLIOUT=%MTKCLI%\mtkclient-main\output"
:: Checking for Flags
if not exist "%ROOT%\!deletemewhenrel.txt" (
    cls
    goto check2e
)else (
 cls
 echo Test mode , skipping downloading...
 timeout /t 5 >nul
 goto testmd
)
:check2e

if not exist "%AUTOSTART%\T-Start.bat" (
    cls
    goto continue
)else (
 cls
 echo Autostart Helper detected , removing...
 timeout /t 5 >nul
 del "%AUTOSTART%\T-Start.bat"
 cls
 echo Starting autoflash.bat to continue ...
timeout /t 2 >nul
CALL "%SCRIPTS%\autoflash.bat"
)
::Check Done...
:continue
:: >Boot Startup Logo
echo TTTTTTT   RRRRRR   OOOOOO   M     M  
echo    T      R     R  O    O   MM   MM  
echo    T      RRRRRR   O    O   M M M M  
echo    T      R   R    O    O   M  M  M  
echo    T      R    R   OOOOOO   M     M  
echo ====================================
echo T-Installer %VER%
echo ====================================
timeout /t 5 >nul
:: Disclaimer
cls
color 4
echo I am NOT RESPONSABLE for your actions.
echo I am NOT RESPONSABLE for bricked devices, dead SD cards, thermonuclear war.
echo YOU are choosing to make these modifications, and if you point the finger at me for messing up your device, I will laugh at you
set /p disclaimer=Do you understand ? (y/n):

if /i "%disclaimer%"=="n" (
    echo You do not agree to the Disclaimer. Closing Script.
    goto exit
)
:: Making Filesystem for Multitool
cls
color 6
echo Booting up...
powershell.exe -c "mkdir '%ROOT%'"    >nul 2>&1
powershell.exe -c "mkdir '%RES%'"     >nul 2>&1
powershell.exe -c "mkdir '%TOOLS%'"   >nul 2>&1
powershell.exe -c "mkdir '%KITCHEN%'" >nul 2>&1
powershell.exe -c "mkdir '%FTOOL%'"   >nul 2>&1
powershell.exe -c "mkdir '%PORT%'"    >nul 2>&1
powershell.exe -c "mkdir '%SCRIPTS%'"    >nul 2>&1
powershell.exe -c "mkdir '%FILETEMP%'"    >nul 2>&1
powershell.exe -c "mkdir '%SCRCPY%'"    >nul 2>&1
powershell.exe -c "mkdir '%MTKCLI%'"    >nul 2>&1
::attrib.exe +h +s "%SCRIPTS%"
::attrib.exe +h +s "%FILETEMP%"
cls
echo Downloading Resources...
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/porttool.bat' -OutFile '%SCRIPTS%\porttool.bat'" >nul 2>&1
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/dlhelper.bat' -OutFile '%SCRIPTS%\dlhelper.bat'" >nul 2>&1
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/kitchen.bat' -OutFile '%SCRIPTS%\kitchen.bat'" >nul 2>&1
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/mio.bat' -OutFile '%SCRIPTS%\mio.bat'" >nul 2>&1
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/scrypy.bat' -OutFile '%SCRIPTS%\scrypy.bat'" >nul 2>&1
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/credits.bat' -OutFile '%SCRIPTS%\credits.bat'" >nul 2>&1
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/autoflash.bat' -OutFile '%SCRIPTS%\autoflash.bat'" >nul 2>&1
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/autostart.bat' -OutFile '%FILETEMP%\autostart.bat'" >nul 2>&1
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/T-Start.bat' -OutFile '%FILETEMP%\T-Start.bat'" >nul 2>&1
if not exist "%FILETEMP%\mtkdriv.exe" (
    powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/DriverInstall.exe' -OutFile '%FILETEMP%\mtkdriv.exe'" >nul 2>&1
    goto Driverexist
)else (
goto Driverexist 
)
:Driverexist
if not exist "%FILETEMP%\UsbDk.msi" (
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" goto 64
if not "%PROCESSOR_ARCHITEW6432%"=="" goto 64
goto 32
:64
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri 'https://github.com/daynix/UsbDk/releases/download/v1.00-22/UsbDk_1.0.22_x64.msi' -OutFile '%FILETEMP%\UsbDk.msi'" >nul 2>&1 
goto z
:32
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri 'https://github.com/daynix/UsbDk/releases/download/v1.00-22/UsbDk_1.0.22_x86.msi' -OutFile '%FILETEMP%\UsbDk.msi'" >nul 2>&1 
goto z
:z
goto Driverexist1
)else (
goto Driverexist1 
)
:Driverexist1
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/cleanup.bat' -OutFile '%SCRIPTS%\cleanup.bat'" >nul 2>&1
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/drivinst.bat' -OutFile '%SCRIPTS%\drivinst.bat'" >nul 2>&1
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/flash.bat' -OutFile '%SCRIPTS%\flash.bat'" >nul 2>&1
cls
:testmd
echo Done
timeout /t 1 >nul
:main
cls
color f
echo TTTTTTT   RRRRRR   OOOOOO   M     M  
echo    T      R     R  O    O   MM   MM  
echo    T      RRRRRR   O    O   M M M M  
echo    T      R   R    O    O   M  M  M  
echo    T      R    R   OOOOOO   M     M  
echo ===============================================================
echo                      T-Installer %VER%
echo ===============================================================
echo                         Options
echo ===============================================================
echo 1 Multi Android Kitchen Tool (For advanced Users and Developers)
echo ===============================================================
echo 2 Auto Porttool (For advanced Users amd Developers)
echo ===============================================================
echo 3 Scrypy (A Tool to mirror you screen from your modded Timmkoo to your Computer via usb)
echo ===============================================================
echo 4 Auto Timmkoo Custom Rom Flasher (For new users recommended)
echo ===============================================================
echo 5
echo ===============================================================
echo 6 Full 
echo ===============================================================
echo 7 Exit 
echo ===============================================================
echo 8 Clean temp files
echo ===============================================================
echo 9 Credits
echo ===============================================================
echo 10 Exit 
echo ===============================================================
SET /P M=Type one option then press ENTER:
IF "%M%"=="1" (
    cls
    CALL "%SCRIPTS%\kitchen.bat"
    GOTO main
) ELSE IF "%M%"=="2" (
    cls
    CALL "%SCRIPTS%\porttool.bat"
    GOTO main
) ELSE IF "%M%"=="3" (
    cls
    CALL "%SCRIPTS%\scrypy.bat"
    GOTO main
) ELSE IF "%M%"=="4" (
    cls
    CALL "%SCRIPTS%\autoflash.bat"
    GOTO main
) ELSE IF "%M%"=="5" (
    cls
    CALL "%SCRIPTS%\service4.bat"
    GOTO main
) ELSE IF "%M%"=="6" (
    cls
    CALL "%SCRIPTS%\service5.bat"
    GOTO main
) ELSE IF "%M%"=="7" (
    cls
    CALL "%SCRIPTS%\service6.bat"
    GOTO main
) ELSE IF "%M%"=="8" (
    cls
    CALL "%SCRIPTS%\cleanup.bat"
    GOTO main
) ELSE IF "%M%"=="9" (
    cls
    CALL "%SCRIPTS%\credits.bat"
    GOTO main
) ELSE IF "%M%"=="10" (
    EXIT
) ELSE (
    cls
    color 4
    echo Unknown Answer. Try Again
    timeout /t 1 >nul
    GOTO main
)


