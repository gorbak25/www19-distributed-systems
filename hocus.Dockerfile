FROM hocusdev/workspace

RUN sudo apt-get update \
    && DEBIAN_FRONTEND=noninteractive sudo apt-get install -y locales psmisc expect unzip curl git dirmngr gpg gawk build-essential autoconf m4 libncurses5-dev libwxgtk3.0-gtk3-dev libwxgtk-webview3.0-gtk3-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk \
    && sudo locale-gen en_US.UTF-8 \
    && sudo update-locale LANG=en_US.UTF-8 LANGUAGE=en_US \
    && git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0 \
    && echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc \
    && echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc \
    && mkdir -p ~/.config/fish/completions \
    && echo 'source ~/.asdf/asdf.fish' >> ~/.config/fish/config.fish \
    && ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions \
    && fish -c "asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git" \
    && fish -c "asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git" \
    && fish -c "asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git" \
    && fish -c "asdf install nodejs latest" \
    && fish -c "KERL_BUILD_DOCS=yes asdf install erlang latest" \
    && fish -c "KERL_BUILD_DOCS=yes asdf install elixir latest" \
    && fish -c "asdf global nodejs latest" \
    && fish -c "asdf global erlang latest" \
    && fish -c "asdf global elixir latest"
RUN fish -c "mix archive.install hex phx_new" \
    && sudo apt-get install -y inotify-tools \
    && {curl -fsSL https://tailscale.com/install.sh | sh}
