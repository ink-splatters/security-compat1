//go:build darwin && cgo && sectrust_compat

package darwin_sectrust_compat

/*
#cgo CFLAGS: -DSECTRUST_COMPAT
*/
import "C"
