@echo off
cls
echo Setting symlink up ...
mklink "%SystemRoot%\System32\python3.exe" "C:\Program Files\Python313\python.exe"
timeout /t 3 >nul
cls
echo Downloading and extracting extra resources ...
if not exist "%MTKCLI%\mtkclient-main\mtk.py" (
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri 'https://github.com/bkerler/mtkclient/archive/refs/heads/main.zip' -OutFile '%FILETEMP%\mtkclient.zip'" >nul 2>&1   
powershell.exe -c "Expand-Archive -Path '%FILETEMP%\mtkclient.zip' -DestinationPath '%MTKCLI%' -Force"
goto bridge
)else (
powershell.exe -c "mkdir '%MTKCLIOUT%'"    >nul 2>&1
goto bridge
)
:bridge
if not exist "%FTOOL%\SP_Flash_Tool_v5.1924_Win\flash_tool.exe" (
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri 'https://spflashtools.com/wp-content/uploads/SP_Flash_Tool_v5.1924_Win.zip' -OutFile '%FILETEMP%\ftool.zip'" >nul 2>&1
powershell.exe -c "Expand-Archive -Path '%FILETEMP%\ftool.zip' -DestinationPath '%FTOOL%' -Force"
goto lol
)else (
goto lol
)
:lol
powershell.exe -NoLogo -NoProfile -Command "Invoke-WebRequest -Uri '%BASEURL%\RP.hta' -OutFile '%FILETEMP%\RP.hta'" >nul 2>&1
cls
echo Done
timeout /t 3 >nul
cls
echo Setting mtkclient up ...
cd %MTKCLI%\mtkclient-main
pip3 install -r requirements.txt
cls
echo Done 
timeout /t 2 >nul
cls 
echo Which Device do you want to flash ?
echo ___________________________________
echo 1 Timmkoo Q5/Q3e 
echo 2 Timmkoo Q8
echo 3 Innioasis Y1
echo 4 Innioasis G1/G3
echo -----------------------------------
SET /P D=Type one option then press ENTER:
IF "%D%"=="1" (
    cls
    echo Q5/Q3E>"%DEVICE%"
    goto mtkbp
) ELSE IF "%D%"=="2" (
    cls
    echo Q8>"%DEVICE%"
    goto mtkbp
) ELSE IF "%D%"=="3" (
    cls
    echo Y1>"%DEVICE%"
    goto mtkbp
) ELSE IF "%D%"=="4" (
    cls
    echo G1/G3>"%DEVICE%"
    goto mtkbp
) 

:mtkbp
set /p DNAME=<%DEVICE%
cls
echo Backing up your %DNAME% firmware ... 
start cmd.exe /c "mshta.exe "%RP%""
echo Plug in your %DNAME% now and find the reset pin based on the info tab that opened right now  
echo Then push the reset pin ...
python3 mtk.py rl output
pause 
