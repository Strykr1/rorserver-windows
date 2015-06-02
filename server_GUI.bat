@echo off
cd ./bin
if exist servergui.exe ( 
	start servergui.exe
) else (
	echo.
	echo.
	echo.
	echo.
	echo.
	echo.
	echo  ##############################################################################
	echo  ##                                                                          ##
	echo  ##                     File 'servergui.exe' is missing.                     ##
	echo  ##                                                                          ##
	echo  ## Please download it from http://sourceforge.net/projects/rorserver/files/ ##
	echo  ##            and extract the archive inside the 'bin' directory.           ##
	echo  ##                                                                          ##
	echo  ##############################################################################
	echo.
	echo.
	echo.
	echo.
	echo.
	echo.
	echo.
	echo.
	echo.
	echo.
	pause
)
cd ..