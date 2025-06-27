#!/usr/bin/env bash
set -ex  # Exit on error (-e) and print each command (-x) for debugging

mkdir /tmp/clangd_distr
cd /tmp/clangd_distr
wget https://github.com/clangd/clangd/releases/download/19.1.2/clangd-linux-19.1.2.zip
unzip clangd-linux-19.1.2.zip
mv clangd_19.1.2 /
ln -s /clangd_19.1.2/bin/clangd /usr/bin/clangd
cd /tmp
rm -rf /tmp/clangd_distr


