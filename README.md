# Calc parser

A simple calculator parser built with [GNU Bison](https://www.gnu.org/software/bison/) and [re2c](https://re2c.org)

## Requirements
* PHP 7.4 (with FFI)
* Linux(x86_64)

## Example

```bash
php bin/parse.php "10 + 20 - 30"
```

```bash
OPERATION_MINUS
  OPERATION_PLUS
    NUMBER "10"
    NUMBER "20"
  NUMBER "30"
```

## Development

### Requirements
* Bison 3.8
* re2c 3.0

### How to compile
```bash
make
```

### Docker
```bash
docker build -t calc-parser .
docker run -v "$PWD":/code -it calc-parser bash
make
php bin/parse.php "10 + 20 - 30"
```
