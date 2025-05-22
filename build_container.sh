#!/usr/bin/env bash

IMAGE_NAME=docker-neovim-cpp
CONTAINER_NAME=neovim-cpp

docker build -t $IMAGE_NAME ./.devcontainer

docker rm --force $CONTAINER_NAME

docker run -d \
    --name $CONTAINER_NAME \
	--mount type=bind,src=$HOME/projects,dst=/workspaces \
	--mount type=volume,src=neovim-cpp-local-store,dst=/local_store  \
	--mount "type=bind,source=$HOME/.config/nvim,target=/local_store/nvim_config" \
	--mount "type=bind,source=$HOME/.ssh,target=/local_store/.ssh" \
	--memory=6gb \
	--hostname=neovim_cpp \
    $IMAGE_NAME \
    tail -f /dev/null



