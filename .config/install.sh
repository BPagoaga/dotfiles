#!/bin/bash
URL=https://raw.githubusercontent.com/BPagoaga/dotfiles/refs/heads/main/
GIT=https://github.com/BPagoaga/dotfiles.git

# deps
echo "Installing dependencies..."
sudo pacman -Sy --needed --noconfirm zsh wlogout waybar fuzzel dunst xdg-desktop-portal-gtk ly niri tealdeer yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide imagemagick btop || true

# change shell to zsh
echo "Changing default shell to zsh..."
sudo chsh -s /usr/bin/zsh

#install oh-my-zsh
echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install dotbare
ehco "Installing dotbare..."
git clone https://github.com/kazhala/dotbare.git $HOME/.oh-my-zsh/custom/plugins/dotbare

# use direct config files for convenience
echo "Using direct config files..."
curl $URL/.zshrc -o $HOME/.zshrc
curl $URL/.zshenv -o $HOME/.zshenv
source $HOME/.zshrc
source $HOME/.zshenv

echo "Installing dotfiles..."
dotbare finit -u $GIT

# disable getty on tty2 and enable ly
echo "Disabling getty on tty2 and enabling ly..."
sudo systemctl enable ly.service
sudo systemctl disable getty@tty2.service

# install wezterm
echo "Installing wezterm..."
curl https://sh.rustup.rs -sSf | sh -s
git clone --depth=1 --branch=main --recursive https://github.com/wezterm/wezterm.git
cd wezterm
git submodule update --init --recursive
./get-deps
cargo build --release

# install nvm
echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# install starship
echo "Installing starship..."
curl -sS https://starship.rs/install.sh | sh
