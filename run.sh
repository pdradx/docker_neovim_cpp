#!/usr/bin/env bash
set -ex  # Exit on error (-e) and print each command (-x) for debugging

CONTAINER_NAME=neovim-cpp

docker start $CONTAINER_NAME
# docker exec -it $CONTAINER_NAME bash
docker exec -it $CONTAINER_NAME bash -i -c tmux
# docker exec -it $CONTAINER_NAME bash -i -c "tmux new-session -A -s def"

