FROM hocusdev/workspace

RUN DEBIAN_FRONTEND=noninteractive sudo apt-get install -y psmisc expect unzip curl git dirmngr gpg gawk \
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
    && fish -c "KERL_BUILD_DOCS=yes asdf install elixir latest"
