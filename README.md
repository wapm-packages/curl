# Curl

You can install curl with:

```shell
wapm install curl
```

## Running

You can run curl cli

```shell
$ wasmer run curl.wasm --mapdir=/etc/ssl:/etc/ssl -- https://registry.wapm.io/graphql -v
```

## Building from Source

You will need [Wasix](https://github.com/wasmer/wasix) to build the `curl.wasm` file.

Steps:

1. Setup wasienv, see
   [Installation Instructions](https://github.com/wasmer/wasix)
2. Run `./build.sh`
