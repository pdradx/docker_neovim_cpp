#!/usr/bin/env bash

CONTAINER_NAME=neovim-cpp

docker start $CONTAINER_NAME
docker exec -it $CONTAINER_NAME bash

