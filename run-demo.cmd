@echo off
setlocal
powershell -ExecutionPolicy Bypass -File "%~dp0run-demo.ps1"
set exitcode=%errorlevel%
echo.
if %exitcode%==0 (
  echo Demo erfolgreich.
) else (
  echo Demo fehlgeschlagen. ExitCode=%exitcode%
)
pause
exit /b %exitcode%
