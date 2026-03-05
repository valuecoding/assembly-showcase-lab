# Assembly Showcase Lab

Mini-Repo mit einfachen, klaren NASM-Beispielen fuer x64.

## Inhalt

- `src/win64/math/sum_u64.asm`
  - Summiert ein `uint64_t`-Array.
- `src/win64/strings/strlen.asm`
  - Laenge eines nullterminierten Strings.
- `src/win64/bit/bitcount_u64.asm`
  - Zaehlt gesetzte Bits in einem 64-Bit-Wert.
- `src/linux64/hello.asm`
  - Minimales Linux `_start` Beispiel mit `write` + `exit`.

## Build (Windows PowerShell)

```powershell
.\build.ps1
```

Das Skript erzeugt:

- `build\win64\*.obj`
- `build\linux64\*.o`

Hinweis:
- Die Windows-Objekte sind sofort in C/C++ Projekte linkbar.
- Das Linux-Beispiel wird hier nur assembliert (kein Link/Run auf Windows).

## Warum dieses Repo?

Ein kleines Showcase, um zu zeigen:

- grundlegendes Register-/Speicherverstaendnis
- Calling Convention (Windows x64)
- Schleifen, Pointer-Arithmetik, bitweise Logik
