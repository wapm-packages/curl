
#!/usr/bin/env sh

# Based on code from https://github.com/TrueBitFoundation/wasm-ports/blob/master/openssl.sh

OPENSSL_VERSION="master"
CURL_VERSION="7_69_0"
PREFIX=`pwd`

OPENSSL_DIRECTORY="OpenSSL-${OPENSSL_VERSION}"
CURL_DIRECTORY="curl-curl-${CURL_VERSION}"


if [ ! -d "$OPENSSL_DIRECTORY" ]; then
  echo "Download curl source code"
  wget https://github.com/wapm-packages/OpenSSL/archive/refs/heads/${OPENSSL_VERSION}.tar.gz
  tar xf ${OPENSSL_VERSION}.tar.gz
fi

if [ ! -d "$CURL_DIRECTORY" ]; then
  echo "Download curl source code"
  wget https://github.com/curl/curl/archive/refs/tags/curl-${CURL_VERSION}.tar.gz
  tar xf curl-${CURL_VERSION}.tar.gz
fi

cd ${CURL_DIRECTORY}

echo "Configure"
if [ ! -f "./configure" ]; then
    autoreconf -fi
fi

wasix-configure ./configure --host wasm32 \
    --disable-shared --disable-thread --disable-threaded-resolver \
    --without-libpsl --disable-netrc --disable-unix-sockets \
    --disable-ipv6 --disable-tftp \
    --with-ssl=${PREFIX}/${OPENSSL_DIRECTORY} \
    --disable-ntlm-wb


echo "Build"
make -j8

cp src/curl.wasm ../

echo "Done"
