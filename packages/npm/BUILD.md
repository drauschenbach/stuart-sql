# Publishing to npmjs.com

## 1. Login

```sh
$ npm login
...
```

## 2. Prepare amalgamated Lua file

```sh
$ lua amalgamate.lua ../../stuart-sql-1.0.0-0.rockspec
```

This generates `stuart-sql.lua`, `package.json`, and `lua-stuart-sql.tgz` files.

## 3. Upload to npmjs.com

```sh
$ npm publish lua-stuart-sql.tgz
```
