#include <stdio.h>
#include <sys/time.h>
void setup();
int load();

static double msecs(struct timeval* t) {
  double d = t->tv_usec;
  d /= 1000000;
  d += t->tv_sec;
  d *= 1000;
  return d;
}
int main() {
  setup();
  struct timeval start, end;
  gettimeofday(&start, 0);
  int r = 0;
  for (int i=0; i<100000000; i++) {
    r += load();
  }
  gettimeofday(&end, 0);
  printf("%3.0f ms\n", msecs(&end) - msecs(&start));
  return r;
}
