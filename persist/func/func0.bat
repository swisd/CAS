rem function_func0 :: args x y z a b c
set x=%1
set y=%2
set z=%3
set a=%4
set b=%5
set c=%6

echo Testing Function func0
echo.
echo Argument:Value
echo x:!x!
echo y:!y!
echo z:!z!

echo %cd%
echo.
echo.
echo Argument 1: %x%
echo Argument 2: %y%
echo Argument 3: %z%
echo Argument 4: %a%
echo Argument 5: %b%
echo Argument 6: %c%
echo.
echo pfnc %PDIMM%
echo.
echo arch %arch%
echo a1 %a1%
echo REF %REF%
echo OSARC %OSARC%