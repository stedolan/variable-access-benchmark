#include <pthread.h>
static pthread_key_t key;
void setup(){
  pthread_key_create(&key, 0);
}

int load() {
  return (pthread_getspecific(key) == 0);
}
