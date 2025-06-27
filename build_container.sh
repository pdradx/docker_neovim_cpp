#!/usr/bin/env bash

IMAGE_NAME=docker-neovim-cpp
CONTAINER_NAME=neovim-cpp

# docker build --no-cache -t $IMAGE_NAME ./.devcontainer
docker build -t $IMAGE_NAME ./.devcontainer

docker rm --force $CONTAINER_NAME

docker run -d \
    --privileged \
    --name $CONTAINER_NAME \
    --mount type=bind,src=$HOME/projects,dst=/workspaces \
    --mount type=volume,src=neovim-cpp-local-store,dst=/local_store  \
    --mount "type=bind,source=$HOME/.config/nvim,target=/local_store/nvim_config" \
    --mount "type=bind,source=$HOME/.ssh,target=/local_store/.ssh" \
    --memory=6gb \
    --memory-swap=-1 \
    --hostname=neovim_cpp \
    $IMAGE_NAME \
    tail -f /dev/null



