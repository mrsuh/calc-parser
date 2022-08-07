# Calc parser

A simple calculator parser built with [GNU Bison](https://www.gnu.org/software/bison/)

## Requirements
* PHP 7.4 (with FFI)
* Linux(x86_64)

## Example

file.txt
```text
1 + 2 - 3
```

```bash
php bin/parse.php
```

```bash
OPERATION_MINUS
  OPERATION_PLUS
    NUMBER "1"
    NUMBER "2"
  NUMBER "3"
```

## Development

### Requirements
* Bison 3.8

### How to compile
```bash
make
```

### Docker
```bash
docker build -t calc-parser .
docker run -v "$PWD":/code -it calc-parser bash
make
php bin/parse.php
```
