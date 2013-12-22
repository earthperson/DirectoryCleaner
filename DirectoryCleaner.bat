@ECHO OFF
CLS

REM ----------------------------------------------------------------------
REM Copyright (c) 2009 Dmitry Ponomarev (e-mail: ponomarev.dev@gmail.com)
REM ----------------------------------------------------------------------

TITLE DirectoryCleaner. Copyright (c) 2009 Dmitry Ponomarev (e-mail: ponomarev.dev@gmail.com)

SET DIRECTORY=%temp%

ECHO Opening directory %DIRECTORY%...
CD /D %DIRECTORY% || GOTO FAILOPENDIR

:AMOUNT
SET NUMBER_OF_ENTITIES=0
FOR /D %%i IN (*) DO SET /A NUMBER_OF_ENTITIES=NUMBER_OF_ENTITIES+1
FOR %%i IN (*) DO SET /A NUMBER_OF_ENTITIES=NUMBER_OF_ENTITIES+1
IF %NUMBER_OF_ENTITIES% GTR 0 (
	GOTO LIST
) ELSE (
	ECHO Directory empty
	GOTO END
)

:LIST
ECHO Directory contents:
ECHO.
DIR /B /O:N
ECHO.

:ACTION
ECHO Do you really want to remove %NUMBER_OF_ENTITIES% entities [Y/n]%?
SET /P CONFIRMATION=
IF /I "%CONFIRMATION%"=="y" (
	GOTO PROCESS
) ELSE (
	GOTO IMMEDIATE_END
)

:PROCESS
CLS
ECHO Do...
SET REMOVED_DIRS=0
SET REMOVED_FILES=0
FOR /D %%i IN (*) DO (
	IF "%~nx0" NEQ "%%i" (
		RD /S /Q "%%i" && SET /A REMOVED_DIRS=REMOVED_DIRS+1
	)
)
FOR %%i IN (*) DO (
	IF "%~nx0" NEQ "%%i" (
		DEL /F /Q "%%i" && SET /A REMOVED_FILES=REMOVED_FILES+1
	)
)
SET /A TOTAL_REMOVED=REMOVED_DIRS+REMOVED_FILES
CLS
ECHO Done.
ECHO Removed directories: %REMOVED_DIRS%; removed files: %REMOVED_FILES%; total removed: %TOTAL_REMOVED%.
GOTO AMOUNT

:FAILOPENDIR
CLS 
ECHO ERROR: Failed to open directory %DIRECTORY%
GOTO END

:END
PAUSE

:IMMEDIATE_END
EXIT /B
