skip_global_compinit=1
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

if [ "$machine" = "Mac" ]; then
    # code for macOS platform        
    export PATH=/Users/bernardpagoaga/.local/bin:$PATH

    export ANDROID_HOME=~/Library/Android/sdk/
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
    export JAVA_HOME="/home/bpagoaga/.sdkman/candidates/java/current/bin/java"
    export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"
    export PATH="/home/bpagoaga/neovim/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.nvm/current/bin:$PATH"
export NVM_SYMLINK_CURRENT=true
export TERM="xterm-256color"
export EDITOR="vim"
alias vi="nvim"
alias vim="nvim"

# avoid javascript heap out of memory error
export NODE_OPTIONS="--max-old-space-size=8192"

export HELIX_RUNTIME="$HOME/helix/runtime"
export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/zed/target/release/Zed:$PATH"
export PATH="$HOME/neovim/bin:$PATH"
export PATH="$HOME/alacritty/target/release/alacritty:$PATH"
export WARP_THEMES_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/warp-terminal/themes"
alias zed="$HOME/zed/target/release/Zed"
alias lz="lazygit"
alias lzd="lazydocker"
alias l="eza -lla --icons always"
alias yz="yazi"
alias logout="pkill -KILL -u bernardpagoaga"
alias kitty="kitty --start-as fullscreen"
