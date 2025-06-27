#!/usr/bin/env bash
set -ex  # Exit on error (-e) and print each command (-x) for debugging

dnf install -y gcc make git ripgrep fd-find unzip

cd /tmp
git clone --depth=1 --branch stable https://github.com/neovim/neovim
cd neovim

make CMAKE_BUILD_TYPE=Release
make install

cd /tmp
rm -rf ./neovim

