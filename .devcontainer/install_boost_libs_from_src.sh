#!/usr/bin/env bash

set -e
dnf -y update
dnf -y groupinstall "Development Tools"
dnf -y install wget bzip2 tar xz gcc gcc-c++ make
# TODO check weter CMake works much more faster without ninja-build under a docker in windows wsl??!!!
dnf -y --enablerepo=powertools install ninja-build

mkdir /tmp/boost_src
cd /tmp/boost_src
boost_name="boost_1_83_0"
boost_arch_name=$boost_name".tar.bz2"
wget "https://archives.boost.io/release/1.83.0/source/"$boost_arch_name
tar --bzip2 -xf $boost_arch_name
cd $boost_name
# get the no of cpucores to make faster
cpuCores=`cat /proc/cpuinfo | grep "siblings" | uniq | awk '{print $NF}'`
echo "Available CPU cores: "$cpuCores
./bootstrap.sh  # this will generate ./b2
./b2 --with=all -j $cpuCores install

echo "Boost libs installed:"
cat /usr/local/include/boost/version.hpp | grep "BOOST_LIB_VERSION"

cd /tmp
rm -rf /tmp/boost_src
dnf clean all

