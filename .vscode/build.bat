@echo OFF
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set VSCODEOS=32BIT || set VSCODEOS=64BIT

if %VSCODEOS%==32BIT (
echo This is a 32bit operating system
"%~1\resources\compilers\tms\Win32\TMSWebCompiler.exe" -ParseDprojFile -NoCodeModification %~6 -CompilerBin "%~1\resources\compilers\tms\Win32\libpas2js.dll" -ProjectFile "%~3" -vsctoolsoptionsjson "%~5"
)
if %VSCODEOS%==64BIT (
echo This is a 64bit operating system
"%~1\resources\compilers\tms\Win64\TMSWebCompiler.exe" -ParseDprojFile -NoCodeModification %~6 -CompilerBin "%~1\resources\compilers\tms\Win64\libpas2js.dll" -ProjectFile "%~3" -vsctoolsoptionsjson "%~5"
)
if %errorlevel% neq 0 exit /b %errorlevel%