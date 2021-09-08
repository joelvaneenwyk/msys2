#! /bin/sh

pacman -S --quiet --noconfirm --needed \
    msys2-devel msys2-runtime-devel msys2-keyring \
    base-devel git autoconf automake1.16 automake-wrapper libtool libcrypt-devel openssl \
    mingw-w64-x86_64-make mingw-w64-x86_64-gcc mingw-w64-x86_64-binutils \
    texinfo texinfo-tex mingw-w64-x86_64-texlive-bin mingw-w64-x86_64-texlive-core mingw-w64-x86_64-texlive-extra-utils \
    mingw-w64-x86_64-perl \
    mingw-w64-x86_64-poppler
