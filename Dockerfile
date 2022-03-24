FROM ghcr.io/kmmiles/rocky8-wsl:main

RUN set -ex; \
  printf "Hello world\n"
