#include <pthread.h>
static pthread_key_t key;
void setup(){
  pthread_key_create(&key, 0);
}

int v;
int load() {
  return v;
  //return (int)pthread_getspecific(key);
}
