#!/usr/bin/env bash
set -ex # Exit on error (-e) and print each command (-x) for debugging

IMAGE_NAME=docker-neovim-cpp
CONTAINER_NAME=neovim-cpp

# docker build --progress=plain --no-cache -t $IMAGE_NAME ./.devcontainer
docker build --progress=plain -t $IMAGE_NAME ./.devcontainer

docker rm --force $CONTAINER_NAME

is_docker_podman() {
    docker --version 2>/dev/null | grep -qi podman && return 0
    docker info 2>/dev/null | grep -qi podman && return 0
    return 1
}

# docker run -d \
#     --privileged \
#     -p 2000:22 \
#     --name $CONTAINER_NAME \
#     --mount type=bind,src=/dev/hugepages,dst=/dev/hugepages \
#     --mount type=bind,src=$HOME/projects,dst=/workspaces \
#     --mount type=volume,src=neovim-cpp-local-store,dst=/local_store  \
#     --mount "type=bind,source=$HOME/.config/nvim,target=/local_store/nvim_config" \
#     --mount "type=bind,source=$HOME/.ssh,target=/local_store/.ssh" \
#     --memory=16gb \
#     --memory-swap=-1 \
#     --hostname=neovim_cpp \
#     --cap-add=NET_RAW \
#     $IMAGE_NAME \
#     sudo /usr/sbin/sshd -D
#

run_args=(
    run -d
    --privileged
    -p 2000:22
    --name $CONTAINER_NAME
    --mount type=bind,src=/dev/hugepages,dst=/dev/hugepages
    --mount type=bind,src=$HOME/projects,dst=/workspaces
    --mount type=volume,src=neovim-cpp-local-store,dst=/local_store 
    --mount type=volume,src=neovim-cpp-ssh-store,dst=/etc/ssh 
    --mount "type=bind,source=$HOME/.config/nvim,target=/local_store/nvim_config"
    --mount "type=bind,source=$HOME/.ssh,target=/local_store/.ssh"
    --memory=16gb
    --memory-swap=-1
    --hostname=neovim_cpp
    --cap-add=NET_RAW
)


if is_docker_podman; then
    echo "Podman environment detected!!!"
    run_args+=(--userns=keep-id);
fi

docker "${run_args[@]}" "$IMAGE_NAME" sudo /usr/sbin/sshd -D

# --userns=keep-id \ # add for podman container only!
# tail -f /dev/null
