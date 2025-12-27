//go:build darwin && cgo

// Backward compatible implementation of SecTrustCopyCertificateChain (macOS 12)
// Disabled by default, except when macOS SDK older than 12 is detected. 
// Use -DSECTRUST_COMPAT to force-enable.

// Usage:
//
// import _ "github.com/ink-splatters/security-compat"
//

package security_compat

/*
#cgo CFLAGS: -Wno-deprecated-declarations
#cgo LDFLAGS: -framework Security -framework CoreFoundation
*/
import "C"
