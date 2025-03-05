alias ls='ls -A'
alias g='git'
alias gco='git checkout'
alias gf='git fetch'
alias gfr='git fetch --all'
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase --interactive'
alias grs='git rebase --skip'
alias gs='git stash'
alias gsa='git stash apply'
alias log="git log --graph --pretty=format:'%Cred%h%Creset %C(cyan)%an%Creset -%C(blue)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias rs='git reset --hard HEAD'
alias gco='git checkout'
alias ga='git add'
alias gap='git add -p'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gcm='git commit -m'
alias gst='git status'
alias gsh='git stash'
alias gsv='git stash save'
alias grm='git pull origin main --rebase'
alias gnb='git checkout -b'
alias gpf='git push -f origin HEAD'
alias gpn='git push --no-verify'
alias gundo='git reset HEAD~1'
alias ozsh='cursor ~/.zshrc'
alias notion='notion '
alias run="run --debug"
gclone() {
  git clone "$1" && cd "$(basename "$1" .git)"
}
alias gvs='git config --global core.editor "code -w"'
alias gvim='git config --global core.editor "vim"'
alias mv='mv -vn'
alias dv='cd ~/Developer'
alias "vpr"='gh pr view --web'
alias "vr"='gh repo view --web'
alias "ra"='pypy3 solution.py'
alias "pypy"='pypy3'

eval "$(/opt/homebrew/bin/brew shellenv)"
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
eval "$(rbenv init -)"
eval "$(direnv hook zsh)"
eval "$(notion completion --install)"
aoc() {
  day=$(printf %02d $1)
  if [ -n "$2" ]
  then
    year=$2
  else
    year=$(date +'%Y')
  fi
  base_dir=~/Developer/p/advent-of-code
  cd $base_dir
  if [ $# -eq 0 ];
  then
    return
  fi
  python3 aoc.py $1 $2
  cursor . -g $year/$day/solution.py
  cd $base_dir/$year/$day
}
eval "$(starship init zsh)"
