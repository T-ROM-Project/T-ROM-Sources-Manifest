@echo off
cls
echo  Checking if MTK or the UsbDk Drivers exist ...
timeout /t 2 >nul 
if not exist "%MTKCHECK%\mtk_etw_log.exe" (
    cls
    echo MTKDRIVER: NO
    echo N >"%FILETEMP%\mtkdriv.txt"
    goto check2
)else (
    echo MTKDRIVER: YES
    echo Y >"%FILETEMP%\mtkdriv.txt"
    goto check2
)

:check2
if not exist "%USBCHECK%\UsbDk.sys" (
    echo USBDKDRIVER: NO
    echo N >"%FILETEMP%\usbdkdriv.txt"
   timeout /t 2 >nul 
   CALL "%SCRIPTS%\drivinst.bat"
   
)else (
    echo USBDKDRIVER: YES
    echo Y >"%FILETEMP%\usbdkdriv.txt"
  timeout /t 2 >nul 
  CALL "%SCRIPTS%\drivinst.bat"
)
