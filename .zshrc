# Aliases

alias gbr="git branch | grep -v "master" | xargs git branch -D"
alias gbrm="git branch | grep -v "main" | xargs git branch -D"
alias gcm="git add . && git stash && git checkout master && git pull"
alias gcmm="git add . && git stash && git checkout main && git pull"
alias gs="git status"
alias D='cd ~/Development/'
alias ss='cd ~/Development/single-spa'
alias W='cd ~/Development/work'
alias P='cd ~/Development/personal'
alias ngrok='~/ngrok'
alias undo-soft="soft-undo"
alias undo-hard="hard-undo"

function hard-undo {
  COUNT="${1:=1}"
  commit-undo $COUNT hard
}

function soft-undo {
  COUNT="${1:=1}"
  commit-undo $COUNT hard
}

function commit-undo {
  COUNT="${1:=1}"
  STRENGTH="${2:=soft}"
  git reset --$STRENGTH HEAD~$COUNT
}