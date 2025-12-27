CC ?= clang
CFLAGS ?= -Wall -Wextra -O2 -mcpu=native
LDFLAGS ?= -dynamiclib -Wl,-exported_symbol,_SecTrustCopyCertificateChain -fuse-ld=lld -framework Security -framework CoreFoundation
SRC = security_compat.c
TARGET = libsecurity_compat.dylib
PREFIX ?=

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<

install: $(TARGET)
	@if [ -z "$(PREFIX)" ] || [ ! -d "$(PREFIX)" ]; then \
		echo "No valid install prefix."; \
	else \
		echo "Installing to $(LIBDIR)..."; \
		install -m 755 $(TARGET) $(LIBDIR) 2>/dev/null || true; \
	fi

clean:
	rm -f $(TARGET)

.PHONY: clean install
