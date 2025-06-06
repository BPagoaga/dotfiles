URL="https://raw.githubusercontent.com/BPagoaga/dotfiles/refs/heads/main/"
GIT=https://github.com/BPagoaga/dotfiles.git

# deps
sudo pacman -Sy zsh wlogout waybar fuzzel dunst xdg-desktop-portal-gtk ly niri tealdeer yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide imagemagick btop

# change shell to zsh
chsh -s /usr/bin/zsh

#install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install dotbare
git clone https://github.com/kazhala/dotbare.git $HOME/.oh-my-zsh/custom/plugins/dotbare

# use direct config files for convenience
curl $URL/.zshrc -o $HOME/.zshrc
curl $URL/.zshenv -o $HOME/.zshenv
source $HOME/.zshrc
source $HOME/.zshenv

dotbare finit -u $GIT

# disable getty on tty2 and enable ly
sudo systemctl enable ly.service sudo systemctl disable getty@tty2.service

# install wezterm
curl https://sh.rustup.rs -sSf | sh -s
git clone --depth=1 --branch=main --recursive https://github.com/wezterm/wezterm.git
cd wezterm
git submodule update --init --recursive
./get-deps
cargo build --release

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# install starship
curl -sS https://starship.rs/install.sh | sh
