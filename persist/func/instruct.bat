rem function_instruct :: args a b c d e f   
set a=%1 
set b=%2 
set c=%3 
set d=%4 
set e=%5 
set f=%6 
echo Getting Started Instructions        
echo. 
pause
cls
echo Echoing
echo.
echo echo ^<text^>
echo.
echo You can also print a new line with:
echo echo.
echo.
pause
cls
echo Setting Variables
echo.
echo :: set variable
echo stvar a 0
echo.
echo :: get variable
echo gtvar a
echo.
echo :: clear variable
echo clvar a
echo :: can clear to another int (replace)
echo clvar a 2
echo.
echo :: stvar also has arithmetic
echo stvar a 10
echo stvar b 5
echo.
echo stvar st:a c a + b
echo.
echo gtvar c
echo.
echo :: possible operators are + - / *
echo :: math function will come soon
echo.
echo :: stvar also has logical operators
echo stvar a true
echo stvar b false
echo.
echo stvar st:l c and ^!a^! ^!a^!
echo :: true
echo.
echo stvar st:l c or ^!a^! ^!b^!
echo :: true
echo.
echo stvar st:l c not ^!a^!
echo ::false
echo.
echo.
echo :: for logic, variables must have active variable syntax (^^!^<var^>^^!)
echo :: you can use passive variable syntax for other function/operation/items as ^%%var^%%
echo.
echo :: because of how odd stvar is, algebraic/math set
echo :: is referred to normally, but logical set is
echo :: referred to as "setting <variable> as <operator> across <var_a> and <var_b>"
echo ::   -- ... set c as OR across a and b ...
echo ::
echo :: but not is referred to as "setting <variable> as the NOT of <var_a>"


