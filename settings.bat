@echo off
echo TTTTTTT   RRRRRR   OOOOOO   M     M  
echo    T      R     R  O    O   MM   MM  
echo    T      RRRRRR   O    O   M M M M  
echo    T      R   R    O    O   M  M  M  
echo    T      R    R   OOOOOO   M     M  
echo ===============================================================
echo                      T-Installer %VER%
echo ===============================================================
echo                         Settings
echo ===============================================================
echo %NOCONFIG%
echo ===============================================================
echo                       Experimental
echo ===============================================================
echo 1 Enable experimental Choices (Not Recommended for Normal Users)
echo 2 Disable experimental Choices 
SET /P S=Type one option then press ENTER:
IF "%M%"=="1" (
    echo SAVED
    echo ENABLED>"%expermimentalset%"
    goto exit
)
IF "%M%"=="2" (
    echo SAVED
    del "%expermimentalset%"
    goto exit
)
:exit 
echo.