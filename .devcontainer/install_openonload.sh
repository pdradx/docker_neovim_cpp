#!/usr/bin/env bash
set -ex  # Exit on error (-e) and print each command (-x) for debugging

dnf -y install libcap-devel libmnl-devel

mkdir -p /tmp/openonload_tmp
cd /tmp/openonload_tmp
tar -xzvf /tmp/onload-9.0.2.140.tgz -C /tmp/openonload_tmp
cd onload-9.0.2.140
export PATH="$PWD/scripts:$PATH"
mmakebuildtree --user
make -C "$(mmaketool --toppath)/build/$(mmaketool --userbuild)"
onload_install --nobuild --userfiles

rm -rf /tmp/openonload_tmp
rm /tmp/onload*
