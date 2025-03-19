# Aliases

alias gbr="git branch | grep -v "master" | xargs git branch -D"
alias gbrm="git branch | grep -v "main" | xargs git branch -D"
alias gs="git status"
alias D='cd ~/Development/'
alias W='cd ~/Development/work'
alias P='cd ~/Development/personal'
alias ngrok='~/ngrok'
alias undo-soft="soft-undo"
alias undo-hard="hard-undo"

# Functions

function hard-undo {
  COUNT="${1:=1}"
  commit-undo $COUNT hard
}

function soft-undo {
  COUNT="${1:=1}"
  commit-undo $COUNT soft
}

function commit-undo {
  COUNT="${1:=1}"
  STRENGTH="${2:=soft}"
  git reset --$STRENGTH HEAD~$COUNT
}

## stash everything then checkout the main branch (even if it's named master or develop or something)
function gcm() {
    git add .
    git stash
    
    local default_branch
    if git show-ref --quiet refs/heads/main; then
        default_branch="main"
    elif git show-ref --quiet refs/heads/master; then
        default_branch="master"
    else
        default_branch=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')
    fi
    
    if [[ -n "$default_branch" ]]; then
        git checkout "$default_branch" && gpo
    else
        echo "Could not determine the default branch."
    fi
}

## This is a nice little helper for large repos, it runs "git pull origin *" where * is the provided branch name or the current branch
function gpo() {
    local branch=${1:-$(git rev-parse --abbrev-ref HEAD)}
    git pull origin $branch
}
