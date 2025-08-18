:: T-ROM Project (palutenfan123) 2025 (Please do not delete this !! , Thanks  : ) )
@echo off
cls 
echo Downloading Porttool and resources ...
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri 'https://github.com/NoahDomingues/MTK-ROM-Porter/releases/download/v1.0/MTK.ROM.Porter.exe' -OutFile '%PORT%\Porttool.exe'" >nul 2>&1
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri 'https://dl.timmkoo.de/trom/res/system.img' -OutFile '%SYS%'" >nul 2>&1
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri 'https://dl.timmkoo.de/trom/res/boot.img' -OutFile '%BOOT%'" >nul 2>&1
cls
echo Done
timeout /t 2 >nul
cls
echo Starting Auto Porttool ...
start "" "%PORT%\Porttool.exe"
echo system.img = %SYS%
echo boot.img = %BOOT%
echo Mode : Replace Kernel only (Recommended for Timmkoo)
echo Output : As IMG File 
echo Kernel : 3.10.54
echo Chipset : MT6582
echo The Custom ROM needs to be the exact kernel and Chipset displayed above (Only when porting for Timmkoo Oldgen)
echo The Settings when porting for Timmkoo Must be exact as above displayed
pause
