#    ______      __         _      __   Gabriel Moreno
#   / ____/___ _/ /_  _____(_)__  / /   ==============
#  / / __/ __ `/ __ \/ ___/ / _ \/ /    E-mail:   gantoreno@gmail.com
# / /_/ / /_/ / /_/ / /  / /  __/ /     Website:  https://gantoreno.com
# \____/\__,_/_.___/_/  /_/\___/_/      GitHub:   https://github.com/gantoreno
# 
# ZSH configuration file

# Config paths {{{
export ZSHDIR="$HOME/.config/zsh"
export ZSHRC="$ZSHDIR/.zshrc"
# }}}

# User configuration {{{
setopt PROMPT_SUBST

bindkey -v
bindkey '^R' history-incremental-search-backward

autoload -U colors && colors
autoload -U compinit && compinit
autoload -U promptinit && promptinit
# }}}

# Plugin loader {{{
plugins=(
  zsh-z
  git
  shrink-path
  # zsh-syntax-highlighting/zsh-syntax-highlighting
)

[[ -z "$NEOVIM" ]] && plugins+=(zsh-autosuggestions/zsh-autosuggestions)

foreach plugin in $plugins
  plugin_path="$ZSHDIR/plugins/$plugin.plugin.zsh" 

  [[ -e $plugin_path ]] && source $plugin_path
end
# }}}

# Theme loader {{{
THEME="spaceship"

[[ ! -z $THEME ]] && source "$ZSHDIR/themes/$THEME.zsh-theme"
# }}}

# Exports {{{
export DEFAULT_USER="gabrielmoreno"

export CLICOLOR=1
export LSCOLORS="GxGxBxDxCxEgEdxbxgxcxd"

export EDITOR="vim"
export EDITORRC="$HOME/.vimrc"

export SSHRC="$HOME/.ssh/config"

export PATH="$HOME/.scripts:$PATH"
export PATH="/usr/local/Cellar/llvm/12.0.0_1/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.fig/bin:$PATH"
# }}}

# RbEnv {{{
eval "$(rbenv init - zsh)"
eval "$(fnm env)"
# }}}

# Lazy load {{{
lazy_load_nvm() {
  unset -f node

  export NVM_DIR="$HOME/.nvm"

  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
}
# }}}

# Aliases {{{
alias ls="ls"

alias l="ls"
alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"

alias top="htop"

alias pc="peco"
alias xp="expand"
alias ws="workspace"

alias lzg="lazygit"

alias gpl="git pull"
alias gck="git checkout"
alias gaa="git add ."
alias gcm="git commit"
alias gam="git commit --amend"
alias gst="git status"
alias glg="git log --graph --oneline"
alias gpm="git push origin main"

alias npdev="npm run dev"
alias nptest="npm run test"
alias npstart="npm run start"
alias npbuild="npm run build"

alias e="emacs"
alias vim="$EDITOR"
alias fetch="macfetch"
alias pingtest="prettyping 8.8.8.8"
alias fastbrew="HOMEBREW_NO_AUTO_UPDATE=1 brew"

alias sshconfig="$EDITOR $SSHRC"
alias zshconfig="$EDITOR $ZSHRC"
alias vimconfig="$EDITOR $EDITORRC"
alias tmuxconfig="$EDITOR ~/.config/tmux/.tmux.conf"
alias themeconfig="$EDITOR $ZSHDIR/themes/$THEME.zsh-theme"
# }}}

# Fetch {{{
# if [[ $TERM_PROGRAM == "iTerm.app" && -z "$NEOVIM" ]]; then 
#   fetch
# fi
# }}}

