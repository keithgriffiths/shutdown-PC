@echo off
setlocal EnableExtensions
 title Windows Shutdown Manager
:menu
cls
echo ==========================================
echo          Windows Shutdown Manager
echo ==========================================
echo.
echo  1. Schedule shutdown in 5 hours
echo  2. Schedule shutdown in 1 hour
echo  3. Schedule shutdown in 60 seconds
echo  4. Cancel a pending shutdown
echo  5. Exit without changes
echo.
choice /c 12345 /n /m "Choose an option [1-5]: "
if errorlevel 5 goto end
if errorlevel 4 goto cancel
if errorlevel 3 goto short
if errorlevel 2 goto hour
if errorlevel 1 goto five
:five
set "DELAY=18000"
set "DESCRIPTION=5 hours"
goto schedule
:hour
set "DELAY=3600"
set "DESCRIPTION=1 hour"
goto schedule
:short
set "DELAY=60"
set "DESCRIPTION=60 seconds"
goto schedule
:schedule
echo.
echo This will request a shutdown in %DESCRIPTION%.
echo Save your work before the scheduled time.
choice /c YN /n /m "Proceed? [Y/N]: "
if errorlevel 2 goto menu
%SystemRoot%\System32\shutdown.exe /s /t %DELAY%
if errorlevel 1 (
  echo Failed to schedule the shutdown.
) else (
  echo Shutdown scheduled in %DESCRIPTION%.
  echo To cancel, run this script and choose option 4.
)
goto pause_end
:cancel
%SystemRoot%\System32\shutdown.exe /a
if errorlevel 1 (
  echo No pending shutdown was cancelled, or cancellation failed.
) else (
  echo Pending shutdown cancelled.
)
goto pause_end
:pause_end
echo.
pause
:end
endlocal
exit /b
