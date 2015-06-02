@echo off
cd ./bin
if exist rorserver.exe ( 
	rorserver.exe -config "../settings/server.cfg" -lan
) else (
	echo.
	echo.
	echo.
	echo.
	echo.
	echo.
	echo  ##############################################################################
	echo  ##                                                                          ##
	echo  ##                     File 'rorserver.exe' is missing.                     ##
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
)
cd ..
pause