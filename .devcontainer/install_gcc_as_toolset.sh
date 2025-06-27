#!/usr/bin/env bash
set -ex  # Exit on error (-e) and print each command (-x) for debugging

dnf -y update
dnf -y groupinstall "Development Tools"
dnf -y install wget bzip2 tar xz gcc gcc-c++ make
dnf -y install gcc-toolset-14

echo "source /opt/rh/gcc-toolset-14/enable" > /etc/profile.d/gcc-toolset-14.sh
chmod +x /etc/profile.d/gcc-toolset-14.sh
source /etc/profile

