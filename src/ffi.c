
#include <unistd.h>
int canExecute(const char *path) {
    return access(path, X_OK) == 0;
}