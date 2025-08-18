:: T-ROM Project (palutenfan123) 2025 (Please do not delete this !! , Thanks  : ) )
@echo off
:Porttool
cls
echo Checking if Python is installed ...
python --version >nul 2>&1
if %errorlevel%==0 goto installedpython
cls
echo No Python installed, downloading...
powershell.exe -NoLogo -NoProfile -Command ^
    "$url = (Invoke-WebRequest -UseBasicParsing 'https://www.python.org/downloads/').Links | Where-Object { $_.href -match '/ftp/python/.*/python-.*-amd64.exe' } | Select-Object -First 1 -ExpandProperty href; Invoke-WebRequest $url -OutFile '%PYTHON_EXE%'" >nul 2>&1

cls
echo Installing Python...
start "" /wait "%PYTHON_EXE%" /quiet InstallAllUsers=1 PrependPath=1 Include_test=0 >nul 2>&1
cls
echo Deleting Python Installer resources...
del "%PYTHON_EXE%" >nul 2>&1

:: Hier restart.txt erstellen
echo 1 > "%~dp0restart.txt"

timeout /t 3 >nul
for /f "tokens=2*" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path ^| find "Path"') do set "PATH=%%B"
cls
echo Continue...
timeout /t 3 >nul
:installedpython
cls
echo Python is installed.
timeout /t 3 >nul
CALL "%SCRIPTS%\dlhelper.bat"
