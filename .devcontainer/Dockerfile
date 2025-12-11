FROM rockylinux:8.9

RUN dnf -y update
RUN dnf -y groupinstall "Development Tools"
RUN dnf -y install wget bzip2 tar xz gcc gcc-c++ make
RUN dnf -y --enablerepo=powertools install ninja-build
RUN dnf -y install epel-release
RUN dnf -y install glib2-devel cppzmq-devel
RUN dnf -y install tcpreplay

#Install GCC compiler from sources
# COPY ./install_gcc_from_src.sh /tmp/
# RUN chmod +x /tmp/install_gcc_from_src.sh && /tmp/install_gcc_from_src.sh \
#     && rm -f /tmp/install_gcc_from_src.sh
# COPY ./install_latest_gcc_from_src.sh /tmp/
# RUN chmod +x /tmp/install_latest_gcc_from_src.sh && /tmp/install_latest_gcc_from_src.sh \
#     && rm -f /tmp/install_latest_gcc_from_src.sh

# Install gcc as toolset
COPY ./install_gcc_as_toolset.sh /tmp/
RUN chmod +x /tmp/install_gcc_as_toolset.sh && /tmp/install_gcc_as_toolset.sh \
    && rm -f /tmp/install_gcc_as_toolset.sh

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
RUN chmod +x /tmp/get_latest_clangd.sh && /tmp/get_latest_clangd.sh && rm -f /tmp/get_latest_clangd.sh

# # enable huge pages
# RUN mkdir /hugetlbfs && \
#     echo "hugetlbfs /hugetlbfs hugetlbfs defaults 0 0" >> /etc/fstab

# Install openonload userfiles
COPY ./sf-109585-ls-47-openonload-release-package/onload-9.0.2.140.tgz /tmp/
COPY ./install_openonload.sh /tmp/
RUN chmod +x /tmp/install_openonload.sh && /tmp/install_openonload.sh && rm -f /tmp/install_openonload.sh

# Install exanic bin libs
COPY ./install_exanic.sh /tmp/
RUN chmod +x /tmp/install_exanic.sh && /tmp/install_exanic.sh && rm -f /tmp/install_exanic.sh

RUN dnf -y install openssh-server
RUN mkdir /var/run/sshd
RUN ssh-keygen -A

# setup user of devcontainer
# Define the ARG for username (with a default value)
ARG USERNAME=me
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user and group
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME
RUN echo "zzz123" | passwd --stdin $USERNAME

# [Optional] Add the user to sudoers (if needed)
RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# persist bash history
RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/local_store/.bash_history" \
    && echo "$SNIPPET" >> "/home/$USERNAME/.bashrc"

# setup volume for local caches and settings
RUN mkdir -p /local_store && \
    chown $USERNAME:$USERNAME /local_store
# VOLUME ["/local_store"]

# set user
USER $USERNAME

# ssh credentials for scp
RUN ln -sf /local_store/.ssh /home/$USERNAME/.ssh
RUN ln -sf /local_store/.gitconfig "/home/$USERNAME/.gitconfig"
RUN ln -sf /local_store/XDG/cache "/home/$USERNAME/.cache"
RUN mkdir -p /home/$USERNAME/.config && chown $USERNAME:$USERNAME /home/$USERNAME/.config && \
    ln -sf /local_store/nvim_config /home/$USERNAME/.config/nvim
RUN ln -sf /local_store/lazy_vim /home/$USERNAME/.config/lazy_vim

# Install cargo and stylua
RUN sudo dnf install -y curl
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable
ENV PATH="/home/$USERNAME/.cargo/bin:${PATH}"

RUN rustup update
RUN cargo install stylua

# Install tree-sitter-cli dependencies
RUN cargo install --locked tree-sitter-cli
# RUN sudo dnf install -y nodejs npm
# Install more fresh nodejs and npm
RUN sudo dnf -y module install nodejs:18

# setup pretty printers for gdb
COPY --chown=$USERNAME ./.gdbinit /home/$USERNAME/

# setup colors in bash
COPY ./.add_to_bash_rc /tmp/
RUN cat /tmp/.add_to_bash_rc >> ~/.bashrc

# setup tmux
COPY --chown=$USERNAME ./.tmux.conf /home/$USERNAME/

# config for lazygit
COPY --chown=$USERNAME ./lazygit_config.yml /home/$USERNAME/.config/lazygit/config.yml

# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN sudo chmod +x /usr/local/bin/docker-entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Default command (can be overridden)
CMD ["/bin/bash"]

WORKDIR /workspaces

