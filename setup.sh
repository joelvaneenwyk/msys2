#! /bin/sh

pacman -S --quiet --noconfirm --needed \
    msys2-devel msys2-runtime-devel msys2-keyring \
    base-devel git autoconf automake1.16 automake-wrapper libtool libcrypt-devel openssl \
    mingw-w64-x86_64-make mingw-w64-x86_64-gcc mingw-w64-x86_64-binutils \
    texinfo texinfo-tex mingw-w64-x86_64-texlive-bin mingw-w64-x86_64-texlive-core mingw-w64-x86_64-texlive-extra-utils \
    mingw-w64-x86_64-perl \
    mingw-w64-x86_64-poppler

# Removing 'db' from these to improve performance on domain joined
# machines, see https://gist.github.com/k-takata/9b8d143f0f3fef5abdab
mkpasswd -l -c >/etc/passwd
mkgroup -l -c >/etc/group

cp -f nsswitch.conf /etc/nsswitch.conf

export HOME=/c/Users/ContainerAdministrator
mkdir -p "$HOME/workspace"
{
    echo "export HOME=$HOME"
    echo "export MSYS=winsymlinks:nativestrict"
    echo "cd $HOME"
    echo "echo Welcome home."
} >"$HOME/.bash_profile"

echo "cd $HOME" >>"/etc/profile"
