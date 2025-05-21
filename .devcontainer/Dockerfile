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

# enable huge pages
RUN mkdir /hugetlbfs && \
    echo "hugetlbfs /hugetlbfs hugetlbfs defaults 0 0" >> /etc/fstab

# setup user of devcontainer
# Define the ARG for username (with a default value)
ARG USERNAME=me
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user and group
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

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
# COPY --chown=$USERNAME ./ssh_config /home/$USERNAME/.ssh/config
RUN ln -sf /local_store/.ssh /home/$USERNAME/.ssh
RUN ln -sf /local_store/.gitconfig "/home/$USERNAME/.gitconfig"
RUN mkdir -p /home/$USERNAME/.config && chown $USERNAME:$USERNAME /home/$USERNAME/.config && \
    ln -sf /local_store/nvim_config /home/$USERNAME/.config/nvim


# setup pretty printers for gdb
COPY --chown=$USERNAME ./.gdbinit /home/$USERNAME/

# setup colors in bash
COPY ./.add_to_bash_rc /tmp/
RUN cat /tmp/.add_to_bash_rc >> ~/.bashrc

WORKDIR /workspaces

