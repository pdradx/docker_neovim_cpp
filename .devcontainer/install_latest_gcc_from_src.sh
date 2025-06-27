#!/usr/bin/env bash
set -ex  # Exit on error (-e) and print each command (-x) for debugging

cd /root
dnf groupinstall "Development Tools" -y
dnf install wget bzip2 tar xz gcc gcc-c++ make -y
gcc_prefix="gcc-15"
gcc_name="gcc-15.1.0"
#site_mirror="https://ftp.gnu.org/gnu/gcc"
site_mirror="https://mirror.linux-ia64.org/gnu/gcc/releases"
download_link=${site_mirror}/${gcc_name}/${gcc_name}.tar.gz
echo "Trying to download ${download_link}"
wget ${download_link}
tar -xvzf ${gcc_name}.tar.gz
cd ${gcc_name}
./contrib/download_prerequisites
mkdir build && cd build
../configure --enable-languages=c,c++ --disable-multilib --prefix=/usr/local/${gcc_prefix}
make -j$(nproc)
make install
sudo alternatives --install /usr/bin/gcc gcc /usr/local/${gcc_prefix}/bin/gcc 100
sudo alternatives --install /usr/bin/g++ g++ /usr/local/${gcc_prefix}/bin/g++ 100

