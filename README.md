# Darwin Security Trust API compatibility shim

The shim that does exactly one thing:

provides symbol `_SecTrustCopyCertificateChain` (macOS 12+ API) on earlier macOS versions.

## Motivation

Make `go 1.25` toolchain and binaries, produced by it, run on macOS Big Sur.

## Building

### With make (Xcode required)

```sh
make
```

### With nix

```sh
nix build
```

### Verify

The dylib must export `_SecTrustCopyCertificateChain` (and must not import it).

<details><summary>Click here for details</summary>

```sh
LIBSECTRUSTCOMPAT=libsectrust_compat.dylib
# LIBSECTRUSTCOMPAT=result/lib/libsectrust_compat.dylib

❯ nm -u "$LIBSECTRUSTCOMPAT" | grep -o _SecTrustCopyCertificateChain

❯ nm -g "$LIBSECTRUSTCOMPAT" | grep -o _SecTrustCopyCertificateChain
_SecTrustCopyCertificateChain

```

</details>

## Usage Examples

### Running go1.25 on macOS Big Sur

```sh
❯  DYLD_INSERT_LIBRARIES="$LIBSECTRUSTCOMPAT" DYLD_FORCE_FLAT_NAMESPACE=1 go version
go version go1.25.4 darwin/arm64

```

### Go Module

See [examples/hello](./examples/hello/README.md)

## Shim availability

As a safenet, the shim is disabled if newer macOS SDK is detected.

To override this behavior, use `-DSECTRUST_COMPAT`.

Details: [darwin_sectrust_compat.c](./darwin_sectrust_compat.c)

## License

[MIT](./LICENSE)
