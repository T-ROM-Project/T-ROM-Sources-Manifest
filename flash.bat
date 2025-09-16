@echo off
cls
set tempFile1=%FILETEMP%\d.txt
echo Setting symlink up ...
mklink "%SystemRoot%\System32\python3.exe" "C:\Program Files\Python313\python.exe"
timeout /t 3 >nul
cls
echo Downloading extra resources ...
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri 'https://github.com/bkerler/mtkclient/archive/refs/heads/main.zip' -OutFile '%FILETEMP%\mtkclient.zip'" >nul 2>&1
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri 'https://spflashtools.com/wp-content/uploads/SP_Flash_Tool_v5.1924_Win.zip' -OutFile '%FILETEMP%\ftool.zip'" >nul 2>&1
cls
echo Done
timeout /t 3 >nul
cls
echo Extracting extra resources ...
powershell.exe -c "Expand-Archive -Path '%FILETEMP%\mtkclient.zip' -DestinationPath '%MTKCLI%' -Force"
powershell.exe -c "Expand-Archive -Path '%FILETEMP%\ftool.zip' -DestinationPath '%FTOOL%' -Force"
cls
echo Done
timeout /t 3 >nul
echo Setting mtkclient up ...
cd %MTKCLI%\mtkclient-main
pip3 install -r requirements.txt
cd %ROOT%
