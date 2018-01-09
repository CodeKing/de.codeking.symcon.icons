@echo off
setlocal enabledelayedexpansion

:: variables
set icons=

:: clear current css file
break>icons.css

:: change to icons folder
cd icons

:: loop icons and appent to css file
for /R %%f in (*.png) do (
    set icons=!icons! "%%~nf",
    @echo .ipsIcon%%~nf { color: transparent^; min-height: 32px^; min-width: 32px^; background-position: center center^; background-size: 28px;^; background-image: url^(icons/%%~nf%%~xf^)^;} >> ../icons.css
)

:: remove last ; and whitespaces
set icons=!icons:~1!
set icons=!icons:~0,-1!

:: echo output
echo JSON Definitionen:
echo ====================================================================
echo(
echo.%icons%
echo(
echo(

pause