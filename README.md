# Stuart SQL

<img src="http://downloadicons.net/sites/default/files/mouse-icon-86497.png" width="100">

A native Lua implementation of [Spark SQL](https://spark.apache.org/docs/2.2.0/sql-programming-guide.html).

This is a companion module for [Stuart](https://github.com/BixData/stuart), the Spark runtime for embedding and edge computing.

![Build Status](https://api.travis-ci.org/BixData/stuart-sql.svg?branch=master)

## Getting Started

### Installing

```sh
$ luarocks install stuart-sql
```

## Testing

### Testing Locally

```sh
$ busted
●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
39 successes / 0 failures / 0 errors / 0 pending : 0.068103 seconds
```

### Testing with a Specific Lua Version

```sh
$ docker build -f Test-Lua53.Dockerfile -t test .
$ docker run -it test busted
●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
39 successes / 0 failures / 0 errors / 0 pending : 0.068103 seconds
```
