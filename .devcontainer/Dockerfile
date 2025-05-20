FROM rockylinux:8.9

ARG REINSTALL_CMAKE_VERSION_FROM_SOURCE="3.22.2"



# Install Boost libraries
COPY ./install_boost_libs_from_src.sh /tmp/
RUN chmod +x /tmp/install_boost_libs_from_src.sh && /tmp/install_boost_libs_from_src.sh \
    && rm -f /tmp/install_boost_libs_from_src.sh

# Lazygit variables
ARG LG='lazygit'
ARG LG_GITHUB='https://github.com/jesseduffield/lazygit/releases/download/v0.31.4/lazygit_0.31.4_Linux_x86_64.tar.gz'
ARG LG_ARCHIVE='lazygit.tar.gz'

# Install development tools
COPY ./install_devtools.sh /tmp/
RUN chmod +x /tmp/install_devtools.sh && /tmp/install_devtools.sh \
    && rm -f /tmp/install_devtools.sh

# Install Neovim
COPY ./install_neovim_from_src.sh /tmp/
RUN chmod +x /tmp/install_neovim_from_src.sh && /tmp/install_neovim_from_src.sh && rm -f /tmp/install_neovim_from_src.sh


# Install clangd
COPY ./get_latest_clangd.sh /tmp/
RUN chmod +x /tmp/get_latest_clangd.sh && /tmp/get_latest_clangd.sh \
&& rm -f /tmp/get_latest_clangd.sh

# fix problem with cr/lf under windows-linux developement.
RUN git config --global core.autocrlf input

# enable huge pages
RUN mkdir /hugetlbfs && \
    echo "hugetlbfs /hugetlbfs hugetlbfs defaults 0 0" >> /etc/fstab

# persist bash history
RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/local_store/.bash_history" \
    && echo "$SNIPPET" >> "/root/.bashrc"

# ssh credentials for scp
COPY ./ssh_config /root/.ssh/config

# setup pretty printers for gdb
COPY ./.gdbinit /root/

# setup colors in bash
COPY ./.add_to_bash_rc /tmp/
RUN cat /tmp/.add_to_bash_rc >> ~/.bashrc

WORKDIR /workspaces

#TODO https://github.com/microsoft/vscode-remote-try-cpp/blob/main/.devcontainer/reinstall-cmake.sh
## reinstall cmake version 3.6

# [Optional] Uncomment this section to install additional vcpkg ports.
# RUN su vscode -c "${VCPKG_ROOT}/vcpkg install <your-port-name-here>"

# [Optional] Uncomment this section to install additional packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>
