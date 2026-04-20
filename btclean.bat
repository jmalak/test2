@echo off
rem Batch to clean a bootstrap build of Open Watcom tools.

rem Verify that critical environment variables are set
if not "%OWROOT%" == "" goto have_owroot
echo The OWROOT environment variable must be set!
goto end
:have_owroot

if not "%OWOBJDIR%" == "" goto have_owobjdir
echo The OWOBJDIR environment variable must be set!
goto finish
:have_owobjdir

if not "%OWBINDIR%" == "" goto have_owbindir
echo The OWBINDIR environment variable must be set!
goto finish
:have_owbindir

rem We do not want the changes to environment to persist
setlocal

rem Save the current environment
set OWBLD_SAVED_PATH=%PATH%

rem Set up the PATH without making any assumptions as to what
rem is or isn't in it. Needed for builder and for makeinit.
set PATH=%OWBINDIR%;%OWROOT%\build;%PATH%

rem Check if builder is available, if not then just skip it.
if exist %OWBINDIR%\builder.exe goto have_builder
echo Cannot find builder - did you run boot.bat?
goto no_builder

rem Use builder to clean out most of the bits, then delete builder.
:have_builder
cd %OWROOT%\src
builder bootclean
cd %OWROOT%

rem At this point there is no builder; kill off the stragglers.
rem First clean out wmake
:no_builder
cd %OWROOT%\src\make
if not exist %OWOBJDIR% goto no_wmake
del /q %OWOBJDIR%\*
rmdir %OWOBJDIR%
:no_wmake

rem Next delete builder object files
rem TODO: Has that not been done already?
cd %OWROOT%\src\builder
if not exist %OWOBJDIR% goto no_bldobj
del /q %OWOBJDIR%\*
rmdir %OWOBJDIR%
:no_bldobj

rem Finally delete remaining executables in build bin directory.
rem TODO: review whether all the POSIX utilities need to be built.
cd %OWROOT%
if exist %OWBINDIR%\wmake.exe del %OWBINDIR%\wmake.exe
if exist %OWBINDIR%\builder.exe del %OWBINDIR%\builder.exe
if exist %OWBINDIR%\wgrep.exe del %OWBINDIR%\wgrep.exe
if exist %OWBINDIR%\rm.exe del %OWBINDIR%\rm.exe
if exist %OWBINDIR%\cat.exe del %OWBINDIR%\cat.exe
if exist %OWBINDIR%\chmod.exe del %OWBINDIR%\chmod.exe
if exist %OWBINDIR%\cp.exe del %OWBINDIR%\cp.exe
if exist %OWBINDIR%\cmp.exe del %OWBINDIR%\cmp.exe
if exist %OWBINDIR%\egrep.exe del %OWBINDIR%\egrep.exe
if exist %OWBINDIR%\false.exe del %OWBINDIR%\false.exe
if exist %OWBINDIR%\head.exe del %OWBINDIR%\head.exe
if exist %OWBINDIR%\ls.exe del %OWBINDIR%\ls.exe
if exist %OWBINDIR%\mkdir.exe del %OWBINDIR%\mkdir.exe
if exist %OWBINDIR%\sed.exe del %OWBINDIR%\sed.exe
if exist %OWBINDIR%\sleep.exe del %OWBINDIR%\sleep.exe
if exist %OWBINDIR%\tee.exe del %OWBINDIR%\tee.exe
if exist %OWBINDIR%\true.exe del %OWBINDIR%\true.exe
if exist %OWBINDIR%\uniq.exe del %OWBINDIR%\uniq.exe
if exist %OWBINDIR%\wc.exe del %OWBINDIR%\wc.exe
if exist %OWBINDIR%\which.exe del %OWBINDIR%\which.exe

rem Restore original values of environment variables
:restore_env
set PATH=%OWBLD_SAVED_PATH%

:finish
cd %OWROOT%
endlocal
:end
