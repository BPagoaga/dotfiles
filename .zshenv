. "$HOME/.cargo/env"

# Determine if running on linux or macos
unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*)     machine=Linux;;
  Darwin*)    machine=Mac;;
  CYGWIN*)    machine=Cygwin;;
  MINGW*)     machine=MinGw;;
  *)          machine="UNKNOWN:${unameOut}"
esac

echo ${machine}

if [ "$machine" = "Mac" ]; then
    # code for macOS platform        
    export PATH=/Users/bernardpagoaga/.local/bin:$PATH

    export PATH=~/Library/Android/sdk/tools:$PATH
    export PATH=~/Library/Android/sdk/platform-tools:$PATH
    export PATH="$PATH:~/flutter/bin"
    export PATH="/opt/homebrew/bin:$PATH"
    export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jbr/Contents/Home
elif [ "$machine" = "Linux" ]; then
    # code for GNU/Linux platform
    export ANDROID_HOME="/home/bpagoaga/.android/android_sdk_root"
    export ANDROID_SDK_ROOT="/home/bpagoaga/.android/android_sdk_root"
    export CAPACITOR_ANDROID_STUDIO_PATH="/home/bpagoaga/android-studio/bin/studio.sh"
    export JAVA_HOME="/usr/lib/jvm/temurin-21-jdk-amd64/bin"
    export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"
    export PATH="/home/bpagoaga/neovim/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.nvm/current/bin:$PATH"
export NVM_SYMLINK_CURRENT=true
export TERM="xterm-256color"
[[ -n $TMUX ]] && export TERM="screen-256color"

# Tmux
export TMUXIFIER_LAYOUT_PATH="$HOME/.tmux-layouts"
# export TMUXIFIER_TMUX_ITERM_ATTACH="-CC"

# Bun
export BUN_INSTALL="/Users/bernardpagoaga/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$HOME/.tmuxifier/bin:$PATH"
export EDITOR="vi"

# avoir javascript heap out of memory error
export NODE_OPTIONS=--max-old-space-size=4096
export PATH=$PATH:/usr/local/go/bin
export WARP_THEMES_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/warp-terminal/themes"
alias zed="$HOME/zed/target/release/Zed"
alias lz="lazygit"
alias ls="eza -l --icons always"
