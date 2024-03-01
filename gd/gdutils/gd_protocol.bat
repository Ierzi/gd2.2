
@echo off
setlocal enabledelayedexpansion

        set "appName=GeometryDash.exe"
set "argument=%1"
set "number="

REM Check if the argument contains /
echo !argument! | find "/" > nul
if not errorlevel 1 (
    REM If / is found, extract the number part after the /
    for /f "tokens=2 delims=/" %%a in ("!argument!") do (
        set "number=%%a"
    )
) else (
    REM If / is not found, the argument is in the format gdutils:123
    for /f "tokens=2 delims=:" %%a in ("!argument!") do (
        set "number=%%a"
    )
)

if not defined number (
    echo Invalid argument format: %1
    exit /b 1
)

set "flagFile=%number%.flag"

REM Check if the application is already running
tasklist /FI "IMAGENAME eq %appName%" | find /i "%appName%" > nul
if errorlevel 1 (
    REM If not running, start the application with the provided argument
    cd ..
    start "" "%appName%"
    cd gdutils
    type nul > "%flagFile%"
) else (
    REM If running, create an empty file based on the extracted number
    type nul > "%flagFile%"
)

endlocal
        