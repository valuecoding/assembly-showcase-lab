# Assembly Showcase Lab

Small NASM x64 playground with a few clean, practical examples.

## What is in this repo?

- `src/win64/math/sum_u64.asm`  
  Sum a `uint64_t` array.
- `src/win64/strings/strlen.asm`  
  Return the length of a null-terminated string.
- `src/win64/bit/bitcount_u64.asm`  
  Count set bits in a 64-bit value.
- `src/linux64/hello.asm`  
  Minimal Linux `_start` example (`write` + `exit`).

## Build on Windows

```powershell
.\build.ps1
```

Output:

- `build\win64\*.obj`
- `build\linux64\*.o`

Notes:

- Windows objects can be linked directly into C/C++ projects.
- The Linux sample is assembled on Windows, but not linked/run there.

## Run the demo quickly

Double-click:

- `run-demo.cmd`

or run:

```powershell
powershell -ExecutionPolicy Bypass -File .\run-demo.ps1
```

The demo script will:

1. assemble the `.asm` files
2. compile a small C++ test runner
3. execute tests and print PASS/FAIL

## Why this repo?

It is a compact public project to show basic low-level skills:

- register and memory handling
- Windows x64 calling convention
- loops, pointer arithmetic, and bit operations
