#!/usr/bin/env bash

docker run -it \
	--mount type=bind,src=$HOME/projects,dst=/workspaces \
	--mount type=volume,src=neovim-cpp-local-store,dst=/local_store  \
	--mount "type=bind,source=$HOME/.config/nvim,target=/local_store/nvim_config" \
	--mount "type=bind,source=$HOME/.ssh,target=/local_store/.ssh" \
	--memory=6gb \
	--hostname=shengli_fh \
	docker-neovim-cpp
# docker run -it docker-neovim-cpp --mount type=volume,src=<volume-name>,dst=<mount-path>


