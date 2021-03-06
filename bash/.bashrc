#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

##### Fancy PS1 (thanks to https://stackoverflow.com/questions/1862510/how-can-the-last-commands-wall-time-be-put-in-the-bash-prompt/1862762#1862762)
function timer_now {
    date +%s%N
}

function timer_start {
    timer_start=${timer_start:-$(timer_now)}
}

function timer_stop {
    local delta_us=$((($(timer_now) - $timer_start) / 1000))
    local us=$((delta_us % 1000))
    local ms=$(((delta_us / 1000) % 1000))
    local s=$(((delta_us / 1000000) % 60))
    local m=$(((delta_us / 60000000) % 60))
    local h=$((delta_us / 3600000000))
    # Goal: always show around 3 digits of accuracy
    if ((h > 0)); then timer_show=${h}h${m}m
    elif ((m > 0)); then timer_show=${m}m${s}s
    elif ((s >= 10)); then timer_show=${s}.$((ms / 100))s
    elif ((s > 0)); then timer_show=${s}.$(printf %03d $ms)s
    elif ((ms >= 100)); then timer_show=${ms}ms
    elif ((ms > 0)); then timer_show=${ms}.$((us / 100))ms
    else timer_show=${us}us
    fi
    unset timer_start
}


set_prompt () {
    Last_Command=$? # Must come first!
    Blue='\[\e[01;34m\]'
    White='\[\e[01;37m\]'
    Red='\[\e[01;31m\]'
    LightGray='\[\e[00;37m\]'
    Yellow='\[\e[01;33m\]'
    Green='\[\e[01;32m\]'
    Reset='\[\e[00m\]'
    FancyX='\342\234\227'
    Checkmark='\342\234\223'


    # Add a bright white exit status for the last command
    PS1="$Whit$White("
    # If it was successful, print a green check mark. Otherwise, print
    # a red X.
    if [[ $Last_Command == 0 ]]; then
	PS1+="$Green$Checkmark$White:"
    else
	PS1+="$Red$FancyX$White:"
    fi
    PS1+="$Last_Command)$LightGray "

    # Add the ellapsed time and current date
    timer_stop
    PS1+="($timer_show) \t "

    # If root, just print the host in red. Otherwise, print the current user
    # and host in green.
    if [[ $EUID == 0 ]]; then
        PS1+="$Red\\u$Reset@\\h "
    else
        PS1+="$Yellow\\u@$Green\\h$Reset "
    fi
    # Print the working directory and prompt marker in blue, and reset
    # the text color to the default.
    if [[ $EUID == 0 ]]; then
        PS1+="$Blue\\w$Reset# "
    else
        PS1+="$Blue\\w$Reset\$ "
    fi
}

trap 'timer_start' DEBUG
PROMPT_COMMAND='set_prompt'
######################################################################

# General aliases
if [[ -f ~/.bash_aliases ]]
then
	. ~/.bash_aliases
fi
# Specific aliases, create this file with host-specific aliases
if [[ -f ~/.bash_aliases_specific ]]; then
    . ~/.bash_aliases_specific
fi

export PATH=$HOME/scripts:$PATH

export EDITOR=vim
