@echo off
setlocal enabledelayedexpansion

:: read skin.json
set config[0]=author
set config[1]=version
set config[2]=compatible
set config[3]=url
set config[4]=git
set config[5]=icons
set value[5]=

set c=-1
for /f "tokens=2 delims=,, " %%a in (' find ":" ^< "skin.json" ') do (
    set /a c+=1
    set value[!c!]=%%~a
)

:: update version number
set value[1]=!value[1]:^.=!
set /a value[1]+=1
set value[1]=!value[1]:~0,1!.!value[1]:~-2!

:: read icons
set icons=
break>./icons.css

:: loop icons and append to css file
for /R %%f in (./icons/*.svg) do (
    set icons=!icons! "%%~nf",
    @echo .ipsIcon%%~nf{background-image:url^(icons/%%~nf%%~xf^)^;} >> ./icons.css
)

:: remove last ; and whitespaces
set value[5]=!icons:~1!
set value[5]=!icons:~0,-1!

:: build updated json config
break>./skin.json
echo ^{ >> skin.json

for /l %%k in (0, 1, %c%) do (
    if /i !config[%%k]!==icons (
        echo   !json!"!config[%%k]!"^: [!value[%%k]!] >> skin.json
    ) else (
        echo   !json!"!config[%%k]!"^: "!value[%%k]!", >> skin.json
    )
)

echo ^} >> skin.json

:: finished!
echo skin v%value[1]% created!
echo.
pause