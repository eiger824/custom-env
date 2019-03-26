# Reload bashrc
alias bashf5='source ~/.bashrc'

# Git aliases
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gb='git branch'
alias gc='git checkout'

# Push & pull
gplo()
{
    local branch
    branch="$1"
    if [[ -z "${branch}" ]]; then
        branch=$(git branch | \grep '^*' | tr -d '* ')
    fi
    echo "Pulling from branch \"${branch}\""
    git pull --rebase origin ${branch}
}
gpso()
{
    local branch
    branch="$1"
    if [[ -z "${branch}" ]]; then
        branch=$(git branch | \grep '^*' | tr -d '* ')
    fi
    echo "Pusing to branch \"${branch}\""
    git push origin ${branch}
}

gerrit_push()
{
    local branch
    branch="$1"
    if [[ -z "${branch}" ]]; then
        branch=$(git branch | \grep '^*' | tr -d '* ')
    fi
    echo "Pushing to branch refs/for/${branch}"
    git push origin HEAD:refs/for/${branch}
}

alias qq='exit'

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep -n --color=auto'
	alias fgrep='fgrep -n --color=auto'
	alias egrep='egrep -n --color=auto'
fi

# Listing aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Use htop instead of top
alias top='htop'

# Sort some outputs
alias lsmod='lsmod | sort'
alias env='env | sort'

# Complete output when cat-ing
alias ccat='cat -nA $1'

alias count='wc -l'

alias sl='sl -e'

alias ec='echo Return code was: $?'

alias mnssh='sshpass -p mininet ssh -X mininet@mininet'
alias odlssh='sshpass -p opendaylight ssh -X odl@odl'

alias tf='sshpass -p TungstenFabric ssh -X tungsten@10.0.2.15'

alias ipa="ip address show | \grep --color=always -E '([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}|$' | GREP_COLORS='mt=01;34' \grep --color=always -P '(\s.+:\s)|$'"
