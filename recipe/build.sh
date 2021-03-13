#!/usr/bin/env bash
set -eux

if [[ $(uname) = "Darwin" ]]; then
    export LDFLAGS="${LDFLAGS} -L$PREFIX/lib -Wl,-rpath,$PREFIX/lib"
fi

export GOPATH="$( pwd )"
export CGO_ENABLED=1
export CGO_CFLAGS="${CFLAGS}"
export CGO_CXXFLAGS="${CPPFLAGS}"
export CGO_LDFLAGS="${LDFLAGS}"
export GOFLAGS="-buildmode=pie -trimpath -ldflags=-linkmode=external -mod=vendor -modcacherw"
export GOTAGS="openssl"

module='github.com/ipfs/go-ipfs'

make -C "src/${module}" install nofuse

bash $RECIPE_DIR/build_library_licenses.sh
