:: T-ROM Project (palutenfan123) 2025 (Please do not delete this !! , Thanks  : ) )
@echo off
echo Setting things up ...
powershell.exe -NoLogo -NoProfile -WindowStyle Hidden -Command ^
    "Start-Process powershell.exe -ArgumentList 'Add-MpPreference -ExclusionPath \"%KITCHEN%"' -Verb RunAs"

powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%/mio.bat' -OutFile '%SCRIPTS%\kitchen.bat'" >nul 2>&1
:
https://github.com/ColdWindScholar/MIO-KITCHEN-SOURCE/releases/download/CI_BUILD_489/MIO-KITCHEN-4.1.3-win.zip