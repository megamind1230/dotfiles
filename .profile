# ~/.profile - login shell / display manager environment (non-interactive)


# exports & PATH
export EDITOR='emacsclient -s emacs-profile-baka -c'
export VISUAL='emacsclient -s emacs-profile-baka -c'
export BROWSER='helium-browser'
export TERMINAL=/usr/bin/kitty
# opencode
export PATH=/home/dt/.opencode/bin:$PATH

export PATH=/home/dt/.local/bin:$PATH
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="/home/dt/scripts/:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"
PATH="$PATH:/opt/nvim-linux-x86_64/bin"
. "$HOME/.cargo/env"
