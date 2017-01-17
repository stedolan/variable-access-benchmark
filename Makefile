.PHONY: benchmark

CC = cc

%.o: %.c
	$(CC) -c -O2 $^

%.exe: var-%.c var-main.o
	$(CC) -O2 $(CFLAGS) $^ -o $@

pthread%: CC := cc -pthread

%.pic.exe: var-%.c var-main.o
	$(CC) -O2 -fPIC $^ -o $@

%.so.exe: var-%.c var-main.o
	$(CC) -O2 -shared -fPIC $< -o $*.so
	$(CC) -L. var-main.o -l:$*.so -o $@

BENCHMARKS = \
  global.exe global.pic.exe global.so.exe \
  tls.exe tls.pic.exe tls.so.exe \
  pthread.exe pthread.pic.exe pthread.so.exe

benchmark: $(BENCHMARKS)
	for i in $^; do \
	  printf "%15s: " $${i%.exe}; \
	  LD_LIBRARY_PATH=.:$$LD_LIBRARY_PATH ./$$i; \
	done

clean:
	rm -f *.exe *.o *.so
