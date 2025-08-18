:: T-ROM Project (palutenfan123) 2025 (Please do not delete this !! , Thanks  : ) )
@echo off
set /p CHOICE="Do you want to exclude Mio Kitchen folders from Windows Defender? (Y/N): "

if /i "%CHOICE%"=="Y" (
    cls
    echo Adding Defender exclusions...

    powershell.exe -NoLogo -NoProfile -Command ^
        "Start-Process powershell.exe -ArgumentList 'Add-MpPreference -ExclusionPath \"\"%KITCHEN%\"\"; Add-MpPreference -ExclusionPath \"\"%FILETEMP%\"\"' -Verb RunAs -Wait"

    echo.
    echo Exclusions added successfully 
) else (
    cls
    echo Operation canceled by user.
    timeout /t 2 >nul
    goto exit
)

cls
echo done 
timeout /t 2 >nul
cls
echo Downloading Kitchen...
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri 'https://github.com/ColdWindScholar/MIO-KITCHEN-SOURCE/releases/download/CI_BUILD_489/MIO-KITCHEN-4.1.3-win.zip' -OutFile '%FILETEMP%\kitchen.zip'" >nul 2>&1
cls
echo done
timeout /t 2 >nul
echo Extracting Kitchen...
powershell.exe -c "Expand-Archive -Path '%FILETEMP%\kitchen.zip' -DestinationPath '%KITCHEN%' -Force"
cls 
echo done
timeout /t 2 >nul
echo Setting Python up ...
cd %KITCHEN%
python -m pip install -U --force-reinstall pip
pip install -r requirements.txt
echo Done 
timeout /t 2 >nul
echo Starting Multi Android Kitchen ...
cd %ROOT%
start "" "%KITCHEN%\tool.exe"
:exit 
echo.

