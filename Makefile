BISON := $(shell which bison)
ifndef BISON
    $(error "No bison found in $PATH")
endif

all: clean
	bison --header -o src/calc.c src/calc.y
	gcc -fPIC -shared $(HFOLDERS) -I src -o src/calc_linux.so src/calc.c

.PHONY: clean
clean:
	rm -rf src/calc.c src/calc.h

