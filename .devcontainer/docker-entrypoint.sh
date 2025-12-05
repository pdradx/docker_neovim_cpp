#!/bin/bash
set -ex  # Exit on error (-e) and print each command (-x) for debugging

# # Mount hugetlbfs and set hugepages
# sudo sysctl -w vm.nr_hugepages=300
# sudo mkdir -p /hugetlbfs
# sudo mount -t hugetlbfs hugetlbfs /hugetlbfs
# sudo chmod 0777 /hugetlbfs

sudo rm -f /run/nologin

# Execute the main command
exec "$@"
