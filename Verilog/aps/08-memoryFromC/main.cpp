#include <stdio.h>
#include <unistd.h>

int main(void) {
  printf("Velikost stranky je: %ld B.\n", sysconf(_SC_PAGESIZE));
  return 0;
}