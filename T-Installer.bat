:: T-ROM Project (palutenfan123) 2025 (Please do not delete this !! , Thanks  : ) )
@echo off
cls

:: Extra parameter check ;)
if "%~1"=="" (
    goto parampass
)

if /i "%~1"=="-c" (
    echo.
    goto c
)

:c
if "%~2"=="" (
    goto parampass
)

if /i "%~2"=="r" (
    if "%~3"=="" (
        echo Missing parameters
        pause
        exit /b
    )
    echo r
)

if /i "%~2"=="u" (
    if "%~3"=="" (
        echo Missing parameters
        pause
        exit /b
    ) else if "%~3"=="b" (
        if "%~4"=="" (
            echo Missing parameters
            pause
            exit /b
        ) else (
            echo Unpacking...
            pause
        )
    ) else if "%~3"=="s" (
        if "%~4"=="" (
            echo Missing parameters
            pause
            exit /b
        ) else (
            echo Unpacking...
            pause
        )
    ) else (
        echo Wrong parameters
        pause
        exit /b
    )
)

if /i "%~2"=="repack" (
    if "%~3"=="" (
        echo Missing parameters
        pause
        exit /b
    )
    echo repack
)

if /i "%~2"=="unpack" (
    if "%~3"=="" (
        echo Missing parameters
        pause
        exit /b
    ) else if "%~3"=="b" (
        if "%~4"=="" (
            echo Missing parameters
            pause
            exit /b
        ) else (
            echo Unpacking...
            pause
        )
    ) else if "%~3"=="s" (
        if "%~4"=="" (
            echo Missing parameters
            pause
            exit /b
        ) else (
            echo Unpacking...
            pause
        )
    ) else (
        echo Wrong parameters
        pause
        exit /b
    )
)

if /i "%~2"=="s" (
    if "%~3"=="short" (
        if "%~4"=="r" (
            echo Removing shortcode ...
            attrib.exe -s -h -r "%userprofile%\desktop\mtk.lnk"
            del "%userprofile%\desktop\mtk.lnk"
            echo Done
            pause
            exit /b
        ) else (
            echo Adding short cmd name..
            powershell -NoLogo -NoProfile -Command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%USERPROFILE%\Desktop\mtk.lnk');$s.TargetPath='%~f0';$s.Save()"
            attrib.exe +h +s "%userprofile%\desktop\mtk.lnk"
            echo Done
            echo You can now use the Shortname mtk in cmd on desktop: start mtk -c examplecommand
            pause
            exit /b
        )
    ) else (
        echo Making shortcut to desktop...
        powershell -NoLogo -NoProfile -Command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%USERPROFILE%\Desktop\T-Installer.lnk');$s.TargetPath='%~f0';$s.Save()"
        echo Done
        pause
        exit /b
    )
)

if /i "%~2"=="shortcut" (
    if "%~3"=="short" (
        if "%~4"=="r" (
            echo Removing shortcode ...
            attrib.exe -s -h -r "%userprofile%\desktop\mtk.lnk"
            del "%userprofile%\desktop\mtk.lnk"
            echo Done
            pause
            exit /b
        ) else (
            echo Adding short cmd name..
            powershell -NoLogo -NoProfile -Command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%USERPROFILE%\Desktop\mtk.lnk');$s.TargetPath='%~f0';$s.Save()"
            attrib.exe +h +s "%userprofile%\desktop\mtk.lnk"
            move "%USERPROFILE%\Desktop\mtk.lnk" "C:\Windows\mtk.lnk"
            echo Done
            echo You can now use the Shortname mtk in cmd: start mtk -c examplecommand
            pause
            exit /b
        )
    ) else (
        echo Making shortcut to desktop...
        powershell -NoLogo -NoProfile -Command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%USERPROFILE%\Desktop\T-Installer.lnk');$s.TargetPath='%~f0';$s.Save()"
        echo Done
        pause
        exit /b
    )
)

if /i "%~2"=="d" (
    if "%~3"=="" (
        echo Missing parameters
        pause
        exit /b
    )
    echo d
)

if /i "%~2"=="download" (
    if "%~3"=="" (
        echo Missing parameters
        pause
        exit /b
    )
    echo download
)

if /i "%~2"=="updatesucess" (
    if "%~3"=="" (
        echo Missing parameters
        pause
        exit /b
    ) else (
    echo Sucessfully updated from %~3 to the latest Version
    timeout /t 2 >nul
    cls
    echo Skipping update check ...
    goto updatefinished
    )
)

if /i "%~2"=="i" (
    if "%~3"=="" (
        echo Missing parameters
        pause
        exit /b
    )
    echo i
)

if /i "%~2"=="update" (
    :newver
    echo Downloading newer Version of T-Installer ...
    powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri 'https://github.com/T-ROM-Project/T-ROM-Sources-Manifest/raw/refs/heads/main/T-Installer.bat' -OutFile '%~dp0\T-Installer.bat'" >nul 2>&1
    cls
    echo Done
    timeout /t 2 >nul
    cls
    echo Restarting ...
    attrib.exe -s -h -r "%VERCHECK%"
    attrib.exe -s -h -r "%CHANGELOG%"
    del "%VERCHECK%"
    del "%CHANGELOG%"
    set scriptPath=%~dp0
    start cmd.exe /c "powershell -WindowStyle Minimized -Command "Start-Sleep -Seconds 0" && timeout /t 3 >nul && start %scriptPath%T-Installer.bat -c updatesucess %VER%"
    exit
)


:updatefinished
:parampass
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
:: Start of the main Script
setlocal
setlocal EnableDelayedExpansion
:: Version of the script
set "VER=2.0"
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
set "VERCHECK=%ROOT%\versioncheck.txt"
set "CHANGELOG=%ROOT%\changelog.txt"
set "disclaimercheckdir=%appdata%\T-Installer"
set "disclaimercheck=%disclaimercheckdir%\Accept.txt"
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
if not exist "%ROOT%" (
    cls
    goto updatecheckpass
)
 :: Update mechanism start 

echo Checking for Updates...
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/last_version.txt' -OutFile '%VERCHECK%'" >nul 2>&1
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/last_changes.txt' -OutFile '%CHANGELOG%'" >nul 2>&1
attrib.exe +h +s "%VERCHECK%"
attrib.exe +h +s "%CHANGELOG%"
set /p filecontent=<%CHANGELOG%
set "INFO=%filecontent%"
if not exist "%VERCHECK%" (
    echo Please Check your internet connection !!
    echo T-Installer cant check for updates without Internet
pause && exit /b


for /f "delims=" %%A in (%VERCHECK%) do set "version=%%A"

if "%VER%" NEQ "%version%" (
    cls
    echo New Update availible
    echo This Version: %VER%
    echo New Version: %version%
    echo CHANGELOG :
    echo %INFO%
    timeout /t 5 >nul
    goto newver
) else (
    cls
    echo No new Updates
)
attrib.exe -s -h -r "%VERCHECK%"
attrib.exe -s -h -r "%CHANGELOG%"
del "%VERCHECK%"
del "%CHANGELOG%"
)
:updatecheckpass
timeout /t 2 >nul
: Update mechanism end
cls
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
if not exist "%disclaimercheck%" ( powershell.exe -c "mkdir '%disclaimercheckdir%'" >nul 2>&1 ) 
if exist "%disclaimercheck%" ( goto bootup ) 
    color 4

    echo I am NOT RESPONSIBLE for your actions.
    echo I am NOT RESPONSIBLE for bricked devices, dead SD cards, thermonuclear war.
    echo YOU are choosing to make these modifications, and if you point the finger at me for messing up your device, I will laugh at you.
    echo.
    set /p "disclaimer=Do you understand ? (y/n): "

    if /i "%disclaimer%"=="n" (
        echo You do not agree to the Disclaimer. Closing Script.
        goto exit
    )

    :: Save acceptance
    echo SAVED
    timeout /t 5 >nul
    echo Accepted the Disclaimer>"%disclaimercheck%"

cls
:bootup
color 6
echo Booting up...
if not exist %ROOT% (
powershell.exe -c "mkdir '%ROOT%'"    >nul 2>&1
)
if not exist %RES% (
powershell.exe -c "mkdir '%RES%'"     >nul 2>&1
)
if not exist %TOOLS% (
powershell.exe -c "mkdir '%TOOLS%'"   >nul 2>&1
)
if not exist %SCRIPTS% (
powershell.exe -c "mkdir '%KITCHEN%'" >nul 2>&1
)
if not exist %FTOOL% (
powershell.exe -c "mkdir '%FTOOL%'"   >nul 2>&1
)
if not exist %PORT% (
powershell.exe -c "mkdir '%PORT%'"    >nul 2>&1
)
if not exist %SCRIPTS% (
powershell.exe -c "mkdir '%SCRIPTS%'"    >nul 2>&1
)
if not exist %FILETEMP% (
powershell.exe -c "mkdir '%FILETEMP%'"    >nul 2>&1
)
if not exist %SCRCPY% (
powershell.exe -c "mkdir '%SCRCPY%'"    >nul 2>&1
)
if not exist %MTKCLI% (
powershell.exe -c "mkdir '%MTKCLI%'"    >nul 2>&1
)
attrib.exe +h +s "%SCRIPTS%"
attrib.exe +h +s "%FILETEMP%"
timeout /t 2 >nul
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


