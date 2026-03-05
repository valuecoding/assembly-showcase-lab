param()

$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectRoot

Write-Host "[1/3] Assemble..."
powershell -ExecutionPolicy Bypass -File ".\build.ps1"

function Resolve-Gpp {
    $cmd = Get-Command g++.exe -ErrorAction SilentlyContinue
    if ($cmd) {
        return $cmd.Source
    }

    $wingetWinlibs = Join-Path $env:LOCALAPPDATA "Microsoft\WinGet\Packages\BrechtSanders.WinLibs.MCF.UCRT_Microsoft.Winget.Source_8wekyb3d8bbwe\mingw64\bin\g++.exe"
    if (Test-Path $wingetWinlibs) {
        return $wingetWinlibs
    }

    throw "g++ nicht gefunden. Bitte WinLibs installieren (winget install BrechtSanders.WinLibs.MCF.UCRT)."
}

$gpp = Resolve-Gpp
$outputExe = Join-Path $projectRoot "build\win64\demo_runner.exe"

Write-Host "[2/3] Compile + link..."
& $gpp -std=c++17 `
    -static -static-libgcc -static-libstdc++ `
    ".\tests\win64\demo_main.cpp" `
    ".\build\win64\math\sum_u64.obj" `
    ".\build\win64\strings\strlen.obj" `
    ".\build\win64\bit\bitcount_u64.obj" `
    -o $outputExe

if ($LASTEXITCODE -ne 0) {
    throw "C++ Build fehlgeschlagen."
}

Write-Host "[3/3] Run demo..."
& $outputExe
$code = $LASTEXITCODE
if ($code -eq 0) {
    Write-Host "coded by valuecoding" -ForegroundColor Cyan
}
exit $code
