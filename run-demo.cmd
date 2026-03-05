@echo off
setlocal EnableExtensions
title Assembly Showcase Lab - coded by valuecoding
color 0B
echo ===============================================================
echo                ASSEMBLY SHOWCASE LAB (x64)
echo                      coded by valuecoding
echo ===============================================================
echo.
echo [BOOT] loading demo runner...
for /l %%i in (1,1,3) do (
  <nul set /p "=."
  powershell -NoProfile -Command "Start-Sleep -Milliseconds 180"
)
echo.
echo.
color 07
powershell -ExecutionPolicy Bypass -File "%~dp0run-demo.ps1"
set exitcode=%errorlevel%
echo.
if %exitcode%==0 (
  color 0A
  echo [OK] Demo erfolgreich.
) else (
  color 0C
  echo [FAIL] Demo fehlgeschlagen. ExitCode=%exitcode%
)
echo.
echo ===============================================================
echo                      coded by valuecoding
echo ===============================================================
pause
exit /b %exitcode%
