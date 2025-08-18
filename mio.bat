:: T-ROM Project (palutenfan123) 2025 (Please do not delete this !! , Thanks  : ) )
@echo off
echo Setting Windows Defender up ...
powershell.exe -NoLogo -NoProfile -WindowStyle Hidden -Command ^
    "Start-Process powershell.exe -ArgumentList 'Add-MpPreference -ExclusionPath \"%KITCHEN%"' -Verb RunAs"

powershell.exe -NoLogo -NoProfile -WindowStyle Hidden -Command ^
    "Start-Process powershell.exe -ArgumentList 'Add-MpPreference -ExclusionPath \"%FILETEMP%"' -Verb RunAs"

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
python tool.py

