#!/usr/bin/env bash

set -e
dnf -y update
dnf -y install epel-release
dnf -y groupinstall "Development Tools"
dnf -y install wget bzip2 tar xz gcc gcc-c++ make
dnf -y install boost1.78 boost1.78-static
dnf -y --enablerepo=powertools install ninja-build

# dnf clean all

