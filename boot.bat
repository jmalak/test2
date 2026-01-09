@echo off
rem Batch to build a subset of the Open Watcom tools

rem Verify that critical environment variables are set
if not "%OWROOT%" == "" goto have_owroot
echo The OWROOT environment variable must be set!
goto end
:have_owroot

rem We do not want the changes to environment to persist
setlocal

if not "%OWOBJDIR%" == "" goto have_owobjdir
echo The OWOBJDIR environment variable must be set!
goto finish
:have_owobjdir

if not "%OWBINDIR%" == "" goto have_owbindir
echo The OWBINDIR environment variable must be set!
goto finish
:have_owbindir

rem Save the current environment
set OWBLD_SAVED_PATH=%PATH%
set OWBLD_SAVED_INCLUDE=%INCLUDE%
set OWBLD_SAVED_WATCOM=%WATCOM%
set OWBLD_SAVED_WLNK=%WLINK_LNK%

rem Make sure the makeinit directory (%OWROOT%\build) is included
rem in the PATH
set PATH=%OWBINDIR%;%OWROOT%\build;%PATH%

rem If the OWBOOTSTRAP environment variable is set, use an existing
rem Open Watcom installation for bootstrapping
rem NB: The environment (PATH, INCLUDE) need not be set up; we can
rem do it ourselves
rem If OWBOOTSTRAP is not set, assume bootstrap with pre-configured
rem Microsoft C/C++
if "%OWBOOTSTRAP%" == "" goto not_ow
rem Set up environment variables needed by Open Watcom
echo Bootstrap using Open Watcom C/C++ in %OWBOOTSTRAP%
set WATCOM=%OWBOOTSTRAP%
set PATH=%OWBOOTSTRAP%\binnt;%OWBOOTSTRAP%\binw;%PATH%
set INCLUDE=%OWBOOTSTRAP%\h;%OWBOOTSTRAP%\h\nt
rem Ensure the right wlink.lnk is used in bootstrap stage
set WLINK_LNK=%OWBOOTSTRAP%\binnt\wlink.lnk
goto cont1

:not_ow
rem PATH, INCLUDE, LIB, etc. must be already configured; we don't
rem know how to do it for Microsoft's tools
rem However, we clear some Watcom specific environment variables
rem to make sure they can't be getting in the way
echo Bootstrap using Microsoft C/C++
set WATCOM=
set WLINK_LNK=
:cont1


rem Start the actual bootstrap build; first build wmake
cd %OWROOT%\src\make
if not exist %OWOBJDIR% mkdir %OWOBJDIR%
cd %OWOBJDIR%
nmake -nologo -f ..\nmkmake

rem Build the builder utility and rm
cd %OWROOT%\src\builder
if not exist %OWOBJDIR% mkdir %OWOBJDIR%
cd %OWOBJDIR%
%OWBINDIR%\wmake -h -f ..\bootmake builder.exe rm.exe
if errorlevel == 1 goto restore_env
cd %OWROOT%\src

rem With wmake and builder at hand, run the bootstrap build
builder boot
if errorlevel == 1 goto restore_env

rem If we are bootstrapping using Open Watcom, we now need to modify
rem the environment so that the freshly built tools are on the PATH
rem first.
rem Make especially sure we're building with the right custom wlink.lnk
rem in %OWROOT%\build
rem NB: We still need the existing Open Watcom tools so that we could
rem build miscellaneous helper programs that need to run on the host!
if "%OWBOOTSTRAP%" == "" goto cont3
set PATH=%OWBINDIR%;%OWROOT%\build;%PATH%
set WLINK_LNK=%OWROOT%\build\wlink.lnk
:cont3


rem Do a regular build using fresh bootstrapped build tools
echo Starting Build
builder rel


rem This is where a testing stage might happen using newly built tools


rem Restore original values of environment variables
:restore_env
set PATH=%OWBLD_SAVED_PATH%
set INCLUDE=%OWBLD_SAVED_INCLUDE%
set WATCOM=%OWBLD_SAVED_WATCOM%
set WLINK_LNK=%OWBLD_SAVED_WLNK%

:finish
cd %OWROOT%
endlocal
:end
