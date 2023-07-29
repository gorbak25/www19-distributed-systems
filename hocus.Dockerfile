FROM hocusdev/workspace

RUN DEBIAN_FRONTEND=noninteractive sudo apt-get install -y psmisc expect unzip curl git dirmngr gpg gawk \
    && git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0 \
    && echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc \
    && echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc \
    && mkdir -p ~/.config/fish/completions \
    && echo 'source ~/.asdf/asdf.fish' >> ~/.config/fish/config.fish \
    && ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions \
    && bash -c "asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git" \
    && bash -c "asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git" \
    && bash -c "asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git" \
    && bash -c "asdf install nodejs latest" \
    && bash -c "asdf install erlang latest" \
    && bash -c "asdf install elixir latest"
