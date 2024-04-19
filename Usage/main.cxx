#include <zlib.h>
#include <cstdio>

int main(int argc, char *argv[])
{
  printf("%s\n", zlibVersion());
  return 0;
}
