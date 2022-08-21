BISON := $(shell which bison)
ifndef BISON
    $(error "No bison found in $PATH")
endif

all: clean
	bison --header -o src/parser.c src/parser.y
	re2c src/lexer.l > src/lexer.c
	gcc -fPIC -shared -I src -o src/library_linux.so src/ast.c src/lexer.c src/parser.c

.PHONY: clean
clean:
	rm -rf src/parser.c src/parser.h src/lexer.c src/library_linux.so

dump:
	bison --header -o src/parser.c src/parser.y
	re2c src/lexer.l > src/lexer.c
	gcc -g src/ast.c src/lexer.c src/parser.c -o src/dump
	./src/dump /code/test.txt
