@echo off
setlocal enabledelayedexpansion

REM Check if the correct number of arguments is provided
IF "%~2"=="" (
    echo Usage: script_name.bat source_directory target_directory
    exit /b 1
)

REM Assigning the source and target directories to variables for better readability
set "sourceDir=%~1"
set "targetDir=%~2"

REM Ensure that the source directory exists
IF NOT EXIST "%sourceDir%" (
    echo Source directory not found: %sourceDir%
    exit /b 1
)

REM Ensure that the target directory exists, if not create it
IF NOT EXIST "%targetDir%" (
    echo Creating target directory: %targetDir%
    mkdir "%targetDir%"
)

REM Copying and moving files from the source to the target directory
robocopy "%sourceDir%" "%targetDir%" /E /Move >NUL

REM Check if robocopy was successful
IF NOT %ERRORLEVEL% LEQ 1 (
    echo Error occurred during file transfer.
    exit /b %ERRORLEVEL%
)

REM Removing the source directory
rd /s /q "%sourceDir%" >NUL

REM Changing to the target directory
cd /d "%targetDir%" >NUL

REM Starting the vRY executable
start "" @vRY.exe

REM End of the script
endlocal
exit /b 0
