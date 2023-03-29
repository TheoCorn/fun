
{.compile: "ffi.c"}

proc canExecute*(path: cstring): bool {.importc: "canExecute", header: "<unistd.h>".}