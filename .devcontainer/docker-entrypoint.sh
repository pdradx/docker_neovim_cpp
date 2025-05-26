#!/bin/bash
# Mount hugetlbfs and set hugepages
sudo sysctl -w vm.nr_hugepages=300
sudo mkdir -p /hugetlbfs
sudo mount -t hugetlbfs hugetlbfs /hugetlbfs
sudo chmod 0777 /hugetlbfs

# Execute the main command
exec "$@"
