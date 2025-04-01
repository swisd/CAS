@echo off
title cmdbios COMMAND EXECUTION TERMINAL

mode con: cols=112 lines=40
echo st:
for /f "tokens=2" %%i in ('wmic os get caption') do set VERSION1=%%i
echo v1
for /f "tokens=3" %%i in ('wmic os get caption') do set VERSION2=%%i
echo v2
for /f "tokens=4" %%i in ('wmic os get caption') do set VERSION3=%%i
echo v3
FOR /F "tokens=2*" %%A IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DisplayVersion 2^> nul') DO SET "CODENAME= %%B "
echo cdnm
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "ReleaseId"') DO set "DFMT7= %%B "
echo dfmt7
FOR /F "skip=2 tokens=2,*" %%A IN ('reg.exe query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "CurrentBuild"') DO set "DFMT5= %%B"
echo dfmt5
FOR /F "tokens=2*" %%a in ('Reg Query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v UBR') do set "UBRHEX=%%~b"
set /a UBRDEC=%UBRHEX%
echo ubr
for /f "tokens=3 delims=()" %%a in ('wmic timezone get caption /value') do set tzone1=%%a
echo tzne0
for /f "tokens=2 delims=()" %%a in ('wmic timezone get caption /value') do set tzone2=%%a
echo tzne1
cls

set "funclist=func1"

if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set "OSARC= 64bit ")
if "%PROCESSOR_ARCHITECTURE%"=="x86" (set "OSARC= 32bit ")

if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    set "arch=64"
) else (
    set "arch=32"
)
set for_IDX=false
echo cmdbios COMMAND EXECUTION TERMINAL
echo compat with 3.31+
echo.
echo [104m[37m %VERSION1% %VERSION2% %VERSION3% [0m[41m[37m%DFMT7%[0m[42m%CODENAME%[0m[44m%DFMT5%.%UBRDEC% [0m[45m%OSARC%[0m
echo.
echo %~tza0
echo.
set fromif=false
set fromfor=false
set user=%USERNAME%
set /A PDIMM=4
set start=%*
set a1=.core
set REF=0
set InpPrmP=cmdterm^>^>
set i=0
set withinfunc=false
set currentFuncLine=0
:: stvar InpPrmP ~$
:: if defined a (set b=1) else (set b=0)
if not exist "%~dp0/temp" mkdir %~dp0temp
if not exist "%~dp0/temp/func" mkdir %~dp0temp/func
if not exist "%~dp0/persist" mkdir %~dp0persist
set funcname=
setlocal ENABLEDELAYEDEXPANSION
setlocal ENABLEEXTENSIONS
:int

if /I "!fromfor!" EQU "false" (
    set input=
)

if /I "!fromif!" EQU "false" (
    if /I "!fromfor!" EQU "false" (
        if /I "!withinfunc!" EQU "false" (
            set /p input=[36m!InpPrmP![0m
        )
    )
)
if /I "!withinfunc!" EQU "true" (
    set /p input=^>
)

if /I "!fromif!" EQU "true" (
    if /I "!fromfor!" EQU "false" (
        set input=none
    )
)
for /f "tokens=1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26 delims= " %%a in ("%input%") do (
    if /I "!fromfor!" EQU "false" (
    if /I "!fromif!" EQU "false" (
        set "arg1=%%a"
        set "arg2=%%b"
        set "arg3=%%c"
        set "arg4=%%d"
        set "arg5=%%e"
        set "arg6=%%f"
        set "arg7=%%g"
        set "arg8=%%h"
        set "arg9=%%i"
        set "arg10=%%j"
        set "arg11=%%k"
        set "arg12=%%l"
        set "arg13=%%m"
        set "arg14=%%n"
        set "arg15=%%o"
        set "arg16=%%p"
        set "arg17=%%q"
        set "arg18=%%r"
        set "arg19=%%s"
        set "arg20=%%t"
        set "arg21=%%u"
        set "arg22=%%v"
        set "arg23=%%w"
        set "arg24=%%x"
        set "arg25=%%y"
        set "arg26=%%z"

    ))
    set fromif=false

    if /I "!withinfunc!" EQU "true" (
        if /I "!arg1!" EQU "endfnc" (
            set withinfunc=false
            goto int
        )
        if /I "!arg1!" EQU "" (
            goto int
        )
        if /I "!arg1!" EQU "echo" (
            echo echo !arg2! !arg3! !arg4! !arg5! !arg6! !arg7! !arg8! !arg9! !arg10! !arg11! >>%~dp0temp/func/!funcname!.bat
            goto int
        )
        if /I "!arg1!" EQU "echo." (
            echo echo. >>%~dp0temp/func/!funcname!.bat
            goto int
        )
        if /I "!arg1!" EQU "stvar" (
            if /I "!arg2!" EQU "st:a" (
                echo set /a !arg3!=!arg4!!arg5!!arg6!!arg7!!arg8!!arg9!!arg10!!arg11!!arg12!!arg13!!arg14!!arg15!!arg16!! >>%~dp0temp/func/!funcname!.bat
                goto int
            )
            if /I "!arg2!" EQU "st:x" (
                echo setx !arg3! !arg4! >>%~dp0temp/func/!funcname!.bat
                goto int
            )
            echo set !arg2!=!arg3! >>%~dp0temp/func/!funcname!.bat
            goto int
        )
        if /I "!arg1!" EQU "gtvar" (
         echo echo [33m^%!arg2!^%[0m >>%~dp0temp/func/!funcname!.bat
         goto int
        )
        goto int
    ) else (

    if /I "!arg1!" EQU "" (
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )
    if /I "!arg1!" EQU "::" (
        goto int
    )
    ::help menu
    if /I "!arg1!" EQU "help" (
        goto genhelp
    )
    if /I "!arg1!" EQU "stvar" (
        if /I "!arg2!" EQU "in:BIOSVARS" (
            echo [33mnull[0m
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg2!" EQU "st:a" (
            set /a !arg3!=!arg4!!arg5!!arg6!!arg7!!arg8!!arg9!!arg10!!arg11!!arg12!!arg13!!arg14!!arg15!!arg16!!
            rem echo !arg2! var '!arg3!'//'!arg4!'
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg2!" EQU "st:x" (
            setx !arg3! !arg4!
            rem echo !arg2! var '!arg3!'//'!arg4!'
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg2!" EQU "st:l" (
            if /I "!arg4!" EQU "and" (
                if /I "!arg5!" EQU "true" (
                    if /I "!arg6!" EQU "true" (
                        set !arg3!=true
                    )
                )
                if /I "!arg5!" EQU "false" (
                    set !arg3!=false
                )
                if /I "!arg6!" EQU "false" (
                    set !arg3!=false
                )
            )
            if /I "!arg4!" EQU "or" (
                if /I "!arg5!" EQU "true" (
                    set !arg3!=true
                )
                if /I "!arg6!" EQU "true" (
                    set !arg3!=true
                )
                if /I "!arg5!" EQU "false" (
                    if /I "!arg6!" EQU "false" (
                        set !arg3!=false
                    )
                )
            )
            if /I "!arg4!" EQU "not" (
                if /I "!arg5!" EQU "true" (
                    set !arg3!=false
                )
                if /I "!arg5!" EQU "false" (
                    set !arg3!=true
                )
            )
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        set !arg2!=!arg3!
        rem echo var '!arg2!'//'!arg3!'
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )
    if /I "!arg1!" EQU "gtvar" (
        call echo [33m%%!arg2!%%[0m
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )

    if /I "!arg1!" EQU "clvar" (
        if /I "!arg3!" NEQ "" (
            set !arg2!=!arg3!
            rem echo var !arg2!//!arg3!
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        set !arg2!=
        rem echo var !arg2!//null
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )

    if /I "!arg1!" EQU "upd" (
        if /I "!arg2!" EQU "bios" (
            echo [33mbios update unavailable (unsupported^)[0m
        if /I "!fromfor!" EQU "false" (
            goto int
        )
        )
        echo [33mno '!arg2!' update[0m
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )
    if /I "!arg1!" EQU "clx" (
         cls
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )
    if /I "!arg1!" EQU "echo" (
        echo [33m!arg2! !arg3! !arg4! !arg5! !arg6! !arg7! !arg8! !arg9! !arg10![0m
        if /I "!fromfor!" EQU "false" (
            goto int
        )

    )
    if /I "!arg1!" EQU "*" (
        if exist "%cd%\biosvars.bat" (
            more %cd%\biosvars.bat
        ) else (
            echo [33mno BIOSVARS found[0m
        )
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )
    if /I "!arg1!" EQU "?" (
        echo [33m%user%[0m
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )

    if /I "!arg1!" EQU "echo." (
        echo.
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )

    if /I "!arg1!" EQU "clr" (
        color !arg2!
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )

    rem if statement
    if /I "!arg1!" EQU "if" (
        if /I "!arg2!" EQU "eqt" (
            if /I "!arg3!" EQU "!arg4!" (
                set arg1=!arg5!
                set arg2=!arg6!
                set arg3=!arg7!
                set arg4=!arg8!
                set arg5=!arg9!
                set arg6=!arg10!
                set arg7=!arg11!
                set arg8=!arg12!
                set arg9=!arg13!
                set arg10=!arg14!
                set arg11=!arg15!
                set arg12=!arg16!
                set arg13=!arg17!
                set arg14=!arg18!
                set arg15=!arg19!
                set arg16=!arg20!
                set fromif=true
                if /I "!fromfor!" EQU "false" (
                    goto int
                )
            ) else (
                echo [33mfalse[0m
            )
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg2!" EQU "net" (
            if /I "!arg3!" NEQ "!arg4!" (
                set arg1=!arg5!
                set arg2=!arg6!
                set arg3=!arg7!
                set arg4=!arg8!
                set arg5=!arg9!
                set arg6=!arg10!
                set arg7=!arg11!
                set arg8=!arg12!
                set arg9=!arg13!
                set arg10=!arg14!
                set arg11=!arg15!
                set arg12=!arg16!
                set arg13=!arg17!
                set arg14=!arg18!
                set arg15=!arg19!
                set arg16=!arg20!
                set fromif=true
                if /I "!fromfor!" EQU "false" (
                    goto int
                )
            ) else (
                echo [33mfalse[0m
            )
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg2!" EQU "let" (
            if /I "!arg3!" LEQ "!arg4!" (
                set arg1=!arg5!
                set arg2=!arg6!
                set arg3=!arg7!
                set arg4=!arg8!
                set arg5=!arg9!
                set arg6=!arg10!
                set arg7=!arg11!
                set arg8=!arg12!
                set arg9=!arg13!
                set arg10=!arg14!
                set arg11=!arg15!
                set arg12=!arg16!
                set arg13=!arg17!
                set arg14=!arg18!
                set arg15=!arg19!
                set arg16=!arg20!
                set fromif=true
                if /I "!fromfor!" EQU "false" (
                    goto int
                )
            ) else (
                echo [33mfalse[0m
            )
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg2!" EQU "get" (
            if /I "!arg3!" GEQ "!arg4!" (
                set arg1=!arg5!
                set arg2=!arg6!
                set arg3=!arg7!
                set arg4=!arg8!
                set arg5=!arg9!
                set arg6=!arg10!
                set arg7=!arg11!
                set arg8=!arg12!
                set arg9=!arg13!
                set arg10=!arg14!
                set arg11=!arg15!
                set arg12=!arg16!
                set arg13=!arg17!
                set arg14=!arg18!
                set arg15=!arg19!
                set arg16=!arg20!
                set fromif=true
                if /I "!fromfor!" EQU "false" (
                    goto int
                )
            ) else (
               echo [33mfalse[0m
             )
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg2!" EQU "gt" (
            if /I "!arg3!" GTR "!arg4!" (
                set arg1=!arg5!
                set arg2=!arg6!
                set arg3=!arg7!
                set arg4=!arg8!
                set arg5=!arg9!
                set arg6=!arg10!
                set arg7=!arg11!
                set arg8=!arg12!
                set arg9=!arg13!
                set arg10=!arg14!
                set arg11=!arg15!
                set arg12=!arg16!
                set arg13=!arg17!
                set arg14=!arg18!
                set arg15=!arg19!
                set arg16=!arg20!
                set fromif=true
                if /I "!fromfor!" EQU "false" (
                    goto int
                )
            ) else (
               echo [33mfalse[0m
             )
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg2!" EQU "ls" (
            if /I "!arg3!" LSS "!arg4!" (
                set arg1=!arg5!
                set arg2=!arg6!
                set arg3=!arg7!
                set arg4=!arg8!
                set arg5=!arg9!
                set arg6=!arg10!
                set arg7=!arg11!
                set arg8=!arg12!
                set arg9=!arg13!
                set arg10=!arg14!
                set arg11=!arg15!
                set arg12=!arg16!
                set arg13=!arg17!
                set arg14=!arg18!
                set arg15=!arg19!
                set arg16=!arg20!
                set fromif=true
                if /I "!fromfor!" EQU "false" (
                    goto int
                )
            ) else (
               echo [33mfalse[0m
             )
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg2!" EQU "not" (
            if "!arg3!" EQU "false" (
                set arg1=!arg4!
                set arg2=!arg5!
                set arg3=!arg6!
                set arg4=!arg7!
                set arg5=!arg8!
                set arg6=!arg9!
                set arg7=!arg10!
                set arg8=!arg11!
                set arg9=!arg12!
                set arg10=!arg13!
                set arg11=!arg14!
                set arg12=!arg15!
                set arg13=!arg16!
                set arg14=!arg17!
                set arg15=!arg18!
                set arg16=!arg19!
                set fromif=true
                if /I "!fromfor!" EQU "false" (
                    goto int
                )
            ) else (
               echo [33mfalse[0m
             )
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        echo [35mnull[0m
        if /I "!fromfor!" EQU "false" (
            goto int
        )

    )

    if /I "!arg1!" EQU "exit" (
        goto exit
    )
    if /I "!arg1!" EQU "loc" (
        where !arg2!
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )
    if /I "!arg1!" EQU "ccmd" (
        cmd /c "!arg2! !arg3! !arg4! !arg5! !arg6! !arg7! !arg8! !arg9! !arg10!"
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )
    if /I "!arg1!" EQU "ps" (
        powershell -Command "!arg2! !arg3! !arg4! !arg5! !arg6! !arg7! !arg8! !arg9! !arg10!"
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )
    if /I "!arg1!" EQU "nul" (
        set !arg2!=

        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )

    if /I "!arg1!" EQU "fi" (
        find !arg2! !arg3!
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )
    if /I "!arg1!" EQU "pr" (
        prompt !arg2!$G
        echo thos does not work
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )
    if /I "!arg1!" EQU "mv" (
        move !arg2! !arg3!
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )
    if /I "!arg1!" EQU "ch" (
        choice /m !arg2! /c !arg3!!arg4!!arg5!!arg6!!arg7!!arg8!!arg9!!arg10!
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )
    if /I "!arg1!" EQU "cl" (
        call !arg2! !arg3! !arg4! !arg5! !arg6! !arg7! !arg8! !arg9! !arg10!
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )
    if /I "!arg1!" EQU "ver" (
        echo cmdbios COMMAND EXECUTION TERMINAL
        echo compat with 3.31+
        echo.
        echo [104m[37m %VERSION1% %VERSION2% %VERSION3% [0m[41m[37m%DFMT7%[0m[42m%CODENAME%[0m[44m%DFMT5%.%UBRDEC% [0m[45m%OSARC%[0m
        echo.
        goto int
    )

    if exist "%~dp0temp/func/!arg1!.bat" (
        call %~dp0temp/func/!arg1!.bat !arg2! !arg3! !arg4! !arg5! !arg6! !arg7! !arg8! !arg9! !arg10! !arg11! !arg12! !arg13!
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )
    if exist "%~dp0persist/func/!arg1!.bat" (
        call %~dp0persist/func/!arg1!.bat !arg2! !arg3! !arg4! !arg5! !arg6! !arg7! !arg8! !arg9! !arg10! !arg11! !arg12! !arg13!
        if /I "!fromfor!" EQU "false" (
            goto int
        )
    )

    rem Functions

    if /I "!arg1!" EQU "fnc" (
        rem if not "x!funclist:!arg2!=!"=="x!arg2!" (
        rem     echo Function !arg2! already defined
        rem     goto int
        rem )
        echo Defining Function '!arg2!' with arguments '!arg3! !arg4! !arg5! !arg6! !arg7! !arg8! !arg9! !arg10!'
        if /I "!withinfunc!" EQU "true" (
            echo Error: Already defining function; cannot define function inside of function
        )
        echo rem function_!arg2! :: args !arg3! !arg4! !arg5! !arg6! !arg7! !arg8! !arg9! !arg10! >%~dp0temp/func/!arg2!.bat
        echo set !arg3!=%%1 >>%~dp0temp/func/!arg2!.bat
        echo set !arg4!=%%2 >>%~dp0temp/func/!arg2!.bat
        echo set !arg5!=%%3 >>%~dp0temp/func/!arg2!.bat
        echo set !arg6!=%%4 >>%~dp0temp/func/!arg2!.bat
        echo set !arg7!=%%5 >>%~dp0temp/func/!arg2!.bat
        echo set !arg8!=%%6 >>%~dp0temp/func/!arg2!.bat
        set funcname=!arg2!
        set function_!arg2!=!arg3! !arg4! !arg5! !arg6! !arg7! !arg8! !arg9! !arg10!
        set "funclist=!funclist! !arg2!"
        set withinfunc=true
        goto int
    )



    if /I "!arg1!" EQU "endfnc" (
        set withinfunc=false
        goto int
    )

    for /f "tokens=1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16 delims= " %%a in ("!funclist!") do (
        if /I "!arg1!" EQU "%%a" (
            echo functions unavailable
            set func_x=function_!arg1!
            call echo function_!arg1! -- %%!func_x!%%
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg1!" EQU "%%b" (
            echo functions unavailable
            set func_x=function_!arg1!
            call echo function_!arg1! -- %%!func_x!%%
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg1!" EQU "%%c" (
            echo functions unavailable
            set func_x=function_!arg1!
            call echo function_!arg1! -- %%!func_x!%%
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg1!" EQU "%%d" (
            echo functions unavailable
            set func_x=function_!arg1!
            call echo function_!arg1! -- %%!func_x!%%
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg1!" EQU "%%e" (
            echo functions unavailable
            set func_x=function_!arg1!
            call echo function_!arg1! -- %%!func_x!%%
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg1!" EQU "%%f" (
            echo functions unavailable
            set func_x=function_!arg1!
            call echo function_!arg1! -- %%!func_x!%%
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg1!" EQU "%%g" (
            echo functions unavailable
            set func_x=function_!arg1!
            call echo function_!arg1! -- %%!func_x!%%
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg1!" EQU "%%h" (
            echo functions unavailable
            set func_x=function_!arg1!
            call echo function_!arg1! -- %%!func_x!%%
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg1!" EQU "%%i" (
            echo functions unavailable
            set func_x=function_!arg1!
            call echo function_!arg1! -- %%!func_x!%%
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg1!" EQU "%%j" (
            echo functions unavailable
            set func_x=function_!arg1!
            call echo function_!arg1! -- %%!func_x!%%
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg1!" EQU "%%k" (
            echo functions unavailable
            set func_x=function_!arg1!
            call echo function_!arg1! -- %%!func_x!%%
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg1!" EQU "%%l" (
            echo functions unavailable
            set func_x=function_!arg1!
            call echo function_!arg1! -- %%!func_x!%%
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg1!" EQU "%%m" (
            echo functions unavailable
            set func_x=function_!arg1!
            call echo function_!arg1! -- %%!func_x!%%
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg1!" EQU "%%n" (
            echo functions unavailable
            set func_x=function_!arg1!
            call echo function_!arg1! -- %%!func_x!%%
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg1!" EQU "%%o" (
            echo functions unavailable
            set func_x=function_!arg1!
            call echo function_!arg1! -- %%!func_x!%%
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )
        if /I "!arg1!" EQU "%%p" (
            echo functions unavailable
            set func_x=function_!arg1!
            call echo function_!arg1! -- %%!func_x!%%
            if /I "!fromfor!" EQU "false" (
                goto int
            )
        )


    )

    rem FOR prc continue
    if /I "!fromfor!" EQU "true" (
        if !i! LEQ !stop! (
            set /a i=!i!+!step!
            rem DEBUGGING ONLY
            rem echo DEBUG: start=!start!, stop=!stop!, step=!step!, arg1=!arg1!, arg2=!arg2!
            if "!for_IDX!" EQU "true" (
                echo [34m!i![0m
            )
            goto int
        ) else (
            set fromfor=false
            goto int
        )
    )

    rem for statement
    if /I "!arg1!" EQU "for"  (
        if "!fromfor!" EQU "false" (
            set i=0
            set fromfor=true
            set start=!arg2!
            set /a i=!start!
            set stop=!arg3!
            set step=!arg4!
            set arg1=!arg5!
            set arg2=!arg6!
            set arg3=!arg7!
            set arg4=!arg8!
            set arg5=!arg9!
            set arg6=!arg10!
            set arg7=!arg11!
            set arg8=!arg12!
            set arg9=!arg13!
            set arg10=!arg14!
            set arg11=!arg15!
            set arg12=!arg16!
            set arg13=!arg17!
            set arg14=!arg18!
            set arg15=!arg19!
            set arg16=!arg20!
            goto int
        )
    )
    echo [31mCommand '!arg1!' does not exist or could not be found.[0m
    goto int

))

goto int

:genhelp
echo COMMANDS HELP MENU
echo.
echo [cmd]             [cmd description]      [cmd usage]                [cmd alt usage]
echo.
echo help              General Help Menu
echo stvar             Set Variable           stvar [var] [value]        stvar [type] [var] [value]
echo                                                  -------^>           stvar st:a [out] [var^/val] [operator] [var^/val] ... arg12
echo                                                  -------^>           stvar st:l [out] [op] [var/val] [var/val]
echo gtvar             Get Variable           gtvar [var]                gtvar [type] [var]
echo clvar             Clear Variable         clvar [var] [clearto]
echo upd               Update                 upd [prgm]
echo clx               Clear Screen           clx
echo clr               Change Color           clr [color]
echo echo              Echo Data (print)      echo [data]
echo *                 List All               *
echo ?                 Whoami                 ?
echo exit              exit                   exit
echo loc               location               loc [file]
echo nul               nul var                nul [var]
echo ps                Powershell Command     ps [command]
echo ccmd              CMD Command            ccmd [command]
echo fi                Find                   fi [str] [file]
echo pr                Prompt                 pr [msg]
echo mv                move                   mv [pathF] [pathT]
echo ch                Choice                 ch [msg] [options]
echo cl                call                   cl [pth] [params]
echo.
echo if                If Statement           if [comp] [a] [b] [do]
echo for               For statement          for [start] [stop] [step] [do]
echo.
pause
goto int


set arg1=!arg5!
set arg2=!arg6!
set arg3=!arg7!
set arg4=!arg8!
set arg5=!arg9!
set arg6=!arg10!

:exit
rmdir %~dp0temp
del %~dp0temp
exit /b