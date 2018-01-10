@echo off
setlocal enabledelayedexpansion

:: variables
set icons=

:: clear current css file
break>icons.css

:: change to icons folder
cd icons

:: loop icons and appent to css file
for /R %%f in (*.svg) do (
    set icons=!icons! "%%~nf",
    @echo .ipsIcon%%~nf{background-image:url^(icons/%%~nf%%~xf^)^;} >> ../icons.css
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