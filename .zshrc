# Path configuration
eval "$(/opt/homebrew/bin/brew shellenv)"
typeset -U PATH path

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

# Zsh options
setopt AUTO_CD AUTO_PUSHD PUSHD_SILENT CORRECT

# Completion
autoload -Uz compinit && compinit

# History search keybindings (type partial command, press up/down to search)
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^[[A' history-beginning-search-backward-end
bindkey '^[[B' history-beginning-search-forward-end

# General aliases
alias ls='ls -A'
alias mv='mv -vn'
alias dv='cd ~/Developer'

# Git aliases
alias g='git'
alias ga='git add'
alias gap='git add -p'
alias gco='git checkout'
alias gnb='git checkout -b'
alias gcm='git commit -m'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gf='git fetch'
alias gfr='git fetch --all'
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase --interactive'
alias grs='git rebase --skip'
alias gs='git stash'
alias gsp='git stash pop'
alias gsl='git stash list'
alias gst='git status'
alias grm='git pull origin main --rebase'
alias gpf='git push -f origin HEAD'
alias gpn='git push --no-verify'
alias gundo='git reset HEAD~1'
alias rs='git reset --hard HEAD'
alias log="git log --graph --pretty=format:'%Cred%h%Creset %C(cyan)%an%Creset -%C(blue)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gvs='git config --global core.editor "code -w"'
alias gvim='git config --global core.editor "vim"'

# GitHub CLI aliases
alias vpr='gh pr view --web'
alias vr='gh repo view --web'

# Other aliases
alias ozsh='cursor ~/.zshrc'
alias run="run --debug"
alias ra='pypy3 solution.py'
alias pypy='pypy3'

# Git clone and cd into directory
gclone() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

# Advent of Code helper
aoc() {
  local base_dir=~/Developer/advent-of-code
  cd $base_dir || return
  [[ $# -eq 0 ]] && return
  local day=$(printf %02d $1)
  local year=${2:-$(date +'%Y')}
  uv run aoc.py $1 $2
  code . -g $year/$day/solution.py
  cd $base_dir/$year/$day
}

# NVM (lazy-loaded for faster shell startup)
export NVM_DIR="$HOME/.nvm"
nvm() {
  unfunction nvm node npm npx
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  nvm "$@"
}
node() { nvm && node "$@" }
npm() { nvm && npm "$@" }
npx() { nvm && npx "$@" }

# UV
. "$HOME/.local/bin/env"
eval "$(uv generate-shell-completion zsh)"

# Starship prompt (cached for faster startup)
if [[ ! -f ~/.starship_init.zsh ]] || [[ $(which starship) -nt ~/.starship_init.zsh ]]; then
  starship init zsh > ~/.starship_init.zsh
fi
source ~/.starship_init.zsh

 [ -f ~/.zshrc.local ] && source ~/.zshrc.local