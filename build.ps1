param()

$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectRoot

function Resolve-Nasm {
    $cmd = Get-Command nasm.exe -ErrorAction SilentlyContinue
    if ($cmd) {
        return $cmd.Source
    }

    $projectLocal = Join-Path $projectRoot "tools\nasm\nasm-3.01\nasm.exe"
    if (Test-Path $projectLocal) {
        return $projectLocal
    }

    $candidates = @(
        "$env:ProgramFiles\NASM\nasm.exe",
        "$env:ProgramFiles(x86)\NASM\nasm.exe"
    )

    foreach ($candidate in $candidates) {
        if (Test-Path $candidate) {
            return $candidate
        }
    }

    throw "NASM wurde nicht gefunden. Bitte 'winget install NASM.NASM' ausfuehren."
}

$nasm = Resolve-Nasm
Write-Host "NASM: $nasm"

$buildRoot = Join-Path $projectRoot "build"
$winOutRoot = Join-Path $buildRoot "win64"
$linuxOutRoot = Join-Path $buildRoot "linux64"

New-Item -ItemType Directory -Force -Path $winOutRoot | Out-Null
New-Item -ItemType Directory -Force -Path $linuxOutRoot | Out-Null

$winSources = Get-ChildItem (Join-Path $projectRoot "src\win64") -Recurse -Filter *.asm
foreach ($source in $winSources) {
    $relative = $source.FullName.Substring((Join-Path $projectRoot "src\win64\").Length)
    $target = Join-Path $winOutRoot ($relative -replace "\.asm$", ".obj")
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $target) | Out-Null
    & $nasm -f win64 $source.FullName -o $target
    if ($LASTEXITCODE -ne 0) {
        throw "Build fehlgeschlagen (win64): $($source.FullName)"
    }
    Write-Host "OK win64  -> $target"
}

$linuxSources = Get-ChildItem (Join-Path $projectRoot "src\linux64") -Recurse -Filter *.asm
foreach ($source in $linuxSources) {
    $relative = $source.FullName.Substring((Join-Path $projectRoot "src\linux64\").Length)
    $target = Join-Path $linuxOutRoot ($relative -replace "\.asm$", ".o")
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $target) | Out-Null
    & $nasm -f elf64 $source.FullName -o $target
    if ($LASTEXITCODE -ne 0) {
        throw "Build fehlgeschlagen (linux64): $($source.FullName)"
    }
    Write-Host "OK linux64 -> $target"
}

Write-Host "Assembly Build abgeschlossen."
