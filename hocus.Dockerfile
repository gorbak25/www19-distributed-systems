FROM hocusdev/workspace

RUN DEBIAN_FRONTEND=noninteractive sudo apt-get install -y psmisc expect unzip curl git dirmngr gpg gawk \
    && git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0 \
    && echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc \
    && echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc \
    && mkdir -p ~/.config/fish/completions \
    && echo 'source ~/.asdf/asdf.fish' >> ~/.config/fish/config.fish \
    && ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
RUN cspell link add @cspell/dict-html-symbol-entities && cspell link add @cspell/dict-lorem-ipsum && cspell link add @cspell/dict-npm
