#!/usr/bin/env bash
set -ex  # Exit on error (-e) and print each command (-x) for debugging

dnf update -y
dnf -y install epel-release
dnf groupinstall 'Development Tools' -y
dnf install -y gcc-c++ compat-openssl10 cmake \
    java-11-openjdk java-11-openjdk-devel \
    libstdc++ libstdc++-devel \
    wget zlib-devel openssl openssl-devel libasan \
    systemtap-sdt-devel \
    iproute \
    rsync vim \
    passwd man sudo \
    htop atop tmux \
    # clang-tools-extra

# systemctl enable --now atop
dnf --enablerepo=powertools -y install libstdc++-static \
    svn

alternatives --set java /usr/lib/jvm/java-11-openjdk-11.0.25.0.9-2.el8.x86_64/bin/java

dnf clean all

mkdir /gdb_printers
cd /gdb_printers
svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python

# Create TMP directory
mkdir -p /root/TMP

# Install Lazygit from binary
cd /root/TMP && curl -L -o $LG_ARCHIVE $LG_GITHUB
cd /root/TMP && tar xzvf $LG_ARCHIVE && mv $LG /usr/bin/

# Delete TMP directory
rm -rf /root/TMP


