#!/usr/bin/env bash
set -ex  # Exit on error (-e) and print each command (-x) for debugging

cd /root
dnf groupinstall "Development Tools" -y
dnf install wget bzip2 tar xz gcc gcc-c++ make -y
wget https://ftp.gnu.org/gnu/gcc/gcc-8.5.0/gcc-8.5.0.tar.gz
tar -xvzf gcc-8.5.0.tar.gz
cd gcc-8.5.0
./contrib/download_prerequisites
mkdir build && cd build
../configure --enable-languages=c,c++ --disable-multilib --prefix=/usr/local/gcc-8
make -j$(nproc)
make install
sudo alternatives --install /usr/bin/gcc gcc /usr/local/gcc-8/bin/gcc 100
sudo alternatives --install /usr/bin/g++ g++ /usr/local/gcc-8/bin/g++ 100

