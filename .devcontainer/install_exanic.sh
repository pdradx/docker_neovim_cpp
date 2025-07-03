#!/usr/bin/env bash
set -ex  # Exit on error (-e) and print each command (-x) for debugging


mkdir -p /tmp/exanic_tmp
cd /tmp/exanic_tmp
git clone https://github.com/cisco/exanic-software.git
cd exanic-software
make bin
make install-bin

cd /tmp
rm -rf /tmp/exanic_tmp
